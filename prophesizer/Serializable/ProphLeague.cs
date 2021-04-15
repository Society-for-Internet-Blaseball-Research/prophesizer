
using Cauldron.Serializable;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace prophesizer.Serializable
{

	public class ProphLeague : ProphBase
	{
		[DbIgnore]
		public override bool UseHash => false;

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

	public class ProphSubleague : ProphBase
	{
		[DbIgnore]
		public override bool UseHash => false;

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

	public class ProphDivision : ProphBase
	{
		[DbIgnore]
		public override bool UseHash => false;

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

}