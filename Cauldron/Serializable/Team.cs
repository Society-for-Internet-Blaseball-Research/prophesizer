using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Cauldron
{
    /// <summary>
    /// Serializable class representing a single response from the list provided by the allTeams API
    /// https://blaseball.com/database/allTeams returns a List<Team>
    /// </summary>
    public class Team : IComparable<Team>
    {
        public string _id { get; set; }
		public string id { get; set; }
		[JsonIgnore]
		public string Id
		{
			get
			{
				return _id ?? id;
			}
		}
        public string fullName { get; set; }
        public string nickname { get; set; }
        public string mainColor { get; set; }
        public string slogan { get; set; }
        public string shorthand { get; set; }
        public int CompareTo(Team other)
        {
            return nickname.CompareTo(other.nickname);
        }
        public override string ToString()
        {
            return String.Concat(new String[3] { fullName, " - ", slogan });
        }
    }
}
