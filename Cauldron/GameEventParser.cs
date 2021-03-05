using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;

namespace Cauldron
{

	public class GameCompleteEventArgs
	{
		public GameCompleteEventArgs(string gameId, IEnumerable<GameEvent> gameEvents, string winningPitcherId, string losingPitcherId)
		{
			GameId = gameId;
			GameEvents = gameEvents;
			WinningPitcherId = winningPitcherId;
			LosingPitcherId = losingPitcherId;
		}

		public string GameId;
		public IEnumerable<GameEvent> GameEvents;
		public string WinningPitcherId;
		public string LosingPitcherId;
	}

	public class GameEventCompleteEventArgs
	{
		public GameEventCompleteEventArgs(GameEvent ev)
		{
			GameEvent = ev;
		}

		public GameEvent GameEvent;
	}

	public enum InningState
	{
		Init,
		GameStart,
		HalfInningStart,
		BatterMessage,
		ValidBatter,
		PlayEnded,
		GameOver,
		OutingMessage
	}

	/// <summary>
	/// Basic parser that takes Game json updates and emits GameEvent json objects
	/// </summary>
	public class GameEventParser
	{
		// Store states that we shouldn't process yet because there's a data gap
		List<Game> m_pendingStates;

		// Last state we saw, for comparison
		Game m_oldState;

		InningState m_inningState;

		// State tracking for stats not tracked inherently in the state updates
		int m_eventIndex = 0;
		int m_batterCount = 0;
		// Map of pitcher IDs indexed by batter ID; used in attributing baserunners to pitchers
		Dictionary<string, string> m_responsiblePitchers;

		// Keep of track of whether we've had a valid batter for this inning
		HashSet<string> m_startedInnings;

		// Properties for metrics
		public int Discards => m_discards;
		int m_discards = 0;
		public int Processed => m_processed;
		int m_processed = 0;
		public int Errors => m_errors;
		int m_errors = 0;
		public int Fixes => m_fixes;
		int m_fixes = 0;
		public string GameId => m_gameId;
		string m_gameId;

		// Event currently being appended to
		GameEvent m_currEvent;

		string m_awayOwningPitcher;
		string m_homeOwningPitcher;

		HttpClient m_client;

		public event EventHandler<GameCompleteEventArgs> GameComplete;

		public event EventHandler<GameEventCompleteEventArgs> EventComplete;

		public bool IsGameComplete
		{
			get; set;
		}
		private bool m_sentGameComplete;

		public IEnumerable<GameEvent> GameEvents => m_gameEvents;
		private List<GameEvent> m_gameEvents;

		private HashSet<string> m_seenUpdates;

		static JsonSerializerOptions s_outcomeJsonSerOpt = new JsonSerializerOptions() 
		{ 
			PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
			WriteIndented = true
		};

		public bool StartNewGame(Game initState, DateTime timeStamp)
		{
			m_pendingStates = new List<Game>();

			m_seenUpdates = new HashSet<string>();
			if(initState.chroniclerHash != null)
				m_seenUpdates.Add(initState.chroniclerHash);

			m_inningState = InningState.Init;

			m_client = new HttpClient();
			m_client.BaseAddress = new Uri("https://api.blaseball-reference.com/v1/");
			m_client.DefaultRequestHeaders.Accept.Clear();
			m_client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

			string outcomeString = "";

			string localOutcomeString = "";
			int localOutcomeVersion = 0;
			// Use a local outcomes.json if it exists
			if (File.Exists("data/simple-outcomes.cfg"))
			{
				using (var outcomesFile = new StreamReader("data/simple-outcomes.cfg"))
				{
					localOutcomeVersion = int.Parse(outcomesFile.ReadLine());
					localOutcomeString = string.Concat(outcomesFile.ReadToEnd().Where(x => x != '\r'));
				}
				//Console.WriteLine($"Local simple-outcomes.cfg is version {localOutcomeVersion}");
			}

			string networkOutcomeString = "";
			int networkOutcomeVersion = 0;
			// Wild but neat: try to download the latest outcomes.json content directly from the mainline repository, and use that!
			using (var client = new WebClient())
			{
				try
				{
					string file = client.DownloadString("https://raw.githubusercontent.com/Society-for-Internet-Blaseball-Research/prophesizer/future-perfect/Cauldron/data/simple-outcomes.cfg");
					networkOutcomeVersion = int.Parse(file.Substring(0, file.IndexOf("\n")));
					networkOutcomeString = file.Substring(file.IndexOf("\n")+1);
					//Console.WriteLine($"Network simple-outcomes.cfg is version {networkOutcomeVersion}");
				}
				catch (Exception)
				{
				}
			}

			bool networkOutcome = false;
			if (networkOutcomeVersion > localOutcomeVersion)
			{
				outcomeString = networkOutcomeString;
				networkOutcome = true;
			}
			else
			{
				outcomeString = localOutcomeString;
			}

			m_simpleOutcomes = new List<(string, string)>();
			if (outcomeString != "")
			{
				var lines = outcomeString.Split("\n");
				foreach(var line in lines)
				{
					if (line.Trim() != string.Empty)
					{
						var halves = line.Split('|');
						m_simpleOutcomes.Add((halves[0], halves[1]));
					}
				}
			}

			m_oldState = initState;
			m_eventIndex = 0;
			m_batterCount = 0;
			m_discards = 0;
			m_processed = 0;
			m_errors = 0;
			m_fixes = 0;
			m_gameId = initState.gameId;
			m_responsiblePitchers = new Dictionary<string, string>();
			m_startedInnings = new HashSet<string>();
			m_homeOwningPitcher = null;
			m_awayOwningPitcher = null;

			m_currEvent = CreateNewGameEvent(initState, timeStamp);
			m_currEvent.eventText.Add(initState.lastUpdate);

			m_gameEvents = new List<GameEvent>();
			IsGameComplete = false;
			m_sentGameComplete = false;

			CheckInningState(initState);

			return networkOutcome;
		}

		bool CheckForDuplicateUpdate(string hash)
		{
			// If the caller isn't providing a hash, we can only say "not a duplicate"
			if (hash == null)
				return false;

			if(m_seenUpdates.Contains(hash))
			{
				return true;
			}
			else
			{
				m_seenUpdates.Add(hash);
				return false;
			}
		}

		#region Inning tracking
		private string MakeInningKey(Game newState)
		{
			return newState.topOfInning ? $"T{newState.inning}" : $"B{newState.inning}";
		}

