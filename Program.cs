using System;
using System.Threading.Tasks;

namespace SIBR {
  class Program {
    static async Task Main(string[] args) {
      Prophesizer prophesizer = new Prophesizer("blaseball-archive-iliana");

      bool firstRun = true;
      // Don't put this where it wraps across zero. Just don't.
      const int BASE_MINUTE = 45;

      while (true) {
        var minutes = DateTime.UtcNow.Minute;
        // Only run Prophesizer around the X:50 mark each hour
        if (firstRun || (minutes >= BASE_MINUTE && minutes <= (BASE_MINUTE + 5))) {
          firstRun = false;
          await prophesizer.Poll();
        }
        await Task.Delay(5 * 60 * 1000);

      }
    }
  }
}
