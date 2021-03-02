using Cauldron;
using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Media;

namespace CauldronVisualizer
{
	public class GameUpdateVm
	{
		public Game Update => m_update;
		Game m_update;

		private Dictionary<string, Team> m_teamLookup;

		public Brush HomeTeamColor
		{
			get
			{
				var color = (Color)ColorConverter.ConvertFromString(m_teamLookup[m_update.homeTeam].mainColor);
				return new SolidColorBrush(color);
			}
		}
		public Brush AwayTeamColor
		{
			get
			{
				var color = (Color)ColorConverter.ConvertFromString(m_teamLookup[m_update.awayTeam].mainColor);
				return new SolidColorBrush(color);
			}
		}
		public string InningDescription
		{
			get
			{
				if (Update.topOfInning)
					return $"Top of {Update.inning+1}, {Update.halfInningOuts} outs";
				else
					return $"Bottom of {Update.inning+1}, {Update.halfInningOuts} outs";
			}
		}
		public GameUpdateVm(Game update, Dictionary<string, Team> teamLookup)
		{
			m_update = update;
			m_teamLookup = teamLookup;
		}
	}
}