		private bool CanStartInning(Game newState)
		{
			return !m_startedInnings.Contains(MakeInningKey(newState)) && newState.BatterId != null;
		}

		private void StartInning(Game newState)
		{
			m_startedInnings.Add(MakeInningKey(newState));
		}
		#endregion

		private void AddParsingError(GameEvent e, string message) 
		{
			if (e != null)
			{
				e.parsingError = true;
				e.parsingErrorList.Add(message);
			}
			m_errors++;
		}

		private void AddFixedError(GameEvent e, string message)
		{
			if (e != null)
			{
				e.fixedError = true;
				e.fixedErrorList.Add(message);
			}
			m_fixes++;
		}

		private bool IsNextHalfInning(Game oldState, Game newState)
		{
			// Assumes no gaps
			return ((newState.topOfInning != oldState.topOfInning) &&
					(newState.inning - oldState.inning <= 1));
		}

		private bool IsStartOfInningMessage(Game newState) 
		{
			return (newState.lastUpdate.Contains("Top of ") || newState.lastUpdate.Contains("Bottom of "));
		}

		private bool IsOutingMessage(Game newState)
		{
			return (newState.lastUpdate.Contains("is now an Outing"));
		}

		private bool IsNewBatterMessage(Game newState)
		{
			return newState.lastUpdate.Contains("batting for the");
		}

		private bool IsGameNearlyOver(Game oldState, Game newState)
		{
			return ((newState.inning >= 8) &&
					(oldState.halfInningOuts == 2 && newState.halfInningOuts == 0) &&
					((!newState.topOfInning) || (newState.topOfInning && newState.homeScore > newState.awayScore)));
		}



		private GameEvent CreateNewGameEvent(Game newState, DateTime timeStamp)
		{
			GameEvent currEvent = new GameEvent();
			currEvent.parsingError = false;
			currEvent.parsingErrorList = new List<string>();
			currEvent.fixedError = false;
			currEvent.fixedErrorList = new List<string>();
			currEvent.updateHashes = new List<string>();

			currEvent.firstPerceivedAt = timeStamp;

			currEvent.gameId = newState.gameId;
			currEvent.season = newState.season;
			currEvent.tournament = newState.tournament.HasValue ? newState.tournament.Value : -1;
			currEvent.day = newState.day;
			currEvent.eventIndex = m_eventIndex;
			currEvent.batterCount = m_batterCount;
			currEvent.inning = newState.inning;
			currEvent.topOfInning = newState.topOfInning;
			currEvent.outsBeforePlay = m_oldState.halfInningOuts;

			currEvent.homeStrikeCount = newState.homeStrikes ?? 3;
			currEvent.awayStrikeCount = newState.awayStrikes ?? 3;
			currEvent.homeBallCount = newState.homeBalls ?? 4;
			currEvent.awayBallCount = newState.awayBalls ?? 4;
			currEvent.homeBaseCount = newState.homeBases ?? 4;
			currEvent.awayBaseCount = newState.awayBases ?? 4;

			currEvent.homeScore = newState.homeScore;
			currEvent.awayScore = newState.awayScore;

			// Currently not supported by the cultural event of Blaseball
			currEvent.isPinchHit = false;
			currEvent.isBunt = false;
			currEvent.errorsOnPlay = 0;

			currEvent.isWildPitch = false;
			currEvent.batterId = newState.BatterId;
			currEvent.batterTeamId = newState.BatterTeamId;
			currEvent.pitcherId = newState.PitcherId;
			currEvent.pitcherTeamId = newState.PitcherTeamId;

			currEvent.eventText = new List<string>();
			currEvent.pitchesList = new List<char>();
			currEvent.outcomes = new List<Outcome>();
			currEvent.baseRunners = new List<GameEventBaseRunner>();

			// Might be incorrect
			currEvent.totalStrikes = newState.atBatStrikes;
			currEvent.totalBalls = newState.atBatBalls;

			return currEvent;
		}

		/// <summary>
		/// Logic for updating balls and strikes, including foul balls
		/// </summary>
		private void UpdateBallsAndStrikes(Game newState)
		{
			int newStrikes = 0;
			int newBalls = 0;

			if(m_inningState == InningState.ValidBatter)
			{
				newStrikes = newState.atBatStrikes - m_currEvent.totalStrikes;
				newBalls = newState.atBatBalls - m_currEvent.totalBalls;
				m_currEvent.totalBalls = newState.atBatBalls;
				m_currEvent.totalStrikes = newState.atBatStrikes;
			}
			else if(m_inningState == InningState.PlayEnded)
			{
				// If a batter strikes out we never get an update with 3 strikes on it
				// so check the play text
				if (newState.lastUpdate.Contains("struck out") || newState.lastUpdate.Contains("strikes out"))
				{
					// Set the strikes to the total for the team that WAS batting
					m_currEvent.totalStrikes = m_oldState.topOfInning ? m_oldState.awayStrikes.GetValueOrDefault() : m_oldState.homeStrikes.GetValueOrDefault();
					newStrikes = m_currEvent.totalStrikes - m_oldState.atBatStrikes;
				}
				else if (newState.lastUpdate.Contains("walk"))
				{
					m_currEvent.totalBalls = newState.BatterTeamBalls;

					if(newState.lastUpdate.Contains("charms"))
					{
						m_currEvent.eventType = GameEventType.CHARM_WALK;
					}
					else
					{
						m_currEvent.eventType = GameEventType.WALK;
					}
					m_currEvent.isWalk = true;
					newBalls = m_currEvent.totalBalls - m_oldState.atBatBalls;
				}
				else if (newState.lastUpdate.Contains("with a pitch!"))
				{
					m_currEvent.eventType = GameEventType.HIT_BY_PITCH;
				}

			}

			if (newState.lastUpdate.Contains("Mild pitch!"))
			{
				m_currEvent.isWildPitch = true;

				if (newState.lastUpdate.Contains("Runners advance on the pathetic play!"))
				{
					m_currEvent.eventType = GameEventType.WILD_PITCH;
				}
			}


			// Oops, we hit a gap, lets see if we can fill it in
			if (newStrikes + newBalls > 1)
			{
				// Error: We skipped *something*, we should log it
				AddFixedError(m_currEvent, $"A single update had more than one pitch, but we fixed it");
				// We can know for sure the state of the last strike.
				if (newState.lastUpdate.Contains("struck out") || newState.lastUpdate.Contains("strikes out"))
				{
					if (newState.lastUpdate.Contains("looking"))
					{
						m_currEvent.pitchesList.Add('C');
						newStrikes -= 1;
					}
					else if (newState.lastUpdate.Contains("swinging"))
					{
						m_currEvent.pitchesList.Add('S');
						newStrikes -= 1;
					}
				}
				// We can know for sure that the last pitch was a ball
				else if (newState.lastUpdate.Contains("walk"))
				{
					m_currEvent.pitchesList.Add('B');
					newBalls -= 1;
				}

				// Add the rest as unknowns
				for (int i = 0; i < newStrikes; i++)
				{
					m_currEvent.pitchesList.Add('K');
				}
				for (int i = 0; i < newBalls; i++)
				{
					m_currEvent.pitchesList.Add('A');
				}
			}
			else if (newStrikes == 1)
			{
				if (newState.lastUpdate.Contains("looking") || newState.lastUpdate.Contains("flinched. Strike.")
					|| newState.lastUpdate.Contains("flinching"))
				{
					m_currEvent.pitchesList.Add('C');
				}
				else if (newState.lastUpdate.Contains("swinging"))
				{
					m_currEvent.pitchesList.Add('S');
				}
				else if (newState.lastUpdate.Contains("Foul Ball"))
				{
					// Do nothing, fouls are handled at the end
				}
				else
				{
					m_currEvent.pitchesList.Add('K');
					AddFixedError(m_currEvent, $"We missed a single strike, but we fixed it");
				}
			} 
			else if (newBalls == 1)
			{
				m_currEvent.pitchesList.Add('B');
				if (!(newState.lastUpdate.Contains("Ball.") || newState.lastUpdate.Contains("Ball,") || newState.lastUpdate.Contains("walk.")))
				{
					AddFixedError(m_currEvent, $"We missed a single ball, but we fixed it");
				}
			}

			if (newState.lastUpdate.Contains("Foul Ball"))
			{
				m_currEvent.totalFouls++;
				m_currEvent.pitchesList.Add('F');
			}
		}

