using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using Cauldron;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
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

namespace SIBR {

  class Logs {
    public List<S3Object> updateLogs { get; set; }
    public List<S3Object> hourlyLogs { get; set; }

    public Logs() {
      updateLogs = new List<S3Object>();
      hourlyLogs = new List<S3Object>();
    }
  }

  class Prophesizer {
    private static readonly RegionEndpoint bucketRegion = RegionEndpoint.USWest2;


    private IAmazonS3 client;
    private string bucketName;
    private Processor processor;
    private Queue<IEnumerable<GameEvent>> gamesToInsert;

    private JsonSerializerOptions serializerOptions;

    private int minSeasonDay = int.MaxValue;
    private int maxSeasonDay = int.MinValue;

    private int numEvents = 0;

    public Prophesizer(string bucketName) {
      this.bucketName = bucketName;
      this.client = new AmazonS3Client(Environment.GetEnvironmentVariable("AWS_KEY"), Environment.GetEnvironmentVariable("AWS_SECRET"), bucketRegion);
      processor = new Processor();
      gamesToInsert = new Queue<IEnumerable<GameEvent>>();

      serializerOptions = new JsonSerializerOptions();
      serializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
      serializerOptions.PropertyNameCaseInsensitive = true;

    }

    private static int MakeSeasonDay(int season, int day) {
      return season * 10000 + day;
    }

    public async Task Poll() {
      ConsoleOrWebhook($"Started poll at {DateTime.UtcNow.ToString()} UTC.");

      minSeasonDay = int.MaxValue;
      maxSeasonDay = int.MinValue;

      numEvents = 0;

      await using var psqlConnection = new NpgsqlConnection(Environment.GetEnvironmentVariable("PSQL_CONNECTION_STRING"));
      await psqlConnection.OpenAsync();

      // Populate the `game` table first
      await PopulateGameTable(psqlConnection);

      var unprocessedLogs = await GetUnprocessedLogs(psqlConnection);

      Console.WriteLine($"Found {unprocessedLogs.updateLogs.Count()} unprocessed game update log(s).");
      Console.WriteLine($"Found {unprocessedLogs.hourlyLogs.Count()} unprocessed hourly log(s).");

      foreach (S3Object logObject in unprocessedLogs.hourlyLogs) {
        await FetchAndProcessHourly(logObject.Key, psqlConnection);

        using (var logStatement = PersistLogRecord(psqlConnection, logObject.Key)) {
          await logStatement.ExecuteNonQueryAsync();
        }
      }

      processor.GameComplete += Processor_GameComplete;
      foreach (S3Object logObject in unprocessedLogs.updateLogs) {
        await FetchAndProcessObject(logObject.Key, psqlConnection);

        using (var logStatement = PersistLogRecord(psqlConnection, logObject.Key)) {
          await logStatement.ExecuteNonQueryAsync();
        }

        //Console.WriteLine($"Found {gamesToInsert.Count} games to insert.");
        while (gamesToInsert.Count > 0) {
          var gameEvents = gamesToInsert.Dequeue();
          await PersistGameEvents(logObject.Key, gameEvents, psqlConnection);
          await PersistTimeMap(gameEvents, psqlConnection);
        }
      }
      processor.GameComplete -= Processor_GameComplete;

      string msg = $"Processed {unprocessedLogs.updateLogs.Count} game update logs and {unprocessedLogs.hourlyLogs.Count} hourly logs.\n";
      if (numEvents > 0) {
        int minDay = minSeasonDay % 10000;
        int minSeason = minSeasonDay / 10000;
        int maxDay = maxSeasonDay % 10000;
        int maxSeason = maxSeasonDay / 10000;

        string rangeText = $"Season {minSeason + 1}, Day {minDay + 1} to Season {maxSeason + 1}, Day {maxDay + 1}";
        if (minSeason == maxSeason) {
          if (minDay == maxDay) {
            rangeText = $"Season {minSeason + 1}, Day {minDay + 1}";
          } else {
            rangeText = $"Season {minSeason + 1}, Day {minDay + 1} - {maxDay + 1}";
          }
        }

        msg += $"Inserted {numEvents} game events (from {rangeText}) into the Datablase.\n";
      }
      else {
        msg += $"No new game events found!\n";
      }
      msg += $"Finished poll at {DateTime.UtcNow.ToString()} UTC.";
      ConsoleOrWebhook(msg);
    }

    private void Processor_GameComplete(object sender, GameCompleteEventArgs e) {
      gamesToInsert.Enqueue(e.GameEvents);
    }

