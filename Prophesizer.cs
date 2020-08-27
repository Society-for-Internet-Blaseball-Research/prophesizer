using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using Cauldron;
using Npgsql;
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text.Json;
using System.Threading.Tasks;

namespace SIBR {
  class Prophesizer {
    private static readonly RegionEndpoint bucketRegion = RegionEndpoint.USWest2;


    private IAmazonS3 client;
    private string bucketName;
    private Processor processor;
    private Queue<IEnumerable<GameEvent>> gamesToInsert;

    public Prophesizer(string bucketName) {
      this.bucketName = bucketName;
      this.client = new AmazonS3Client(Environment.GetEnvironmentVariable("AWS_KEY"), Environment.GetEnvironmentVariable("AWS_SECRET"), bucketRegion);
      processor = new Processor();
      gamesToInsert = new Queue<IEnumerable<GameEvent>>();
    }

    public async Task Poll() {
      await using var psqlConnection = new NpgsqlConnection(Environment.GetEnvironmentVariable("PSQL_CONNECTION_STRING"));
      await psqlConnection.OpenAsync();


      await FetchGameList(psqlConnection);

      var unprocessedLogs = await GetUnprocessedLogs(psqlConnection);

      Console.WriteLine($"Found {unprocessedLogs.Count()} unprocessed log(s).");

      long totalEvents = 0;

      processor.GameComplete += Processor_GameComplete;
      foreach (S3Object logObject in unprocessedLogs) {
        await FetchAndProcessObject(logObject.Key, psqlConnection);
        Console.WriteLine($"Found {gamesToInsert.Count} games to insert.");
        while (gamesToInsert.Count > 0) {
          var gameEvents = gamesToInsert.Dequeue();
          await PersistGameEvents(logObject.Key, gameEvents, psqlConnection);
        }
      }
      processor.GameComplete -= Processor_GameComplete;

      Console.WriteLine($"Finished poll at {DateTime.UtcNow.ToString()} UTC - inserted {totalEvents} event(s).");
    }

    private void Processor_GameComplete(object sender, GameCompleteEventArgs e) {
      gamesToInsert.Enqueue(e.GameEvents);
    }


