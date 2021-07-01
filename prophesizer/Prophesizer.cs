using Cauldron;
using Npgsql;
using prophesizer;
using prophesizer.Serializable;
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
using System.Reflection;
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
		public int Tournament { get; set; }
		public int TournamentRound { get; set; }
		public int Phase { get; set; }
	}

	struct PollResult
	{
		public SeasonDay Latest;
		public int NumUpdatesProcessed;
	}

	class Prophesizer
	{

		int m_gameEventId = 0;
		private Queue<GameEvent> m_eventsToInsert;
		private Queue<(string, string, string, GameEvent)> m_pitcherResults;

		private JsonSerializerOptions serializerOptions;

		private const int MAX_SEASON = 8;
		private const int MAX_DAY = 135;

		// Most positive SeasonDay known
		private SeasonDay m_regularSeasonDay;
		// Most negative SeasonDay known
		private SeasonDay m_tournamentSeasonDay;

		private const bool TIMING = false;
		private const bool TIMING_FILE = true;
		private const bool DO_HOURLY = true;
		private const bool DO_EVENTS = true;
		private bool DO_REFRESH_MATVIEWS = true;

		private HttpClient m_chroniclerClient;
		private HttpClient m_chroniclerV2Client;
		private HttpClient m_blaseballClient;

		private JsonSerializerOptions m_options;

		private object _eventLocker = new object();
		private object _pitcherLocker = new object();

		private int m_lastMatRefreshPhase = 0;
		private SeasonDay m_lastMaterializedRefresh = new SeasonDay(0, 0);
		private SeasonDay m_dbSeasonDay;
		private DateTime? m_dbGameTimestamp;
		private DateTime? m_dbTeamTimestamp;
		private DateTime? m_dbPlayerTimestamp;
		private DateTime? m_dbDivisionTimestamp;
		private DateTime? m_dbStadiumTimestamp;

		public int NumNetworkOutcomes => m_processor.NumNetworkOutcomes;
		public int NumLocalOutcomes => m_processor.NumLocalOutcomes;

		public Prophesizer()
		{
			//m_processor = new Processor();
			m_eventsToInsert = new Queue<GameEvent>();
			m_pitcherResults = new Queue<(string, string, string, GameEvent)>();

			serializerOptions = new JsonSerializerOptions();
			serializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
			serializerOptions.PropertyNameCaseInsensitive = true;
			serializerOptions.IgnoreNullValues = true;

			m_chroniclerClient = new HttpClient();
			m_chroniclerClient.BaseAddress = new Uri("https://api.sibr.dev/chronicler/v1/");
			m_chroniclerClient.DefaultRequestHeaders.Accept.Clear();
			m_chroniclerClient.DefaultRequestHeaders.Accept.Add(
				new MediaTypeWithQualityHeaderValue("application/json"));

			m_chroniclerV2Client = new HttpClient();
			m_chroniclerV2Client.BaseAddress = new Uri("https://api.sibr.dev/chronicler/v2/");
			m_chroniclerV2Client.DefaultRequestHeaders.Accept.Clear();
			m_chroniclerV2Client.DefaultRequestHeaders.Accept.Add(
				new MediaTypeWithQualityHeaderValue("application/json"));

			m_blaseballClient = new HttpClient();
			m_blaseballClient.BaseAddress = new Uri("https://www.blaseball.com/database/");
			m_blaseballClient.DefaultRequestHeaders.Accept.Clear();
			m_blaseballClient.DefaultRequestHeaders.Accept.Add(
				new MediaTypeWithQualityHeaderValue("application/json"));

			m_options = new JsonSerializerOptions();
			m_options.IgnoreNullValues = true;
			m_options.PropertyNameCaseInsensitive = true;

			// Assume that we refresh matviews
			DO_REFRESH_MATVIEWS = bool.Parse(Environment.GetEnvironmentVariable("prophesizer.refreshMatViews") ?? "true");
		}

		/// <summary>
		/// Get the last season & day that we've recorded in the DB
		/// </summary>
		private async Task<(SeasonDay, DateTime?, DateTime?, DateTime?, DateTime?, DateTime?)> GetChroniclerMeta(NpgsqlConnection psqlConnection)
		{
			int season = 0;
			int day = 0;
			DateTime? gameTime = null;
			DateTime? teamTime = null;
			DateTime? playerTime = null;
			DateTime? divisionTime = null;
			DateTime? stadiumTime = null;

			NpgsqlCommand cmd = new NpgsqlCommand(@"select season, day, game_timestamp, team_timestamp, player_timestamp, division_timestamp, stadium_timestamp from data.chronicler_meta where id=0", psqlConnection);

			bool foundRecord = false;
			using (var reader = await cmd.ExecuteReaderAsync())
			{
				if (reader.HasRows)
					foundRecord = true;

				while (await reader.ReadAsync())
				{
					season = reader.GetInt32(0);
					day = reader.GetInt32(1);
					if (!reader.IsDBNull(2))
					{
						gameTime = reader.GetDateTime(2);
					}
					if (!reader.IsDBNull(3))
					{
						teamTime = reader.GetDateTime(3);
					}
					if (!reader.IsDBNull(4))
					{
						playerTime = reader.GetDateTime(4);
					}
					if (!reader.IsDBNull(5))
					{
						divisionTime = reader.GetDateTime(5);
					}
					if (!reader.IsDBNull(6))
					{
						stadiumTime = reader.GetDateTime(6);
					}
				}
			}

			if (!foundRecord)
			{
				NpgsqlCommand insertCmd = new NpgsqlCommand(@"insert into data.chronicler_meta values(0,0,0,null,null,null)", psqlConnection);
				insertCmd.ExecuteNonQuery();
			}

			return (new SeasonDay(season, day), gameTime, teamTime, playerTime, divisionTime, stadiumTime);
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
						obj.Data.chroniclerHash = obj.Hash;
						await processor.ProcessGameObject(obj.Data, obj.Timestamp);
					}

				}
			}

			processor.EventComplete -= Processor_EventComplete;
			processor.GameComplete -= Processor_GameComplete;

			//Console.WriteLine($"Finished loading season {dayToFetch.Season}, day {dayToFetch.Day}.");
			return numUpdatesForDay > 0;
		}


		public async Task<PollResult> Poll()
		{
			Metadata meta = new Metadata();

			PollResult result = new PollResult();

			Console.WriteLine($"Started poll at {DateTime.UtcNow.ToString()} UTC.");

			await using var psqlConnection = new NpgsqlConnection(Environment.GetEnvironmentVariable("PSQL_CONNECTION_STRING"));
			await psqlConnection.OpenAsync();

			var recordId = OpenMetadata(meta, psqlConnection);

			// Talk to the /games endpoint to find all the games we can into the DB
			await PopulateGameTable(psqlConnection);

			// Last day recorded in the DB
			(m_dbSeasonDay, m_dbGameTimestamp, m_dbTeamTimestamp, m_dbPlayerTimestamp, m_dbDivisionTimestamp, m_dbStadiumTimestamp) = await GetChroniclerMeta(psqlConnection);

			// Current day according to blaseball.com
			SeasonDay simSeasonDay;
			SimulationData simData;

			var response = await m_blaseballClient.GetAsync("simulationData");
			if (response.IsSuccessStatusCode)
			{
				string strResponse = await response.Content.ReadAsStringAsync();
				simData = JsonSerializer.Deserialize<SimulationData>(strResponse, m_options);
				simSeasonDay = new SeasonDay(simData.Season, simData.Day, simData.Tournament);
			}
			else
			{
				throw new InvalidDataException("Couldn't get current simulation data from blaseball!");
			}

			if (DO_HOURLY)
			{
				var leagueDivTimestamp = m_dbDivisionTimestamp;

				await LoadUpdates<ProphLeague>(psqlConnection, "league", leagueDivTimestamp, ProcessLeagues, 100, false);
				await LoadUpdates<ProphSubleague>(psqlConnection, "subleague", leagueDivTimestamp, ProcessSubleagues, 100, false);
				await LoadUpdates<ProphDivision>(psqlConnection, "division", leagueDivTimestamp, ProcessDivisions);
				await LoadUpdates<ProphTeam>(psqlConnection, "team", m_dbTeamTimestamp, ProcessTeams, 250);
				await LoadUpdates<ProphPlayer>(psqlConnection, "player", m_dbPlayerTimestamp, ProcessPlayers, 250);
				await LoadUpdates<ProphStadium>(psqlConnection, "stadium", m_dbStadiumTimestamp, ProcessStadiums, 1000);

				await StoreTimeMapEvents(psqlConnection);
			}

			if (DO_EVENTS)
			{
				// Grab the list of games we know from the DB's `games` table
				var gameList = GetAllGameDays(psqlConnection);

				// Grab all the days we've stored games in the DB's `game_events` table
				var storedGameList = GetStoredGameDays(psqlConnection);

				// Find all games that we should have stored but don't
				var missingGames = gameList.Except(storedGameList);

				// Ignore all the games before the SIBR era
				missingGames = missingGames.Where(sd => sd > new SeasonDay(1, 97));

				IEnumerable<SeasonDay> bustedDays = new SeasonDay[]
				{
					new SeasonDay(3,71),
					new SeasonDay(3,72),
					new SeasonDay(9,101),
					new SeasonDay(10,108)
				};

				// Ignore the known-busted days
				missingGames = missingGames.Except(bustedDays);

				if (missingGames.Any())
				{
					// Batch load all missing games
					await BatchLoadGameUpdates(psqlConnection, missingGames, meta);
				}

				Console.WriteLine($"Starting incremental update from {simSeasonDay.HumanReadable} at time {m_dbGameTimestamp}");
				result = await IncrementalUpdate(psqlConnection, simSeasonDay, m_dbGameTimestamp, meta);
			}

			ApplyDbPatches(psqlConnection);

			m_dbSeasonDay = result.Latest;

			if (DO_REFRESH_MATVIEWS)
			{
				meta.RefreshedMatviews = await RefreshMaterializedViews(psqlConnection, simData);
			}

			CloseMetadata(meta, recordId, psqlConnection);

			var msg = $"Finished poll at {DateTime.UtcNow.ToString()} UTC.";
			Console.WriteLine(msg);

			return result;
		}

		private int OpenMetadata(Metadata meta, NpgsqlConnection psqlConnection)
		{
			var cmd = new NpgsqlCommand("INSERT INTO data.prophesizer_meta (major_version, minor_version, patch_version, run_started) VALUES (@major, @minor, @patch, @runStarted) RETURNING prophesizer_meta_id", psqlConnection);
			cmd.Parameters.AddWithValue("major", meta.MajorVersion);
			cmd.Parameters.AddWithValue("minor", meta.MinorVersion);
			cmd.Parameters.AddWithValue("patch", meta.PatchVersion);
			cmd.Parameters.AddWithValue("runStarted", meta.RunStarted);

			int record = (int)(cmd.ExecuteScalar());
			return record;
		}

		private void CloseMetadata(Metadata meta, int record, NpgsqlConnection psqlConnection)
		{
			meta.LastGameEvent = m_gameEventId;
			meta.RunFinished = DateTime.UtcNow;

			if (meta.FirstGameEvent != meta.LastGameEvent || meta.RefreshedMatviews)
			{
				// Update our record to show when the run finished etc
				var cmd = new NpgsqlCommand("UPDATE data.prophesizer_meta SET (first_game_event, last_game_event, run_finished, refreshed_matviews) = (@first, @last, @runFinished, @refreshed) WHERE prophesizer_meta_id = @record", psqlConnection);
				cmd.Parameters.AddWithValue("first", meta.FirstGameEvent);
				cmd.Parameters.AddWithValue("last", meta.LastGameEvent);
				cmd.Parameters.AddWithValue("runFinished", meta.RunFinished);
				cmd.Parameters.AddWithValue("refreshed", meta.RefreshedMatviews);
				cmd.Parameters.AddWithValue("record", record);

				cmd.ExecuteNonQuery();
			}
			else
			{
				// Delete our record since no game events were added anyway
				var cmd = new NpgsqlCommand("DELETE FROM data.prophesizer_meta WHERE prophesizer_meta_id=@record", psqlConnection);
				cmd.Parameters.AddWithValue("record", record);
				cmd.ExecuteNonQuery();
			}
		}


		// Run any unapplied DB patches
		private void ApplyDbPatches(NpgsqlConnection psqlConnection)
		{
			var cmd = new NpgsqlCommand("SELECT patch_hash FROM data.applied_patches", psqlConnection);

			HashSet<Guid> existingPatches = new HashSet<Guid>();
			using (var reader = cmd.ExecuteReader())
			{
				while (reader.Read())
				{
					existingPatches.Add((Guid)reader[0]);
				}
			}

			foreach (var patchFilename in Directory.GetFiles(Path.Combine(GetExecutingDirectoryName(), "patch")))
			{
				using (var md5 = MD5.Create())
				{
					using (var sr = new StreamReader(patchFilename))
					{
						string cmdText = sr.ReadToEnd().Replace("\r\n", "\n");
						var hashBytes = md5.ComputeHash(Encoding.UTF8.GetBytes(cmdText));
						var hash = new Guid(hashBytes);

						if (!existingPatches.Contains(hash))
						{
							Console.WriteLine($"Applying patch from {Path.GetFileName(patchFilename)} / {hash.ToString()}:");
							Console.WriteLine(cmdText);
							var patchCmd = new NpgsqlCommand(cmdText, psqlConnection);

							var trans = psqlConnection.BeginTransaction();
							try
							{

								patchCmd.ExecuteNonQuery();
								var insertCmd = new NpgsqlCommand("INSERT INTO data.applied_patches(patch_hash) VALUES(@hash)", psqlConnection);
								insertCmd.Parameters.AddWithValue("hash", NpgsqlTypes.NpgsqlDbType.Uuid, hash);
								insertCmd.ExecuteNonQuery();
								trans.Commit();
							}
							catch (NpgsqlException ex)
							{
								Console.WriteLine($"Exception while processing patch:\n{ex.Message}");
								trans.Rollback();
							}
						}
						else
						{
							Console.WriteLine($"Patch from {Path.GetFileName(patchFilename)} is already applied.");
						}
					}
				}
			}


		}

		public static string GetExecutingDirectoryName()
		{
			var location = new Uri(Assembly.GetEntryAssembly().GetName().CodeBase);
			return new FileInfo(location.AbsolutePath).Directory.FullName;
		}

		private async Task<bool> RefreshMaterializedViews(NpgsqlConnection psqlConnection, SimulationData simData)
		{
			bool printMatviewTime = false;
			Stopwatch matviewTimer = new Stopwatch();
			matviewTimer.Start();
			bool refreshed = false;
			// If it's been at least one day since the last refresh
			// Or the previous refresh wasn't in the Election phase and we've now entered the Election phase
			if (m_dbSeasonDay > m_lastMaterializedRefresh || (m_lastMatRefreshPhase != 13 && simData.Phase == 13))
			{
				// Count how many games were today
				var countCmd = new NpgsqlCommand("SELECT COUNT(DISTINCT(game_id)) FROM data.game_events WHERE season=@season AND day=@day", psqlConnection);
				countCmd.Parameters.AddWithValue("season", m_dbSeasonDay.Season);
				countCmd.Parameters.AddWithValue("day", m_dbSeasonDay.Day);
				var gameCountResponse = countCmd.ExecuteScalar();

				// Count how many of today's games are finished
				var cmd = new NpgsqlCommand("SELECT COUNT(1) FROM data.game_events WHERE season=@season AND day=@day AND is_last_game_event", psqlConnection);
				cmd.Parameters.AddWithValue("season", m_dbSeasonDay.Season);
				cmd.Parameters.AddWithValue("day", m_dbSeasonDay.Day);
				var response = cmd.ExecuteScalar();

				if (response is DBNull)
				{
					return false;
				}
				else
				{
					Int64 numGames = (Int64)gameCountResponse;
					Int64 numFinishedGames = (Int64)response;
					Console.WriteLine($"{numFinishedGames} of {numGames} games complete for {m_dbSeasonDay.HumanReadable}...");
					// If all games are done, refresh our materialized views
					if ((numGames > 0 && numFinishedGames >= numGames) ||
						(numGames == 0 && m_dbSeasonDay.Season > m_lastMaterializedRefresh.Season) ||
						(m_lastMaterializedRefresh.Season == 0 && m_lastMaterializedRefresh.Day == 0) ||
						simData.Phase == 13)
					{
						var checkCmd = new NpgsqlCommand("SELECT relispopulated FROM pg_class WHERE relname = 'players_info_expanded_all'", psqlConnection);
						var isPopulated = (bool)(checkCmd.ExecuteScalar() ?? false);

						printMatviewTime = true;

						ConsoleOrWebhook($"All games complete for {m_dbSeasonDay.HumanReadable}, refreshing materialized views{(isPopulated ? " concurrently" : "")}!");
						string query = isPopulated ? "CALL data.refresh_materialized_views_concurrently()" : "CALL data.refresh_materialized_views()";
						var refreshCmd = new NpgsqlCommand(query, psqlConnection);
						await refreshCmd.ExecuteNonQueryAsync();

						m_lastMaterializedRefresh = m_dbSeasonDay;
						m_lastMatRefreshPhase = simData.Phase;
						refreshed = true;
					}
				}
			}
			matviewTimer.Stop();
			if (printMatviewTime)
			{
				ConsoleOrWebhook($"Matview refresh took {matviewTimer.Elapsed}. Last day refreshed is now {m_lastMaterializedRefresh.HumanReadable}");
			}

			return refreshed;
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

		private IEnumerable<SeasonDay> GetStoredGameDays(NpgsqlConnection psqlConnection)
		{
			var cmd = new NpgsqlCommand(@"SELECT DISTINCT season, day, tournament FROM data.game_events ORDER BY tournament, season, day", psqlConnection);

			List<SeasonDay> days = new List<SeasonDay>();
			using (var reader = cmd.ExecuteReader())
			{
				while (reader.Read())
				{
					int season = (int)reader[0];
					int day = (int)reader[1];
					int tournament = -1;
					if (!(reader[2] is DBNull))
						tournament = (int)reader[2];

					days.Add(new SeasonDay(season, day, tournament));
				}
			}

			return days;
		}

		private IEnumerable<SeasonDay> GetAllGameDays(NpgsqlConnection psqlConnection)
		{
			var cmd = new NpgsqlCommand(@"SELECT DISTINCT season, day, tournament FROM data.games ORDER BY tournament, season, day", psqlConnection);

			List<SeasonDay> days = new List<SeasonDay>();
			using (var reader = cmd.ExecuteReader())
			{
				while (reader.Read())
				{
					int season = (int)reader[0];
					int day = (int)reader[1];
					int tournament = (int)reader[2];

					days.Add(new SeasonDay(season, day, tournament));
				}
			}

			return days;
		}

		private async Task<PollResult> IncrementalUpdate(NpgsqlConnection psqlConnection, SeasonDay startAt, DateTime? afterTime, Metadata meta)
		{
			PollResult pollResult = new PollResult();
			m_gameEventId = GetMaxGameEventId(psqlConnection);
			if (!meta.FirstGameEvent.HasValue)
			{
				meta.FirstGameEvent = m_gameEventId;
			}

			bool morePages = true;
			string nextPage = null;
			DateTime? lastSeenGameTime = null;
			SeasonDay lastSeenDay = startAt;

			var transaction = psqlConnection.BeginTransaction();

			while (morePages)
			{
				string query;
				if (afterTime.HasValue)
				{
					query = $"games/updates?after={TimestampQueryValue(afterTime.Value)}&order=asc&started=true&count={NUM_EVENTS_REQUESTED}";
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
					else if (page.Data.Count() == NUM_EVENTS_REQUESTED)
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
						lastSeenDay.Season = update.Data.season;
						lastSeenDay.Day = update.Data.day;
						update.Data.chroniclerHash = update.Hash;
						await m_processor.ProcessGameObject(update.Data, update.Timestamp);
						pollResult.NumUpdatesProcessed++;
					}
					m_processor.EventComplete -= Processor_EventComplete;
					m_processor.GameComplete -= Processor_GameComplete;

					Console.WriteLine($"  Processed {page.Data.Count()} updates (through {page.Data.Last().Timestamp}).\n  Inserting {m_eventsToInsert.Count()} game events and {m_pitcherResults.Count()} pitching results...");

					// Process any game events we received
					while (m_eventsToInsert.Count > 0)
					{
						var ev = m_eventsToInsert.Dequeue();
						try
						{
							await PersistGame(psqlConnection, ev, m_gameEventId);
						}
						catch (Exception ex)
						{
							Console.WriteLine(ex);
						}
						m_gameEventId++;
					}

					// Process any pitcher results from completed games
					while (m_pitcherResults.Count > 0)
					{
						var result = m_pitcherResults.Dequeue();
						await PersistPitcherResults(psqlConnection, result.Item1, result.Item2, result.Item3, result.Item4);
					}

				}
			}

			if (lastSeenGameTime.HasValue)
			{
				NpgsqlCommand updateCmd = new NpgsqlCommand(@"UPDATE data.chronicler_meta SET season=@season, day=@day, game_timestamp=@ts WHERE id=0", psqlConnection);
				updateCmd.Parameters.AddWithValue("ts", lastSeenGameTime);
				updateCmd.Parameters.AddWithValue("season", lastSeenDay.Season);
				updateCmd.Parameters.AddWithValue("day", lastSeenDay.Day);
				int updateResult = await updateCmd.ExecuteNonQueryAsync();
			}

			await transaction.CommitAsync();

			pollResult.Latest = lastSeenDay;
			return pollResult;
		}

	

		// Find all the "special" times in the season and add them to time_map
		private async Task StoreTimeMapEvents(NpgsqlConnection psqlConnection)
		{
			string nextPage = null;

			var trans = psqlConnection.BeginTransaction();
			Console.WriteLine($"Populating Time Map...");

			while (true)
			{
				string query = $"versions?type=sim&count=1000";
				if (nextPage != null)
				{
					query += $"&page={nextPage}";
				}

				ChroniclerV2Page<SimData> page = await ChroniclerV2Query<SimData>(query);

				if (page == null || page.Items.Count() == 0)
				{
					break;
				}
				else
				{
					nextPage = page.NextPage;

					foreach (var chronData in page.Items)
					{
						SimData simData = chronData.Data;
						StoreSimDataPhase(psqlConnection, simData.Season, simData.Day, chronData.ValidFrom.Value, simData.Phase);
					}
				}
			}

			trans.Commit();
		}

		// Store time_map data about a sim phase
		private void StoreSimDataPhase(NpgsqlConnection psqlConnection, int season, int day, DateTime firstTime, int phaseId)
		{
			// HACK for Coffee Cup; set the Coffee phases to season -1
			if (phaseId >= 13 && phaseId <= 15 && firstTime < new DateTime(2021,1,1))
			{
				season = -1;
			}

			//Console.WriteLine($"Storing phase {phaseId} for season {season}, day {day} starting at {firstTime}.");
			NpgsqlCommand insertCmd = new NpgsqlCommand(@"
								INSERT INTO data.time_map(season, day, first_time, phase_id) values(@season, @day, @first_time, @phaseId)
								ON CONFLICT ON CONSTRAINT season_day_unique DO UPDATE SET first_time=EXCLUDED.first_time
								WHERE EXCLUDED.first_time < data.time_map.first_time", psqlConnection);
			insertCmd.Parameters.AddWithValue("season", season);
			insertCmd.Parameters.AddWithValue("day", day);
			insertCmd.Parameters.AddWithValue("first_time", firstTime);
			insertCmd.Parameters.AddWithValue("phaseId", phaseId);
			insertCmd.ExecuteNonQuery();
		}
		/// <summary>
		/// Load updates from Chronicler by going wide
		/// </summary>
		private async Task BatchLoadGameUpdates(NpgsqlConnection psqlConnection, IEnumerable<SeasonDay> games, Metadata meta)
		{
			const int NUM_TASKS = 10;

			m_gameEventId = GetMaxGameEventId(psqlConnection);
			if (!meta.FirstGameEvent.HasValue)
			{
				meta.FirstGameEvent = m_gameEventId;
			}

			Queue<SeasonDay> gameQueue = new Queue<SeasonDay>(games);

			while (gameQueue.Count > 0)
			{
				// Fetch and process 10 days at a time
				Task<bool>[] tasks = new Task<bool>[NUM_TASKS];

				Console.Write($"Processing: ");
				for (int i = 0; i < NUM_TASKS; i++)
				{
					if (gameQueue.Count > 0)
					{
						SeasonDay dayToFetch = gameQueue.Dequeue();
						tasks[i] = Task.Run(() => FetchAndProcessFullDay(dayToFetch));
						Console.Write($"{dayToFetch} ");
					}
					else
					{
						tasks[i] = Task.Run(() => false);
					}
				}
				Console.WriteLine();

				// Wait for all 10 tasks to complete; SQL work has to be done on a single thread
				Task.WaitAll(tasks);

				// Start a transaction for all we'll update
				var transaction = psqlConnection.BeginTransaction();

				Console.WriteLine($"  Inserting {m_eventsToInsert.Count()} game events and {m_pitcherResults.Count()} pitching results...");

				// Process any game events we received
				if (m_eventsToInsert.Count > 0)
				{
					await CopyGameEvents(psqlConnection, m_eventsToInsert);
					// TODO filter to the earliest timestamp for a SeasonDay in LINQ first instead of doing it in SQL
					//await PersistTimeMap(m_eventsToInsert, psqlConnection);
					m_eventsToInsert.Clear();
				}

				// Process any pitcher results from completed games
				while (m_pitcherResults.Count > 0)
				{
					var result = m_pitcherResults.Dequeue();
					await PersistPitcherResults(psqlConnection, result.Item1, result.Item2, result.Item3, result.Item4);
				}

				//NpgsqlCommand updateCmd = new NpgsqlCommand(@"
				//	INSERT INTO data.chronicler_meta(id, season, day, game_timestamp) values (0, @season, @day, null)
				//	ON CONFLICT(id) DO UPDATE SET season=EXCLUDED.season, day=EXCLUDED.day, game_timestamp=null", 
				//	psqlConnection);
				//updateCmd.Parameters.AddWithValue("season", currSeasonDay.Season);
				//updateCmd.Parameters.AddWithValue("day", lastValidDay);
				//int updateResult = await updateCmd.ExecuteNonQueryAsync();

				await transaction.CommitAsync();
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
				Console.WriteLine($"      Game Complete! {e.GameId}");
				m_pitcherResults.Enqueue((e.GameId, e.WinningPitcherId, e.LosingPitcherId, e.GameEvents.Last()));
			}
		}

		private async Task CopyGameEvents(NpgsqlConnection psqlConnection, Queue<GameEvent> gameEvents)
		{
			List<(int, GameEventBaseRunner)> runners = new List<(int, GameEventBaseRunner)>();
			List<(int, Outcome)> outcomes = new List<(int, Outcome)>();
			List<(int, string)> hashes = new List<(int, string)>();

			using (var writer = psqlConnection.BeginBinaryImport(
				@"COPY data.game_events(
					id, perceived_at, game_id, event_type, event_index, inning, top_of_inning, outs_before_play,
					batter_id, batter_team_id, pitcher_id, pitcher_team_id, home_score, away_score,
					home_strike_count, away_strike_count, batter_count, pitches, total_strikes,
					total_balls, total_fouls, is_leadoff, is_pinch_hit, lineup_position,
					is_last_event_for_plate_appearance, bases_hit, runs_batted_in, is_sacrifice_hit,
					is_sacrifice_fly, outs_on_play, is_double_play, is_triple_play, is_wild_pitch,
					batted_ball_type, is_bunt, errors_on_play, batter_base_after_play, is_last_game_event,
					event_text, season, day, parsing_error, parsing_error_list, fixed_error, fixed_error_list, tournament,
					home_base_count, away_base_count, home_ball_count, away_ball_count
				)FROM STDIN (FORMAT BINARY)"))
			{
				foreach (var ge in gameEvents)
				{
					foreach (var runner in ge.baseRunners)
					{
						runners.Add((m_gameEventId, runner));
					}
					foreach (var outcome in ge.outcomes)
					{
						outcomes.Add((m_gameEventId, outcome));
					}
					foreach (var hash in ge.updateHashes)
					{
						if (hash != null)
							hashes.Add((m_gameEventId, hash));
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
					writer.Write(ge.homeStrikeCount, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.awayStrikeCount, NpgsqlTypes.NpgsqlDbType.Integer);
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
					writer.Write(ge.runsBattedIn, NpgsqlTypes.NpgsqlDbType.Numeric);
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
					writer.Write(ge.tournament, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.homeBaseCount, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.awayBaseCount, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.homeBallCount, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(ge.awayBallCount, NpgsqlTypes.NpgsqlDbType.Integer);

					m_gameEventId++;
				}

				await writer.CompleteAsync();
			}

			using (var writer = psqlConnection.BeginBinaryImport(
				@"COPY data.game_event_base_runners(
					game_event_id, runner_id, responsible_pitcher_id, base_before_play, base_after_play,
					was_base_stolen, was_caught_stealing, was_picked_off, runs_scored
				)FROM STDIN (FORMAT BINARY)"))
			{
				foreach ((var id, var r) in runners)
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
					writer.Write(r.runsScored, NpgsqlTypes.NpgsqlDbType.Numeric);
				}

				await writer.CompleteAsync();
			}

			using (var writer = psqlConnection.BeginBinaryImport(
				@"COPY data.outcomes(
					game_event_id, entity_id, event_type, original_text
				)FROM STDIN (FORMAT BINARY)"))
			{
				foreach ((var id, var o) in outcomes)
				{
					writer.StartRow();
					writer.Write(id, NpgsqlTypes.NpgsqlDbType.Integer);
					writer.Write(o.entityId);
					writer.Write(o.eventType);
					writer.Write(o.originalText);
				}
				await writer.CompleteAsync();
			}

			if (hashes.Count() > 0)
			{
				using (var writer = psqlConnection.BeginBinaryImport(
					@"COPY data.chronicler_hash_game_event(
					update_hash, game_event_id
				) FROM STDIN (FORMAT BINARY)"))
				{
					foreach ((var id, var hash) in hashes)
					{
						writer.StartRow();
						writer.Write(Guid.Parse(hash), NpgsqlTypes.NpgsqlDbType.Uuid);
						writer.Write(id, NpgsqlTypes.NpgsqlDbType.Integer);
					}
					await writer.CompleteAsync();
				}
			}
		}

		private async Task PersistGame(NpgsqlConnection psqlConnection, GameEvent gameEvent, int gameEventId)
		{
			if (gameEvent.firstPerceivedAt.Year < 2020)
			{
				Console.WriteLine($"Warning! Found a game event with bogus timestamp - event {gameEventId} from game {gameEvent.gameId}, eventIndex {gameEvent.eventIndex}.");
			}

			using (var gameEventStatement = PrepareGameEventStatement(psqlConnection, gameEvent, gameEventId))
			{
				int id = -1;
				var response = await gameEventStatement.ExecuteScalarAsync();
				if (response == null)
				{
					return;
				}
				else
				{
					id = (int)response;
				}

				foreach (var hash in gameEvent.updateHashes)
				{
					var cmd = new NpgsqlCommand(@"INSERT INTO data.chronicler_hash_game_event(update_hash, game_event_id) values(@hash, @geid)", psqlConnection);
					cmd.Parameters.AddWithValue("hash", Guid.Parse(hash));
					cmd.Parameters.AddWithValue("geid", id);
					await cmd.ExecuteNonQueryAsync();
				}

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
			string onConflict = "ON CONFLICT ON CONSTRAINT no_dupes DO NOTHING";
			var cmd = new InsertCommand(psqlConnection, "data.game_events", gameEvent, extra, onConflict).Command;
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

		/// <summary>
		/// Helper function to do a query to Chronicler and return a page with generic data
		/// </summary>
		private async Task<ChroniclerV2Page<T>> ChroniclerV2Query<T>(string query)
		{
			HttpResponseMessage response = await m_chroniclerV2Client.GetAsync(query);

			if (response.IsSuccessStatusCode)
			{
				string strResponse = await response.Content.ReadAsStringAsync();

				using JsonDocument json = JsonDocument.Parse(strResponse);

				JsonElement root = json.RootElement;
				JsonElement nextPageElement = root.GetProperty("nextPage");
				JsonElement itemsElement = root.GetProperty("items");

				ChroniclerV2Page<T> page = new ChroniclerV2Page<T>();
				page.NextPage = nextPageElement.ToString();

				List<ChroniclerItem<T>> validItems = new List<ChroniclerItem<T>>();

				foreach (JsonElement item in itemsElement.EnumerateArray())
				{
					try
					{
						ChroniclerItem<T> obj = JsonSerializer.Deserialize<ChroniclerItem<T>>(item.GetRawText(), serializerOptions);
						validItems.Add(obj);
					}
					catch (JsonException e)
					{
						ConsoleOrWebhook(
							$"Exception: ChroniclerV2Query deserialization failed:\n" +
							$"```{JsonSerializer.Serialize(item, new JsonSerializerOptions { WriteIndented = true })}```"
						);
						Console.WriteLine($"Exception message: ${e.Message}");
					}
				}

				page.Items = validItems;

				return page;
			}
			else
			{
				Console.WriteLine($"Query [{query}] failed: {response.ReasonPhrase}");
				return null;
			}
		}

		static string TimestampQueryValue(DateTime dt)
		{
			return dt.ToString("yyyy-MM-ddTHH:mm:ss.ffffffZ");
		}

		private delegate Task ProcessCallback<T>(NpgsqlConnection conn, IEnumerable<ChroniclerItem<T>> items);

		/// <summary>
		/// Generic function to handle making a Chronicler query and paging it up to the time provided
		/// </summary>
		/// <typeparam name="T">Type expected from Chronicler V2 endpoint</typeparam>
		/// <param name="psqlConnection">SQL connection</param>
		/// <param name="type">Type name to pass to Chronicler v2/versions?type= endpoint</param>
		/// <param name="dbTimestamp">Timestamp to start from, or null</param>
		/// <param name="processFunc">Function to process the returned objects</param>
		/// <param name="count">Number of items to fetch per query</param>
		/// <returns></returns>
		private async Task LoadUpdates<T>(NpgsqlConnection psqlConnection, string type, DateTime? dbTimestamp, ProcessCallback<T> processFunc, int count = 100, bool updateChroniclerMeta = true)
		{
			string nextPage = null;
			DateTime? lastSeenTime = null;

			var transaction = psqlConnection.BeginTransaction();

			while (true)
			{
				string query = $"versions?type={type}&count={count}";
				if (dbTimestamp.HasValue)
				{
					query += $"&after={TimestampQueryValue(dbTimestamp.Value)}";
				}
				if (nextPage != null)
				{
					query += $"&page={nextPage}";
				}
				
				ChroniclerV2Page<T> page = null;

				try
				{
					page = await ChroniclerV2Query<T>(query);
				}
				catch (Exception e)
				{
					ConsoleOrWebhook($"Exception: ChroniclerV2Query failed while querying `{query}`.");
					Console.WriteLine($"Exception message: {e.Message}");
				}

				if (page == null || page.Items.Count() == 0)
				{
					break;
				}
				else
				{
					nextPage = page.NextPage;

					Console.WriteLine($"  Processing {page.Items.Count()} {type} updates (through {page.Items.Last().ValidFrom}).");
					lastSeenTime = page.Items.Last().ValidFrom;

					// Create savepoint before upcoming batch of item processing
					await transaction.SaveAsync(lastSeenTime.ToString());

					try 
					{
						await processFunc(psqlConnection, page.Items);
					}
					catch (Exception e)
					{
						ConsoleOrWebhook($"Exception: Rolling back transaction savepoint while processing items for `{query}`.");
						Console.WriteLine($"Exception message: {e.Message}");
						await transaction.RollbackAsync(lastSeenTime.ToString());
						break;
					}

					// We're done!
					if (page.Items.Count() != count)
					{
						break;
					}
				}
			}

			if (lastSeenTime.HasValue && updateChroniclerMeta)
			{
				NpgsqlCommand updateCmd = new NpgsqlCommand($"UPDATE data.chronicler_meta SET {type}_timestamp=@ts WHERE id=0", psqlConnection);
				updateCmd.Parameters.AddWithValue("ts", lastSeenTime);
				int updateResult = await updateCmd.ExecuteNonQueryAsync();
			}

			await transaction.CommitAsync();
		}

		/// <summary>
		/// Generic function for processing entities and upserting them into a table
		/// </summary>
		/// <typeparam name="T">Type of entity</typeparam>
		/// <param name="psqlConnection">SQL connection</param>
		/// <param name="items">List of ChroniclerItems wrapping the entities</param>
		/// <param name="table">Table name to use in SQL</param>
		/// <param name="pkCol">Primary key column name</param>
		/// <param name="ExistsFunc">Function that returns whether this item is already in the DB</param>
		/// <param name="UncountedWorkFunc">Optional </param>
		/// <returns></returns>
		private async Task ProcessEntityList<T>(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerItem<T>> items, string table, string pkCol,
			Func<ChroniclerItem<T>, Task<bool>> ExistsFunc,
			Func<ChroniclerItem<T>, Task> UncountedWorkFunc = null,
			Func<ChroniclerItem<T>, Task> PostWorkFunc = null) where T : ProphBase
		{
			using (MD5 md5 = MD5.Create())
			{
				foreach (var t in items)
				{
					if (UncountedWorkFunc != null)
					{
						await UncountedWorkFunc(t);
					}

					Guid hash = new Guid();
					bool exists = false;

					if (t.Data.UseHash)
					{
						hash = t.Data.Hash(md5);
						NpgsqlCommand cmd = new NpgsqlCommand($"select count(hash) from {table} where hash=@hash and valid_until is null", psqlConnection);
						cmd.Parameters.AddWithValue("hash", hash);
						var count = (long)await cmd.ExecuteScalarAsync();
						exists = (count == 1);
					}
					else
					{
						exists = await ExistsFunc(t);
					}

					if (exists)
					{
						// Record exists
					}
					else
					{
						//Console.WriteLine($"    Found an update {t.Hash} for {t.Data}");

						// Update the old record
						NpgsqlCommand update = new NpgsqlCommand($"update {table} set valid_until=@timestamp where {pkCol} = @id and valid_until is null", psqlConnection);
						// Old record is valid until new record starts
						update.Parameters.AddWithValue("timestamp", t.ValidFrom.Value);
						update.Parameters.AddWithValue("id", t.EntityId);
						int rows = await update.ExecuteNonQueryAsync();
						if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

						var extra = new Dictionary<string, object>();
						extra["valid_from"] = t.ValidFrom.Value;
						if (t.Data.UseHash)
						{
							extra["hash"] = hash;
						}
						// Try to insert our current data
						InsertCommand insertCmd = new InsertCommand(psqlConnection, table, t.Data, extra, "", pkCol);
						var newId = await insertCmd.Command.ExecuteNonQueryAsync();


					}

					if (PostWorkFunc != null)
					{
						await PostWorkFunc(t);
					}
				}
			}
		}

		private async Task ProcessDivisionFinal(ChroniclerItem<ProphDivision> div, NpgsqlConnection psqlConnection)
		{
			var subleagueId = m_divisionToSubleagueMap[div.EntityId];
			var leagueId = m_subleagueToLeagueMap[subleagueId];

			NpgsqlCommand cmd = new NpgsqlCommand(@"update data.divisions set subleague_id=@sub, league_id=@league where division_id=@div and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("sub", subleagueId);
			cmd.Parameters.AddWithValue("league", leagueId);
			cmd.Parameters.AddWithValue("div", div.EntityId);
			await cmd.ExecuteNonQueryAsync();

		}

		// Process the list of teams in the division
		private async Task ProcessDivisionTeamList(ProphDivision d, DateTime? validFrom, DateTime? validTo, NpgsqlConnection psqlConnection)
		{
			foreach (var teamId in d.Teams)
			{

				NpgsqlCommand cmd = new NpgsqlCommand(@"select division_id from data.division_teams where team_id=@team and valid_until is null", psqlConnection);
				cmd.Parameters.AddWithValue("team", teamId);
				var div = (string)await cmd.ExecuteScalarAsync();

				if (div == d.Id)
				{
					// Team is already in that division
				}
				else
				{
					Console.WriteLine($"    Team {teamId} moved to {d.Name}...");

					NpgsqlCommand update = new NpgsqlCommand(@"update data.division_teams set valid_until=@time where team_id=@team and valid_until is null", psqlConnection);
					update.Parameters.AddWithValue("time", validFrom.Value);
					update.Parameters.AddWithValue("team", teamId);

					int rows = await update.ExecuteNonQueryAsync();
					if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

					var subleagueId = m_divisionToSubleagueMap[d.Id];
					var leagueId = m_subleagueToLeagueMap[subleagueId];

					// Try to insert our current data
					NpgsqlCommand insert = new NpgsqlCommand(@"insert into data.division_teams(division_id, subleague_id, league_id, team_id, valid_from, valid_until) values (@div, @sub, @league, @team, @time, null)", psqlConnection);
					insert.Parameters.AddWithValue("div", d.Id);
					insert.Parameters.AddWithValue("sub", subleagueId);
					insert.Parameters.AddWithValue("league", leagueId);
					insert.Parameters.AddWithValue("team", teamId);
					insert.Parameters.AddWithValue("time", validFrom.Value);

					int newId = await insert.ExecuteNonQueryAsync();
				}
			}
		}

		private Dictionary<string, string> m_subleagueToLeagueMap = new Dictionary<string, string>();
		private async Task ProcessLeagueSubList(ChroniclerItem<ProphLeague> league, NpgsqlConnection psqlConnection)
		{
			foreach (var sl in league.Data.Subleagues)
			{
				m_subleagueToLeagueMap[sl] = league.EntityId;
			}
		}


		private async Task ProcessLeagues(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerItem<ProphLeague>> divs)
		{
			await ProcessEntityList<ProphLeague>(psqlConnection, divs, "data.leagues", "league_id",
				async x =>
				{
					NpgsqlCommand cmd = new NpgsqlCommand(@"select count(*) from data.leagues where league_id=@id and league_name=@name and valid_until is null", psqlConnection);
					cmd.Parameters.AddWithValue("id", x.Data.Id);
					cmd.Parameters.AddWithValue("name", x.Data.Name);
					return (long)await cmd.ExecuteScalarAsync() > 0;
				},
				null,
				async x =>
				{
					await ProcessLeagueSubList(x, psqlConnection);
				});
		}

		private Dictionary<string, string> m_divisionToSubleagueMap = new Dictionary<string, string>();
		private async Task ProcessSubleagueDivList(ChroniclerItem<ProphSubleague> sub, NpgsqlConnection psqlConnection)
		{
			foreach (var div in sub.Data.Divisions)
			{
				m_divisionToSubleagueMap[div] = sub.EntityId;
			}

			var leagueId = m_subleagueToLeagueMap[sub.EntityId];
			NpgsqlCommand cmd = new NpgsqlCommand(@"update data.subleagues set league_id=@league where subleague_id=@sub and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("sub", sub.EntityId);
			cmd.Parameters.AddWithValue("league", leagueId);
			await cmd.ExecuteNonQueryAsync();
		}

		private async Task ProcessSubleagues(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerItem<ProphSubleague>> divs)
		{
			await ProcessEntityList<ProphSubleague>(psqlConnection, divs, "data.subleagues", "subleague_id",
				async x =>
				{
					NpgsqlCommand cmd = new NpgsqlCommand(@"select count(*) from data.subleagues where subleague_id=@id and subleague_name=@name and valid_until is null", psqlConnection);
					cmd.Parameters.AddWithValue("id", x.Data.Id);
					cmd.Parameters.AddWithValue("name", x.Data.Name);
					return (long)await cmd.ExecuteScalarAsync() > 0;
				},
				null,
				async x =>
				{
					await ProcessSubleagueDivList(x, psqlConnection);
				});
		}

		private async Task ProcessDivisions(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerItem<ProphDivision>> divs)
		{
			await ProcessEntityList<ProphDivision>(psqlConnection, divs, "data.divisions", "division_id",
				async x =>
				{
					NpgsqlCommand cmd = new NpgsqlCommand(@"select count(*) from data.divisions where division_id=@id and division_name=@name and valid_until is null", psqlConnection);
					cmd.Parameters.AddWithValue("id", x.Data.Id);
					cmd.Parameters.AddWithValue("name", x.Data.Name);
					return (long)await cmd.ExecuteScalarAsync() > 0;
				},
				async x =>
				{
					await ProcessDivisionTeamList(x.Data, x.ValidFrom, x.ValidTo, psqlConnection);
				},
				async x =>
				{
					await ProcessDivisionFinal(x, psqlConnection);
				});
		}

		private async Task ProcessStadiums(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerItem<ProphStadium>> stadiums)
		{
			await ProcessEntityList<ProphStadium>(psqlConnection, stadiums, "data.stadiums", "stadium_id",
				async x =>
				{
					using (MD5 md5 = MD5.Create())
					{
						var hash = x.Data.Hash(md5);
						NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.stadiums where hash=@hash and valid_until is null", psqlConnection);
						cmd.Parameters.AddWithValue("hash", hash);
						var count = (long)await cmd.ExecuteScalarAsync();
						return count == 1;
					}
				},
				async x =>
				{
					NpgsqlCommand curr = new NpgsqlCommand(@"select modification, level from data.stadium_modifications where stadium_id=@sid and valid_until is null", psqlConnection);
					curr.Parameters.AddWithValue("sid", x.Data.Id);

					Dictionary<string, int> modList = new Dictionary<string, int>();
					using(var dr = curr.ExecuteReader())
					{
						while (dr.Read())
						{
							modList[dr.GetString(0)] = dr.GetInt32(1);
						}
					}

					var currMods = x.Data.RenoLog.Concat(x.Data.Weather);
					var goneMods = modList.Except(currMods);
					var newMods = currMods.Except(modList);

					if(goneMods.Count() > 0)
					{
						foreach (var mod in goneMods)
						{
							Console.WriteLine($"    Found a lack of {mod.Key}:{mod.Value} for {x.Data.Nickname} at {x.ValidFrom}!");
							NpgsqlCommand upd = new NpgsqlCommand(@"update data.stadium_modifications set valid_until=@timestamp where stadium_id=@sid and modification=@mod and level=@lev", psqlConnection);
							upd.Parameters.AddWithValue("timestamp", x.ValidFrom);
							upd.Parameters.AddWithValue("sid", x.Data.Id);
							upd.Parameters.AddWithValue("mod", mod.Key);
							upd.Parameters.AddWithValue("lev", mod.Value);
							int rows = await upd.ExecuteNonQueryAsync();
							if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");
						}
					}
					if(newMods.Count() > 0)
					{
						foreach(var mod in newMods)
						{
							Console.WriteLine($"    Found new mod {mod.Key}:{mod.Value} for {x.Data.Nickname} at {x.ValidFrom}!");
							NpgsqlCommand add = new NpgsqlCommand(@"insert into data.stadium_modifications (stadium_id, modification, level, valid_from, valid_until) values (@sid, @mod, @lev, @from, NULL)", psqlConnection);
							add.Parameters.AddWithValue("sid", x.Data.Id);
							add.Parameters.AddWithValue("mod", mod.Key);
							add.Parameters.AddWithValue("lev", mod.Value);
							add.Parameters.AddWithValue("from", x.ValidFrom);
							int rows = await add.ExecuteNonQueryAsync();
							if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");
						}
					}
				},
				null);
		}

		private async Task ProcessTeams(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerItem<ProphTeam>> teams)
		{
			using (MD5 md5 = MD5.Create())
			{
				foreach (var t in teams)
				{
					await ProcessRoster(t.Data, t.ValidFrom, t.ValidTo, psqlConnection);

					var hash = t.Data.Hash(md5);
					NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.teams where hash=@hash and valid_until is null", psqlConnection);
					cmd.Parameters.AddWithValue("hash", hash);
					var count = (long)await cmd.ExecuteScalarAsync();

					if (count == 1)
					{
						// Record exists
					}
					else
					{
						Console.WriteLine($"    Found an update {t.Hash} for {t.Data.FullName} ({t.Data.Id})");

						// Update the old record
						NpgsqlCommand update = new NpgsqlCommand(@"update data.teams set valid_until=@timestamp where team_id = @team_id and valid_until is null", psqlConnection);
						// Old record is valid until new record starts
						update.Parameters.AddWithValue("timestamp", t.ValidFrom);
						update.Parameters.AddWithValue("team_id", t.Data.Id);
						//update.Prepare();
						int rows = await update.ExecuteNonQueryAsync();
						if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

						var extra = new Dictionary<string, object>();
						extra["valid_from"] = t.ValidFrom;
						extra["hash"] = hash;
						// Try to insert our current data
						InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.teams", t.Data, extra);
						var newId = await insertCmd.Command.ExecuteNonQueryAsync();

					}

					await ProcessTeamModAttrs(t.Data, t.ValidFrom, t.ValidTo, psqlConnection);

				}
			}
		}

		private async Task ProcessItems(NpgsqlConnection psqlConnection, DateTime timestamp, ProphPlayer player)
		{
			NpgsqlCommand currCmd = new NpgsqlCommand(@"select item_id from data.player_items where player_id=@pid and valid_until is null", psqlConnection);
			currCmd.Parameters.AddWithValue("pid", player.Id);

			List<string> oldItems = new List<string>();
			using (NpgsqlDataReader dr = currCmd.ExecuteReader())
			{ 
				while (dr.Read())
				{
					oldItems.Add(dr.GetString(0));
				}
			}

			var goneItems = oldItems.Except(player.Items.Select(x => x.Id));

			foreach(var itemId in goneItems)
			{
				NpgsqlCommand update = new NpgsqlCommand(@"update data.player_items set valid_until=@timestamp where player_id=@pid and item_id=@iid and valid_until is null", psqlConnection);
				update.Parameters.AddWithValue("timestamp", timestamp);
				update.Parameters.AddWithValue("pid", player.Id);
				update.Parameters.AddWithValue("iid", itemId);
				int rows = await update.ExecuteNonQueryAsync();
				if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");
			}

			foreach (var item in player.Items)
			{
				item.PlayerId = player.Id;

				// This will need to change to a more sophisticated hash if properties other than ownership and health ever change after the fact for items
				NpgsqlCommand cmd = new NpgsqlCommand(@"select count(*) from data.player_items where player_id=@pid and item_id=@iid and health=@health and valid_until is null", psqlConnection);
				cmd.Parameters.AddWithValue("pid", item.PlayerId);
				cmd.Parameters.AddWithValue("iid", item.Id);
				cmd.Parameters.AddWithValue("health", item.Health);
				var count = (long)cmd.ExecuteScalar();

				if(count == 1)
				{
					// record exists
				}
				else
				{
					Console.WriteLine($"  Processing update for item {item} owned by {item.PlayerId}...");

					// Update the old record
					NpgsqlCommand update = new NpgsqlCommand(@"update data.player_items set valid_until=@timestamp where player_id=@pid and item_id=@iid and valid_until is null", psqlConnection);
					update.Parameters.AddWithValue("timestamp", timestamp);
					update.Parameters.AddWithValue("pid", item.PlayerId);
					update.Parameters.AddWithValue("iid", item.Id);
					int rows = await update.ExecuteNonQueryAsync();
					if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

					var extra = new Dictionary<string, object>();
					extra["valid_from"] = timestamp;
					// Try to insert our current data
					InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.player_items", item, extra);
					var newId = await insertCmd.Command.ExecuteNonQueryAsync();
				}
			}
		}

		private async Task ProcessPlayers(NpgsqlConnection psqlConnection, IEnumerable<ChroniclerItem<ProphPlayer>> players)
		{
			using (MD5 md5 = MD5.Create())
			{
				foreach (var p in players)
				{
					if(p.Data.State != null && p.Data.State.Count > 0)
					{
						if(p.Data.State.ContainsKey("unscatteredName"))
						{
							// Override the scattered name we're getting
							p.Data.Name = ((JsonElement)p.Data.State["unscatteredName"]).GetString();
						}
					}

					if (p.Data.Items != null)
					{
						await ProcessItems(psqlConnection, p.ValidFrom.Value, p.Data);
					}

					var hash = p.Data.Hash(md5);

					NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.players where hash=@hash and valid_until is null", psqlConnection);
					cmd.Parameters.AddWithValue("hash", hash);
					var count = (long)cmd.ExecuteScalar();

					if (count == 1)
					{
						// Record exists
					}
					else
					{
						Console.WriteLine($"    Processing player update {p.Hash} for {p.Data.Name} ({p.Data.Id})");

						// Update the old record
						NpgsqlCommand update = new NpgsqlCommand(@"update data.players set valid_until=@timestamp where player_id=@player_id and valid_until is null", psqlConnection);
						update.Parameters.AddWithValue("timestamp", p.ValidFrom);
						update.Parameters.AddWithValue("player_id", p.Data.Id);
						int rows = await update.ExecuteNonQueryAsync();
						if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

						var extra = new Dictionary<string, object>();
						extra["hash"] = hash;
						extra["valid_from"] = p.ValidFrom;
						// Try to insert our current data
						InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.players", p.Data, extra);
						var newId = await insertCmd.Command.ExecuteNonQueryAsync();

					}

					ProcessPlayerModAttrs(p.Data, p.ValidFrom, p.ValidTo, psqlConnection);
				}
			}
		}

	


		private void ProcessPlayerModAttrs(ProphPlayer p, DateTime? validFrom, DateTime? validTo, NpgsqlConnection psqlConnection)
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

			if (newMods.Count() > 0)
				Console.WriteLine($"    Adding new attrs for {p.Name} ({p.Id})");
			if (oldMods.Count() > 0)
				Console.WriteLine($"    Removing old attrs for {p.Name} ({p.Id})");

			foreach (var modification in newMods)
			{

				// Try to insert our current data
				var insertCmd = new NpgsqlCommand(@"insert into data.player_modifications(player_id, modification, valid_from) values(@player_id, @modification, @valid_from)", psqlConnection);
				insertCmd.Parameters.AddWithValue("player_id", p.Id);
				insertCmd.Parameters.AddWithValue("modification", modification);
				insertCmd.Parameters.AddWithValue("valid_from", validFrom.Value);
				//insertCmd.Prepare();
				int rows = insertCmd.ExecuteNonQuery();
				if (rows != 1) throw new InvalidOperationException($"Tried to insert but got {rows} rows affected!");
			}

			foreach (var modification in oldMods)
			{
				// Update the old record
				NpgsqlCommand update = new NpgsqlCommand(@"update data.player_modifications set valid_until=@timestamp where player_id = @player_id and modification=@modification and valid_until is null", psqlConnection);
				update.Parameters.AddWithValue("timestamp", validFrom.Value);
				update.Parameters.AddWithValue("modification", modification);
				update.Parameters.AddWithValue("player_id", p.Id);
				//update.Prepare();
				int rows = update.ExecuteNonQuery();
				if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

			}

		}


		private async Task ProcessRosterEntry(NpgsqlConnection psqlConnection, DateTime timestamp, ProphTeam team, string playerId, int rosterPosition, PositionType positionTypeEnum)
		{

			int positionType = (int)positionTypeEnum;

			NpgsqlCommand cmd = new NpgsqlCommand(@"select player_id from data.team_roster where team_id=@team_id and position_id=@position_id and position_type_id=@position_type and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("team_id", team.Id);
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
				Console.WriteLine($"    Updating roster entry for {team.FullName} ({team.Id})");

				// Update the old record
				NpgsqlCommand update = new NpgsqlCommand(@"update data.team_roster set valid_until=@timestamp where team_id = @team_id and position_id = @position_id and position_type_id=@position_type and valid_until is null", psqlConnection);
				update.Parameters.AddWithValue("timestamp", timestamp);
				update.Parameters.AddWithValue("team_id", team.Id);
				update.Parameters.AddWithValue("position_id", rosterPosition);
				update.Parameters.AddWithValue("position_type", positionType);
				//update.Prepare();
				int rows = await update.ExecuteNonQueryAsync();
				if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

				if (playerId != null)
				{
					NpgsqlCommand insert = new NpgsqlCommand(@"insert into data.team_roster(team_id, position_id, player_id, position_type_id, valid_from) values(@team_id, @position_id, @player_id, @position_type, @valid_from)", psqlConnection);
					insert.Parameters.AddWithValue("team_id", team.Id);
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
			Bench,
			Shadows
		}

		private NpgsqlCommand CountPositionTypeCommand(NpgsqlConnection psqlConnection, string teamId, PositionType posType)
		{
			NpgsqlCommand cmd = new NpgsqlCommand(@"select max(position_id) from data.team_roster where team_id=@team_id and position_type_id=@position_type and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("team_id", teamId);
			cmd.Parameters.AddWithValue("position_type", (int)posType);
			return cmd;
		}

		private async Task ProcessRoster(ProphTeam t, DateTime? validFrom, DateTime? validTo, NpgsqlConnection psqlConnection)
		{

			Stopwatch s = new Stopwatch();
			s.Start();

			var cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Batter);
			var response = await cmd.ExecuteScalarAsync();
			var maxBatters = response is System.DBNull ? 0 : (int)response + 1;

			for (int i = 0; i < Math.Max(maxBatters, t.Lineup?.Count() ?? 0); i++)
			{
				string playerId = null;
				if (i < t.Lineup.Count())
				{
					playerId = t.Lineup.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, validFrom.Value, t, playerId, i, PositionType.Batter);
			}

			cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Pitcher);
			response = await cmd.ExecuteScalarAsync();
			maxBatters = response is System.DBNull ? 0 : (int)response + 1;
			
			for (int i = 0; i < Math.Max(maxBatters, t.Rotation?.Count() ?? 0); i++)
			{
				string playerId = null;
				if (i < t.Rotation.Count())
				{
					playerId = t.Rotation.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, validFrom.Value, t, playerId, i, PositionType.Pitcher);
			}

			cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Bullpen);
			response = await cmd.ExecuteScalarAsync();
			maxBatters = response is System.DBNull ? 0 : (int)response + 1;

			for (int i = 0; i < Math.Max(maxBatters, t.Bullpen?.Count() ?? 0); i++)
			{
				string playerId = null;
				if (i < (t.Bullpen?.Count() ?? 0))
				{
					playerId = t.Bullpen.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, validFrom.Value, t, playerId, i, PositionType.Bullpen);
			}

			cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Bench);
			response = await cmd.ExecuteScalarAsync();
			maxBatters = response is System.DBNull ? 0 : (int)response + 1;
			
			for (int i = 0; i < Math.Max(maxBatters, t.Bench?.Count() ?? 0); i++)
			{
				string playerId = null;
				if (i < (t.Bench?.Count() ?? 0))
				{
					playerId = t.Bench.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, validFrom.Value, t, playerId, i, PositionType.Bench);
			}

			cmd = CountPositionTypeCommand(psqlConnection, t.Id, PositionType.Shadows);
			response = await cmd.ExecuteScalarAsync();
			maxBatters = response is System.DBNull ? 0 : (int)response + 1;
			
			for (int i = 0; i < Math.Max(maxBatters, t.Shadows?.Count() ?? 0); i++)
			{
				string playerId = null;
				if (i < (t.Shadows?.Count() ?? 0))
				{
					playerId = t.Shadows.ElementAt(i);
				}
				await ProcessRosterEntry(psqlConnection, validFrom.Value, t, playerId, i, PositionType.Shadows);
			}
			
			s.Stop();
			// if (TIMING) Console.WriteLine($"Processed rosters in {s.ElapsedMilliseconds} ms");
		}

	

		private async Task ProcessTeamModAttrs(ProphTeam p, DateTime? validFrom, DateTime? validTo, NpgsqlConnection psqlConnection)
		{

			var countCmd = new NpgsqlCommand(@"select count(modification) from data.team_modifications where team_id=@team_id and valid_until is null", psqlConnection);
			countCmd.Parameters.AddWithValue("team_id", p.Id);
			//countCmd.Prepare();
			long count = (long)await countCmd.ExecuteScalarAsync();
			if (count == 0 && p.PermAttr == null && p.SeasAttr == null && p.WeekAttr == null && p.GameAttr == null)
			{
				return;
			}

			var allMods = new List<string>();
			var currentMods = new List<string>();

			if (p.PermAttr != null) allMods.AddRange(p.PermAttr);
			if (p.SeasAttr != null) allMods.AddRange(p.SeasAttr);
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

			if(newMods.Count() > 0)
				Console.WriteLine($"    Adding new attrs for {p.FullName} ({p.Id})");
			if(oldMods.Count() > 0)
				Console.WriteLine($"    Removing old attrs for {p.FullName} ({p.Id}");

			foreach (var modification in newMods)
			{

				// Try to insert our current data
				var insertCmd = new NpgsqlCommand(@"insert into data.team_modifications(team_id, modification, valid_from) values(@team_id, @modification, @valid_from)", psqlConnection);
				insertCmd.Parameters.AddWithValue("team_id", p.Id);
				insertCmd.Parameters.AddWithValue("modification", modification);
				insertCmd.Parameters.AddWithValue("valid_from", validFrom.Value);
				//insertCmd.Prepare();
				int rows = await insertCmd.ExecuteNonQueryAsync();
				if (rows != 1) throw new InvalidOperationException($"Tried to insert but got {rows} rows affected!");
			}

			foreach (var modification in oldMods)
			{
				// Update the old record
				NpgsqlCommand update = new NpgsqlCommand(@"update data.team_modifications set valid_until=@timestamp where team_id = @team_id and modification=@modification and valid_until is null", psqlConnection);
				update.Parameters.AddWithValue("timestamp", validFrom.Value);
				update.Parameters.AddWithValue("modification", modification);
				update.Parameters.AddWithValue("team_id", p.Id);
				//update.Prepare();
				int rows = await update.ExecuteNonQueryAsync();
				if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

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
                terminology_id, rules_id, statsheet_id, tournament
            )
            VALUES
            (
                @game_id, @day, @season, @home_odds, @away_odds, @weather, @is_postseason, @series_index, @series_length,
                @home_team, @away_team, @home_score, @away_score, @number_of_innings, @ended_on_top_of_inning, @ended_in_shame,
                @terminology_id, @rules_id, @statsheet_id, @tournament
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
			insertGameStatement.Parameters.AddWithValue("tournament", game.tournament);
			return insertGameStatement;
		}

		private NpgsqlCommand UpdateGameCommand(NpgsqlConnection psqlConnection, Game game, string winPitcher, string losePitcher)
		{
			var updateGameStatement = new NpgsqlCommand(@"
            UPDATE data.games SET
            (
                day, season, home_odds, away_odds, weather, is_postseason, series_index, series_length,
                home_team, away_team, home_score, away_score, number_of_innings, ended_on_top_of_inning, ended_in_shame,
                terminology_id, rules_id, statsheet_id, tournament, outcomes, winning_pitcher_id, losing_pitcher_id
            )
            =
            (
                @day, @season, @home_odds, @away_odds, @weather, @is_postseason, @series_index, @series_length,
                @home_team, @away_team, @home_score, @away_score, @number_of_innings, @ended_on_top_of_inning, @ended_in_shame,
                @terminology_id, @rules_id, @statsheet_id, @tournament, @outcomes, @winPitcher, @losePitcher
            )
			WHERE game_id = @game_id;
            ", psqlConnection);

			updateGameStatement.Parameters.AddWithValue("game_id", game.gameId);
			updateGameStatement.Parameters.AddWithValue("day", game.day);
			updateGameStatement.Parameters.AddWithValue("season", game.season);
			updateGameStatement.Parameters.AddWithValue("home_odds", game.homeOdds);
			updateGameStatement.Parameters.AddWithValue("away_odds", game.awayOdds);
			updateGameStatement.Parameters.AddWithValue("weather", game.weather.HasValue ? game.weather.Value : -1);
			updateGameStatement.Parameters.AddWithValue("is_postseason", game.isPostseason);
			updateGameStatement.Parameters.AddWithValue("series_index", game.seriesIndex);
			updateGameStatement.Parameters.AddWithValue("series_length", game.seriesLength);
			updateGameStatement.Parameters.AddWithValue("home_team", game.homeTeam);
			updateGameStatement.Parameters.AddWithValue("away_team", game.awayTeam);
			updateGameStatement.Parameters.AddWithValue("home_score", game.homeScore);
			updateGameStatement.Parameters.AddWithValue("away_score", game.awayScore);
			updateGameStatement.Parameters.AddWithValue("number_of_innings", game.inning);
			updateGameStatement.Parameters.AddWithValue("ended_on_top_of_inning", game.topOfInning);
			updateGameStatement.Parameters.AddWithValue("ended_in_shame", game.shame);
			updateGameStatement.Parameters.AddWithValue("terminology_id", game.terminology);
			updateGameStatement.Parameters.AddWithValue("rules_id", game.rules);
			updateGameStatement.Parameters.AddWithValue("statsheet_id", game.statsheet);
			updateGameStatement.Parameters.AddWithValue("tournament", game.tournament);
			updateGameStatement.Parameters.AddWithValue("outcomes", game.outcomes);
			updateGameStatement.Parameters.AddWithValue("winPitcher", winPitcher);
			updateGameStatement.Parameters.AddWithValue("losePitcher", losePitcher);

			return updateGameStatement;
		}

		private async Task PersistPitcherResults(NpgsqlConnection psqlConnection, string gameId, string winPitcher, string losePitcher, GameEvent lastEvent)
		{
			var game = await GetGameById(gameId);

			var updateCmd = UpdateGameCommand(psqlConnection, game, winPitcher, losePitcher);

			await updateCmd.ExecuteNonQueryAsync();
		}

		private async Task<Game> GetGameById(string id)
		{
			JsonSerializerOptions options = new JsonSerializerOptions();
			options.IgnoreNullValues = true;

			string query = $"gameById/{id}";

			HttpResponseMessage response = await m_blaseballClient.GetAsync(query);

			if (response.IsSuccessStatusCode)
			{

				string strResponse = await response.Content.ReadAsStringAsync();
				return JsonSerializer.Deserialize<Game>(strResponse, options);
			}
			else
			{
				Console.WriteLine($"Got response {response.StatusCode} from {response.RequestMessage.RequestUri}!");
			}

			return null;
		}

		private async Task<IEnumerable<Game>> GetGames(int season, int day, int tournament = -1)
		{
			JsonSerializerOptions options = new JsonSerializerOptions();
			options.IgnoreNullValues = true;

			string query = $"games?day={day}";
			if(season == -1 && tournament != -1)
			{
				query += $"&tournament={tournament}";
			}
			else if(season != -1 && tournament == -1)
			{
				query += $"&season={season}";
			}

			// Get games for this season & day
			HttpResponseMessage response = await m_blaseballClient.GetAsync(query);

			if (response.IsSuccessStatusCode)
			{

				string strResponse = await response.Content.ReadAsStringAsync();
				return JsonSerializer.Deserialize<IEnumerable<Game>>(strResponse, options);
			}
			else
			{
				Console.WriteLine($"Got response {response.StatusCode} from {response.RequestMessage.RequestUri}!");
			}

			return null;
		}

		private async Task<int> GetMaxDayForSeason(int season)
		{
			// Talk to the blaseball API
			var response = await m_blaseballClient.GetAsync($"seasondaycount?season={season}");
			if (response.IsSuccessStatusCode)
			{
				string strResponse = await response.Content.ReadAsStringAsync();
				var data = JsonSerializer.Deserialize<Dictionary<string, int>>(strResponse);
				if(data.ContainsKey("dayCount"))
					return data["dayCount"]+1;
			}

			return 125;
		}

		/// <summary>
		/// Get any completed games from the Blaseball API and insert them in the `game` table
		/// </summary>
		private async Task PopulateGameTable(NpgsqlConnection psqlConnection)
		{

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

				m_regularSeasonDay = new SeasonDay(season, day);
				SeasonDay currSeasonDay = new SeasonDay(season, day);

				Console.WriteLine($"Found games through season {season}, day {day}.");
				// Start on the next day
				day++;

				int maxDay = await GetMaxDayForSeason(season);

				Console.WriteLine($"Adding regular season game records...");
				// Loop until we break out
				while (true)
				{
					var gameList = await GetGames(season, day);
					// If we got an empty response
					if (gameList == null || gameList.Count() == 0)
					{
						// If we've exceeded a reasonable day size for the season
						if (day > maxDay)
						{
							// Ran out of finished games this season, try the next
							m_regularSeasonDay.Season = season;
							season++;
							day = 0;
							maxDay = await GetMaxDayForSeason(season);
							continue;
						}
						// If we got no response on Day 0
						else if (day == 0)
						{
							// season X day 0 had no complete games, stop looping
							break;
						}
					}

					foreach (var game in gameList)
					{
						var cmd = InsertGameCommand(psqlConnection, game);
						await cmd.ExecuteNonQueryAsync();
					}

					m_regularSeasonDay.Day = day;
					day++;
				}
			}

			{
				int tournament = 0;
				int tournDay = -1;

				using (var gamesCommand = new NpgsqlCommand(@"
                SELECT MAX(tournament), MAX(day) from data.games
                INNER JOIN (SELECT MAX(tournament) AS max_tourn FROM data.games WHERE season=-1) b ON b.max_tourn = games.tournament",
					psqlConnection))
				using (var reader = await gamesCommand.ExecuteReaderAsync())
				{

					while (await reader.ReadAsync())
					{
						if (!reader.IsDBNull(0))
							tournament = reader.GetInt32(0);
						if (!reader.IsDBNull(1))
							tournDay = reader.GetInt32(1);
					}
				}

				m_tournamentSeasonDay = new SeasonDay(-1, tournDay, tournament);
				// Start on the next day
				tournDay++;

				Console.WriteLine($"Adding tournament game records...");
				// Loop until we break out
				while (true)
				{
					var gameList = await GetGames(-1, tournDay, tournament);
					// If we got no response 
					if (gameList == null || gameList.Count() == 0)
					{
						if (tournDay > 0)
						{
							// Ran out of finished games this season, try the next
							m_tournamentSeasonDay.Season = -tournament;
							tournament++;
							tournDay = 0;
							continue;
						}
						else
						{
							// season X day 0 had no complete games, stop looping
							break;
						}
					}

					foreach (var game in gameList)
					{
						var cmd = InsertGameCommand(psqlConnection, game);
						await cmd.ExecuteNonQueryAsync();
					}

					m_tournamentSeasonDay.Day = tournDay;
					tournDay++;
				}
			}

			Console.WriteLine($"Stored regular games through Season {m_regularSeasonDay.Season}, Day {m_regularSeasonDay.Day}");
			Console.WriteLine($"Stored tournament games through Tournament {m_tournamentSeasonDay.Tournament}, Day {m_tournamentSeasonDay.Day}");
			Console.WriteLine($"Done!");
		}

		public static void ConsoleOrWebhook(string msg)
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