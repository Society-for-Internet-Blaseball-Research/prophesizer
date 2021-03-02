using System;
using System.Collections.Generic;
using System.Text;

namespace Cauldron
{
	public class OutcomeEntityDefinition
	{
		public string OutcomeType { get; set; }

		public string EntityType { get; set; }
		public string CaptureName { get; set; }
	}

	public class OutcomeDefinition
	{
		public string Regex { get; set; }

		public List<OutcomeEntityDefinition> Entities { get; set; }
	}
}