		/// <summary>
		/// Update outs (they're annoying)
		/// </summary>
		private void UpdateOuts(Game newState)
		{
			// If the inning suddenly changed, that means this play got all the rest of the outs
			// TODO: triple plays if implemented
			//if ((newState.topOfInning != m_oldState.topOfInning && m_oldState.halfInningOuts > 0) ||
			//	endOfGameHappened(m_oldState, newState))
			
			// The inning flags no longer change right on the event that caused the out, so literally our only detection is outs snapping back to 0 :(
			if ( (m_oldState.halfInningOuts > 0 && newState.halfInningOuts == 0) ||
				endOfGameHappened(m_oldState, newState))
			{
				m_currEvent.outsOnPlay = 3 - m_oldState.halfInningOuts;
			}
			else
			{
				m_currEvent.outsOnPlay = Math.Max(0, newState.halfInningOuts - m_oldState.halfInningOuts);
			}

			// Types of outs
			if (newState.lastUpdate.Contains("out") || newState.lastUpdate.Contains("sacrifice") || newState.lastUpdate.Contains("hit into a double play"))
			{
				if (newState.lastUpdate.Contains("strikes out") || newState.lastUpdate.Contains("struck out"))
				{
					m_currEvent.eventType = GameEventType.STRIKEOUT;
				}
				else if(newState.lastUpdate.Contains("strike out willingly!"))
				{
					for (int i = 0; i < newState.BatterTeamStrikes; i++)
					{
						m_currEvent.pitchesList.Add('S');
					}
					m_currEvent.eventType = GameEventType.CHARM_STRIKEOUT;
					m_currEvent.totalStrikes = newState.topOfInning ? newState.awayStrikes.GetValueOrDefault() : newState.homeStrikes.GetValueOrDefault();
				}
				else if(newState.lastUpdate.Contains("sacrifice"))
				{
					m_currEvent.eventType = GameEventType.SACRIFICE;
				}
				else
				{
					m_currEvent.eventType = GameEventType.OUT;
				}
			}

		}

		/// <summary>
		/// Update hit information
		/// </summary>
		private void UpdateHits(Game newState)
		{
			// Handle RBIs
			m_currEvent.runsBattedIn = newState.topOfInning ? newState.awayScore - m_oldState.awayScore : newState.homeScore - m_oldState.homeScore;

			// Mark any kind of hit
			if (newState.lastUpdate.Contains("hits a") || newState.lastUpdate.Contains("hit a"))
			{
				m_currEvent.pitchesList.Add('X');
				m_currEvent.battedBallType = BattedBallType.UNKNOWN;
			}

			// Extremely basic single/double/triple/HR detection
			if (newState.lastUpdate.Contains("hits a Single"))
			{
				m_currEvent.basesHit = 1;
				m_currEvent.batterBaseAfterPlay = 1;
				m_currEvent.eventType = GameEventType.SINGLE;
			}
			else if (newState.lastUpdate.Contains("hits a Double"))
			{
				m_currEvent.basesHit = 2;
				m_currEvent.batterBaseAfterPlay = 2;
				m_currEvent.eventType = GameEventType.DOUBLE;
			}
			else if (newState.lastUpdate.Contains("hits a Triple"))
			{
				m_currEvent.basesHit = 3;
				m_currEvent.batterBaseAfterPlay = 3;
				m_currEvent.eventType = GameEventType.TRIPLE;
			}
			else if (newState.lastUpdate.Contains("hits a Quadruple"))
			{
				m_currEvent.basesHit = 4;
				m_currEvent.batterBaseAfterPlay = 4;
				m_currEvent.eventType = GameEventType.QUADRUPLE;
			}
			else if (newState.lastUpdate.Contains("home run") || newState.lastUpdate.Contains("grand slam"))
			{
				m_currEvent.basesHit = newState.BatterTeamBases;
				m_currEvent.batterBaseAfterPlay = newState.BatterTeamBases;
				m_currEvent.eventType = m_currEvent.basesHit == 5 ? GameEventType.HOME_RUN_5 : GameEventType.HOME_RUN;
				m_currEvent.battedBallType = BattedBallType.FLY;
			}

			if(newState.lastUpdate.Contains("ground"))
			{
				m_currEvent.battedBallType = BattedBallType.GROUNDER;
			}
			if(newState.lastUpdate.Contains("flyout"))
			{
				m_currEvent.battedBallType = BattedBallType.FLY;
			}
		}

