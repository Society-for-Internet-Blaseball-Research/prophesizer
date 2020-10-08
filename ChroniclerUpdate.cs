using Cauldron;
using System;
using System.Collections.Generic;
using System.Text;

namespace prophesizer
{

	class ChroniclerPage<T>
	{
		public string NextPage { get; set; }

		public IEnumerable<T> Data { get; set; }
	}

	class ChroniclerUpdate
	{
		public string GameId { get; set; }
		public DateTime Timestamp { get; set; }
		public string Hash { get; set; }
		public Game Data { get; set; }
	}

	class ChroniclerTeam
	{
		public string UpdateId { get; set; }
		public string TeamId { get; set; }
		public DateTime FirstSeen { get; set; }
		public DateTime LastSeen { get; set; }

		public Team Data { get; set; }
	}

	class ChroniclerPlayer
	{
		public string UpdateId { get; set; }
		public string PlayerId { get; set; }
		public DateTime FirstSeen { get; set; }
		public DateTime LastSeen { get; set; }
		public Player Data { get; set; }
	}
}
