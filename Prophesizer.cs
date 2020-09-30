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


	class Prophesizer
	{

		private Processor processor;
		private Queue<GameEvent> m_eventsToInsert;
		private Queue<(string, string, string)> pitcherResults;

		private JsonSerializerOptions serializerOptions;

		private int minSeasonDay = int.MaxValue;
		private int maxSeasonDay = int.MinValue;

		private int numEvents = 0;

		private const bool TIMING = false;
		private const bool TIMING_FILE = true;
		private const bool DO_HOURLY = true;
		private const bool DO_EVENTS = true;

		HttpClient m_client;
		public Prophesizer(string bucketName)
		{
			processor = new Processor();
			m_eventsToInsert = new Queue<GameEvent>();
			pitcherResults = new Queue<(string, string, string)>();

			serializerOptions = new JsonSerializerOptions();
			serializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
			serializerOptions.PropertyNameCaseInsensitive = true;
			serializerOptions.IgnoreNullValues = true;

			m_client = new HttpClient();
			m_client.BaseAddress = new Uri("https://reblase.sibr.dev/newapi/");
			m_client.DefaultRequestHeaders.Accept.Clear();
			m_client.DefaultRequestHeaders.Accept.Add(
				new MediaTypeWithQualityHeaderValue("application/json"));

		}

		private static int MakeSeasonDay(int season, int day)
		{
			return season * 10000 + day;
		}

		private async Task<(int, int)> GetLastRecordedSeasonDay(NpgsqlConnection psqlConnection)
		{
			int season = 0;
			int day = 0;

			NpgsqlCommand cmd = new NpgsqlCommand(@"
				select b.season, b.maxday from data.completed_days cd
				inner join
				(
					select season, max(day) as maxday from data.completed_days group by season
				) b on cd.season = b.season and cd.day = b.maxday
				order by season desc
				limit 1", psqlConnection);
			using (var reader = await cmd.ExecuteReaderAsync())
			{
				while (await reader.ReadAsync())
				{
					season = reader.GetInt32(0);
					day = reader.GetInt32(1);
				}
			}

			return (season, day);
		}

		public async Task Poll()
		{
			ConsoleOrWebhook($"Started poll at {DateTime.UtcNow.ToString()} UTC.");

			minSeasonDay = int.MaxValue;
			maxSeasonDay = int.MinValue;

			numEvents = 0;

			await using var psqlConnection = new NpgsqlConnection(Environment.GetEnvironmentVariable("PSQL_CONNECTION_STRING"));
			await psqlConnection.OpenAsync();


			//if (DO_HOURLY)
			//{
			//	int i = 0;
			//	foreach (S3Object logObject in unprocessedLogs.hourlyLogs)
			//	{
			//		await FetchAndProcessHourly(logObject.Key, psqlConnection);
			//		var percent = (float)i / unprocessedLogs.hourlyLogs.Count();
			//		Console.WriteLine($"{percent:P0} complete");

			//		using (var logStatement = PersistLogRecord(psqlConnection, logObject.Key))
			//		{
			//			await logStatement.ExecuteNonQueryAsync();
			//		}
			//		i++;
			//	}
			//}

			await PopulateGameTable(psqlConnection);

			int season = 0;
			int day = 0;

			(season, day) = await GetLastRecordedSeasonDay(psqlConnection);
			// Start from the next day
			day++;

			if (DO_EVENTS)
			{
				processor.GameComplete += Processor_GameComplete;
				processor.EventComplete += Processor_EventComplete;
				while (true)
				{
					string query = $"games/updates?season={season}&day={day}&order=asc&started=true&count=1000";

					HttpResponseMessage response = await m_client.GetAsync(query);

					if (response.IsSuccessStatusCode)
					{
						string strResponse = await response.Content.ReadAsStringAsync();

						// Deserialize the JSON
						var updates = JsonSerializer.Deserialize<IEnumerable<ChroniclerUpdate>>(strResponse, serializerOptions);

						if(updates.Count() == 0 && day == 0)
						{
							// If we got no results on day 0 of a season, bail out
							break;
						}
						if (updates.Count() == 0 )
						{
							// If we got no results some other time in the season, try the next season
							day = 0;
							season++;
						}

						foreach (var obj in updates)
						{
							await processor.ProcessGameObject(obj.Data, obj.Timestamp);
						}

						// TODO: Update the time map
						//await PersistTimeMap(gameEvents, psqlConnection);

						// Update the completed_days table 
					}

					Console.WriteLine($"Inserting {m_eventsToInsert.Count} game events from season {season}, day {day}");
					// Process any game events we received
					while(m_eventsToInsert.Count > 0)
					{
						var e = m_eventsToInsert.Dequeue();
						await PersistGame(psqlConnection, e);
					}

					Console.WriteLine($"Inserting {pitcherResults.Count} pitcher records from season {season}, day {day}");
					// Process any pitcher results from completed games
					while (pitcherResults.Count > 0)
					{
						var result = pitcherResults.Dequeue();
						await PersistPitcherResults(psqlConnection, result.Item1, result.Item2, result.Item3);
					}

					// Increment the day
					day++;
				}
				processor.EventComplete -= Processor_EventComplete;
				processor.GameComplete -= Processor_GameComplete;
			}

			/*
			string msg = $"Processed {unprocessedLogs.updateLogs.Count} game update logs and {unprocessedLogs.hourlyLogs.Count} hourly logs.\n";
			if (numEvents > 0)
			{
				int minDay = minSeasonDay % 10000;
				int minSeason = minSeasonDay / 10000;
				int maxDay = maxSeasonDay % 10000;
				int maxSeason = maxSeasonDay / 10000;

				string rangeText = $"Season {minSeason + 1}, Day {minDay + 1} to Season {maxSeason + 1}, Day {maxDay + 1}";
				if (minSeason == maxSeason)
				{
					if (minDay == maxDay)
					{
						rangeText = $"Season {minSeason + 1}, Day {minDay + 1}";
					}
					else
					{
						rangeText = $"Season {minSeason + 1}, Day {minDay + 1} - {maxDay + 1}";
					}
				}

				msg += $"Inserted {numEvents} game events (from {rangeText}) into the Datablase.\n";
			}
			else
			{
				msg += $"No new game events found!\n";
			}
			msg += $"Finished poll at {DateTime.UtcNow.ToString()} UTC.";
			ConsoleOrWebhook(msg);*/
		}

		private void Processor_EventComplete(object sender, GameEventCompleteEventArgs e)
		{
			m_eventsToInsert.Enqueue(e.GameEvent);
		}

		private void Processor_GameComplete(object sender, GameCompleteEventArgs e)
		{
			pitcherResults.Enqueue((e.GameId, e.WinningPitcherId, e.LosingPitcherId));
		}

	
		//private async Task<int> PersistGameEvents(
		//  string keyName,
		//  IEnumerable<GameEvent> gameEvents,
		//  NpgsqlConnection psqlConnection
		//)
		//{
		//	var transaction = psqlConnection.BeginTransaction();

		//	try
		//	{
		//		foreach (var gameEvent in gameEvents)
		//		{
		//			await PersistGame(psqlConnection, gameEvent, keyName);
		//		}

		//		transaction.Commit();

		//		var first = gameEvents.First();
		//		var last = gameEvents.Last();

		//		minSeasonDay = Math.Min(minSeasonDay, MakeSeasonDay(first.season, first.day));
		//		maxSeasonDay = Math.Max(maxSeasonDay, MakeSeasonDay(last.season, last.day));

		//		numEvents += gameEvents.Count();

		//		//Console.WriteLine($"Inserted {gameEvents.Count()} game_events (from S{first.season}D{first.day} to S{last.season}D{last.day}) into Postgres from {keyName}.");

		//		return gameEvents.Count();
		//	}
		//	catch (Exception e)
		//	{
		//		transaction.Rollback();

		//		ConsoleOrWebhook($"Failed to insert events from {keyName} into Postgres:");
		//		ConsoleOrWebhook(e.Message);

		//		return 0;
		//	}
		//}

		private async Task PersistGame(NpgsqlConnection psqlConnection, GameEvent gameEvent)
		{
			using (var gameEventStatement = PrepareGameEventStatement(psqlConnection, gameEvent))
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

					if (outcome.eventType == OutcomeType.INCINERATION)
					{
						var playerId = outcome.entityId;

						DateTime timestamp;
						if (gameEvent.firstPerceivedAt.Year == 1970)
						{
							// TODO is this a problem
							timestamp = gameEvent.firstPerceivedAt;
						}
						else
						{
							timestamp = gameEvent.firstPerceivedAt;
						}

						await LookupIncineratedPlayer(playerId, timestamp, psqlConnection);
					}
				}
			}
		}

		private async Task LookupIncineratedPlayer(string playerId, DateTime timestamp, NpgsqlConnection psqlConnection)
		{

			HttpClient client = new HttpClient();
			client.BaseAddress = new Uri("https://www.blaseball.com/database/");
			client.DefaultRequestHeaders.Accept.Clear();
			client.DefaultRequestHeaders.Accept.Add(
				new MediaTypeWithQualityHeaderValue("application/json"));

			JsonSerializerOptions options = new JsonSerializerOptions();
			options.IgnoreNullValues = true;
			options.PropertyNameCaseInsensitive = true;

			// Get player record
			HttpResponseMessage response = await client.GetAsync($"players?ids={playerId}");

			if (response.IsSuccessStatusCode)
			{

				string strResponse = await response.Content.ReadAsStringAsync();
				var playerList = JsonSerializer.Deserialize<List<Player>>(strResponse, options);

				var player = playerList.FirstOrDefault();
				using (MD5 md5 = MD5.Create())
				{
					ProcessPlayer(player, timestamp, psqlConnection, md5);
				}
			}
		}

		private NpgsqlCommand PrepareGameEventStatement(NpgsqlConnection psqlConnection, GameEvent gameEvent)
		{
			var cmd = new InsertCommand(psqlConnection, "data.game_events", gameEvent).Command;
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

		private NpgsqlCommand PersistLogRecord(NpgsqlConnection psqlConnection, string keyName)
		{
			var persistLogStatement = new NpgsqlCommand(@"
        INSERT INTO data.imported_logs(
          key,
          imported_at
        ) VALUES (
          @key,
          @imported_at
        );
      ", psqlConnection);

			persistLogStatement.Parameters.AddWithValue("key", keyName);
			persistLogStatement.Parameters.AddWithValue("imported_at", DateTime.UtcNow);
			//persistLogStatement.Prepare();
			return persistLogStatement;
		}

		//private async Task FetchAndProcessHourly(string keyName, NpgsqlConnection psqlConnection)
		//{
		//	GetObjectRequest request = new GetObjectRequest
		//	{
		//		BucketName = bucketName,
		//		Key = keyName
		//	};

		//	using (GetObjectResponse response = await client.GetObjectAsync(request))
		//	using (Stream responseStream = response.ResponseStream)
		//	{
		//		Console.Write($"Processing document (Key: {keyName}, Length: {response.ContentLength})...");

		//		await ProcessHourly(keyName, responseStream, psqlConnection);

		//		return;
		//	}
		//}

		private static DateTime DateTimeFromKeyName(string keyName)
		{
			var dash = keyName.LastIndexOf('-');
			var dot = keyName.IndexOf('.');

			string timeStr = keyName.Substring(dash + 1, dot - dash - 1);
			long timeNum = long.Parse(timeStr);
			DateTime timestamp = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
			return timestamp.AddMilliseconds(timeNum);
		}

		private async Task ProcessHourly(string keyName, Stream responseStream, NpgsqlConnection psqlConnection)
		{
			Stopwatch s = new Stopwatch();
			s.Start();
			try
			{

				using (GZipStream decompressionStream = new GZipStream(responseStream, CompressionMode.Decompress))
				using (MemoryStream decompressedStream = new MemoryStream())
				{
					decompressionStream.CopyTo(decompressedStream);
					decompressedStream.Seek(0, SeekOrigin.Begin);


					using (StreamReader reader = new StreamReader(decompressedStream))
					{
						while (!reader.EndOfStream)
						{
							string json = reader.ReadLine();
							var hourly = JsonSerializer.Deserialize<HourlyArchive>(json, serializerOptions);

							DateTime timestamp;

							if (hourly.ClientMeta == null || hourly.ClientMeta.timestamp == null)
							{
								timestamp = DateTimeFromKeyName(keyName);
							}
							else
							{
								timestamp = hourly.ClientMeta.timestamp;
							}

							switch (hourly.Endpoint)
							{
								case "players":
									ProcessPlayers(hourly, timestamp, psqlConnection);
									break;
								case "allTeams":
									await ProcessAllTeams((JsonElement)hourly.Data, timestamp, psqlConnection);
									break;
								case "offseasonSetup":
									break;
								case "globalEvents":
									break;
							}
						}
					}
				}
			}
			catch (Exception e)
			{
				ConsoleOrWebhook($"Failed to process {keyName}: {e.Message}");
				Console.WriteLine(e.StackTrace);
				return;
			}
			s.Stop();
			if (TIMING_FILE) Console.Write($"({s.ElapsedMilliseconds} ms)...");
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

		private void ProcessPlayer(Player p, DateTime timestamp, NpgsqlConnection psqlConnection, HashAlgorithm hashAlg)
		{

			// TODO move hashing into Player
			var hash = HashObject(hashAlg, p);

			NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.players where hash=@hash and valid_until is null", psqlConnection);
			cmd.Parameters.AddWithValue("hash", hash);
			//cmd.Prepare();
			var count = (long)cmd.ExecuteScalar();

			if (count == 1)
			{
				// Record exists
			}
			else
			{
				// Update the old record
				NpgsqlCommand update = new NpgsqlCommand(@"update data.players set valid_until=@timestamp where player_id = @player_id and valid_until is null", psqlConnection);
				update.Parameters.AddWithValue("timestamp", timestamp);
				update.Parameters.AddWithValue("player_id", p.Id);
				//update.Prepare();
				int rows = update.ExecuteNonQuery();
				if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

				var extra = new Dictionary<string, object>();
				extra["hash"] = hash;
				extra["valid_from"] = timestamp;
				// Try to insert our current data
				InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.players", p, extra);
				var newId = insertCmd.Command.ExecuteNonQuery();

			}

			ProcessPlayerModAttrs(p, timestamp, psqlConnection);
		}

		private void ProcessPlayers(HourlyArchive hourly, DateTime timestamp, NpgsqlConnection psqlConnection)
		{
			string text = ((JsonElement)hourly.Data).GetRawText();

			IEnumerable<string> playerIds = hourly.Params["ids"];

			Stopwatch s = new Stopwatch();
			using (MD5 md5 = MD5.Create())
			{
				s.Start();

				var playerList = JsonSerializer.Deserialize<IEnumerable<Player>>(text, serializerOptions);

				foreach (var p in playerList)
				{
					ProcessPlayer(p, timestamp, psqlConnection, md5);
				}
				s.Stop();
				//Console.WriteLine($"Processed {playerList.Count()} players in {s.ElapsedMilliseconds} ms");
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

			Console.WriteLine($"Found games through season {season}, day {day}.");
			// Start on the next day
			day++;

			// Talk to the blaseball API
			HttpClient client = new HttpClient();
			client.BaseAddress = new Uri("https://www.blaseball.com/database/");
			client.DefaultRequestHeaders.Accept.Clear();
			client.DefaultRequestHeaders.Accept.Add(
				new MediaTypeWithQualityHeaderValue("application/json"));

			JsonSerializerOptions options = new JsonSerializerOptions();
			options.IgnoreNullValues = true;

			// Okay we know we have completed at least this many full seasons
			int MIN_SEASON = 5;

			// Loop until we break out
			while (true)
			{
				// Get games for this season & day
				HttpResponseMessage response = await client.GetAsync($"games?day={day}&season={season}");

				if (response.IsSuccessStatusCode)
				{

					string strResponse = await response.Content.ReadAsStringAsync();
					var gameList = JsonSerializer.Deserialize<IEnumerable<Game>>(strResponse, options);

					// If we got no response OR we're past the minimum and we got a "game not complete" response
					if (gameList == null || gameList.Count() == 0 || (season > MIN_SEASON && gameList.First().gameComplete == false))
					{
						if (day > 0)
						{
							// Ran out of finished games this season, try the next
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