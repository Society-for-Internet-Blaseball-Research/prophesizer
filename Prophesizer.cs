using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using Cauldron;
using Npgsql;
using prophesizer;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace SIBR
{
	struct SimulationData
	{
		public int Season { get; set; }
		public int Day { get; set; }
	}

	class Prophesizer
	{

		int m_gameEventId = 0;
		private Queue<GameEvent> m_eventsToInsert;
		private Queue<(string, string, string)> m_pitcherResults;

		private JsonSerializerOptions serializerOptions;

		private const int MAX_SEASON = 8;
		private const int MAX_DAY = 135;

		private SeasonDay m_lastKnownSeasonDay;

		private const bool TIMING = false;
		private const bool TIMING_FILE = true;
		private const bool DO_HOURLY = true;
		private const bool DO_EVENTS = true;

		private HttpClient m_chroniclerClient;
		private HttpClient m_blaseballClient;

		private JsonSerializerOptions m_options;

		private object _eventLocker = new object();
		private object _pitcherLocker = new object();

		private SeasonDay m_dbSeasonDay;
		private DateTime? m_dbGameTimestamp;
		private DateTime? m_dbTeamTimestamp;
		private DateTime? m_dbPlayerTimestamp;

		public Prophesizer(string bucketName)
		{
			//m_processor = new Processor();
			m_eventsToInsert = new Queue<GameEvent>();
			m_pitcherResults = new Queue<(string, string, string)>();

			serializerOptions = new JsonSerializerOptions();
			serializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
			serializerOptions.PropertyNameCaseInsensitive = true;
			serializerOptions.IgnoreNullValues = true;

			m_chroniclerClient = new HttpClient();
			m_chroniclerClient.BaseAddress = new Uri("https://api.sibr.dev/chronicler/v1/");
			m_chroniclerClient.DefaultRequestHeaders.Accept.Clear();
			m_chroniclerClient.DefaultRequestHeaders.Accept.Add(
				new MediaTypeWithQualityHeaderValue("application/json"));

			m_blaseballClient = new HttpClient();
			m_blaseballClient.BaseAddress = new Uri("https://www.blaseball.com/database/");
			m_blaseballClient.DefaultRequestHeaders.Accept.Clear();
			m_blaseballClient.DefaultRequestHeaders.Accept.Add(
				new MediaTypeWithQualityHeaderValue("application/json"));

			m_options = new JsonSerializerOptions();
			m_options.IgnoreNullValues = true;
			m_options.PropertyNameCaseInsensitive = true;
		}

		/// <summary>
		/// Get the last season & day that we've recorded in the DB
		/// </summary>
		private async Task<(SeasonDay, DateTime?, DateTime?, DateTime?)> GetChroniclerMeta(NpgsqlConnection psqlConnection)
		{
			int season = 0;
			int day = 0;
			DateTime? game_time = null;
			DateTime? team_time = null;
			DateTime? player_time = null;

			NpgsqlCommand cmd = new NpgsqlCommand(@"select season, day, game_timestamp, team_timestamp, player_timestamp from data.chronicler_meta where id=0", psqlConnection);

			using (var reader = await cmd.ExecuteReaderAsync())
			{
				while (await reader.ReadAsync())
				{
					season = reader.GetInt32(0);
					day = reader.GetInt32(1);
					if (!reader.IsDBNull(2))
					{
						game_time = reader.GetDateTime(2);
					}
					if(!reader.IsDBNull(3))
					{
						team_time = reader.GetDateTime(3);
					}
					if(!reader.IsDBNull(4))
					{
						player_time = reader.GetDateTime(4);
					}
				}
			}

			return (new SeasonDay(season, day), game_time, team_time, player_time);
		}

		const int NUM_EVENTS_REQUESTED = 1000;

		/// <summary>
		/// Get all the updates for a given day and process them through Cauldron
		/// </summary>
		public async Task<bool> FetchAndProcessFullDay(SeasonDay dayToFetch)
		{
			bool continueDay = true;
			int numUpdatesForDay = 0;
			string nextPage = null;

			Processor processor = new Processor();
			processor.EventComplete += Processor_EventComplete;
			processor.GameComplete += Processor_GameComplete;

			while (continueDay)
			{
				string query;
				if (nextPage != null)
				{
					query = $"games/updates?season={dayToFetch.Season}&day={dayToFetch.Day}&order=asc&started=true&count={NUM_EVENTS_REQUESTED}&page={nextPage}";
				}
				else
				{
					query = $"games/updates?season={dayToFetch.Season}&day={dayToFetch.Day}&order=asc&started=true&count={NUM_EVENTS_REQUESTED}";
				}

				var page = await ChroniclerQuery<ChroniclerUpdate>(query);
				int numUpdates = 0;

				if (page != null)
				{

					var updates = page.Data;
					numUpdates = updates.Count();
					numUpdatesForDay += numUpdates;

					if (numUpdates == NUM_EVENTS_REQUESTED)
					{
						continueDay = true;
						nextPage = page.NextPage;
					}
					else
					{
						continueDay = false;
						nextPage = null;
					}

					foreach (var obj in updates)
					{
						await processor.ProcessGameObject(obj.Data, obj.Timestamp);
					}

				}
			}

			processor.EventComplete -= Processor_EventComplete;
			processor.GameComplete -= Processor_GameComplete;

			//Console.WriteLine($"Finished loading season {dayToFetch.Season}, day {dayToFetch.Day}.");
			return numUpdatesForDay > 0;
		}


		public async Task Poll()
		{
			ConsoleOrWebhook($"Started poll at {DateTime.UtcNow.ToString()} UTC.");

			await using var psqlConnection = new NpgsqlConnection(Environment.GetEnvironmentVariable("PSQL_CONNECTION_STRING"));
			await psqlConnection.OpenAsync();

			await PopulateGameTable(psqlConnection);

			// Last day recorded in the DB
			(m_dbSeasonDay, m_dbGameTimestamp, m_dbTeamTimestamp, m_dbPlayerTimestamp) = await GetChroniclerMeta(psqlConnection);
			// Current day according to blaseball.com
			SeasonDay simSeasonDay;

			var response = await m_blaseballClient.GetAsync("simulationData");
			if (response.IsSuccessStatusCode)
			{
				string strResponse = await response.Content.ReadAsStringAsync();
				var simData = JsonSerializer.Deserialize<SimulationData>(strResponse, m_options);
				simSeasonDay = new SeasonDay(simData.Season, simData.Day);
			}
			else
			{
				throw new InvalidDataException("Couldn't get current simulation data from blaseball!");
			}

			if (DO_HOURLY)
			{
				await LoadTeamUpdates(psqlConnection);
				await LoadPlayerUpdates(psqlConnection);
			}


			if (DO_EVENTS)
			{
				// TODO store current time

				if (m_dbSeasonDay < simSeasonDay)
				{
					await BatchLoadGameUpdates(psqlConnection, m_dbSeasonDay, simSeasonDay);
				}

				await IncrementalUpdate(psqlConnection, simSeasonDay, m_dbGameTimestamp);
			}

			var msg = $"Finished poll at {DateTime.UtcNow.ToString()} UTC.";
			ConsoleOrWebhook(msg);
		}

		private int GetMaxGameEventId(NpgsqlConnection psqlConnection)
		{
			var getMaxGameEventId = new NpgsqlCommand("select max(id) from data.game_events", psqlConnection);
			var response = getMaxGameEventId.ExecuteScalar();
			if (response is DBNull)
			{
				return 0;
			}
			else
			{
				return (int)response + 1;
			}
		}

		private Processor m_processor = new Processor();

		

		private async Task IncrementalUpdate(NpgsqlConnection psqlConnection, SeasonDay startAt, DateTime? afterTime)
		{
			m_gameEventId = GetMaxGameEventId(psqlConnection);

			bool morePages = true;
			string nextPage = null;
			DateTime? lastSeenGameTime = null;

			while (morePages)
			{
				string query;
				if (afterTime.HasValue)
				{
					query = $"games/updates?after={afterTime.Value.ToString("yyyy-MM-ddTHH:mm:ssZ")}&order=asc&started=true&count={NUM_EVENTS_REQUESTED}";
					if (nextPage != null)
					{
						query += $"&page={nextPage}";
					}
					
				}
				else
				{
					query = $"games/updates?season={startAt.Season}&day={startAt.Day}&order=asc&started=true&count={NUM_EVENTS_REQUESTED}";
					if (nextPage != null)
					{
						query += $"&page={nextPage}";
					}
				}

				var page = await ChroniclerQuery<ChroniclerUpdate>(query);
				HttpResponseMessage response = await m_chroniclerClient.GetAsync(query);

				if (page != null)
				{
					nextPage = page.NextPage;

					if (page.Data.Count() == 0)
					{
						Console.WriteLine("Got no data from Chronicler!");
						break;
					}
					else if(page.Data.Count() == NUM_EVENTS_REQUESTED)
					{
						morePages = true;
					}
					else
					{
						morePages = false;
					}

					m_processor.EventComplete += Processor_EventComplete;
					m_processor.GameComplete += Processor_GameComplete;
					foreach (var update in page.Data)
					{
						//Console.WriteLine($"    Processing update {update.Hash}");
						lastSeenGameTime = update.Timestamp;
						await m_processor.ProcessGameObject(update.Data, update.Timestamp, update.Hash);
					}
					m_processor.EventComplete -= Processor_EventComplete;
					m_processor.GameComplete -= Processor_GameComplete;

					Console.WriteLine($"  Processed {page.Data.Count()} updates (through {page.Data.Last().Timestamp}).\n  Inserting {m_eventsToInsert.Count()} game events and {m_pitcherResults.Count()} pitching results...");
					// Process any game events we received
					while (m_eventsToInsert.Count > 0)
					{
						var ev = m_eventsToInsert.Dequeue();
						await PersistGame(psqlConnection, ev, m_gameEventId);
						m_gameEventId++;
					}

					// Process any pitcher results from completed games
					while (m_pitcherResults.Count > 0)
					{
						var result = m_pitcherResults.Dequeue();
						await PersistPitcherResults(psqlConnection, result.Item1, result.Item2, result.Item3);
					}

				}
			}

			if (lastSeenGameTime.HasValue)
			{
				NpgsqlCommand updateCmd = new NpgsqlCommand(@"UPDATE data.chronicler_meta SET game_timestamp=@ts WHERE id=0", psqlConnection);
				updateCmd.Parameters.AddWithValue("ts", lastSeenGameTime);
				int updateResult = await updateCmd.ExecuteNonQueryAsync();
			}
		}

		/// <summary>
		/// Load updates from Chronicler by going wide
		/// </summary>
		private async Task BatchLoadGameUpdates(NpgsqlConnection psqlConnection, SeasonDay startAfter, SeasonDay stopBefore)
		{
			const int NUM_TASKS = 10;

			m_gameEventId = GetMaxGameEventId(psqlConnection);
			SeasonDay currSeasonDay = startAfter+1;

			while (currSeasonDay < stopBefore)
			{
				// Fetch and process 10 days at a time
				Task<bool>[] tasks = new Task<bool>[NUM_TASKS];

				for (int i = 0; i < NUM_TASKS; i++)
				{
					SeasonDay dayToFetch = new SeasonDay(currSeasonDay.Season, currSeasonDay.Day + i);

					if (dayToFetch < stopBefore)
					{
						tasks[i] = Task.Run(() => FetchAndProcessFullDay(dayToFetch));
					}
					else
					{
						tasks[i] = Task.Run(() => false );
					}
				}

				Console.WriteLine($"Processing Season {currSeasonDay.Season}, Days {currSeasonDay.Day}-{currSeasonDay.Day+NUM_TASKS-1}");
				// Wait for all 10 tasks to complete; SQL work has to be done on a single thread
				Task.WaitAll(tasks);

				// Start a transaction for all we'll update
				var transaction = psqlConnection.BeginTransaction();

				Console.WriteLine($"  Inserting {m_eventsToInsert.Count()} game events and {m_pitcherResults.Count()} pitching results...");

				// Process any game events we received
				if (m_eventsToInsert.Count > 0)
				{
					await CopyGameEvents(psqlConnection, m_eventsToInsert);
					await PersistTimeMap(m_eventsToInsert, psqlConnection);
					m_eventsToInsert.Clear();
				}


				// Process any pitcher results from completed games
				while (m_pitcherResults.Count > 0)
				{
					var result = m_pitcherResults.Dequeue();
					await PersistPitcherResults(psqlConnection, result.Item1, result.Item2, result.Item3);
				}

				NpgsqlCommand updateCmd = new NpgsqlCommand(@"
					INSERT INTO data.chronicler_meta(id, season, day, game_timestamp) values (0, @season, @day, null)
					ON CONFLICT(id) DO UPDATE SET season=EXCLUDED.season, day=EXCLUDED.day, game_timestamp=null", 
					psqlConnection);
				updateCmd.Parameters.AddWithValue("season", currSeasonDay.Season);
				updateCmd.Parameters.AddWithValue("day", currSeasonDay.Day + NUM_TASKS-1);
				int updateResult = await updateCmd.ExecuteNonQueryAsync();

				await transaction.CommitAsync();

				currSeasonDay += NUM_TASKS;

			}
		}

		private void Processor_EventComplete(object sender, GameEventCompleteEventArgs e)
		{
			if (e.GameEvent == null)
				Debugger.Break();
			lock (_eventLocker)
			{
				m_eventsToInsert.Enqueue(e.GameEvent);
			}
		}

		private void Processor_GameComplete(object sender, GameCompleteEventArgs e)
		{
			lock (_pitcherLocker)
			{
				m_pitcherResults.Enqueue((e.GameId, e.WinningPitcherId, e.LosingPitcherId));
			}
		}

		private async Task CopyGameEvents(NpgsqlConnection psqlConnection, Queue<GameEvent> gameEvents)
		{
			List<(int, GameEventBaseRunner)> runners = new List<(int, GameEventBaseRunner)>();
			List<(int, Outcome)> outcomes = new List<(int, Outcome)>();

			using(var writer = psqlConnection.BeginBinaryImport(
				@"COPY data.game_events(
					id, perceived_at, game_id, event_type, event_index, inning, top_of_inning, outs_before_play,
					batter_id, batter_team_id, pitcher_id, pitcher_team_id, home_score, away_score,
					home_strike_count, away_strike_count, batter_count, pitches, total_strikes,
					total_balls, total_fouls, is_leadoff, is_pinch_hit, lineup_position,
					is_last_event_for_plate_appearance, bases_hit, runs_batted_in, is_sacrifice_hit,
					is_sacrifice_fly, outs_on_play, is_double_play, is_triple_play, is_wild_pitch,
					batted_ball_type, is_bunt, errors_on_play, batter_base_after_play, is_last_game_event,
					event_text, season, day, parsing_error, parsing_error_list, fixed_error, fixed_error_list
				)FROM STDIN (FORMAT BINARY)"))
			{
				foreach(var ge in gameEvents)
				{
					foreach(var runner in ge.baseRunners)
					{
						runners.Add((m_gameEventId, runner));
					}
					foreach(var outcome in ge.outcomes)
					{
						outcomes.Add((m_gameEventId, outcome));
					}
					writer.StartRow();
					writer.Write(m_gameEventId, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.firstPerceivedAt);
					writer.Write(ge.gameId);
					writer.Write(ge.eventType);
					writer.Write(ge.eventIndex, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.inning, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.topOfInning);
					writer.Write(ge.outsBeforePlay, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.batterId);
					writer.Write(ge.batterTeamId);
					writer.Write(ge.pitcherId);
					writer.Write(ge.pitcherTeamId);
					writer.Write(ge.homeScore, NpgsqlTypes.NpgsqlDbType.Numeric);
					writer.Write(ge.awayScore, NpgsqlTypes.NpgsqlDbType.Numeric);
					writer.Write(ge.homeStrikeCount, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.awayStrikeCount, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.batterCount, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.pitchesList, NpgsqlTypes.NpgsqlDbType.Array | NpgsqlTypes.NpgsqlDbType.Varchar);
					writer.Write(ge.totalStrikes, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.totalBalls, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.totalFouls, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.isLeadoff);
					writer.Write(ge.isPinchHit);
					writer.Write(ge.lineupPosition, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.isLastEventForPlateAppearance);
					writer.Write(ge.basesHit, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.runsBattedIn, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.isSacrificeHit);
					writer.Write(ge.isSacrificeFly);
					writer.Write(ge.outsOnPlay, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.isDoublePlay);
					writer.Write(ge.isTriplePlay);
					writer.Write(ge.isWildPitch);
					writer.Write(ge.battedBallType);
					writer.Write(ge.isBunt);
					writer.Write(ge.errorsOnPlay, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.batterBaseAfterPlay, NpgsqlTypes.NpgsqlDbType.Smallint);
					writer.Write(ge.isLastGameEvent);
					writer.Write(ge.eventText);
					writer.Write(ge.season, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.day, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.parsingError);
					writer.Write(ge.parsingErrorList);
					writer.Write(ge.fixedError);
					writer.Write(ge.fixedErrorList);

					m_gameEventId++;
				}

				await writer.CompleteAsync();
			}

			using(var writer = psqlConnection.BeginBinaryImport(
				@"COPY data.game_event_base_runners(
					game_event_id, runner_id, responsible_pitcher_id, base_before_play, base_after_play,
					was_base_stolen, was_caught_stealing, was_picked_off, runner_scored
				)FROM STDIN (FORMAT BINARY)"))
			{
				foreach((var id, var r) in runners)
				{
					writer.StartRow();
					writer.Write(id, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(r.runnerId);
					writer.Write(r.responsiblePitcherId);
					writer.Write(r.baseBeforePlay, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(r.baseAfterPlay, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(r.wasBaseStolen);
					writer.Write(r.wasCaughtStealing);
					writer.Write(r.wasPickedOff);
					writer.Write(r.runnerScored);
				}

				await writer.CompleteAsync();
			}

			using(var writer = psqlConnection.BeginBinaryImport(
				@"COPY data.outcomes(
					game_event_id, entity_id, event_type, original_text
				)FROM STDIN (FORMAT BINARY)"))
			{
				foreach((var id, var o) in outcomes)
				{
					writer.StartRow();
					writer.Write(id, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(o.entityId);
					writer.Write(o.eventType);
					writer.Write(o.originalText);
				}
				await writer.CompleteAsync();
			}
		}

		private async Task PersistGame(NpgsqlConnection psqlConnection, GameEvent gameEvent, int gameEventId)
		{
			using (var gameEventStatement = PrepareGameEventStatement(psqlConnection, gameEvent, gameEventId))
			{
				int id = (int)await gameEventStatement.ExecuteScalarAsync();

				foreach (var baseRunner in gameEvent.baseRunners)
				{
					using (var baseRunnerStatement = PrepareGameEventBaseRunnerStatements(psqlConnection, id, baseRunner))
					{
						await baseRunnerStatement.ExecuteNonQueryAsync();
					}
				}

				foreach (var outcome in gameEvent.outcomes)
				{
					if (outcome.entityId == "UNKNOWN")
					{
						Console.WriteLine($"Found an outcome with unknown entity ID in season {gameEvent.season}, day {gameEvent.day}, game {gameEvent.gameId}");
					}

					using (var playerEventStatement = PrepareOutcomeStatement(psqlConnection, id, outcome))
					{
						await playerEventStatement.ExecuteNonQueryAsync();
					}

				}
			}
		}

		
		private NpgsqlCommand PrepareGameEventStatement(NpgsqlConnection psqlConnection, GameEvent gameEvent, int id)
		{
			var extra = new Dictionary<string, object>();
			extra["id"] = id;
			var cmd = new InsertCommand(psqlConnection, "data.game_events", gameEvent, extra).Command;
			//cmd.Prepare();
			return cmd;
		}

		private NpgsqlCommand PrepareGameEventBaseRunnerStatements(NpgsqlConnection psqlConnection, int gameEventId, GameEventBaseRunner baseRunnerEvent)
		{
			var extra = new Dictionary<string, object>();
			extra["game_event_id"] = gameEventId;
			var cmd = new InsertCommand(psqlConnection, "data.game_event_base_runners", baseRunnerEvent, extra).Command;
			//cmd.Prepare();
			return cmd;
		}

		private NpgsqlCommand PrepareOutcomeStatement(NpgsqlConnection psqlConnection, int gameEventId, Outcome outcome)
		{
			var extra = new Dictionary<string, object>();
			extra["game_event_id"] = gameEventId;
			var cmd = new InsertCommand(psqlConnection, "data.outcomes", outcome, extra).Command;
			//cmd.Prepare();
			return cmd;
		}

		/// <summary>
		/// Helper function to do a query to Chronicler and return a page with generic data
		/// </summary>
		private async Task<ChroniclerPage<T>> ChroniclerQuery<T>(string query)
		{
			HttpResponseMessage response = await m_chroniclerClient.GetAsync(query);

			if (response.IsSuccessStatusCode)
			{
				string strResponse = await response.Content.ReadAsStringAsync();
				return JsonSerializer.Deserialize<ChroniclerPage<T>>(strResponse, serializerOptions);
			}
			else
			{
				Console.WriteLine($"Query [{query}] failed: {response.ReasonPhrase}");
				return null;
			}
		}

		static string TimestampQueryValue(DateTime dt)
		{
			return dt.ToString("yyyy-MM-ddTHH:mm:ssZ");
		}

		private async Task LoadTeamUpdates(NpgsqlConnection psqlConnection)
		{
			const int NUM_REQUESTED = 250;
			string nextPage = null;
			DateTime? lastSeenTeamTime = null;

			while (true)
			{
				string query = $"teams/updates?count={NUM_REQUESTED}";
				if(m_dbTeamTimestamp.HasValue)
				{
					query += $"&after={TimestampQueryValue(m_dbTeamTimestamp.Value)}";
				}
				if (nextPage != null)
				{
					query += $"&page={nextPage}";
				}

				ChroniclerPage<ChroniclerTeam> page = await ChroniclerQuery<ChroniclerTeam>(query);

				if (page == null || page.Data.Count() == 0)
				{
					break;
				}
				else
				{
					nextPage = page.NextPage;

					Console.WriteLine($"  Processing {page.Data.Count()} team updates (through {page.Data.Last().FirstSeen}).");
					lastSeenTeamTime = page.Data.Last().LastSeen;
					await ProcessTeams(psqlConnection, page.Data);

					// We're done!
					if(page.Data.Count() != NUM_REQUESTED)
					{
						break;
					}
				}
			}

			if (lastSeenTeamTime.HasValue)
			{
				NpgsqlCommand updateCmd = new NpgsqlCommand(@"UPDATE data.chronicler_meta SET team_timestamp=@ts WHERE id=0", psqlConnection);
				updateCmd.Parameters.AddWithValue("ts", lastSeenTeamTime);
				int updateResult = await updateCmd.ExecuteNonQueryAsync();
			}
		}

		private async Task ProcessTeams(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerTeam> teams)
		{
			using (MD5 md5 = MD5.Create())
			{
				foreach (var t in teams)
				{
					await ProcessRoster(t.Data, t.FirstSeen, psqlConnection);

					var hash = HashTeamAttrs(md5, t.Data);
					NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.teams where hash=@hash and valid_until is null", psqlConnection);
					cmd.Parameters.AddWithValue("hash", hash);
					//cmd.Prepare();
					var count = (long)await cmd.ExecuteScalarAsync();

					if (count == 1)
					{
						// Record exists
					}
					else
					{
						// Update the old record
						NpgsqlCommand update = new NpgsqlCommand(@"update data.teams set valid_until=@timestamp where team_id = @team_id and valid_until is null", psqlConnection);
						update.Parameters.AddWithValue("timestamp", t.FirstSeen);
						update.Parameters.AddWithValue("team_id", t.TeamId);
						//update.Prepare();
						int rows = await update.ExecuteNonQueryAsync();
						if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

						var extra = new Dictionary<string, object>();
						extra["valid_from"] = t.FirstSeen;
						extra["hash"] = hash;
						// Try to insert our current data
						InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.teams", t.Data, extra);
						var newId = await insertCmd.Command.ExecuteNonQueryAsync();

					}

					await ProcessTeamModAttrs(t.Data, t.FirstSeen, psqlConnection);

				}
			}
		}

		private async Task LoadPlayerUpdates(NpgsqlConnection psqlConnection)
		{
			const int NUM_REQUESTED = 1000;
			string nextPage = null;
			DateTime? lastSeenPlayerTime = null;

			while (true)
			{
				string query = $"players/updates?count={NUM_REQUESTED}";
				if (m_dbPlayerTimestamp.HasValue)
				{
					query += $"&after={TimestampQueryValue(m_dbPlayerTimestamp.Value)}";
				}
				if (nextPage != null)
				{
					query += $"&page={nextPage}";
				}

				ChroniclerPage<ChroniclerPlayer> page = await ChroniclerQuery<ChroniclerPlayer>(query);

				if (page == null || page.Data.Count() == 0)
				{
					break;
				}
				else
				{
					nextPage = page.NextPage;
					lastSeenPlayerTime = page.Data.Last().LastSeen;
					Console.WriteLine($"  Processing {page.Data.Count()} player updates (through {page.Data.Last().FirstSeen}).");
					await ProcessPlayers(psqlConnection, page.Data);

					// We're done!
					if (page.Data.Count() != NUM_REQUESTED)
					{
						break;
					}
				}
			}

			if (lastSeenPlayerTime.HasValue)
			{
				NpgsqlCommand updateCmd = new NpgsqlCommand(@"UPDATE data.chronicler_meta SET player_timestamp=@ts WHERE id=0", psqlConnection);
				updateCmd.Parameters.AddWithValue("ts", lastSeenPlayerTime);
				int updateResult = await updateCmd.ExecuteNonQueryAsync();
			}

		}

		private async Task ProcessPlayers(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerPlayer> players)
		{
			using (MD5 md5 = MD5.Create())
			{
				foreach (var p in players)
				{
					// TODO move hashing into Player
					var hash = HashObject(md5, p.Data);

					NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.players where hash=@hash and valid_until is null", psqlConnection);
					cmd.Parameters.AddWithValue("hash", hash);
					var count = (long)cmd.ExecuteScalar();

					if (count == 1)
					{
						// Record exists
					}
					else
					{
						// Update the old record
						NpgsqlCommand update = new NpgsqlCommand(@"update data.players set valid_until=@timestamp where player_id = @player_id and valid_until is null", psqlConnection);
						update.Parameters.AddWithValue("timestamp", p.FirstSeen);
						update.Parameters.AddWithValue("player_id", p.PlayerId);
						int rows = await update.ExecuteNonQueryAsync();
						if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

						var extra = new Dictionary<string, object>();
						extra["hash"] = hash;
						extra["valid_from"] = p.FirstSeen;
						// Try to insert our current data
						InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.players", p.Data, extra);
						var newId = await insertCmd.Command.ExecuteNonQueryAsync();

					}
				}
			}
		}

	
		private Guid HashObject(HashAlgorithm hashAlgorithm, object obj)
		{
			StringBuilder sb = new StringBuilder();

			foreach (var prop in obj.GetType().GetProperties())
			{
				sb.Append(prop.GetValue(obj)?.ToString());
			}

			// Convert the input string to a byte array and compute the hash.
			byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(sb.ToString()));

			return new Guid(data);
		}

		private void ProcessPlayerModAttrs(Player p, DateTime timestamp, NpgsqlConnection psqlConnection)
		{

			var countCmd = new NpgsqlCommand(@"select count(modification) from data.player_modifications where player_id=@player_id and valid_until is null", psqlConnection);
			countCmd.Parameters.AddWithValue("player_id", p.Id);
			//countCmd.Prepare();
			long count = (long)countCmd.ExecuteScalar();
			if (count == 0 && p.PermAttr == null && p.SeasonAttr == null && p.WeekAttr == null && p.GameAttr == null)
			{
				return;
			}

			var allMods = new List<string>();
			var currentMods = new List<string>();

			if (p.PermAttr != null) allMods.AddRange(p.PermAttr);
			if (p.SeasonAttr != null) allMods.AddRange(p.SeasonAttr);
			if (p.WeekAttr != null) allMods.AddRange(p.WeekAttr);
			if (p.GameAttr != null) allMods.AddRange(p.GameAttr);

			NpgsqlCommand cmd = new NpgsqlCommand(@"select modification from data.player_modifications where player_id=@player_id and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("player_id", p.Id);
			//cmd.Prepare();
			using (var reader = cmd.ExecuteReader())
			{
				while (reader.Read())
				{
					currentMods.Add(reader[0] as string);
				}
			}
			var newMods = allMods.Except(currentMods);
			var oldMods = currentMods.Except(allMods);

			foreach (var modification in newMods)
			{

				// Try to insert our current data
				var insertCmd = new NpgsqlCommand(@"insert into data.player_modifications(player_id, modification, valid_from) values(@player_id, @modification, @valid_from)", psqlConnection);
				insertCmd.Parameters.AddWithValue("player_id", p.Id);
				insertCmd.Parameters.AddWithValue("modification", modification);
				insertCmd.Parameters.AddWithValue("valid_from", timestamp);
				//insertCmd.Prepare();
				int rows = insertCmd.ExecuteNonQuery();
				if (rows != 1) throw new InvalidOperationException($"Tried to insert but got {rows} rows affected!");
			}

			foreach (var modification in oldMods)
			{
				// Update the old record
				NpgsqlCommand update = new NpgsqlCommand(@"update data.player_modifications set valid_until=@timestamp where player_id = @player_id and modification=@modification and valid_until is null", psqlConnection);
				update.Parameters.AddWithValue("timestamp", timestamp);
				update.Parameters.AddWithValue("modification", modification);
				update.Parameters.AddWithValue("player_id", p.Id);
				//update.Prepare();
				int rows = update.ExecuteNonQuery();
				if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

			}

		}


		private async Task ProcessRosterEntry(NpgsqlConnection psqlConnection, DateTime timestamp, string teamId, string playerId, int rosterPosition, PositionType positionTypeEnum)
		{

			int positionType = (int)positionTypeEnum;

			NpgsqlCommand cmd = new NpgsqlCommand(@"select player_id from data.team_roster where team_id=@team_id and position_id=@position_id and position_type_id=@position_type and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("team_id", teamId);
			cmd.Parameters.AddWithValue("position_id", rosterPosition);
			cmd.Parameters.AddWithValue("position_type", positionType);
			//cmd.Prepare();
			var oldPlayerId = (string)await cmd.ExecuteScalarAsync();

			if (oldPlayerId == playerId)
			{
				// No change
			}
			else
			{
				// Update the old record
				NpgsqlCommand update = new NpgsqlCommand(@"update data.team_roster set valid_until=@timestamp where team_id = @team_id and position_id = @position_id and position_type_id=@position_type and valid_until is null", psqlConnection);
				update.Parameters.AddWithValue("timestamp", timestamp);
				update.Parameters.AddWithValue("team_id", teamId);
				update.Parameters.AddWithValue("position_id", rosterPosition);
				update.Parameters.AddWithValue("position_type", positionType);
				//update.Prepare();
				int rows = await update.ExecuteNonQueryAsync();
				if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

				if (playerId != null)
				{
					NpgsqlCommand insert = new NpgsqlCommand(@"insert into data.team_roster(team_id, position_id, player_id, position_type_id, valid_from) values(@team_id, @position_id, @player_id, @position_type, @valid_from)", psqlConnection);
					insert.Parameters.AddWithValue("team_id", teamId);
					insert.Parameters.AddWithValue("position_id", rosterPosition);
					insert.Parameters.AddWithValue("player_id", playerId);
					insert.Parameters.AddWithValue("valid_from", timestamp);
					insert.Parameters.AddWithValue("position_type", positionType);
					//insert.Prepare();
					// Try to insert our current data
					rows = await insert.ExecuteNonQueryAsync();
					if (rows == 0) throw new InvalidOperationException($"Failed to insert new team roster entry");
				}
			}

		}

		enum PositionType
		{
			Batter = 0,
			Pitcher,
			Bullpen,
			Bench
		}

		private NpgsqlCommand CountPositionTypeCommand(NpgsqlConnection psqlConnection, string teamId, PositionType posType)
		{
			NpgsqlCommand cmd = new NpgsqlCommand(@"select max(position_id) from data.team_roster where team_id=@team_id and position_type_id=@position_type and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("team_id", teamId);
			cmd.Parameters.AddWithValue("position_type", (int)posType);
			return cmd;
		}

		private async Task ProcessRoster(Team t, DateTime timestamp, NpgsqlConnection psqlConnection)
		{

			Stopwatch s = new Stopwatch();
			s.Start();

			var cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Batter);
			var response = await cmd.ExecuteScalarAsync();
			var maxBatters = response is System.DBNull ? 0 : (int)response + 1;

			for (int i = 0; i < Math.Max(maxBatters, t.Lineup.Count()); i++)
			{
				string playerId = null;
				if (i < t.Lineup.Count())
				{
					playerId = t.Lineup.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, timestamp, t.Id, playerId, i, PositionType.Batter);
			}

			cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Pitcher);
			response = await cmd.ExecuteScalarAsync();
			maxBatters = response is System.DBNull ? 0 : (int)response + 1;

			for (int i = 0; i < Math.Max(maxBatters, t.Rotation.Count()); i++)
			{
				string playerId = null;
				if (i < t.Rotation.Count())
				{
					playerId = t.Rotation.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, timestamp, t.Id, playerId, i, PositionType.Pitcher);
			}

			cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Bullpen);
			response = await cmd.ExecuteScalarAsync();
			maxBatters = response is System.DBNull ? 0 : (int)response + 1;

			for (int i = 0; i < Math.Max(maxBatters, t.Bullpen.Count()); i++)
			{
				string playerId = null;
				if (i < t.Bullpen.Count())
				{
					playerId = t.Bullpen.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, timestamp, t.Id, playerId, i, PositionType.Bullpen);
			}

			cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Bench);
			response = await cmd.ExecuteScalarAsync();
			maxBatters = response is System.DBNull ? 0 : (int)response + 1;

			for (int i = 0; i < Math.Max(maxBatters, t.Bench.Count()); i++)
			{
				string playerId = null;
				if (i < t.Bench.Count())
				{
					playerId = t.Bench.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, timestamp, t.Id, playerId, i, PositionType.Bench);
			}

			s.Stop();
			if (TIMING) Console.WriteLine($"Processed rosters in {s.ElapsedMilliseconds} ms");
		}

		// Hash just the basic attributes of a team, not including their player roster
		private Guid HashTeamAttrs(HashAlgorithm hashAlgorithm, Team obj)
		{
			StringBuilder sb = new StringBuilder();

			sb.Append(obj.Id);
			sb.Append(obj.Location);
			sb.Append(obj.Nickname);
			sb.Append(obj.FullName);

			// Convert the input string to a byte array and compute the hash.
			byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(sb.ToString()));
			return new Guid(data);
		}

		private async Task ProcessTeamModAttrs(Team p, DateTime timestamp, NpgsqlConnection psqlConnection)
		{

			var countCmd = new NpgsqlCommand(@"select count(modification) from data.team_modifications where team_id=@team_id and valid_until is null", psqlConnection);
			countCmd.Parameters.AddWithValue("team_id", p.Id);
			//countCmd.Prepare();
			long count = (long)await countCmd.ExecuteScalarAsync();
			if (count == 0 && p.PermAttr == null && p.SeasonAttr == null && p.WeekAttr == null && p.GameAttr == null)
			{
				return;
			}

			var allMods = new List<string>();
			var currentMods = new List<string>();

			if (p.PermAttr != null) allMods.AddRange(p.PermAttr);
			if (p.SeasonAttr != null) allMods.AddRange(p.SeasonAttr);
			if (p.WeekAttr != null) allMods.AddRange(p.WeekAttr);
			if (p.GameAttr != null) allMods.AddRange(p.GameAttr);

			NpgsqlCommand cmd = new NpgsqlCommand(@"select modification from data.team_modifications where team_id=@team_id and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("team_id", p.Id);
			//cmd.Prepare();
			using (var reader = await cmd.ExecuteReaderAsync())
			{
				while (reader.Read())
				{
					currentMods.Add(reader[0] as string);
				}
			}
			var newMods = allMods.Except(currentMods);
			var oldMods = currentMods.Except(allMods);

			foreach (var modification in newMods)
			{

				// Try to insert our current data
				var insertCmd = new NpgsqlCommand(@"insert into data.team_modifications(team_id, modification, valid_from) values(@team_id, @modification, @valid_from)", psqlConnection);
				insertCmd.Parameters.AddWithValue("team_id", p.Id);
				insertCmd.Parameters.AddWithValue("modification", modification);
				insertCmd.Parameters.AddWithValue("valid_from", timestamp);
				//insertCmd.Prepare();
				int rows = await insertCmd.ExecuteNonQueryAsync();
				if (rows != 1) throw new InvalidOperationException($"Tried to insert but got {rows} rows affected!");
			}

			foreach (var modification in oldMods)
			{
				// Update the old record
				NpgsqlCommand update = new NpgsqlCommand(@"update data.team_modifications set valid_until=@timestamp where team_id = @team_id and modification=@modification and valid_until is null", psqlConnection);
				update.Parameters.AddWithValue("timestamp", timestamp);
				update.Parameters.AddWithValue("modification", modification);
				update.Parameters.AddWithValue("team_id", p.Id);
				//update.Prepare();
				int rows = await update.ExecuteNonQueryAsync();
				if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

			}

		}

		private async Task ProcessAllTeams(JsonElement teamResponse, DateTime timestamp, NpgsqlConnection psqlConnection)
		{
			string text = teamResponse.GetRawText();

			var teams = JsonSerializer.Deserialize<IEnumerable<Team>>(text, serializerOptions);

			using (MD5 md5 = MD5.Create())
			{
				Stopwatch s = new Stopwatch();
				s.Start();
				foreach (var t in teams)
				{
					await ProcessRoster(t, timestamp, psqlConnection);

					var hash = HashTeamAttrs(md5, t);
					NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.teams where hash=@hash and valid_until is null", psqlConnection);
					cmd.Parameters.AddWithValue("hash", hash);
					//cmd.Prepare();
					var count = (long)await cmd.ExecuteScalarAsync();

					if (count == 1)
					{
						// Record exists
					}
					else
					{
						// Update the old record
						NpgsqlCommand update = new NpgsqlCommand(@"update data.teams set valid_until=@timestamp where team_id = @team_id and valid_until is null", psqlConnection);
						update.Parameters.AddWithValue("timestamp", timestamp);
						update.Parameters.AddWithValue("team_id", t.Id);
						//update.Prepare();
						int rows = await update.ExecuteNonQueryAsync();
						if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

						var extra = new Dictionary<string, object>();
						extra["valid_from"] = timestamp;
						extra["hash"] = hash;
						// Try to insert our current data
						InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.teams", t, extra);
						var newId = await insertCmd.Command.ExecuteNonQueryAsync();

					}

					await ProcessTeamModAttrs(t, timestamp, psqlConnection);

				}

				s.Stop();
				if (TIMING) Console.WriteLine($"Processed {teams.Count()} teams in {s.ElapsedMilliseconds} ms");
			}
		}



		private async Task PersistTimeMap(IEnumerable<GameEvent> events, NpgsqlConnection psqlConnection)
		{

			foreach (var e in events)
			{

				if (e.firstPerceivedAt != DateTime.MinValue && e.firstPerceivedAt.Year != 1970)
				{

					// Record the first time seen for each season and day
					var updateTimeMap = new NpgsqlCommand(@"
        insert into data.time_map values(@season, @day, @first_time)
        on conflict (season, day)  do
        update set first_time = EXCLUDED.first_time
        where time_map.first_time > EXCLUDED.first_time;
        ", psqlConnection);

					updateTimeMap.Parameters.AddWithValue("season", e.season);
					updateTimeMap.Parameters.AddWithValue("day", e.day);
					updateTimeMap.Parameters.AddWithValue("first_time", e.firstPerceivedAt);
					//updateTimeMap.Prepare();
					await updateTimeMap.ExecuteNonQueryAsync();
				}
			}

		}

		/// <summary>
		/// Generate a command for inserting a Game into the `game` table
		/// </summary>
		private NpgsqlCommand InsertGameCommand(NpgsqlConnection psqlConnection, Game game)
		{
			var insertGameStatement = new NpgsqlCommand(@"
            INSERT INTO data.games
            (
                game_id, day, season, home_odds, away_odds, weather, is_postseason, series_index, series_length,
                home_team, away_team, home_score, away_score, number_of_innings, ended_on_top_of_inning, ended_in_shame,
                terminology_id, rules_id, statsheet_id
            )
            VALUES
            (
                @game_id, @day, @season, @home_odds, @away_odds, @weather, @is_postseason, @series_index, @series_length,
                @home_team, @away_team, @home_score, @away_score, @number_of_innings, @ended_on_top_of_inning, @ended_in_shame,
                @terminology_id, @rules_id, @statsheet_id
            );
            ", psqlConnection);

			insertGameStatement.Parameters.AddWithValue("game_id", game.gameId);
			insertGameStatement.Parameters.AddWithValue("day", game.day);
			insertGameStatement.Parameters.AddWithValue("season", game.season);
			insertGameStatement.Parameters.AddWithValue("home_odds", game.homeOdds);
			insertGameStatement.Parameters.AddWithValue("away_odds", game.awayOdds);
			insertGameStatement.Parameters.AddWithValue("weather", game.weather.HasValue ? game.weather.Value : -1);
			insertGameStatement.Parameters.AddWithValue("is_postseason", game.isPostseason);
			insertGameStatement.Parameters.AddWithValue("series_index", game.seriesIndex);
			insertGameStatement.Parameters.AddWithValue("series_length", game.seriesLength);
			insertGameStatement.Parameters.AddWithValue("home_team", game.homeTeam);
			insertGameStatement.Parameters.AddWithValue("away_team", game.awayTeam);
			insertGameStatement.Parameters.AddWithValue("home_score", game.homeScore);
			insertGameStatement.Parameters.AddWithValue("away_score", game.awayScore);
			insertGameStatement.Parameters.AddWithValue("number_of_innings", game.inning);
			insertGameStatement.Parameters.AddWithValue("ended_on_top_of_inning", game.topOfInning);
			insertGameStatement.Parameters.AddWithValue("ended_in_shame", game.shame);
			insertGameStatement.Parameters.AddWithValue("terminology_id", game.terminology);
			insertGameStatement.Parameters.AddWithValue("rules_id", game.rules);
			insertGameStatement.Parameters.AddWithValue("statsheet_id", game.statsheet);
			//insertGameStatement.Prepare();
			return insertGameStatement;
		}

		private async Task PersistPitcherResults(NpgsqlConnection psqlConnection, string gameId, string winPitcher, string losePitcher)
		{
			using (var updateCommand = new NpgsqlCommand(@"
        UPDATE data.games SET winning_pitcher_id=@winPitcher, losing_pitcher_id=@losePitcher
        WHERE game_id=@gameId",
			  psqlConnection))
			{
				updateCommand.Parameters.AddWithValue("winPitcher", winPitcher);
				updateCommand.Parameters.AddWithValue("losePitcher", losePitcher);
				updateCommand.Parameters.AddWithValue("gameId", gameId);

				await updateCommand.ExecuteNonQueryAsync();
			}
		}

		/// <summary>
		/// Get any completed games from the Blaseball API and insert them in the `game` table
		/// </summary>
		private async Task PopulateGameTable(NpgsqlConnection psqlConnection)
		{

			// Find the latest day already stored in the DB
			int season = 0;
			int day = -1;
			using (var gamesCommand = new NpgsqlCommand(@"
                SELECT MAX(season), MAX(day) from data.games
                INNER JOIN (SELECT MAX(season) AS max_season FROM data.games) b ON b.max_season = games.season",
				psqlConnection))
			using (var reader = await gamesCommand.ExecuteReaderAsync())
			{

				while (await reader.ReadAsync())
				{
					if (!reader.IsDBNull(0))
						season = reader.GetInt32(0);
					if (!reader.IsDBNull(1))
						day = reader.GetInt32(1);
				}
			}

			m_lastKnownSeasonDay = new SeasonDay(season, day);

			Console.WriteLine($"Found games through season {season}, day {day}.");
			// Start on the next day
			day++;

			// Talk to the blaseball API

			JsonSerializerOptions options = new JsonSerializerOptions();
			options.IgnoreNullValues = true;

			// Okay we know we have completed at least this many full seasons
			int MIN_SEASON = 5;

			// Loop until we break out
			while (true)
			{
				// Get games for this season & day
				HttpResponseMessage response = await m_blaseballClient.GetAsync($"games?day={day}&season={season}");

				if (response.IsSuccessStatusCode)
				{

					string strResponse = await response.Content.ReadAsStringAsync();
					var gameList = JsonSerializer.Deserialize<IEnumerable<Game>>(strResponse, options);

					// If we got no response OR we're past the minimum and we got a "game not complete" response
					if (gameList == null || gameList.Count() == 0) //|| (season > MIN_SEASON && gameList.First().gameComplete == false))
					{
						if (day > 0)
						{
							// Ran out of finished games this season, try the next
							m_lastKnownSeasonDay.Season = season;
							season++;
							day = 0;
							continue;
						}
						else
						{
							// season X day 0 had no complete games, stop looping
							break;
						}
					}

					Console.WriteLine($"Inserting games from season {season}, day {day}...");
					foreach (var game in gameList)
					{
						var cmd = InsertGameCommand(psqlConnection, game);
						await cmd.ExecuteNonQueryAsync();
					}

					m_lastKnownSeasonDay.Day = day;
					day++;
				}
				else
				{
					Console.WriteLine($"Got response {response.StatusCode} from {response.RequestMessage.RequestUri}!");
					return;
				}
			}


		}

		static void ConsoleOrWebhook(string msg)
		{
			Console.WriteLine(msg);

			var webhookUri = Environment.GetEnvironmentVariable("PROPHESIZER_WEBHOOK");

			if (webhookUri != null)
			{
				WebClient webClient = new WebClient();
				NameValueCollection values = new NameValueCollection();

				values.Add("content", msg);
				values.Add("username", "prophesizer");

				webClient.UploadValuesAsync(new Uri(webhookUri), values);
			}
		}


	}

}