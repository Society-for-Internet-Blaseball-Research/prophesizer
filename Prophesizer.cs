using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using Cassandra;
using Cassandra.Mapping;
using Cauldron;
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Threading.Tasks;

namespace SIBR {
  class Prophesizer {
    private static readonly RegionEndpoint bucketRegion = RegionEndpoint.USWest2;
    private IAmazonS3 client;
    private Cluster cluster;
    private string bucketName;

    public Prophesizer(string bucketName) {
      this.bucketName = bucketName;
      this.cluster = Cluster
        .Builder()
        .AddContactPoints("localhost")
        .Build();
      this.client = new AmazonS3Client(Environment.GetEnvironmentVariable("AWS_KEY"), Environment.GetEnvironmentVariable("AWS_SECRET"), bucketRegion);
    }
    
    public async Task Poll() {
      var unprocessedLogs = await GetUnprocessedLogs();
      
      Console.WriteLine($"Found {unprocessedLogs.Count()} unprocessed log(s).");

      long totalEvents = 0;

      using(var session = cluster.Connect("blaseball")) {
        PreparedStatement processedLogStatement = PrepareProcessedLogStatement(session);
        PreparedStatement gameEventStatement = PrepareGameEventStatement(session);

        foreach (S3Object logObject in unprocessedLogs) {
          totalEvents += await FetchAndProcessObject(logObject.Key, session, processedLogStatement, gameEventStatement);
        }
      }
      Console.WriteLine($"Finished poll at {DateTime.UtcNow.ToString()} UTC - inserted {totalEvents} event(s).");
    }

