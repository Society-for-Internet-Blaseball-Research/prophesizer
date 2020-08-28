using Cauldron;
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json.Serialization;

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
  public string _id { get; set; }
  public string id { get; set; }

  [JsonIgnore]
  public string Id => _id ?? id;
  public string Name { get; set; }
  public bool Deceased { get; set; }

  //TODO: attrs
}
   
public class Team {

  public string _id { get; set; }
  public string id { get; set; }

  [JsonIgnore]
  public string Id => _id ?? id;
  public IEnumerable<string> Lineup { get; set; }
  public IEnumerable<string> Rotation { get; set; }
  public IEnumerable<string> Bullpen { get; set; }
  public IEnumerable<string> Bench { get; set; }

  public string Location { get; set; }
  public string Nickname { get; set; }
  public string FullName { get; set; }

  // TODO: more fields
}