		/// <summary>
		/// Should be called after UpdateOuts because fielder's choice overrides the generic OUT type
		/// </summary>
		private void UpdateFielding(Game newState)
		{
			// Sacrifice outs
			if(newState.lastUpdate.Contains("sacrifice fly"))
			{
				m_currEvent.isSacrificeFly = true;
			}
			else if (newState.lastUpdate.Contains("sacrifice"))
			{
				m_currEvent.isSacrificeHit = true;
			}

			// Double plays
			if (newState.lastUpdate.Contains("double play"))
			{
				m_currEvent.isDoublePlay = true;
			}

			// Triple plays
			if (newState.lastUpdate.Contains("triple play"))
			{
				m_currEvent.isTriplePlay = true;
			}

			// Fielder's choice
			// This has to go after out because it overrides it in case
			// a different batter was out.
			if (newState.lastUpdate.Contains("fielder's choice"))
			{
				m_currEvent.eventType = GameEventType.FIELDERS_CHOICE;
			}

			// Caught Stealing
			if (newState.lastUpdate.Contains("caught stealing"))
			{
				m_currEvent.eventType = GameEventType.CAUGHT_STEALING;
				m_currEvent.isLastEventForPlateAppearance = false;
			}
		}


		private const int BASE_RUNNER_OUT = 0;
		/// <summary>
		/// Update stuff around baserunning
		/// </summary>
		private void UpdateBaserunning(Game newState)
		{

			// Steals
			if (newState.lastUpdate.Contains("steals"))
			{
				m_currEvent.eventType = GameEventType.STOLEN_BASE;
				m_currEvent.isSteal = true;
				m_currEvent.isLastEventForPlateAppearance = false;
			}

			// If this play is known to be ending the inning or game
			if (m_currEvent.outsBeforePlay + m_currEvent.outsOnPlay >= 3 || newState.gameComplete)
			{
				// Baserunners should be exactly what we had in the last update
				// But create a new one if it's null
				if(m_currEvent.baseRunners == null)
				{
					m_currEvent.baseRunners = new List<GameEventBaseRunner>();
				}
				return;
			}
			else
			{
				// Clear to a new list every time we parse an update
				// Since runners can only move in cases where we emit, the last state should be correct
				m_currEvent.baseRunners = new List<GameEventBaseRunner>();
			}

			// Handle runners present in the new state and probably the old state too
			for(int i=0; i < newState.baseRunners.Count; i++)
			{
				string runnerId = newState.baseRunners[i];
				int baseIndex = newState.basesOccupied[i];

				GameEventBaseRunner runner = new GameEventBaseRunner();
				runner.runnerId = runnerId;

				// Add a new entry for this new baserunner
				if(!m_responsiblePitchers.ContainsKey(runnerId))
				{
					// Pitcher from the previous state must be responsible for this new baserunner
					m_responsiblePitchers[runnerId] = m_oldState.PitcherId;
				}

				runner.responsiblePitcherId = m_responsiblePitchers[runnerId];

				// We number home = 0, first = 1, second = 2, third = 3
				// Game updates have first = 0, second = 1, third = 2
				runner.baseAfterPlay = baseIndex + 1;

				// Find this runner's previous base in the old state
				bool found = false;
				for(int j=0; j < m_oldState.baseRunners.Count; j++)
				{
					if(m_oldState.baseRunners[j] == runnerId)
					{
						runner.baseBeforePlay = m_oldState.basesOccupied[j] + 1;
						found = true;
						if(runner.baseBeforePlay != runner.baseAfterPlay)
						{
							if(newState.lastUpdate.Contains("steals"))
							{
								runner.wasBaseStolen = true;
								if (newState.lastUpdate.Contains("Blaserunning!"))
								{
									runner.runsScored += 0.2f;
								}
							}
							if(newState.lastUpdate.Contains("caught"))
							{
								runner.wasCaughtStealing = true;
							}
						}
					}
				}
				if(!found)
				{
					runner.baseBeforePlay = 0;
				}

				m_currEvent.baseRunners.Add(runner);
			}

			// Translate old baserunners into a more easily looped form
			Dictionary<int, string> oldBases = new Dictionary<int, string>();
			for (int i = 0; i < m_oldState.baseRunners.Count; i++)
			{
				oldBases[m_oldState.basesOccupied[i]] = m_oldState.baseRunners[i];
			}

			// TODO fractional runs handling here
			float newScore = m_oldState.topOfInning ? newState.awayScore : newState.homeScore;
			float oldScore = m_oldState.topOfInning ? m_oldState.awayScore : m_oldState.homeScore;
			float scoreDiff = newScore - oldScore;

			// Handle runners present in the old state but possibly not in the new ('cuz they scored)
			foreach (var kvp in oldBases.OrderByDescending(x => x.Key))
			{
				string runnerId = kvp.Value;
				int baseIndex = kvp.Key;

				bool found = false;
				for(int j=0; j < newState.baseRunners.Count; j++)
				{
					if(newState.baseRunners[j] == runnerId)
					{
						found = true;
					}
				}

				// If this old runner was not found and we have runs not attributed yet
				if (!found && scoreDiff > 0)
				{
					// One run accounted for
					scoreDiff--;
					GameEventBaseRunner runner = new GameEventBaseRunner();
					runner.runnerId = runnerId;
					if(m_responsiblePitchers.ContainsKey(runnerId))
					{
						runner.responsiblePitcherId = m_responsiblePitchers[runnerId];
					}
					else
					{
						runner.responsiblePitcherId = "";
						AddParsingError(m_currEvent, $"Couldn't find responsible pitcher for runner {runnerId} in update '{newState.lastUpdate}'");
					}

					runner.baseBeforePlay = baseIndex + 1;
					runner.baseAfterPlay = newState.BatterTeamBases;
					runner.runsScored += 1;
					if (newState.lastUpdate.Contains("steals"))
					{
						runner.wasBaseStolen = true;
					}
					m_currEvent.baseRunners.Add(runner);
				}
				else if (!found && m_currEvent.outsOnPlay > 0)
				{
					// Fine, he was out
					GameEventBaseRunner runner = new GameEventBaseRunner();
					runner.runnerId = runnerId;
					if (m_responsiblePitchers.ContainsKey(runnerId))
					{
						runner.responsiblePitcherId = m_responsiblePitchers[runnerId];
					}
					else
					{
						runner.responsiblePitcherId = "";
						AddParsingError(m_currEvent, $"Couldn't find responsible pitcher for runner {runnerId} in update '{newState.lastUpdate}'");
					}

					if (newState.lastUpdate.Contains("caught"))
					{
						runner.wasCaughtStealing = true;
					}

					runner.baseBeforePlay = baseIndex + 1;
					runner.baseAfterPlay = BASE_RUNNER_OUT;
					m_currEvent.baseRunners.Add(runner);
				}
				else if(found)
				{
					// Fine, he was found
				}
				else if(m_oldState.inning >= 8 && m_oldState.halfInningOuts == 2)
				{
					// In the case that the game-ending out just happened, we'll get an update still in the 9th inning but with outs back at 0 and gameComplete not yet true. Sigh.
					// For now, allow this in the 9th inning with 2 outs
					GameEventBaseRunner runner = new GameEventBaseRunner();
					runner.runnerId = runnerId;
					if (m_responsiblePitchers.ContainsKey(runnerId))
					{
						runner.responsiblePitcherId = m_responsiblePitchers[runnerId];
					}
					else
					{
						runner.responsiblePitcherId = "";
						AddParsingError(m_currEvent, $"Couldn't find responsible pitcher for runner {runnerId} in update '{newState.lastUpdate}'");
					}

					runner.baseBeforePlay = baseIndex + 1;
					runner.baseAfterPlay = baseIndex + 1;
					m_currEvent.baseRunners.Add(runner);
				}
				else
				{
					// What the hell else could have happened?
					AddParsingError(m_currEvent, $"Baserunner {runnerId} missing from base {baseIndex + 1}, but there were no outs and score went from {oldScore} to {newScore}");
				}
			}

			// Add the homering batter as a baserunner
			if (m_currEvent.eventType == GameEventType.HOME_RUN)
			{
				GameEventBaseRunner runner = new GameEventBaseRunner();
				runner.runnerId = newState.BatterId ?? m_oldState.BatterId;
				runner.responsiblePitcherId = newState.PitcherId;
				runner.baseBeforePlay = 0;
				runner.runsScored += 1;
				runner.baseAfterPlay = newState.BatterTeamBases;
				m_currEvent.baseRunners.Add(runner);
			}



			// Last thing - if we just changed innings, clear the responsible pitcher list
			// Note that we do this AFTER attributing baserunners who may have just done something on this play
			// and whose pitcher was from this old inning
			if (newState.inning != m_oldState.inning)
			{
				m_responsiblePitchers.Clear();
			}

		}

