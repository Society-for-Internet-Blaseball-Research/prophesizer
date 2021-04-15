using Cauldron;
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json.Serialization;
using Cauldron.Serializable;

public class ClientMeta
{
	[JsonConverter(typeof(TimestampConverter))]
	public DateTime timestamp { get; set; }
}

public class HourlyArchive
{
	public string Endpoint { get; set; }
	public Dictionary<string, IEnumerable<string>> Params { get; set; }
	public object Data { get; set; }

	public ClientMeta ClientMeta { get; set; }
}





