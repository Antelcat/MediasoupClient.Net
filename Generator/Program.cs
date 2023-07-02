using CppSharp;

namespace MediasoupClient.Net.Generator; 

public static class Program {
    public static void Main(string[] args) {
        ConsoleDriver.Run(new MediasoupClient(
            Path.GetFullPath(@"G:\Source\C\MediasoupClient.Net\build\mediasoupclient.sln")));
    }
}