using SIBR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SIBR
{
	class Metadata
	{
		public int MajorVersion { get; private set; }
		public int MinorVersion { get; private set; }
		public int PatchVersion { get; private set; }
		public DateTime RunStarted { get; private set; }
		public DateTime? RunFinished { get; set; }
		public int? FirstGameEvent { get; set; }
		public int? LastGameEvent { get; set; }

		public Metadata()
		{
			var versionInfo = typeof(Prophesizer).Assembly.GetName().Version;

			MajorVersion = versionInfo.Major;
			MinorVersion = versionInfo.Minor;
			PatchVersion = versionInfo.Build;
			RunStarted = DateTime.UtcNow;
		}
	}
}
