using Amazon.S3;
using Amazon.S3.Model;
using Cauldron;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Windows.Input;

namespace CauldronVisualizer
{
	class GameSpan
	{
		public int DisplayStartSeason => StartSeason + 1;
		public int DisplayEndSeason => EndSeason + 1;
		public int DisplayStartDay => StartDay + 1;
		public int DisplayEndDay => EndDay + 1;
		public int StartSeason { get; set; }
		public int StartDay { get; set; }
		public int EndSeason { get; set; }
		public int EndDay { get; set; }

		public GameSpan()
		{
			StartSeason = -1;
			StartDay = -1;
			EndSeason = -1;
			EndDay = -1;
		}
		public GameSpan(int startSeason, int startDay, int endSeason, int endDay)
		{
			StartSeason = startSeason;
			StartDay = startDay;
			EndSeason = endSeason;
			EndDay = endDay;
		}
	}

	class LogWindowVm : INotifyPropertyChanged, IDisposable
	{
		private static string BUCKET_NAME = "blaseball-archive-iliana";

		public IEnumerable<LogItemVm> LogRecords => m_logRecords;
		ObservableCollection<LogItemVm> m_logRecords;

		public LogItemVm SelectedLog 
		{ 
			get => m_selectedLog; 
			set
			{
				m_selectedLog = value;
				PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(SelectedLog)));
			}
		}
		private LogItemVm m_selectedLog;

		private IAmazonS3 m_s3client;

		public event PropertyChangedEventHandler PropertyChanged;


		Dictionary<string, GameSpan> m_logMapping;
		private bool disposedValue;

		public bool Loading 
		{ 
			get => m_loading;
			set { m_loading = value; PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Loading))); } 
		}
		private bool m_loading;

		public string LoadingMessage
		{
			get => m_loadingMessage;
			set { m_loadingMessage = value; PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(LoadingMessage))); }
		}
		private string m_loadingMessage;

		public VisualizerVm RootVm => m_rootVm;
		private VisualizerVm m_rootVm;

		public ICommand AddLogCommand => m_addLogCommand;
		DelegateCommand m_addLogCommand;
		public ICommand LoadLogCommand => m_loadLogCommand;
		DelegateCommand m_loadLogCommand;

		public LogWindowVm(IAmazonS3 client, VisualizerVm rootVm)
		{
			m_rootVm = rootVm;
			m_s3client = client;
			m_logMapping = new Dictionary<string, GameSpan>();
			m_logRecords = new ObservableCollection<LogItemVm>();

			m_addLogCommand = new DelegateCommand(AddSelectedLog);
			m_loadLogCommand = new DelegateCommand(LoadSelectedLog);

			LoadLogs();
		}

		private async void LoadSelectedLog(object obj)
		{
			m_rootVm.ClearUpdates();
			var item = SelectedLog;
			if(item != null)
			{
				await FetchAndDoStuff(item.KeyName, AddFromStream);
			}
		}

		private async void AddSelectedLog(object obj)
		{
			var item = SelectedLog;
			if(item != null)
			{
				await FetchAndDoStuff(item.KeyName, AddFromStream);
			}
		}

		private void AddFromStream(string key, MemoryStream stream)
		{
			using (StreamReader reader = new StreamReader(stream))
			{
				var options = new JsonSerializerOptions() { PropertyNameCaseInsensitive = true };

				while(!reader.EndOfStream)
				{
					string line = reader.ReadLine();
					Update u = JsonSerializer.Deserialize<Update>(line, options);

					m_rootVm.AddUpdate(u);
				}
			}
		}


		private async void LoadLogs()
		{
			Loading = true;
			if (File.Exists("logmap.json"))
			{
				using (StreamReader reader = new StreamReader("logmap.json"))
				{
					m_logMapping = JsonSerializer.Deserialize<Dictionary<string, GameSpan>>(reader.ReadToEnd());
				}
			}
			else
			{
				m_logMapping = new Dictionary<string, GameSpan>();
			}

			foreach (var item in m_logMapping)
			{
				LogItemVm newVm = new LogItemVm(item.Key, item.Value);
				m_logRecords.Add(newVm);
			}

			PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(LogRecords)));

			var logs = await GetS3Objects();

			foreach(var obj in logs)
			{
				if(!m_logMapping.ContainsKey(obj.Key))
				{
					m_logRecords.Add(new LogItemVm(obj.Key));
				}
			}

			PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(LogRecords)));

			await ExploreLogs();
			Loading = false;
		}

		private async Task ExploreLogs()
		{
			foreach(var obj in m_logRecords)
			{
				if (!m_logMapping.ContainsKey(obj.KeyName))
				{
					LoadingMessage = $"Checking {obj.KeyName}...";
					await FetchAndDoStuff(obj.KeyName, UpdateMapping);
				}
			}
		}

		private void UpdateMapping(string keyName, MemoryStream stream)
		{
			using (StreamReader reader = new StreamReader(stream))
			{
				int beginSeason = -1;
				int beginDay = -1;
				int endSeason = -1;
				int endDay = -1;

				var options = new JsonSerializerOptions() { PropertyNameCaseInsensitive = true };

				try
				{
					// Read the first schedule
					var firstLine = reader.ReadLine();
					var firstUpdate = JsonSerializer.Deserialize<Update>(firstLine, options);

					// Loop until we find a valid first schedule
					while (firstUpdate.Schedule == null && !reader.EndOfStream)
					{
						firstLine = reader.ReadLine();
						firstUpdate = JsonSerializer.Deserialize<Update>(firstLine, options);
					}

					var firstGame = firstUpdate.Schedule.First();
					beginSeason = firstGame.season;
					beginDay = firstGame.day;
					endSeason = beginSeason;
					endDay = beginDay;

					// Find the last schedule
					var lastLine = reader.ReadLine();
					while (!reader.EndOfStream)
					{
						lastLine = reader.ReadLine();
					}

					var lastUpdate = JsonSerializer.Deserialize<Update>(lastLine, options);
					var lastGame = lastUpdate.Schedule.Last();
					endSeason = lastGame.season;
					endDay = lastGame.day;
				}
				catch (Exception)
				{
					// Ignore it
				}
				finally
				{
					m_logMapping[keyName] = new GameSpan(beginSeason, beginDay, endSeason, endDay);

					var vm = m_logRecords.Where(x => x.KeyName == keyName).FirstOrDefault();
					if (vm != null)
					{
						vm.GameSpan = new GameSpan(beginSeason, beginDay, endSeason, endDay);
					}
				}

			}
		}

		private async Task FetchAndDoStuff(string keyName, Action<string, MemoryStream> updateAction)
		{
			GetObjectRequest request = new GetObjectRequest
			{
				BucketName = BUCKET_NAME,
				Key = keyName
			};

			using (GetObjectResponse response = await m_s3client.GetObjectAsync(request))
			using (Stream responseStream = response.ResponseStream)
			{
				using (GZipStream decompressionStream = new GZipStream(responseStream, CompressionMode.Decompress))
				using (MemoryStream decompressedStream = new MemoryStream())
				{
					decompressionStream.CopyTo(decompressedStream);
					decompressedStream.Seek(0, SeekOrigin.Begin);

					updateAction(keyName, decompressedStream);
				}
			}
		}

		private async Task<IEnumerable<S3Object>> GetS3Objects()
		{
			LoadingMessage = "Fetching item keys in S3 bucket...";
			List<S3Object> objects = new List<S3Object>();
			try
			{
				ListObjectsRequest request = new ListObjectsRequest
				{
					BucketName = BUCKET_NAME,
					MaxKeys = 500,
					Prefix = "blaseball-log-"
				};

				do
				{
					ListObjectsResponse response = await m_s3client.ListObjectsAsync(request);

					objects.AddRange(response.S3Objects);

					if (response.IsTruncated)
					{
						request.Marker = response.NextMarker;
					}
					else
					{
						request = null;
					}
				}
				while (request != null);
			}
			catch (AmazonS3Exception e)
			{
				Console.WriteLine("ListObjects encountered an S3 error: {0}", e.Message);
			}
			catch (Exception e)
			{
				Console.WriteLine("ListObjects encounter an unexpected error: {0}", e.Message);
			}

			return objects;
		}

		protected virtual void Dispose(bool disposing)
		{
			if (!disposedValue)
			{
				if (disposing)
				{
					using (StreamWriter file = new StreamWriter("logmap.json"))
					{
						string json = JsonSerializer.Serialize(m_logMapping);
						file.Write(json);
					}
				}

				// TODO: free unmanaged resources (unmanaged objects) and override finalizer
				// TODO: set large fields to null
				disposedValue = true;
			}
		}

		// // TODO: override finalizer only if 'Dispose(bool disposing)' has code to free unmanaged resources
		// ~LogWindowVm()
		// {
		//     // Do not change this code. Put cleanup code in 'Dispose(bool disposing)' method
		//     Dispose(disposing: false);
		// }

		public void Dispose()
		{
			// Do not change this code. Put cleanup code in 'Dispose(bool disposing)' method
			Dispose(disposing: true);
			GC.SuppressFinalize(this);
		}
	}
}
