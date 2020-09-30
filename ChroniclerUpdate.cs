using Cauldron;
using System;
using System.Collections.Generic;
using System.Text;

namespace prophesizer
{
	class ChroniclerUpdate
	{
		public string GameId { get; set; }
		public DateTime Timestamp { get; set; }
		public string Hash { get; set; }
		public Game Data { get; set; }
	}
}