    private async Task<IEnumerable<S3Object>> GetObjectsWithPrefix(string prefix) {
      List<S3Object> objects = new List<S3Object>();
      try {
        ListObjectsRequest request = new ListObjectsRequest {
          BucketName = bucketName,
          MaxKeys = 500,
          Prefix = prefix
        };

        do {
          ListObjectsResponse response = await client.ListObjectsAsync(request);

          objects.AddRange(response.S3Objects);

          if (response.IsTruncated) {
            request.Marker = response.NextMarker;
          } else {
            request = null;
          }
        } while (request != null);
      } catch (AmazonS3Exception e) {
        Console.WriteLine("ListObjects encountered an S3 error: {0}", e.Message);
      } catch (Exception e) {
        Console.WriteLine("ListObjects encounter an unexpected error: {0}", e.Message);
      }

      return objects;
    }

    private async Task<Logs> GetUnprocessedLogs(NpgsqlConnection psqlConnection) {
      Console.WriteLine("Fetching bucket keys...");

      Logs logs = new Logs();
      logs.updateLogs.AddRange(await GetObjectsWithPrefix("blaseball-log-"));
      logs.hourlyLogs.AddRange(await GetObjectsWithPrefix("compressed-hourly/blaseball-hourly-"));

      Console.WriteLine("Determining which logs require processing...");

      using (var importedLogsStatement = new NpgsqlCommand("SELECT key FROM data.imported_logs", psqlConnection))
      using (var reader = await importedLogsStatement.ExecuteReaderAsync()) {
        var processedLogs = new List<string>();

        while (await reader.ReadAsync()) {
          processedLogs.Add(reader.GetString(0));
        }

        logs.updateLogs = logs.updateLogs.Where(log => !processedLogs.Contains(log.Key)).ToList();
        logs.hourlyLogs = logs.hourlyLogs.Where(log => !processedLogs.Contains(log.Key)).ToList();
        return logs;
      }
    }

    private async Task FetchAndProcessObject(string keyName, NpgsqlConnection psqlConnection) {
      GetObjectRequest request = new GetObjectRequest {
        BucketName = bucketName,
        Key = keyName
      };

      using (GetObjectResponse response = await client.GetObjectAsync(request))
      using (Stream responseStream = response.ResponseStream) {
        Console.WriteLine($"Processing document (Key: {keyName}, Length: {response.ContentLength})...");

        ProcessObject(keyName, responseStream);

        return;
      }
    }

    private void ProcessObject(string keyName, Stream responseStream) {
      try {
        using (GZipStream decompressionStream = new GZipStream(responseStream, CompressionMode.Decompress))
        using (MemoryStream decompressedStream = new MemoryStream()) {
          decompressionStream.CopyTo(decompressedStream);
          decompressedStream.Seek(0, SeekOrigin.Begin);

          using (StreamReader reader = new StreamReader(decompressedStream)) {
            processor.Process(reader);
          }
        }
      } catch (Exception e) {
        Console.WriteLine($"Failed to process {keyName}: {e.Message}");
        Console.WriteLine(e.StackTrace);
        return;
      }
    }

    private async Task<int> PersistGameEvents(
      string keyName,
      IEnumerable<GameEvent> gameEvents,
      NpgsqlConnection psqlConnection
    ) {
      var transaction = psqlConnection.BeginTransaction();

      try {
        foreach (var gameEvent in gameEvents) {
          await PersistGame(psqlConnection, gameEvent);
        }

        transaction.Commit();

        var first = gameEvents.First();
        var last = gameEvents.Last();

        minSeasonDay = Math.Min(minSeasonDay, MakeSeasonDay(first.season, first.day));
        maxSeasonDay = Math.Max(maxSeasonDay, MakeSeasonDay(last.season, last.day));

        numEvents += gameEvents.Count();

        //Console.WriteLine($"Inserted {gameEvents.Count()} game_events (from S{first.season}D{first.day} to S{last.season}D{last.day}) into Postgres from {keyName}.");

        return gameEvents.Count();
      } catch (Exception e) {
        transaction.Rollback();

        Console.WriteLine($"Failed to insert events from {keyName} into Postgres:");
        Console.WriteLine(e.Message);

        return 0;
      }
    }