		/// <summary>
		/// Update metadata like the leadoff flag and lineupPosition
		/// </summary>
		private void UpdateLineupInfo(Game newState)
		{
			// Track first batter in each inning
			if(CanStartInning(newState))
			{
				StartInning(newState);
				m_currEvent.isLeadoff = true;
			}
		}

		private bool UpdateSpecialNonsense(Game newState)
		{
			if (newState.lastUpdate.Contains("is Shelled and cannot escape!"))
			{
				m_currEvent.eventType = GameEventType.SHELLED_ATBAT;
				return true;
			}

			if(newState.lastUpdate.Contains("The Black Hole swallows the Runs"))
			{
				m_currEvent.eventType = GameEventType.BLACK_HOLE;
				return true;
			}

			if(newState.lastUpdate.Contains("Sun 2 smiles."))
			{
				m_currEvent.eventType = GameEventType.SUN_2;
				return true;
			}

			return false;
		}


		private List<(string, string)> m_simpleOutcomes;

		private void UpdateOutcomes(Game newState)
		{
			foreach(var outcome in m_simpleOutcomes)
			{
				if(Regex.IsMatch(newState.lastUpdate, ".*"+outcome.Item2+".*"))
				{
					Outcome o = new Outcome(newState.lastUpdate);
					o.eventType = outcome.Item1;
					m_currEvent.outcomes.Add(o);
				}
			}

		}

		/// <summary>
		/// Final check for obvious errors in the event we're about to emit
		/// </summary>
		private void ErrorCheckBeforeEmit(GameEvent toEmit)
		{
			// Game Over events can't really have errors
			// Neither can crazy weather effects
			if(toEmit.isLastGameEvent == true || 
				toEmit.eventType == GameEventType.GAME_OVER ||
				toEmit.eventType == GameEventType.BLACK_HOLE ||
				toEmit.eventType == GameEventType.SUN_2)
			{
				return;
			}

			// UNKNOWN_OUT events are already as fixed as they can get
			if(toEmit.eventType == GameEventType.UNKNOWN_OUT)
			{
				return;
			}

			if(toEmit.baseRunners.Count > 0)
			{
				foreach(var runner in toEmit.baseRunners)
				{
					if(runner.runnerId == null)
					{
						AddParsingError(toEmit, $"Emitted an event with a NULL runnerId");
						runner.runnerId = "";
					}
				}
			}
			if(toEmit.batterId == null)
			{
				AddParsingError(toEmit, $"Emitted an event with NULL batterId");
			}
			if (toEmit.pitcherId == null)
			{
				AddParsingError(toEmit, $"Emitted an event with NULL pitcherId");
			}
			if(toEmit.eventType == GameEventType.UNKNOWN)
			{
				AddParsingError(toEmit, "Unknown event type");
			}
		}

		private void UpdateScoreChanges(Game newState)
		{
			float oldScoreDiff = m_oldState.homeScore - m_oldState.awayScore;
			float newScoreDiff = newState.homeScore - newState.awayScore;

			// Should leave us with 1 = home winning, 0 = tied, -1 = away winning
			if (oldScoreDiff != 0)
				oldScoreDiff /= Math.Abs(oldScoreDiff);
			if(newScoreDiff != 0)
				newScoreDiff /= Math.Abs(newScoreDiff);

			// If the lead changed
			if(oldScoreDiff != newScoreDiff)
			{
				if(newScoreDiff > 0)
				{
					// Home is now winning
					var leadingRunner = m_currEvent.baseRunners.Where(x => x.runsScored > 0).OrderByDescending(x => x.baseBeforePlay).FirstOrDefault();
					m_awayOwningPitcher = leadingRunner?.responsiblePitcherId ?? m_awayOwningPitcher;
				}
				else if(newScoreDiff < 0)
				{
					// Away is now winning
					var leadingRunner = m_currEvent.baseRunners.Where(x => x.runsScored > 0).OrderByDescending(x => x.baseBeforePlay).FirstOrDefault();
					m_homeOwningPitcher = leadingRunner?.responsiblePitcherId ?? m_homeOwningPitcher;
				}
			}
		}

