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

    private int minSeason = int.MaxValue;
    private int maxSeason = int.MinValue;
    private int minDay = int.MaxValue;
    private int maxDay = int.MinValue;
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

    public async Task Poll() {
      ConsoleOrWebhook($"Started poll at {DateTime.UtcNow.ToString()} UTC.");
      minSeason = int.MaxValue;
      maxSeason = int.MinValue;
      minDay = int.MaxValue;
      maxDay = int.MinValue;
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

        Console.WriteLine($"Found {gamesToInsert.Count} games to insert.");
        while (gamesToInsert.Count > 0) {
          var gameEvents = gamesToInsert.Dequeue();
          await PersistGameEvents(logObject.Key, gameEvents, psqlConnection);
          await PersistTimeMap(gameEvents, psqlConnection);
        }
      }
      processor.GameComplete -= Processor_GameComplete;

      string msg = $"Processed {unprocessedLogs.updateLogs.Count} game update logs and {unprocessedLogs.hourlyLogs.Count} hourly logs.\n";
      if (numEvents > 0) {
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
          MaxKeys = 2,
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

      using (var importedLogsStatement = new NpgsqlCommand("SELECT key FROM imported_logs", psqlConnection))
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

        minSeason = Math.Min(minSeason, gameEvents.Min(x => x.season));
        maxSeason = Math.Max(maxSeason, gameEvents.Max(x => x.season));
        minDay = Math.Min(minDay, gameEvents.Min(x => x.day));
        maxDay = Math.Max(maxDay, gameEvents.Max(x => x.day));
        numEvents += gameEvents.Count();

        Console.WriteLine($"Inserted {gameEvents.Count()} game_events (from S{first.season}D{first.day} to S{last.season}D{last.day}) into Postgres from {keyName}.");

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
        }
      }
    }

    private NpgsqlCommand PrepareGameEventStatement(NpgsqlConnection psqlConnection, GameEvent gameEvent) {
      return new InsertCommand(psqlConnection, "game_events", gameEvent).Command;
    }

    private NpgsqlCommand PrepareGameEventBaseRunnerStatements(NpgsqlConnection psqlConnection, int gameEventId, GameEventBaseRunner baseRunnerEvent) {
      var extra = new Dictionary<string, object>();
      extra["game_event_id"] = gameEventId;
      return new InsertCommand(psqlConnection, "game_event_base_runners", baseRunnerEvent, extra).Command;
    }

    private NpgsqlCommand PreparePlayerEventStatement(NpgsqlConnection psqlConnection, int gameEventId, PlayerEvent playerEvent) {
      var extra = new Dictionary<string, object>();
      extra["game_event_id"] = gameEventId;
      return new InsertCommand(psqlConnection, "player_events", playerEvent, extra).Command;
    }

    private NpgsqlCommand PersistLogRecord(NpgsqlConnection psqlConnection, string keyName) {
      var persistLogStatement = new NpgsqlCommand(@"
        INSERT INTO imported_logs(
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

              switch (hourly.Endpoint) {
                case "players":
                  ProcessPlayers(hourly, psqlConnection);
                  break;
                case "allTeams":
                  ProcessAllTeams((JsonElement)hourly.Data, hourly?.ClientMeta?.timestamp ?? DateTime.UtcNow, psqlConnection);
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

    private void ProcessPlayers(HourlyArchive hourly, NpgsqlConnection psqlConnection) {
      string text = ((JsonElement)hourly.Data).GetRawText();

      IEnumerable<string> playerIds = hourly.Params["ids"];

      using (MD5 md5 = MD5.Create()) {

        var playerList = JsonSerializer.Deserialize<IEnumerable<Player>>(text, serializerOptions);

        foreach(var p in playerList) {
          // TODO move hashing into Player
          var hash = HashObject(md5, p);

          NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from players where hash=@hash and valid_until is null", psqlConnection);
          cmd.Parameters.AddWithValue("hash", hash);
          var count = (long)cmd.ExecuteScalar();

          if (count == 1) {
            // Record exists
          } else {
            // Update the old record
            NpgsqlCommand update = new NpgsqlCommand(@"update players set valid_until=@timestamp where player_id = @player_id and valid_until is null", psqlConnection);
            update.Parameters.AddWithValue("timestamp", hourly?.ClientMeta?.timestamp ?? DateTime.UtcNow);
            update.Parameters.AddWithValue("player_id", p.Id);
            int rows = update.ExecuteNonQuery();
            if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

            var extra = new Dictionary<string, object>();
            extra["hash"] = hash;
            // Try to insert our current data
            InsertCommand insertCmd = new InsertCommand(psqlConnection, "players", p, extra);
            var newId = insertCmd.Command.ExecuteNonQuery();

          }
        }
      }
    }


    private void ProcessAllTeams(JsonElement teamResponse, DateTime timestamp, NpgsqlConnection psqlConnection) {
      string text = teamResponse.GetRawText();

      var teams = JsonSerializer.Deserialize<IEnumerable<Team>>(text, serializerOptions);

      using (MD5 md5 = MD5.Create()) {

        foreach (var t in teams) {

          var hash = HashObject(md5, t);
          NpgsqlCommand cmd = new NpgsqlCommand(@"select count(hash) from teams where hash=@hash and valid_until is null", psqlConnection);
          cmd.Parameters.AddWithValue("hash", hash);
          var count = (long)cmd.ExecuteScalar();

          if(count == 1) {
            // Record exists
          }
          else {
            // Update the old record
            NpgsqlCommand update = new NpgsqlCommand(@"update teams set valid_until=@timestamp where team_id = @team_id and valid_until is null", psqlConnection);
            update.Parameters.AddWithValue("timestamp", timestamp);
            update.Parameters.AddWithValue("team_id", t.Id);
            int rows = update.ExecuteNonQuery();
            if (rows > 1) throw new InvalidOperationException($"Tried to update the current row but got {rows} rows affected!");

            var extra = new Dictionary<string, object>();
            extra["hash"] = hash;
            // Try to insert our current data
            InsertCommand insertCmd = new InsertCommand(psqlConnection, "teams", t, extra);
            var newId = insertCmd.Command.ExecuteNonQuery();

          }


        }
      }
    }

   

    private async Task PersistTimeMap(IEnumerable<GameEvent> events, NpgsqlConnection psqlConnection) {

      foreach(var e in events) {

        // Record the first time seen for each season and day
        var updateTimeMap = new NpgsqlCommand(@"
        insert into time_map values(@season, @day, @first_time)
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
            INSERT INTO games
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
                SELECT MAX(season), MAX(day) from games
                INNER JOIN (SELECT MAX(season) AS max_season FROM games) b ON b.max_season = games.season",
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