    private async Task PersistGame(NpgsqlConnection psqlConnection, GameEvent gameEvent) {
      using (var gameEventStatement = PrepareGameEventStatement(psqlConnection, gameEvent)) {
        int id = (int)await gameEventStatement.ExecuteScalarAsync();

        foreach (var baseRunner in gameEvent.baseRunners) {
          using (var baseRunnerStatement = PrepareGameEventBaseRunnerStatements(psqlConnection, id, baseRunner)) {
            await baseRunnerStatement.ExecuteNonQueryAsync();
          }
        }

        foreach (var playerEvent in gameEvent.playerEvents) {
          using (var playerEventStatement = PreparePlayerEventStatement(psqlConnection, id, playerEvent)) {
            await playerEventStatement.ExecuteNonQueryAsync();
          }

          if(playerEvent.eventType == PlayerEventType.INCINERATION) {
            var playerId = playerEvent.playerId;
            await LookupIncineratedPlayer(playerId, gameEvent.firstPerceivedAt, psqlConnection);
          }
        }
      }
    }

    private async Task LookupIncineratedPlayer(string playerId, DateTime timestamp, NpgsqlConnection psqlConnection) {
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

      if (response.IsSuccessStatusCode) {

        string strResponse = await response.Content.ReadAsStringAsync();
        var playerList = JsonSerializer.Deserialize<List<Player>>(strResponse, options);

        var player = playerList.FirstOrDefault();
        using (MD5 md5 = MD5.Create()) {
          ProcessPlayer(player, timestamp, psqlConnection, md5);
        }
      }
    }

    private NpgsqlCommand PrepareGameEventStatement(NpgsqlConnection psqlConnection, GameEvent gameEvent) {
      return new InsertCommand(psqlConnection, "data.game_events", gameEvent).Command;
    }

    private NpgsqlCommand PrepareGameEventBaseRunnerStatements(NpgsqlConnection psqlConnection, int gameEventId, GameEventBaseRunner baseRunnerEvent) {
      var extra = new Dictionary<string, object>();
      extra["game_event_id"] = gameEventId;
      return new InsertCommand(psqlConnection, "data.game_event_base_runners", baseRunnerEvent, extra).Command;
    }

    private NpgsqlCommand PreparePlayerEventStatement(NpgsqlConnection psqlConnection, int gameEventId, PlayerEvent playerEvent) {
      var extra = new Dictionary<string, object>();
      extra["game_event_id"] = gameEventId;
      return new InsertCommand(psqlConnection, "data.player_events", playerEvent, extra).Command;
    }

    private NpgsqlCommand PersistLogRecord(NpgsqlConnection psqlConnection, string keyName) {
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

      return persistLogStatement;
    }

    private async Task FetchAndProcessHourly(string keyName, NpgsqlConnection psqlConnection) {
      GetObjectRequest request = new GetObjectRequest {
        BucketName = bucketName,
        Key = keyName
      };

      using (GetObjectResponse response = await client.GetObjectAsync(request))
      using (Stream responseStream = response.ResponseStream) {
        Console.WriteLine($"Processing document (Key: {keyName}, Length: {response.ContentLength})...");

        ProcessHourly(keyName, responseStream, psqlConnection);

        return;
      }
    }

    private void ProcessHourly(string keyName, Stream responseStream, NpgsqlConnection psqlConnection) {
      try {
        using (GZipStream decompressionStream = new GZipStream(responseStream, CompressionMode.Decompress))
        using (MemoryStream decompressedStream = new MemoryStream()) {
          decompressionStream.CopyTo(decompressedStream);
          decompressedStream.Seek(0, SeekOrigin.Begin);


          using (StreamReader reader = new StreamReader(decompressedStream)) {
            while (!reader.EndOfStream) {
              string json = reader.ReadLine();
              var hourly = JsonSerializer.Deserialize<HourlyArchive>(json, serializerOptions);

              DateTime timestamp;

              if(hourly.ClientMeta == null || hourly.ClientMeta.timestamp == null) {
                
                var dash = keyName.LastIndexOf('-');
                var dot = keyName.IndexOf('.');
                
                string timeStr = keyName.Substring(dash+1, dot-dash-1);
                long timeNum = long.Parse(timeStr);
                // TODO make this a utility function already
                timestamp = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
                timestamp = timestamp.AddMilliseconds(timeNum);
              }
              else {
                timestamp = hourly.ClientMeta.timestamp;
              }

              switch (hourly.Endpoint) {
                case "players":
                  ProcessPlayers(hourly, timestamp, psqlConnection);
                  break;
                case "allTeams":
                  ProcessAllTeams((JsonElement)hourly.Data, timestamp, psqlConnection);
                  break;
                case "offseasonSetup":
                  break;
                case "globalEvents":
                  break;
              }
            }
          }
        }
      } catch (Exception e) {
        Console.WriteLine($"Failed to process {keyName}: {e.Message}");
        Console.WriteLine(e.StackTrace);
        return;
      }
    }

