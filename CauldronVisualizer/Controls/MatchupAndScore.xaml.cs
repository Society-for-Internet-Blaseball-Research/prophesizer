using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace CauldronVisualizer.Controls
{
	/// <summary>
	/// Interaction logic for MatchupAndScore.xaml
	/// </summary>
	public partial class MatchupAndScore : UserControl
	{
		public Brush HomeColorBrush
		{
			get { return (Brush)GetValue(HomeColorProperty); }
			set { SetValue(HomeColorProperty, value); }
		}

		// Using a DependencyProperty as the backing store for HomeColor.  This enables animation, styling, binding, etc...
		public static readonly DependencyProperty HomeColorProperty =
			DependencyProperty.Register(nameof(HomeColorBrush), typeof(Brush), typeof(MatchupAndScore), new PropertyMetadata(new SolidColorBrush(Colors.White)));

		public Brush AwayColorBrush
		{
			get { return (Brush)GetValue(AwayColorBrushProperty); }
			set { SetValue(AwayColorBrushProperty, value); }
		}

		// Using a DependencyProperty as the backing store for AwayColorBrush.  This enables animation, styling, binding, etc...
		public static readonly DependencyProperty AwayColorBrushProperty =
			DependencyProperty.Register(nameof(AwayColorBrush), typeof(Brush), typeof(MatchupAndScore), new PropertyMetadata(new SolidColorBrush(Colors.White)));

		public string HomeTeamName
		{
			get { return (string)GetValue(HomeTeamNameProperty); }
			set { SetValue(HomeTeamNameProperty, value); }
		}

		// Using a DependencyProperty as the backing store for HomeTeamName.  This enables animation, styling, binding, etc...
		public static readonly DependencyProperty HomeTeamNameProperty =
			DependencyProperty.Register("HomeTeamName", typeof(string), typeof(MatchupAndScore), new PropertyMetadata(""));

		public string AwayTeamName
		{
			get { return (string)GetValue(AwayTeamNameProperty); }
			set { SetValue(AwayTeamNameProperty, value); }
		}

		// Using a DependencyProperty as the backing store for AwayTeamName.  This enables animation, styling, binding, etc...
		public static readonly DependencyProperty AwayTeamNameProperty =
			DependencyProperty.Register("AwayTeamName", typeof(string), typeof(MatchupAndScore), new PropertyMetadata(""));

		public int HomeTeamScore
		{
			get { return (int)GetValue(HomeTeamScoreProperty); }
			set { SetValue(HomeTeamScoreProperty, value); }
		}

		// Using a DependencyProperty as the backing store for HomeTeamScore.  This enables animation, styling, binding, etc...
		public static readonly DependencyProperty HomeTeamScoreProperty =
			DependencyProperty.Register("HomeTeamScore", typeof(int), typeof(MatchupAndScore), new PropertyMetadata(0));

		public int AwayTeamScore
		{
			get { return (int)GetValue(AwayTeamScoreProperty); }
			set { SetValue(AwayTeamScoreProperty, value); }
		}

		// Using a DependencyProperty as the backing store for AwayTeamScore.  This enables animation, styling, binding, etc...
		public static readonly DependencyProperty AwayTeamScoreProperty =
			DependencyProperty.Register("AwayTeamScore", typeof(int), typeof(MatchupAndScore), new PropertyMetadata(0));


		public MatchupAndScore()
		{
			InitializeComponent();
		}
	}
}
