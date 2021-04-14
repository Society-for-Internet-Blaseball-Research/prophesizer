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

	class ChroniclerV2Page<T>
	{
		public string NextPage { get; set; }

		public IEnumerable<ChroniclerItem<T>> Items { get; set; }
	}

	class ChroniclerItem<T>
	{
		public string EntityId { get; set; }
		public string Hash { get; set; }
		public DateTime? ValidFrom { get; set; }
		public DateTime? ValidTo { get; set; }
		public T Data { get; set; }
	}

	class ChroniclerUpdate
	{
		public string GameId { get; set; }
		public DateTime Timestamp { get; set; }
		public string Hash { get; set; }
		public Game Data { get; set; }
	}


	class SimData
	{
		public int Phase { get; set; }
		public int Season { get; set; }
		public int Day { get; set; }
		public int Tournament { get; set; }
		public int TournamentRound { get; set; }
	}


}
