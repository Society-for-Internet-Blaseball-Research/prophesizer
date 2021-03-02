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
using System.Windows.Shapes;

namespace CauldronVisualizer
{
	/// <summary>
	/// Interaction logic for LogWindowView.xaml
	/// </summary>
	public partial class LogWindowView : Window
	{
		public LogWindowView()
		{
			InitializeComponent();
			Dispatcher.ShutdownStarted += Dispatcher_ShutdownStarted;
		}

		private void Dispatcher_ShutdownStarted(object sender, EventArgs e)
		{
			((LogWindowVm)DataContext).Dispose();
		}
	}
}