		public void EmitEvent(Game newState, DateTime timestamp, bool startFromCurrent = false)
		{
			GameEvent emitted = m_currEvent;
			m_eventIndex++;

			// If this was a steal or caught stealing, OR the caller want to start from this current state
			if (startFromCurrent || m_currEvent.isSteal || m_currEvent.eventType == GameEventType.CAUGHT_STEALING)
			{
				// Start the next event in this state
				m_currEvent = CreateNewGameEvent(newState, timestamp);
			}
			else
			{
				// Start the next event in the next state
				m_currEvent = null;
			}

			ErrorCheckBeforeEmit(emitted);
			m_gameEvents.Add(emitted);

			EventComplete?.Invoke(this, new GameEventCompleteEventArgs(emitted));
		}

		public enum PlayCountStatus
		{
			Increment,
			Decrease,
			Gap,
			NotFound
		}

		// Checks whether the playCount increased correctly
		// Returns a descriptor for the current playCount state
		public PlayCountStatus CheckPlayCount(Game newState)
		{
			if(m_oldState.playCount.HasValue && newState.playCount.HasValue)
			{
				int diff = newState.playCount.Value - m_oldState.playCount.Value;

				if(diff == 1)
				{
					return PlayCountStatus.Increment;
				}
				else if(diff < 0)
				{
					//if (m_currEvent != null)
					//{
					//	m_currEvent.parsingError = true;
					//	m_currEvent.parsingErrorList.Add($"Out of order! playCount went from {m_oldState.playCount.Value} to {newState.playCount.Value}");
					//}
					return PlayCountStatus.Decrease;
				}
				else
				{
					//if (m_currEvent != null)
					//{
					//	m_currEvent.parsingError = true;
					//	m_currEvent.parsingErrorList.Add($"Data gap! playCount went from {m_oldState.playCount.Value} to {newState.playCount.Value}");
					//}
					return PlayCountStatus.Gap;
				}
			}
			else
			{
				return PlayCountStatus.NotFound;
			}
		}

		// Checks the new message and advances the inning state machine
		// Returns TRUE on a valid transition and FALSE on an invalid one (meaning a data gap)
		public bool CheckInningState(Game newState)
		{
			// Init can transition to GameStart when it sees "Play Ball!"
			if(m_inningState == InningState.Init && 
				newState.lastUpdate.Contains("Play ball!"))
			{
				m_inningState = InningState.GameStart;
				return true;
			}
			// GameStart, OutingMessage and PlayEnded go to HalfInningStart on a "Top of" or "Bottom of"
			else if((m_inningState == InningState.GameStart || m_inningState == InningState.PlayEnded || m_inningState == InningState.OutingMessage) && 
				IsStartOfInningMessage(newState))
			{
				m_inningState = InningState.HalfInningStart;
				return true;
			}
			// HalfInningStart and PlayEnded both go to BatterMessage on a "batting for the"
			else if((m_inningState == InningState.HalfInningStart || m_inningState == InningState.PlayEnded) &&
				IsNewBatterMessage(newState))
			{
				m_inningState = InningState.BatterMessage;

				return true;
			}
			else if((m_inningState == InningState.PlayEnded && IsOutingMessage(newState)))
			{
				m_inningState = InningState.OutingMessage;

				return true;
			}
			else if(m_inningState == InningState.HalfInningStart && newState.BatterId == null)
			{
				// Just stay in HalfInningStart until we see the BatterMessage
				return true;
			}
			// BatterMessage goes to ValidBatter on an update with a non-null batter ID
			else if(m_inningState == InningState.BatterMessage && 
				(newState.BatterId != null) &&
				(newState.BatterId == m_oldState.BatterId))
			{
				m_inningState = InningState.ValidBatter;
				return true;
			}
			// ValidBatter and BatterMessage can both go to PlayEnded on a null batter ID
			else if((m_inningState == InningState.ValidBatter || m_inningState == InningState.BatterMessage) && 
				(newState.BatterId == null) &&
				(newState.gameComplete == false))
			{
				m_inningState = InningState.PlayEnded;
				return true;
			}
			// ValidBatter stays in the same state as long as the same batter is up
			else if(m_inningState == InningState.ValidBatter && 
				(newState.BatterId == m_oldState.BatterId))
			{
				// Stay in ValidBatter
				return true;
			}
			// In Season 3 and earlier the state machine wasn't as good; the fielding team had valid batters still listed
			// in every update so there was no play-ending NULL batter when half-innings swap
			else if((m_inningState == InningState.ValidBatter || m_inningState == InningState.BatterMessage) &&
				(newState.BatterId != m_oldState.BatterId) &&
				(newState.season <= 2))
			{
				m_inningState = InningState.PlayEnded;
				return true;
			}
			// PlayEnded can go to GameOver when the game completes
			else if(m_inningState == InningState.PlayEnded &&
				(newState.gameComplete == true ))
			{
				m_inningState = InningState.GameOver;
				return true;
			}

			//////////////////////////
			// FAILURE STATES
			// All the valid transitions were above - below we need to return FALSE but still get ourselves back into the correct state

			if(IsOutingMessage(newState))
			{
				m_inningState = InningState.OutingMessage;
			}
			if(IsNewBatterMessage(newState))
			{
				// Bad transition, but we know we're back in BatterMessage
				m_inningState = InningState.BatterMessage;
			}
			else if(IsStartOfInningMessage(newState))
			{
				// Bad transition, but we know we're back in HalfInningStart
				m_inningState = InningState.HalfInningStart;
			}
			// Check for GameOver before PlayEnded because they both have a null batter ID
			else if(newState.gameComplete == true)
			{
				m_inningState = InningState.GameOver;
			}
			else if(newState.BatterId == null)
			{
				m_inningState = InningState.PlayEnded;
			}
			else if(newState.BatterId != null)
			{
				m_inningState = InningState.ValidBatter;
			}

			return false;
		}

		public bool endOfGameHappened(Game oldState, Game newState)
		{
			return (oldState.inning >= 8 && oldState.inning == newState.inning && oldState.topOfInning == newState.topOfInning && oldState.halfInningOuts == 2 && newState.halfInningOuts == 0);
		}

		public int outsBetween(Game oldState, Game newState)
		{
			if (newState.gameComplete || endOfGameHappened(oldState, newState))
			{
				// On game complete it resets to 0 outs, ugh
				// So pretend we were passed the next half-inning
				var inning = newState.topOfInning ? newState.inning : newState.inning + 1;
				var top = !newState.topOfInning;

				return outsBetween(oldState.inning, oldState.topOfInning, oldState.halfInningOuts, inning, top, newState.halfInningOuts);
			}
			else
			{
				return outsBetween(oldState.inning, oldState.topOfInning, oldState.halfInningOuts, newState.inning, newState.topOfInning, newState.halfInningOuts);
			}
		}

