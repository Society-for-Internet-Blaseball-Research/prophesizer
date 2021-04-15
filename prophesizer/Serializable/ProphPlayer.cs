using Cauldron.Serializable;
using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json.Serialization;

namespace prophesizer.Serializable
{
	public class ProphPlayer : ProphBase
	{
		[DbIgnore]
		public string _id { get; set; }
		[DbIgnore]
		public string id { get; set; }

		[JsonIgnore]
		[DbAlias("player_id")]
		public string Id => _id ?? id;

		[DbAlias("player_name")]
		public string Name { get; set; }

		[DbIgnore]
		public Dictionary<string, object> State { get; set; }
		public bool Deceased { get; set; }

		// Attributes
		public double Anticapitalism { get; set; }
		public double BaseThirst { get; set; }
		public double Buoyancy { get; set; }
		public double Chasiness { get; set; }
		public double Coldness { get; set; }
		public double Continuation { get; set; }
		public double Divinity { get; set; }
		public double GroundFriction { get; set; }
		public double Indulgence { get; set; }
		public double Laserlikeness { get; set; }
		public double Martyrdom { get; set; }
		public double Moxie { get; set; }
		public double Musclitude { get; set; }
		public double Omniscience { get; set; }
		public double Overpowerment { get; set; }
		public double Patheticism { get; set; }
		public double Ruthlessness { get; set; }
		public double Shakespearianism { get; set; }
		public double Suppression { get; set; }
		public double Tenaciousness { get; set; }
		public double Thwackability { get; set; }
		public double Tragicness { get; set; }
		public double Unthwackability { get; set; }
		public double Watchfulness { get; set; }
		[DbNullValue(0f)]
		public double? Pressurization { get; set; }
		[DbNullValue(0f)]
		public double? Cinnamon { get; set; }

		// Other stuff

		public int TotalFingers { get; set; }
		public int Soul { get; set; }
		[DbNullValue(false)]
		public bool? PeanutAllergy { get; set; }
		[DbNullValue(-1)]
		public int? Fate { get; set; }

		[DbNullValue("")]
		public string Bat { get; set; }
		[DbNullValue("")]
		public string Armor { get; set; }
		[DbNullValue("")]
		public string Ritual { get; set; }
		[DbNullValue(-1)]
		public int? Coffee { get; set; }
		[DbNullValue(-1)]
		public int? Blood { get; set; }

		public int Evolution { get; set; }

		[DbIgnore]
		public IEnumerable<string> PermAttr { get; set; }
		[DbIgnore]
		public IEnumerable<string> SeasonAttr { get; set; }
		[DbIgnore]
		public IEnumerable<string> WeekAttr { get; set; }
		[DbIgnore]
		public IEnumerable<string> GameAttr { get; set; }

		public override Guid Hash(HashAlgorithm hashAlgorithm)
		{
			StringBuilder sb = new StringBuilder();

			foreach (var prop in this.GetType().GetProperties())
			{
				sb.Append(prop.GetValue(this)?.ToString());
			}

			// Convert the input string to a byte array and compute the hash.
			byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(sb.ToString()));

			return new Guid(data);
		}
	}
}
