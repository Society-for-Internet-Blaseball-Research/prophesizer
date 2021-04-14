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

public class Player
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
	public Dictionary<string,object> State { get; set; }
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
}

public class Team
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
}

public class League
{
	[DbIgnore]
	public string _id { get; set; }
	[DbIgnore]
	public string id { get; set; }
	[JsonIgnore]
	[DbAlias("league_id")]
	public string Id => _id ?? id;

	[DbAlias("league_name")]
	public string Name { get; set; }

	[DbIgnore]
	public IEnumerable<string> Subleagues { get; set; }

	public override string ToString() { return Name; }
}

public class Subleague
{
	[DbIgnore]
	public string _id { get; set; }
	[DbIgnore]
	public string id { get; set; }
	[JsonIgnore]
	[DbAlias("subleague_id")]
	public string Id => _id ?? id;

	[DbAlias("subleague_name")]
	public string Name { get; set; }

	[DbIgnore]
	public IEnumerable<string> Divisions { get; set; }

	public override string ToString() { return Name; }
}

public class Division
{
	[DbIgnore]
	public string _id { get; set; }
	[DbIgnore]
	public string id { get; set; }
	[JsonIgnore]
	[DbAlias("division_id")]
	public string Id => _id ?? id;

	[DbAlias("division_name")]
	public string Name { get; set; }

	[DbIgnore]
	public IEnumerable<string> Teams { get; set; }

	public override string ToString() { return Name; }
}