		public int outsBetween(int startInning, bool startTop, int startOuts, int endinning, bool endTop, int endOuts)
		{
			if (endinning < startInning || 
				(endinning == startInning && startTop == false && endTop == true) ||
				(startInning == endinning && startTop == endTop && endOuts < startOuts))
			{
				//Console.WriteLine($"S{m_oldState.season}D{m_oldState.day} Game {m_oldState.gameId} updates out of order! Old state was {(startTop?"Top":"Bot")}{startInning}, {startOuts} outs. New state was {(endTop?"Top":"Bot")}{endinning}, {endOuts} outs.");
				//throw new InvalidOperationException("End time is before start time");
				return 0;
			}
			int currInning = startInning;
			bool currTop = startTop;
			int currOuts = startOuts;

			int outsBetween = 0;
			while(!(currInning == endinning && currTop == endTop && currOuts == endOuts))
			{
				currOuts++;
				outsBetween++;

				if(currOuts == 3)
				{
					if(currTop)
					{
						currTop = false;
						currOuts = 0;
					}
					else
					{
						currTop = true;
						currInning++;
						currOuts = 0;
					}
				}
			}

			return outsBetween;
		}

		// Set the inning state for the current event to match the new Game state
		public void SetInningState(Game newState)
		{
			if (m_currEvent != null)
			{
				m_currEvent.inning = newState.inning;
				m_currEvent.topOfInning = newState.topOfInning;
				m_currEvent.batterTeamId = newState.topOfInning ? newState.awayTeam : newState.homeTeam;
				m_currEvent.batterId = newState.topOfInning ? newState.awayBatter : newState.homeBatter;
				m_currEvent.pitcherTeamId = newState.topOfInning ? newState.homeTeam : newState.awayTeam;
				m_currEvent.pitcherId = newState.topOfInning ? newState.homePitcher : newState.awayPitcher;
			}
		}

