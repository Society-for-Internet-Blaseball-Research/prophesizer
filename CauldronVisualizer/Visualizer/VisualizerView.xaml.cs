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

namespace CauldronVisualizer
{
	/// <summary>
	/// Interaction logic for VisualizerView.xaml
	/// </summary>
	public partial class VisualizerView : UserControl
	{
		public VisualizerView()
		{
			InitializeComponent();

			m_updates.SelectionChanged += listBoxSelectionChanged;
			m_events.SelectionChanged += listBoxSelectionChanged;
		}

		private void listBoxSelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			ListBox lb = (ListBox)sender;
			lb.ScrollIntoView(lb.SelectedItem);
		}
	}
}
