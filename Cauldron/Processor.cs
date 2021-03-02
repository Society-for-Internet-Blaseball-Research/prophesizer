using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace Cauldron
{
	/// <summary>
	/// Basic processor that reads game update JSON objects from a stream and writes GameEvent JSON objects out
	/// </summary>
	public class Processor
	{
		/// <summary>
		/// Parser has state, so store one per game we're tracking
		/// </summary>
		Dictionary<string, GameEventParser> m_trackedGames;
		public Dictionary<string, GameEventParser> TrackedGames => m_trackedGames;

		private readonly JsonSerializerOptions m_serializerOptions;

		public int NumNetworkOutcomes => m_numNetworkOutcomes;
		int m_numNetworkOutcomes = 0;

		public int NumLocalOutcomes => m_numLocalOutcomes;
		int m_numLocalOutcomes = 0;

		/// <summary>
		/// Constructor
		/// </summary>
		public Processor()
		{
			// I like camel case for my C# properties, sue me
			m_serializerOptions = new JsonSerializerOptions();
			m_serializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;

			m_trackedGames = new Dictionary<string, GameEventParser>();
		}

		#region Event-based API

		/// <summary>
		/// Prophesizer registers for GameCompleted event
		/// Prophesizer sends chunks of updates to Processor
		/// Processor waits for each GameEventParser to be finished, then fires GameCompleted with the IEnumerable<GameEvent> for that game
		/// </summary>
		public event EventHandler<GameCompleteEventArgs> GameComplete;

		private void GameCompleteInternal(object sender, GameCompleteEventArgs e)
		{
			GameComplete?.Invoke(this, e);
		}

		public event EventHandler<GameEventCompleteEventArgs> EventComplete;

		private void GameEventCompleteInternal(object sender, GameEventCompleteEventArgs e)
		{
			EventComplete?.Invoke(this, e);
		}
		
		#endregion


		/// <summary>
		/// Process a single game update object
		/// </summary>
		/// <param name="game">update object</param>
		/// <param name="timestamp">time this object was perceived</param>
		/// <param name="hash">unique hash for this update</param>
		public async Task ProcessGameObject(Game game, DateTime? inTimestamp)
		{
			DateTime timestamp;
			// If timestamp is missing or stupid, look it up in our list of known bummers
			if (inTimestamp == null || inTimestamp == TimestampConverter.unixEpoch || inTimestamp == DateTime.MinValue)
			{
				timestamp = GetKnownBummerTimestamp(game.season, game.day);
			}
			else
			{
				timestamp = inTimestamp.Value;
			}

			// Add new games if needed
			if (!m_trackedGames.ContainsKey(game.gameId))
			{
				GameEventParser parser = new GameEventParser();
				parser.EventComplete += GameEventCompleteInternal;
				parser.GameComplete += GameCompleteInternal;
				bool networkOutcomes = parser.StartNewGame(game, timestamp);

				if (networkOutcomes)
					m_numNetworkOutcomes++;
				else
					m_numLocalOutcomes++;

				m_trackedGames[game.gameId] = parser;
			}
			else
			{
				// Update a current game
				GameEventParser parser = m_trackedGames[game.gameId];
				await parser.ParseGameUpdate(game, timestamp);
			}
		}

		private DateTime GetKnownBummerTimestamp(int season, int day)
		{
			switch(season)
			{
				case 3:
					{
						switch(day)
						{
							case 71: return new DateTime(2020, 8, 28, 1, 0, 0);
							case 72: return new DateTime(2020, 8, 28, 2, 0, 0);
						}
						break;
					}
					
			}

			return TimestampConverter.unixEpoch;
		}

		private async Task ProcessUpdateString(string obj)
		{
			Update update = null;
			try
			{
				update = JsonSerializer.Deserialize<Update>(obj, m_serializerOptions);
			}
			catch(System.Text.Json.JsonException ex)
			{
				Console.WriteLine(ex.Message);
				Console.WriteLine($"While processing: {obj}");
			}

			// Currently we only care about the 'schedule' field that has the game updates
			if (update.Schedule != null)
			{
				foreach (var game in update.Schedule)
				{
					var timestamp = update?.clientMeta?.timestamp;

					await ProcessGameObject(game, timestamp);
				}
			}
		}

		public async Task Process(StreamReader newlineDelimitedJson)
		{
			if (GameComplete == null)
				throw new InvalidOperationException("Please listen for the GameComplete event before calling Process()");
			while (!newlineDelimitedJson.EndOfStream)
			{
				string obj = newlineDelimitedJson.ReadLine();

				await ProcessUpdateString(obj);
			}
		}

		public async Task Process(string newlineDelimitedJson)
		{
			StringReader sr = new StringReader(newlineDelimitedJson);
			string line = sr.ReadLine();
			while (line != null)
			{
				await ProcessUpdateString(line);
				line = sr.ReadLine();
			}
		}

	}
}
