using System.Threading.Tasks;

namespace SIBR {
  class Program {
      static async Task Main(string[] args) {
        Prophesizer prophesizer;
        if(args.Length == 1) {
          prophesizer = new Prophesizer(args[0], true);
        } else {
          prophesizer = new Prophesizer("blaseball-archive-iliana");
        }

        while (true) {
          await prophesizer.Poll();
          await Task.Delay(60 * 60 * 1000);
        }
      }
  }
}
