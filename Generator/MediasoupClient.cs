using CppSharp;
using CppSharp.AST;
using CppSharp.Generators;
using CppSharp.Parser;
using Microsoft.Build.Construction;

namespace MediasoupClient.Net.Generator;

public class MediasoupClient : ILibrary {
    private readonly string slnPath;
    
    public MediasoupClient(string slnPath) {
        this.slnPath = slnPath;
        var sln = SolutionFile.Parse(slnPath);
        foreach (var project in sln.ProjectsInOrder) {
            if (project.ProjectName == "mediasoupclient") {
                
            }
        }
    }
    
    public void Setup(Driver driver) {
        var options = driver.Options;
        options.Verbose = true;
        options.OutputDir = "Output";
        options.GeneratorKind = GeneratorKind.CLI;
        
        var module = options.AddModule(nameof(MediasoupClient));
        module.IncludeDirs.AddRange(new [] {
            @"G:\Source\C\MediasoupClient.Net\include",
            @"G:\Source\C\MediasoupClient.Net\deps\libsdptransform\include",
            @"G:\Source\C\MediasoupClient.Net\deps\webrtc-builds\out\webrtc-34737-6584528-win-x64\include",
            @"G:\Source\C\MediasoupClient.Net\deps\webrtc-builds\out\webrtc-34737-6584528-win-x64\include\third_party\abseil-cpp"
        });
        module.LibraryDirs.AddRange(new [] {
            @"G:\Source\C\MediasoupClient.Net\deps\webrtc-builds\out\webrtc-34737-6584528-win-x64\lib\x64\Release"
        });
        
        module.Headers.Add("mediasoupclient.hpp");
        module.Libraries.AddRange(new [] {
            "libwebrtc_full.lib"
        });

        var parserOptions = driver.ParserOptions;
        parserOptions.LanguageVersion = LanguageVersion.CPP14;
    }

    public void SetupPasses(Driver driver) {
        
    }
    
    public void Preprocess(Driver driver, ASTContext ctx) {
        
    }

    public void Postprocess(Driver driver, ASTContext ctx) {
        
    }
}