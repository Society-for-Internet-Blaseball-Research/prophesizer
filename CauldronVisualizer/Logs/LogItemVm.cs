using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;

namespace CauldronVisualizer
{
	class LogItemVm : INotifyPropertyChanged
	{
		public string KeyName
		{
			get => m_keyName;
			set { m_keyName = value; PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(KeyName))); }
		}
		string m_keyName;

		public GameSpan GameSpan
		{
			get => m_gameSpan;
			set { m_gameSpan = value; PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(GameSpan))); }
		}
		GameSpan m_gameSpan;

		public event PropertyChangedEventHandler PropertyChanged;

		public LogItemVm(string s3ObjectKey)
		{
			KeyName = s3ObjectKey;
		}
		public LogItemVm(string s3ObjectKey, GameSpan span)
		{
			KeyName = s3ObjectKey;
			GameSpan = span;
		}

	}
}
