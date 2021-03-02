using Cauldron;
using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Linq;
using System.Text;

namespace CauldronVisualizer
{
	public class GameEventVm
	{
		public GameEvent Event => m_event;
		GameEvent m_event;

		public string HomeTeamId
		{
			get
			{
				return m_event.topOfInning ? m_event.pitcherTeamId : m_event.batterTeamId;
			}
		}

		public string AwayTeamId
		{
			get
			{
				return m_event.topOfInning ? m_event.batterTeamId : m_event.pitcherTeamId;
			}
		}

		public string HomeTeamName
		{
			get
			{
				return m_teamLookup[HomeTeamId].fullName;
			}
		}

		public string AwayTeamName
		{
			get
			{
				return m_teamLookup[AwayTeamId].fullName;
			}
		}

		public Brush HomeTeamColor
		{
			get
			{
				var color = (Color)ColorConverter.ConvertFromString(m_teamLookup[HomeTeamId].mainColor);
				return new SolidColorBrush(color);
			}
		}

		public Brush AwayTeamColor
		{
			get
			{
				var color = (Color)ColorConverter.ConvertFromString(m_teamLookup[AwayTeamId].mainColor);
				return new SolidColorBrush(color);
			}
		}

		public Brush BattingColor
		{
			get
			{
				var color = (Color)ColorConverter.ConvertFromString(m_teamLookup[m_event.batterTeamId].mainColor);
				return new SolidColorBrush(color);
			}
		}
		
		public bool HasIncineration
		{
			get
			{
				return m_event.outcomes.Count(x => x.eventType == OutcomeType.INCINERATION) > 0;
			}
		}

		public bool HasPeanut
		{
			get
			{
				return m_event.outcomes.Count(x => x.eventType == OutcomeType.PEANUT_GOOD || x.eventType == OutcomeType.PEANUT_BAD) > 0;
			}
		}

		private Dictionary<string, Team> m_teamLookup;

		public string InningDescription
		{
			get
			{
				if (m_event.topOfInning)
					return $"Top of {m_event.inning + 1}, {m_event.outsBeforePlay} outs";
				else
					return $"Bottom of {m_event.inning + 1}, {m_event.outsBeforePlay} outs";
			}
		}

		public string PitchesList
		{
			get
			{
				return m_event.pitchesList.Aggregate("", (s, x) => s += x);
			}
		}

		public GameEventVm(GameEvent e, Dictionary<string, Team> teamLookup)
		{
			m_event = e;
			m_teamLookup = teamLookup;
		}
	}
}