    private Guid HashObject(HashAlgorithm hashAlgorithm, object obj) {
      StringBuilder sb = new StringBuilder();

      foreach(var prop in obj.GetType().GetProperties()) {
        sb.Append(prop.GetValue(obj)?.ToString());
      }

      // Convert the input string to a byte array and compute the hash.
      byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(sb.ToString()));

      return new Guid(data);
    }

    private void ProcessPlayer(Player p, DateTime timestamp, NpgsqlConnection psqlConnection, HashAlgorithm hashAlg) {
      // TODO move hashing into Player
      var hash = HashObject(hashAlg, p);

      NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.players where hash=@hash and valid_until is null", psqlConnection);
      cmd.Parameters.AddWithValue("hash", hash);
      var count = (long)cmd.ExecuteScalar();

      if (count == 1) {
        // Record exists
      } else {
        // Update the old record
        NpgsqlCommand update = new NpgsqlCommand(@"update data.players set valid_until=@timestamp where player_id = @player_id and valid_until is null", psqlConnection);
        update.Parameters.AddWithValue("timestamp", timestamp);
        update.Parameters.AddWithValue("player_id", p.Id);
        int rows = update.ExecuteNonQuery();
        if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

        var extra = new Dictionary<string, object>();
        extra["hash"] = hash;
        extra["valid_from"] = timestamp;
        // Try to insert our current data
        InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.players", p, extra);
        var newId = insertCmd.Command.ExecuteNonQuery();

      }
    }

    private void ProcessPlayers(HourlyArchive hourly, DateTime timestamp, NpgsqlConnection psqlConnection) {
      string text = ((JsonElement)hourly.Data).GetRawText();

      IEnumerable<string> playerIds = hourly.Params["ids"];

      using (MD5 md5 = MD5.Create()) {

        var playerList = JsonSerializer.Deserialize<IEnumerable<Player>>(text, serializerOptions);

        foreach (var p in playerList) {
          ProcessPlayer(p, timestamp, psqlConnection, md5);
        }
      }
    }


    private void ProcessRosterEntry(NpgsqlConnection psqlConnection, DateTime timestamp, string teamId, string playerId, int rosterPosition) {

      NpgsqlCommand cmd = new NpgsqlCommand(@"select player_id from data.team_roster where team_id=@team_id and position_id=@position_id and valid_until is null", psqlConnection);
      cmd.Parameters.AddWithValue("team_id", teamId);
      cmd.Parameters.AddWithValue("position_id", rosterPosition);
      var oldPlayerId = (string)cmd.ExecuteScalar();

      if (oldPlayerId == playerId) {
        // No change
      } else {
        // Update the old record
        NpgsqlCommand update = new NpgsqlCommand(@"update data.team_roster set valid_until=@timestamp where team_id = @team_id and position_id = @position_id and valid_until is null", psqlConnection);
        update.Parameters.AddWithValue("timestamp", timestamp);
        update.Parameters.AddWithValue("team_id", teamId);
        update.Parameters.AddWithValue("position_id", rosterPosition);
        int rows = update.ExecuteNonQuery();
        if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

        NpgsqlCommand insert = new NpgsqlCommand(@"insert into data.team_roster(team_id, position_id, player_id, valid_from) values(@team_id, @position_id, @player_id, @valid_from)", psqlConnection);
        insert.Parameters.AddWithValue("team_id", teamId);
        insert.Parameters.AddWithValue("position_id", rosterPosition);
        insert.Parameters.AddWithValue("player_id", playerId);
        insert.Parameters.AddWithValue("valid_from", timestamp);
        // Try to insert our current data
        rows = insert.ExecuteNonQuery();
        if (rows == 0) throw new InvalidOperationException($"Failed to insert new team roster entry");
      }

    }

    private void ProcessRoster(Team t, DateTime timestamp, NpgsqlConnection psqlConnection) {

      int rosterPosition = 0;
      foreach (var playerId in t.Lineup) {
        ProcessRosterEntry(psqlConnection, timestamp, t.Id, playerId, rosterPosition);
        rosterPosition++;
      }

      foreach(var playerId in t.Rotation) {
        ProcessRosterEntry(psqlConnection, timestamp, t.Id, playerId, rosterPosition);
        rosterPosition++;
      }

      foreach (var playerId in t.Bullpen) {
        ProcessRosterEntry(psqlConnection, timestamp, t.Id, playerId, rosterPosition);
        rosterPosition++;
      }

      foreach (var playerId in t.Bench) {
        ProcessRosterEntry(psqlConnection, timestamp, t.Id, playerId, rosterPosition);
        rosterPosition++;
      }
    }

