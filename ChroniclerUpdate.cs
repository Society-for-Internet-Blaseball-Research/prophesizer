using Cauldron;
using System;
using System.Collections.Generic;
using System.Text;

namespace prophesizer
{

	class ChroniclerPage
	{
		public string NextPage { get; set; }

		public IEnumerable<ChroniclerUpdate> Data { get; set; }
	}

	class ChroniclerUpdate
	{
		public string GameId { get; set; }
		public DateTime Timestamp { get; set; }
		//public string Hash { get; set; }
		public Game Data { get; set; }
	}
}
