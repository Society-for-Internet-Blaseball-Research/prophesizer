using Cauldron.Serializable;
using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace prophesizer.Serializable
{
	public class ProphItem: ProphBase
	{
		[DbAlias("item_id")]
		public string Id { get; set; }
		public string PlayerId { get; set; }
		public string Name { get; set; }
		public int Health { get; set; }
		public int Durability { get; set; }
		public double? DefenseRating { get; set; }
		public double? HittingRating { get; set; }
		public double? PitchingRating { get; set; }
		public double? BaserunningRating { get; set; }
		public string ForgerName { get; set; }

		public override string ToString()
		{
			return Name;
		}

	}
}