    private async Task<IEnumerable<S3Object>> GetUnprocessedLogs() {
      Console.WriteLine("Fetching bucket keys...");

      List<S3Object> allLogs = new List<S3Object>();
      
      try {
        ListObjectsRequest request = new ListObjectsRequest {
          BucketName = bucketName,
          MaxKeys = 2
        };

        do {
          ListObjectsResponse response = await client.ListObjectsAsync(request);

          allLogs.AddRange(response.S3Objects);

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

      using(var session = cluster.Connect("blaseball")) {
        var response = session.Execute("SELECT * FROM imported_logs;");

        var processedLogs = response.GetRows().Select(row => row.GetValue<string>("key"));

        return allLogs.Where(log => !processedLogs.Contains(log.Key));
      }
    }

    private async Task<int> FetchAndProcessObject(
      string keyName,
      ISession cassandraSession,
      PreparedStatement processedLogStatement,
      PreparedStatement gameEventStatement
    ) {
      GetObjectRequest request = new GetObjectRequest {
        BucketName = bucketName,
        Key = keyName
      };

      using (GetObjectResponse response = await client.GetObjectAsync(request))
      using (Stream responseStream = response.ResponseStream) {
        Console.WriteLine($"Processing document (Key: {keyName}, Length: {response.ContentLength})...");

        IEnumerable<GameEvent> gameEvents = ProcessObject(keyName, responseStream);

        await PersistGameEvents(keyName, gameEvents, cassandraSession, processedLogStatement, gameEventStatement);

        return gameEvents.Count();
      }
    }

    private IEnumerable<GameEvent> ProcessObject(string keyName, Stream responseStream) {
      try {
        Processor processor = new Processor();

        using (GZipStream decompressionStream = new GZipStream(responseStream, CompressionMode.Decompress))
        using (MemoryStream decompressedStream = new MemoryStream()) {
          decompressionStream.CopyTo(decompressedStream);
          decompressedStream.Seek(0, SeekOrigin.Begin);

          using (StreamReader reader = new StreamReader(decompressedStream)) {
            var output = processor.Process(reader);

            Console.WriteLine($"Processed {output.Count()} game event(s)!");

            return output;
          }
        }     
      } catch (Exception e) {
        Console.WriteLine($"Failed to process {keyName}: {e.Message}");

        return new List<GameEvent>();
      }
    }

    private async Task PersistGameEvents(
      string keyName,
      IEnumerable<GameEvent> gameEvents,
      ISession cassandraSession,
      PreparedStatement processedLogStatement,
      PreparedStatement gameEventStatement
    ) {
      try {
        DefineTypesForSession(cassandraSession);        

        var tasks = gameEvents.Select(gameEvent =>
          cassandraSession.ExecuteAsync(gameEventStatement.Bind(
            DateTime.UtcNow, // todo
            new Guid(gameEvent.gameId),
            gameEvent.eventType,
            gameEvent.eventIndex,
            (sbyte) gameEvent.inning,
            gameEvent.topOfInning,
            (sbyte) gameEvent.outsBeforePlay,
            gameEvent.batterId == null ? new Guid() : new Guid(gameEvent.batterId), // todo remove
            new Guid(gameEvent.batterTeamId),
            new Guid(gameEvent.pitcherId),
            new Guid(gameEvent.pitcherTeamId),
            (double) gameEvent.homeScore,
            (double) gameEvent.awayScore,
            (short) gameEvent.homeStrikeCount,
            (short) gameEvent.awayStrikeCount,
            gameEvent.batterCount,
            gameEvent.pitchesList.Select(x => x.ToString()),
            (short) gameEvent.totalStrikes,
            (short) gameEvent.totalBalls,
            (short) gameEvent.totalFouls,
            gameEvent.isLeadoff,
            gameEvent.isPinchHit,
            (short) gameEvent.lineupPosition,
            gameEvent.isLastEventForPlateAppearance,
            (sbyte) gameEvent.basesHit,
            (sbyte) gameEvent.runsBattedIn,
            gameEvent.isSacrificeHit,
            gameEvent.isSacrificeFly,
            (sbyte) gameEvent.outsOnPlay,
            gameEvent.isDoublePlay,
            gameEvent.isTriplePlay,
            gameEvent.isWildPitch,
            gameEvent.battedBallType ?? "", // todo
            gameEvent.isBunt,
            (sbyte) gameEvent.errorsOnPlay,
            (sbyte) gameEvent.batterBaseAfterPlay,
            gameEvent.baseRunners,
            gameEvent.isLastGameEvent,
            new List<PlayerEventTemp>(), // todo
            gameEvent.eventText,
            gameEvent.additionalContext ?? ""
          ))
        );

        await Task.WhenAll(tasks);

        cassandraSession.Execute(processedLogStatement.Bind(keyName, DateTime.UtcNow));

        Console.WriteLine($"Inserted {gameEvents.Count()} game_events into Cassandra from {keyName}.");
      } catch (Exception e) {
        Console.WriteLine($"Failed to insert events from {keyName} into Cassandra:");
        Console.WriteLine(e.Message);
      }
    }

    private PreparedStatement PrepareProcessedLogStatement(ISession cassandraSession) {
      return cassandraSession.Prepare("INSERT INTO imported_logs(key, imported_at) VALUES (?, ?);");
    }

    private PreparedStatement PrepareGameEventStatement(ISession cassandraSession) {
      return cassandraSession.Prepare(@"
        INSERT INTO blaseball.game_events(
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
          base_runners,
          is_last_game_event,
          player_events,
          event_text,
          additional_context
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
      ");
    }

    private void DefineTypesForSession(ISession session) {
      session.UserDefinedTypes.Define(
        UdtMap.For<GameEventBaseRunner>("game_event_base_runner")
          .Map(a => a.runnerId, "runner_id")
          .Map(a => a.responsiblePitcherId, "responsible_pitcher_id")
          .Map(a => a.baseBeforePlay, "base_before_play")
          .Map(a => a.baseAfterPlay, "base_after_play")
          .Map(a => a.wasBaseStolen, "was_base_stolen")
          .Map(a => a.wasCaughtStealing, "was_caught_stealing")
          .Map(a => a.wasPickedOff, "was_picked_off")
      );

      session.UserDefinedTypes.Define(
        UdtMap.For<PlayerEventTemp>("player_event")
          .Map(a => a.PlayerId, "player_id")
          .Map(a => a.EventType, "event_type")
      );
    }
  }
}