using Cauldron.Serializable;
using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json.Serialization;

namespace prophesizer.Serializable
{
	public class ProphTeam
	{
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

		[DbAlias("team_main_color")]
		public string MainColor { get; set; }
		[DbAlias("team_secondary_color")]
		public string SecondaryColor { get; set; }
		[DbAlias("team_abbreviation")]
		public string Shorthand { get; set; }
		[DbAlias("team_slogan")]
		public string Slogan { get; set; }
		[DbAlias("team_emoji")]
		public string Emoji { get; set; }
		[DbAlias("stadium_id")]
		[DbNullValue("")]
		public string Stadium { get; set; }


		// Tarot card index from S11 election
		// DbIgnore this entry because it might not exist
		[DbIgnore]
		public int? Card { get; set; }

		// Insert this property into the DB as 'card'
		[DbAlias("card")]
		public int CardIndex
		{
			get
			{
				return Card.HasValue ? Card.Value : -1;
			}
		}

		[DbIgnore]
		public IEnumerable<string> PermAttr { get; set; }
		[DbIgnore]
		public IEnumerable<string> SeasAttr { get; set; }
		[DbIgnore]
		public IEnumerable<string> WeekAttr { get; set; }
		[DbIgnore]
		public IEnumerable<string> GameAttr { get; set; }

		// Hash just the basic attributes of a team, not including their player roster
		public  Guid Hash(HashAlgorithm hashAlgorithm)
		{
			StringBuilder sb = new StringBuilder();

			sb.Append(Id);
			sb.Append(Location);
			sb.Append(Nickname);
			sb.Append(FullName);
			sb.Append(CardIndex);
			sb.Append(Slogan);
			sb.Append(MainColor);
			sb.Append(SecondaryColor);
			sb.Append(Emoji);
			sb.Append(Shorthand);

			// Convert the input string to a byte array and compute the hash.
			byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(sb.ToString()));
			return new Guid(data);
		}
	}
}
