using System;
using System.Threading.Tasks;

namespace SIBR
{
	class Program
	{
		static async Task Main(string[] args)
		{
			Prophesizer prophesizer = new Prophesizer("blaseball-archive-iliana");

			int lastHour = -1;
			while (true)
			{
				var hour = DateTime.UtcNow.Hour;
				SeasonDay latest = await prophesizer.Poll();
				if ((hour > lastHour) || (hour==0 && lastHour == 23))
				{
					Prophesizer.ConsoleOrWebhook($"Processed games through Season {latest.Season+1}, Day {latest.Day+1} in the past hour.");
					//Prophesizer.ConsoleOrWebhook($"    {prophesizer.NumNetworkOutcomes} games used the network outcomes.json file, {prophesizer.NumLocalOutcomes} did not.");
					lastHour = hour;
				}
				await Task.Delay(1 * 60 * 1000);

			}
		}
	}
}
