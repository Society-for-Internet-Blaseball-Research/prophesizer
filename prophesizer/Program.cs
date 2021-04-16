using Npgsql;
using System;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace SIBR
{
	class Program
	{
		static async Task Main(string[] args)
		{
			try
			{
				// Try to migrate the DB to the latest schema
				var connString = Environment.GetEnvironmentVariable("PSQL_CONNECTION_STRING");
				var connection  = new NpgsqlConnection(connString);
				var evolve = new Evolve.Evolve(connection, msg => Console.WriteLine(msg))
				{
					Locations = new[] { "migrations" },
					SqlMigrationSuffix = ".pgsql",
					CommandTimeout = 600,
					RetryRepeatableMigrationsUntilNoError = true,
				};

				var dev = Environment.GetEnvironmentVariable("PROPHESIZER_DEV");
				bool devMode = dev == null ? false : bool.Parse(dev);
				if(devMode)
				{
					evolve.MustEraseOnValidationError = true;
				}
				else
				{
					evolve.IsEraseDisabled = true; // recommended in production
				}

				// Find the DB name from the connection string
				string dbName = "blaseball";
				var splits = connString.Split(';');
				foreach(var s in splits)
				{
					var halves = s.Split('=');
					if(halves[0] == "database")
					{
						dbName = halves[1];
					}
				}

				// Add a placeholder for the DB name
				evolve.Placeholders.Add("${database}", dbName);

				evolve.Migrate();
			}
			catch (Exception ex)
			{
				// Oh noes
				Console.WriteLine("Database migration failed.", ex);
				throw;
			}


			Prophesizer prophesizer = new Prophesizer();

			int lastHour = -1;
			int numUpdates = 0;
			while (true)
			{
				var hour = DateTime.UtcNow.Hour;
				PollResult result = await prophesizer.Poll();
				numUpdates += result.NumUpdatesProcessed;
				if ((hour > lastHour) || (hour==0 && lastHour == 23))
				{
					string[] goofs = new string[]
					{
						"\nI'm hungry.",
						"\nI miss blaseball.",
						"\nIs it time for the next Era yet?",
						"\nAre we there yet?",
						"\nSIBR are all love blaseball.",
						"\nThe commissioner is doing a great job."
					};

					string g = "";

					if (numUpdates == 0)
					{
						var r = new Random();
						if (r.Next(100) < 10)
						{
							var i = r.Next(goofs.Length);
							g = goofs[i];
						}
					}

					Prophesizer.ConsoleOrWebhook($"Processed {numUpdates} updates in the past hour. Last recorded game is {result.Latest.HumanReadable}.{g}");
					//Prophesizer.ConsoleOrWebhook($"    {prophesizer.NumNetworkOutcomes} games used the network outcomes.json file, {prophesizer.NumLocalOutcomes} did not.");
					lastHour = hour;
					numUpdates = 0;
				}
				await Task.Delay(1 * 60 * 1000);

			}
		}
	}
}