    // Hash just the basic attributes of a team, not including their player roster
    private Guid HashTeamAttrs(HashAlgorithm hashAlgorithm, Team obj) {
      StringBuilder sb = new StringBuilder();

      sb.Append(obj.Id);
      sb.Append(obj.Location);
      sb.Append(obj.Nickname);
      sb.Append(obj.FullName);

      // Convert the input string to a byte array and compute the hash.
      byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(sb.ToString()));
      return new Guid(data);
    }

    private void ProcessAllTeams(JsonElement teamResponse, DateTime timestamp, NpgsqlConnection psqlConnection) {
      string text = teamResponse.GetRawText();

      var teams = JsonSerializer.Deserialize<IEnumerable<Team>>(text, serializerOptions);

      using (MD5 md5 = MD5.Create()) {

        foreach (var t in teams) {
          ProcessRoster(t, timestamp, psqlConnection);

          var hash = HashTeamAttrs(md5, t);
          NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from data.teams where hash=@hash and valid_until is null", psqlConnection);
          cmd.Parameters.AddWithValue("hash", hash);
          var count = (long)cmd.ExecuteScalar();

          if(count == 1) {
            // Record exists
          }
          else {
            // Update the old record
            NpgsqlCommand update = new NpgsqlCommand(@"update data.teams set valid_until=@timestamp where team_id = @team_id and valid_until is null", psqlConnection);
            update.Parameters.AddWithValue("timestamp", timestamp);
            update.Parameters.AddWithValue("team_id", t.Id);
            int rows = update.ExecuteNonQuery();
            if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

            var extra = new Dictionary<string, object>();
            extra["valid_from"] = timestamp;
            extra["hash"] = hash;
            // Try to insert our current data
            InsertCommand insertCmd = new InsertCommand(psqlConnection, "data.teams", t, extra);
            var newId = insertCmd.Command.ExecuteNonQuery();

          }


        }
      }
    }

   

    private async Task PersistTimeMap(IEnumerable<GameEvent> events, NpgsqlConnection psqlConnection) {

      foreach(var e in events) {

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

        await updateTimeMap.ExecuteNonQueryAsync();
      }

    }

    /// <summary>
    /// Generate a command for inserting a Game into the `game` table
    /// </summary>
    private NpgsqlCommand InsertGameCommand(NpgsqlConnection psqlConnection, Game game) {
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

      return insertGameStatement;
    }

    /// <summary>
    /// Get any completed games from the Blaseball API and insert them in the `game` table
    /// </summary>
    private async Task PopulateGameTable(NpgsqlConnection psqlConnection) {
      
      // Find the latest day already stored in the DB
      int season = 0;
      int day = -1;
      using (var gamesCommand = new NpgsqlCommand(@"
                SELECT MAX(season), MAX(day) from data.games
                INNER JOIN (SELECT MAX(season) AS max_season FROM data.games) b ON b.max_season = games.season",
          psqlConnection))
      using (var reader = await gamesCommand.ExecuteReaderAsync()) {

        while (await reader.ReadAsync()) {
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

      // Loop until we break out
      while (true) {
        // Get games for this season & day
        HttpResponseMessage response = await client.GetAsync($"games?day={day}&season={season}");

        if (response.IsSuccessStatusCode) {
          
          string strResponse = await response.Content.ReadAsStringAsync();
          var gameList = JsonSerializer.Deserialize<IEnumerable<Game>>(strResponse, options);

          if (gameList == null || gameList.Count() == 0 ) {//|| gameList.First().gameComplete == false) {
            if (day > 0) {
              // Ran out of finished games this season, try the next
              season++;
              day = 0;
              continue;
            } else {
              // season X day 0 had no complete games, stop looping
              break;
            }
          }

          Console.WriteLine($"Inserting games from season {season}, day {day}...");
          foreach (var game in gameList) {
            var cmd = InsertGameCommand(psqlConnection, game);
            await cmd.ExecuteNonQueryAsync();
          }

          day++;
        }
        else {
          Console.WriteLine($"Got response {response.StatusCode} from {response.RequestMessage.RequestUri}!");
          return;
        }
      }
    }

    static void ConsoleOrWebhook(string msg) {
      Console.WriteLine(msg);

      var webhookUri = Environment.GetEnvironmentVariable("PROPHESIZER_WEBHOOK");

      if (webhookUri != null) {
        WebClient webClient = new WebClient();
        NameValueCollection values = new NameValueCollection();

        values.Add("content", msg);
        values.Add("username", "prophesizer");

        webClient.UploadValuesAsync(new Uri(webhookUri), values);
      }
    }


  }

}