using Cauldron.Serializable;
using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace prophesizer.Serializable
{
	class ProphStadium : ProphBase
	{
		[DbAlias("stadium_id")]
		public string Id { get; set; }

		public float Hype { get; set; }

		public string Name { get; set; }
		public string Nickname { get; set; }
		public int Birds { get; set; }
		public int? Model { get; set; }
		public string TeamId { get; set; }
		public string MainColor { get; set; }
		public string SecondaryColor { get; set; }
		public string TertiaryColor { get; set; }
		public float Mysticism { get; set; }
		public float Viscosity { get; set; }
		public float Elongation { get; set; }
		[DbIgnore]
		public float Filthiness { get; set; }
		public float Obtuseness { get; set; }
		public float Forwardness { get; set; }
		public float Grandiosity { get; set; }
		public float Ominousness { get; set; }
		public float Fortification { get; set; }
		public float Inconvenience { get; set; }
		public float Luxuriousness { get; set; }

		[DbIgnore]
		public Dictionary<string, int> RenoLog { get; set; }
		[DbIgnore]
		public Dictionary<string, int> Weather { get; set; }

		public override string ToString()
		{
			return "Stadium";
		}

	}
}