		/// <summary>
		/// Call this with every game update for the game this parser is handling
		/// </summary>f
		/// <param name="newState"></param>
		/// <param name="timeStamp"></param>
		/// <returns></returns>
		public async Task ParseGameUpdate(Game newState, DateTime timeStamp, bool ignoreGaps = false)
		{
			// Remove any leading/trailing whitespace and newlines inside the update string
			newState.lastUpdate = newState.lastUpdate.Trim();
			newState.lastUpdate = newState.lastUpdate.Replace("\n", " ");

			bool dupe = CheckForDuplicateUpdate(newState.chroniclerHash);

			if (IsGameComplete)
			{
				m_discards++;
				return;
			}
			if(dupe || newState.Equals(m_oldState))
			{
				//Console.WriteLine($"Discarded update from game {newState._id} as a duplicate.");
				m_discards++;
				return;
			}
			else if(newState.gameId != m_oldState.gameId)
			{
				Console.WriteLine("ERROR: GameEventParser got an update for the wrong game!");
				m_discards++;
				return;
			}
			else
			{
				m_processed++;
			}

			Debugger.Log(0, "Reorder", $"## ParseGameUpdate for state {newState.playCount} ##\n");
			PlayCountStatus playCountState = CheckPlayCount(newState);

			if(ignoreGaps && playCountState == PlayCountStatus.Gap)
			{
				if (m_currEvent != null)
				{
					m_currEvent.parsingError = true;
					m_currEvent.parsingErrorList.Add($"Data gap! playCount went from {m_oldState.playCount.Value} to {newState.playCount.Value} despite reorder attempt");
				}
			}
			else
			{
				// This gap is probably unfixable
				if (m_pendingStates.Count > 5 || newState.gameComplete == true)
				{
					Debugger.Log(0, "Reorder", $"Gave up waiting for pending state {m_oldState.playCount + 1}!\n");
					var ordered = m_pendingStates.OrderBy(x => x.playCount).ToList();
					m_pendingStates.Clear();
					foreach (var state in ordered)
					{
						Debugger.Log(0, "Reorder", $"Parsing pending state {state.playCount}...\n");
						// Recurse, yikes
						await ParseGameUpdate(state, state.timestamp, true);
					}
				}
				else if (playCountState == PlayCountStatus.Gap && m_oldState.playCount.HasValue)
				{
					// Process this later!
					Debugger.Log(0, "Reorder", $"Found a gap from {m_oldState.playCount} to {newState.playCount}! Shelving {newState.playCount}\n");
					m_seenUpdates.Remove(newState.chroniclerHash);
					m_pendingStates.Add(newState);
					return;
				}
				else if (playCountState == PlayCountStatus.Decrease)
				{
					Debugger.Log(0, "Reorder", $"Got a decreasing play count! Probably means we got the first few events out of order. Dropping the decreasing one...\n");
					// Discard this event, we're past it and committed already
					return;
				}

				//if (playCountState == PlayCountStatus.Decrease)
				//{
				//	string s = $"# Game {newState.gameId} : out of order playCount : {m_oldState.playCount} -> {newState.playCount}\n";
				//	Debugger.Log(0, "OutOfOrder", s);
				//	Console.Write(s);
				//}
				//else if (playCountState == PlayCountStatus.Gap)
				//{
				//	string s = $"# Game {newState.gameId} : gap in playCount : {m_oldState.playCount} -> {newState.playCount}\n";
				//	Debugger.Log(0, "Gap", s);
				//	Console.Write(s);
				//}
			}

			bool validInningState = CheckInningState(newState);

			if(m_currEvent != null && m_inningState == InningState.HalfInningStart)
			{
				SetInningState(newState);
			}

			// DATA GAP DETECTION
			// If we had an invalid transition on our inning state machine, something weird happened
			if (!validInningState)
			{
				int missedOuts = outsBetween(m_oldState, newState);

				int currInning = m_oldState.inning;
				bool currTop = m_oldState.topOfInning;
				int currOuts = m_oldState.halfInningOuts;

				// If we ended up in a PlayEnded state, this event is an out
				if(m_inningState == InningState.PlayEnded)
				{
					// So we didn't miss this one
					missedOuts--;
				}

				// Fill in any fully missing outs; the last out will be part of this event one way or another
				for(int i = 0; i < missedOuts; i++)
				{
					if(m_currEvent == null)
					{
						m_currEvent = CreateNewGameEvent(newState, timeStamp);
					}
					m_currEvent.fixedError = true;
					m_currEvent.fixedErrorList.Add("Dummy event for missing out");
					m_currEvent.eventType = GameEventType.UNKNOWN_OUT;
					m_currEvent.eventText.Add("Unknown out.");
					m_currEvent.inning = currInning;
					m_currEvent.topOfInning = currTop;
					m_currEvent.outsBeforePlay = currOuts;
					m_currEvent.outsOnPlay = 1;
					m_currEvent.baseRunners = new List<GameEventBaseRunner>();

					m_currEvent.batterTeamId = currTop ? newState.awayTeam : newState.homeTeam;
					m_currEvent.batterId = currTop ? newState.awayBatter : newState.homeBatter;
					m_currEvent.pitcherTeamId = currTop ? newState.homeTeam : newState.awayTeam;
					m_currEvent.pitcherId = currTop ? newState.homePitcher : newState.awayPitcher;

					// Increment to the next out
					currOuts++;
					if (currOuts == 3)
					{
						if (currTop)
						{
							currTop = false;
							currOuts = 0;
						}
						else
						{
							currTop = true;
							currInning++;
							currOuts = 0;
						}
					}

					// After incrementing, advance the "old state" to where we are now
					m_oldState = m_oldState.ShallowCopy();
					m_oldState.halfInningOuts = currOuts;
					m_oldState.inning = currInning;
					m_oldState.topOfInning = currTop;
					// We're just simulating unknown outs, we can't keep track of baserunners
					m_oldState.basesOccupied.Clear();
					m_oldState.baseRunners.Clear();

					EmitEvent(newState, timeStamp, true);
				}

				// If needed, set up an event we're creating with the correct adjusted "before" state
				m_currEvent = CreateNewGameEvent(newState, timeStamp);
				m_currEvent.outsBeforePlay = currOuts;
				m_currEvent.inning = currInning;
				m_currEvent.topOfInning = currTop;

				m_currEvent.batterTeamId = currTop ? newState.awayTeam : newState.homeTeam;
				m_currEvent.batterId = currTop ? newState.awayBatter : newState.homeBatter;
				m_currEvent.pitcherTeamId = currTop ? newState.homeTeam : newState.awayTeam;
				m_currEvent.pitcherId = currTop ? newState.homePitcher : newState.awayPitcher;
			}

			if (m_currEvent == null)
			{
				m_currEvent = CreateNewGameEvent(newState, timeStamp);
			}

			m_currEvent.updateHashes.Add(newState.chroniclerHash);
			m_currEvent.lastPerceivedAt = timeStamp;

			// If we haven't found the batter for this event yet, try again
			if (m_currEvent.batterId == null)
			{
				m_currEvent.batterId = newState.BatterId;
			}

			if(m_inningState == InningState.BatterMessage || m_inningState == InningState.ValidBatter)
			{
				// If we're in a normal batting state
				// Set this event to the current pitcher (which should always be valid in this state)
				m_currEvent.pitcherId = newState.PitcherId;
			}

			if (m_homeOwningPitcher == null)
			{
				m_homeOwningPitcher = newState.homePitcher;
			}
			if(m_awayOwningPitcher == null)
			{
				m_awayOwningPitcher = newState.awayPitcher;
			}

			// Presume this event will be last; steals can set this to false later
			m_currEvent.isLastEventForPlateAppearance = true;

			UpdateLineupInfo(newState);

			bool specialNonsense = UpdateSpecialNonsense(newState);

			if (!specialNonsense)
			{
				UpdateBallsAndStrikes(newState);

				UpdateOuts(newState);

				UpdateHits(newState);

				// Call after UpdateOuts
				UpdateFielding(newState);

				// Call after UpdateOuts
				UpdateBaserunning(newState);

				// Call after UpdateBaseRunning
				UpdateScoreChanges(newState);
			}

			UpdateOutcomes(newState);

			// Unknown or not currently handled event
			if (m_currEvent.eventType == null)
			{
				m_currEvent.eventType = GameEventType.UNKNOWN;
			}

			// Unsure if this is enough
			m_currEvent.isLastGameEvent = newState.gameComplete;
			IsGameComplete = newState.gameComplete;
			if(IsGameComplete)
			{
				m_currEvent.eventType = GameEventType.GAME_OVER;
				// Just complete however many outs
				//m_currEvent.outsOnPlay = 3 - m_currEvent.outsBeforePlay;
			}

			// Store original update text for reference
			m_currEvent.eventText.Add(newState.lastUpdate);

			// Cycle state
			m_oldState = newState;

			// If we had outs or hits or a walk or a steal, emit
			// OR IF THE GAME IS OVER, duh
			// or hit by a pitch or a wild pitch
			// or the special Black Hole and Sun2 events
			if(m_currEvent.outsOnPlay > 0 
				|| m_currEvent.basesHit > 0 
				|| m_currEvent.isSteal 
				|| m_currEvent.isWalk 
				|| m_currEvent.isLastGameEvent
				|| m_currEvent.eventType == GameEventType.HIT_BY_PITCH
				|| m_currEvent.eventType == GameEventType.WILD_PITCH
				|| m_currEvent.eventType == GameEventType.BLACK_HOLE
				|| m_currEvent.eventType == GameEventType.SUN_2
				|| m_inningState == InningState.PlayEnded)
			{
				EmitEvent(newState, timeStamp);
			}

			if(m_pendingStates.Count > 0)
			{
				var firstPending = m_pendingStates.OrderBy(x => x.playCount).First();
				if(firstPending.playCount == m_oldState.playCount+1)
				{
					Debugger.Log(0, "Reorder", $"First pending state is the next one, {firstPending.playCount}!\n");
					m_pendingStates.Remove(firstPending);
					await ParseGameUpdate(firstPending, firstPending.timestamp);
				}
			}

			if (IsGameComplete && !m_sentGameComplete)
			{
				var lastEvent = m_gameEvents.LastOrDefault();
				var winPitcher = lastEvent.homeScore > lastEvent.awayScore ? m_homeOwningPitcher : m_awayOwningPitcher;
				var losePitcher = lastEvent.homeScore > lastEvent.awayScore ? m_awayOwningPitcher : m_homeOwningPitcher;

				GameComplete?.Invoke(this, new GameCompleteEventArgs(lastEvent.gameId, m_gameEvents, winPitcher, losePitcher));
			}
		}
	}
}