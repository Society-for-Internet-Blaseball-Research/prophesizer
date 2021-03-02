using Cauldron.Serializable;
using System;
using System.Collections.Generic;
using System.Text;

namespace Cauldron
{
	
	public static class OutcomeType
	{
		public static string INCINERATION = "INCINERATION";
		public static string PEANUT_GOOD = "PEANUT_GOOD";
		public static string PEANUT_BAD = "PEANUT_BAD";
		public static string FEEDBACK = "FEEDBACK";
		public static string FEEDBACK_BLOCKED = "FEEDBACK_BLOCKED";
		public static string REVERB_PITCHERS = "REVERB_PITCHERS";
		public static string REVERB_HITTERS = "REVERB_HITTERS";
		public static string REVERB_SEVERAL = "REVERB_SEVERAL";
		public static string REVERB_ALL = "REVERB_ALL";
		public static string REVERB_PLAYER = "REVERB_PLAYER";
		public static string BLOOD_DRAIN_VICTIM = "BLOOD_DRAIN_VICTIM";
		public static string BLOOD_DRAIN_SIPHONER = "BLOOD_DRAIN_SIPHONER";
		public static string BEANED_PITCHER = "BEANED_PITCHER";
		public static string BEANED_HITTER = "BEANED_HITTER";
		public static string DEBT_PAID = "DEBT_PAID";
		public static string UNSTABLE_CHAINED = "UNSTABLE_CHAINED";
		public static string SHELL_CRACKED = "SHELL_CRACKED";
		public static string PARTYING = "PARTYING";
		public static string BLACK_HOLE = "BLACK_HOLE";
		public static string SUN_2 = "SUN_2";
	}


	/// <summary>
	/// Player events
	/// </summary>
	public class Outcome
	{
		public Outcome(string text)
		{
			originalText = text;
		}

		[DbNullValue("UNKNOWN")]
		public string entityId { get; set; }
		public string eventType { get; set; }
		public string originalText { get; set; }
	}
}
