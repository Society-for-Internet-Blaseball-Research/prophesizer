using Cauldron;
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json.Serialization;
using Cauldron.Serializable;

public class ClientMeta {
  [JsonConverter(typeof(TimestampConverter))]
  public DateTime timestamp { get; set; }
}

  public class HourlyArchive {
  public string Endpoint { get; set; }
  public Dictionary<string, IEnumerable<string>> Params { get; set; }
  public object Data { get; set; }

  public ClientMeta ClientMeta { get; set; }
}

public class Player {
  [DbIgnore]
  public string _id { get; set; }
  [DbIgnore]
  public string id { get; set; }

  [JsonIgnore]
  [DbAlias("player_id")]
  public string Id => _id ?? id;
  
  [DbAlias("player_name")]
  public string Name { get; set; }
  public bool Deceased { get; set; }

  //TODO: attrs
}
   
public class Team {
  [DbIgnore]
  public string _id { get; set; }
  [DbIgnore]
  public string id { get; set; }

  [JsonIgnore]
  [DbAlias("team_id")]
  public string Id => _id ?? id;
  [DbIgnore]
  public IEnumerable<string> Lineup { get; set; }
  [DbIgnore]
  public IEnumerable<string> Rotation { get; set; }
  [DbIgnore]
  public IEnumerable<string> Bullpen { get; set; }
  [DbIgnore]
  public IEnumerable<string> Bench { get; set; }

  public string Location { get; set; }
  public string Nickname { get; set; }
  public string FullName { get; set; }

  // TODO: more fields
}