    private async Task<IEnumerable<S3Object>> GetUnprocessedLogs(NpgsqlConnection psqlConnection) {
      Console.WriteLine("Fetching bucket keys...");

      List<S3Object> allLogs = new List<S3Object>();

      try {
        ListObjectsRequest request = new ListObjectsRequest {
          BucketName = bucketName,
          MaxKeys = 2
        };

        do {
          ListObjectsResponse response = await client.ListObjectsAsync(request);

          allLogs.AddRange(response.S3Objects.Where(item => item.Key.StartsWith("blaseball-log-")));

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

      Console.WriteLine("Determining which logs require processing...");

      using (var importedLogsStatement = new NpgsqlCommand("SELECT key FROM imported_logs", psqlConnection))
      using (var reader = await importedLogsStatement.ExecuteReaderAsync()) {
        var processedLogs = new List<string>();

        while (await reader.ReadAsync()) {
          processedLogs.Add(reader.GetString(0));
        }

        return allLogs.Where(log => !processedLogs.Contains(log.Key));
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
        Console.WriteLine("Persisting game events...");

        foreach (var gameEvent in gameEvents) {
          await PersistGame(psqlConnection, gameEvent);
        }

        using (var logStatement = PersistLogRecord(psqlConnection, keyName)) {
          await logStatement.ExecuteNonQueryAsync();
        }

        transaction.Commit();
        Console.WriteLine($"Inserted {gameEvents.Count()} game_events into Postgres from {keyName}.");

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
      var gameEventStatement = new NpgsqlCommand(@"
        INSERT INTO game_events(
          perceived_at,
          game_id,
          event_type,
          event_index,
          inning,
          top_of_inning,
          outs_before_play,
          batter_id,
          batter_team_id,
          pitcher_id,
          pitcher_team_id,
          home_score,
          away_score,
          home_strike_count,
          away_strike_count,
          batter_count,
          pitches,
          total_strikes,
          total_balls,
          total_fouls,
          is_leadoff,
          is_pinch_hit,
          lineup_position,
          is_last_event_for_plate_appearance,
          bases_hit,
          runs_batted_in,
          is_sacrifice_hit,
          is_sacrifice_fly,
          outs_on_play,
          is_double_play,
          is_triple_play,
          is_wild_pitch,
          batted_ball_type,
          is_bunt,
          errors_on_play,
          batter_base_after_play,
          is_last_game_event,
          event_text,
          additional_context
        ) VALUES (
          @perceived_at,
          @game_id,
          @event_type,
          @event_index,
          @inning,
          @top_of_inning,
          @outs_before_play,
          @batter_id,
          @batter_team_id,
          @pitcher_id,
          @pitcher_team_id,
          @home_score,
          @away_score,
          @home_strike_count,
          @away_strike_count,
          @batter_count,
          @pitches,
          @total_strikes,
          @total_balls,
          @total_fouls,
          @is_leadoff,
          @is_pinch_hit,
          @lineup_position,
          @is_last_event_for_plate_appearance,
          @bases_hit,
          @runs_batted_in,
          @is_sacrifice_hit,
          @is_sacrifice_fly,
          @outs_on_play,
          @is_double_play,
          @is_triple_play,
          @is_wild_pitch,
          @batted_ball_type,
          @is_bunt,
          @errors_on_play,
          @batter_base_after_play,
          @is_last_game_event,
          @event_text,
          @additional_context
        ) RETURNING id;
      ", psqlConnection);

      gameEventStatement.Parameters.AddWithValue("perceived_at", DateTime.UtcNow); // todo
      gameEventStatement.Parameters.AddWithValue("game_id", gameEvent.gameId);
      gameEventStatement.Parameters.AddWithValue("event_type", gameEvent.eventType);
      gameEventStatement.Parameters.AddWithValue("event_index", gameEvent.eventIndex);
      gameEventStatement.Parameters.AddWithValue("inning", gameEvent.inning);
      gameEventStatement.Parameters.AddWithValue("top_of_inning", gameEvent.topOfInning);
      gameEventStatement.Parameters.AddWithValue("outs_before_play", gameEvent.outsBeforePlay);
      gameEventStatement.Parameters.AddWithValue("batter_id", gameEvent.batterId ?? "UNKNOWN");
      gameEventStatement.Parameters.AddWithValue("batter_team_id", gameEvent.batterTeamId);
      gameEventStatement.Parameters.AddWithValue("pitcher_id", gameEvent.pitcherId);
      gameEventStatement.Parameters.AddWithValue("pitcher_team_id", gameEvent.pitcherTeamId);
      gameEventStatement.Parameters.AddWithValue("home_score", gameEvent.homeScore);
      gameEventStatement.Parameters.AddWithValue("away_score", gameEvent.awayScore);
      gameEventStatement.Parameters.AddWithValue("home_strike_count", gameEvent.homeStrikeCount);
      gameEventStatement.Parameters.AddWithValue("away_strike_count", gameEvent.awayStrikeCount);
      gameEventStatement.Parameters.AddWithValue("batter_count", gameEvent.batterCount);
      gameEventStatement.Parameters.AddWithValue("pitches", gameEvent.pitchesList);
      gameEventStatement.Parameters.AddWithValue("total_strikes", gameEvent.totalStrikes);
      gameEventStatement.Parameters.AddWithValue("total_balls", gameEvent.totalBalls);
      gameEventStatement.Parameters.AddWithValue("total_fouls", gameEvent.totalFouls);
      gameEventStatement.Parameters.AddWithValue("is_leadoff", gameEvent.isLeadoff);
      gameEventStatement.Parameters.AddWithValue("is_pinch_hit", gameEvent.isPinchHit);
      gameEventStatement.Parameters.AddWithValue("lineup_position", gameEvent.lineupPosition);
      gameEventStatement.Parameters.AddWithValue("is_last_event_for_plate_appearance", gameEvent.isLastEventForPlateAppearance);
      gameEventStatement.Parameters.AddWithValue("bases_hit", gameEvent.basesHit);
      gameEventStatement.Parameters.AddWithValue("runs_batted_in", gameEvent.runsBattedIn);
      gameEventStatement.Parameters.AddWithValue("is_sacrifice_hit", gameEvent.isSacrificeHit);
      gameEventStatement.Parameters.AddWithValue("is_sacrifice_fly", gameEvent.isSacrificeFly);
      gameEventStatement.Parameters.AddWithValue("outs_on_play", gameEvent.outsOnPlay);
      gameEventStatement.Parameters.AddWithValue("is_double_play", gameEvent.isDoublePlay);
      gameEventStatement.Parameters.AddWithValue("is_triple_play", gameEvent.isTriplePlay);
      gameEventStatement.Parameters.AddWithValue("is_wild_pitch", gameEvent.isWildPitch);
      gameEventStatement.Parameters.AddWithValue("batted_ball_type", gameEvent.battedBallType ?? "");
      gameEventStatement.Parameters.AddWithValue("is_bunt", gameEvent.isBunt);
      gameEventStatement.Parameters.AddWithValue("errors_on_play", gameEvent.errorsOnPlay);
      gameEventStatement.Parameters.AddWithValue("batter_base_after_play", gameEvent.batterBaseAfterPlay);
      gameEventStatement.Parameters.AddWithValue("is_last_game_event", gameEvent.isLastGameEvent);
      gameEventStatement.Parameters.AddWithValue("event_text", gameEvent.eventText);
      gameEventStatement.Parameters.AddWithValue("additional_context", gameEvent.additionalContext ?? "");

      return gameEventStatement;
    }

    private NpgsqlCommand PrepareGameEventBaseRunnerStatements(NpgsqlConnection psqlConnection, int gameEventId, GameEventBaseRunner baseRunnerEvent) {
      var baseRunnerStatement = new NpgsqlCommand(@"
        INSERT INTO game_event_base_runners(
          game_event_id,
          runner_id,
          responsible_pitcher_id,
          base_before_play,
          base_after_play,
          was_base_stolen,
          was_caught_stealing,
          was_picked_off
        ) VALUES (
          @game_event_id,
          @runner_id,
          @responsible_pitcher_id,
          @base_before_play,
          @base_after_play,
          @was_base_stolen,
          @was_caught_stealing,
          @was_picked_off
        );
      ", psqlConnection);

      baseRunnerStatement.Parameters.AddWithValue("game_event_id", gameEventId);
      baseRunnerStatement.Parameters.AddWithValue("runner_id", baseRunnerEvent.runnerId ?? "UNKNOWN");
      baseRunnerStatement.Parameters.AddWithValue("responsible_pitcher_id", baseRunnerEvent.responsiblePitcherId ?? "UNKNOWN");
      baseRunnerStatement.Parameters.AddWithValue("base_before_play", baseRunnerEvent.baseBeforePlay);
      baseRunnerStatement.Parameters.AddWithValue("base_after_play", baseRunnerEvent.baseAfterPlay);
      baseRunnerStatement.Parameters.AddWithValue("was_base_stolen", baseRunnerEvent.wasBaseStolen);
      baseRunnerStatement.Parameters.AddWithValue("was_caught_stealing", baseRunnerEvent.wasCaughtStealing);
      baseRunnerStatement.Parameters.AddWithValue("was_picked_off", baseRunnerEvent.wasPickedOff);

      return baseRunnerStatement;
    }

    private NpgsqlCommand PreparePlayerEventStatement(NpgsqlConnection psqlConnection, int gameEventId, PlayerEvent playerEvent) {
      var playerEventStatement = new NpgsqlCommand(@"
        INSERT INTO player_events(
          game_event_id,
          player_id,
          event_type
        ) VALUES (
          @game_event_id,
          @player_id,
          @event_type
        );
      ", psqlConnection);

      playerEventStatement.Parameters.AddWithValue("game_event_id", gameEventId);
      playerEventStatement.Parameters.AddWithValue("player_id", playerEvent.playerId ?? "UNKNOWN");
      playerEventStatement.Parameters.AddWithValue("event_type", playerEvent.eventType);

      return playerEventStatement;
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

    private NpgsqlCommand InsertGameCommand(NpgsqlConnection psqlConnection, Game game) {
      var insertGameStatement = new NpgsqlCommand(@"
            INSERT INTO game
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

    private async Task FetchGameList(NpgsqlConnection psqlConnection) {
      int season = 0;
      int day = 0;

      using (var gamesCommand = new NpgsqlCommand(@"
                SELECT MAX(season), MAX(day) from game
                INNER JOIN (SELECT MAX(season) AS max_season FROM game) b ON b.max_season = game.season",
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
      day++;

      HttpClient client = new HttpClient();
      client.BaseAddress = new Uri("https://www.blaseball.com/database/");
      client.DefaultRequestHeaders.Accept.Clear();
      client.DefaultRequestHeaders.Accept.Add(
          new MediaTypeWithQualityHeaderValue("application/json"));

      JsonSerializerOptions options = new JsonSerializerOptions();
      options.IgnoreNullValues = true;

      while (true) {
        HttpResponseMessage response = await client.GetAsync($"games?day={day}&season={season}");

        if (response.IsSuccessStatusCode) {
          string strResponse = await response.Content.ReadAsStringAsync();

          var gameList = JsonSerializer.Deserialize<IEnumerable<Game>>(strResponse, options);


          if (gameList == null || gameList.Count() == 0 || gameList.First().gameComplete == false) {
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
      }
    }
  }

}