using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Cauldron
{
	/// <summary>
	/// Serializable class representing a single JSON object in a blaseball socket.io update
	/// Currently the only thing this parser cares about is the Schedule - the game updates themselves
	/// </summary>
	public class Update
    {
        public List<Game> Schedule { get; set; }

        public ClientMeta clientMeta { get; set; }
    }

    public class ClientMeta
	{
        [JsonConverter(typeof(TimestampConverter))]
        public DateTime timestamp { get; set; }
	}
}
