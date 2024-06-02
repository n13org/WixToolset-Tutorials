# WixToolset-Tutorials

A collection of tutorials for the [Wix Toolset][Wix Toolset], which include a bunch of samples and examples.  

Wix toolset (v3, v4 and v5) is the tool to create:

* Modern `MSI` setups for the Windows Installer, main file is `Product.wxs`
* Boostrapper `EXE` installer to handle prerequisites, main file is `Bundle.wxs`
* Custom Actions to write your own C# code inside the Windows Installer, main file is `CustomAction.cs`

Slogan from the official Website:
> THE MOST POWERFUL SET OF TOOLS AVAILABLE TO CREATE YOUR WINDOWS INSTALLATION EXPERIENCE.

A MSI can be inspected by the tool **Orca** from Microsoft ([Orca - Documenation][Orca - Documenation]), which is part of the Windows Installer SDK and installed at `C:\Program Files (x86)\Orca\Orca.exe`. As an Alternative there is also [SuperOrca][SuperOrca] which is **NOT** from Microsoft.

The [Roadmap][ROADMAP] of the project.

> When GPG signing is not working, try command `gpgconf --launch gpg-agent`

## WixToolset v5

### Visual Studio Extension

Install [HeatWave for VS2022 by FireGiant](https://marketplace.visualstudio.com/items?itemName=FireGiant.FireGiantHeatWaveDev17) to Visual Studio 2022.
With this extension WixToolset v5 will be available and be supported.

### Offical documentation for WixToolset v5

* [Get started with WiX](https://wixtoolset.org/docs/intro/)
* [Update from v4 to v5](https://wixtoolset.org/docs/fivefour/)
* [Update from v3 to v4](https://wixtoolset.org/docs/fourthree/)

## Docker - debian based

The docker usage is for the shell (bash) scripts to do download the HTML pages from Microsoft dotnet SDKs.

|Major|Max Version|
|:---:|:---------:|
| [5.0](https://dotnet.microsoft.com/en-us/download/dotnet/5.0) | 5.0.17 |
| [6.0](https://dotnet.microsoft.com/en-us/download/dotnet/6.0) | 6.0.31 |
| [7.0](https://dotnet.microsoft.com/en-us/download/dotnet/7.0) | 7.0.20 |
| [8.0](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) | 8.0.6  |

These versions are stored (additionally) in [_variables.sh](docker/scripts/_variables.sh).

Create the docker image

```powershell
docker build --tag wixtoolset .
```

Run container interactive from docker image, use PWD as volume inside

```powershell
docker run -it --rm -v ${pwd}:/ws/data wixtoolset /bin/bash
```

Inside the docker container

1. Download the dotnet pages [`./download-pages.sh`](docker/scripts/download-pages.sh), will be stored outside the container in the local `download` folder. This folder should be in gitignore and not under version controls.
2. Parse the local HTML files to JSON with [`./html2json.sh`](docker/scripts/html2json.sh), the json files will be stored in a local `data`folder. These json files can be under source control. For each SDK Runtime `asp`, `desktop` and `runtime` a file will be generated.
3. Generate the WXS (wix toolset components) files with [`./generateWixToolsetFragment.sh`](docker/scripts/generateWixToolsetFragment.sh) a local `wix-dotnet` folder will be generated.

An example wxs code, for dotnet `v8.0.6` SDK `Desktop` runtime for `x64`, the original link would be [.NET 8.0 Desktop Runtime (v8.0.6) Windows x64](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-desktop-8.0.6-windows-x64-installer).

The code is copied from [DotNet_DesktopRuntime_v8_0_6_x64.wxs](wix-dotnet/DotNet_DesktopRuntime_v8.0.6_x64.wxs) below the folder [wix-dotnet](wix-dotnet/), where all other wxs-files are stored. 

```xml
<Wix xmlns="http://wixtoolset.org/schemas/v4/wxs"
     xmlns:netfx="http://wixtoolset.org/schemas/v4/wxs/netfx"
     xmlns:bal="http://wixtoolset.org/schemas/v4/wxs/bal">

    <Fragment>
    <netfx:DotNetCoreSearch
        RuntimeType="desktop"
        Platform="x64"
        MajorVersion="8"
        Variable="DOT_NET_VER" />

    <PackageGroup Id="DotNet_DesktopRuntime_v8_0_6_x64">
    <ExePackage Id="Netfx80"
                DisplayName="Microsoft .NET 8.0 Desktop Runtime"
                Description="Microsoft .NET 8.0 (8.0.6) Desktop Runtime for windows x64"
                PerMachine="yes" Permanent="yes" Vital="yes" InstallArguments="/norestart /quiet"
                DetectCondition="DOT_NET_VER &gt;= v8.0.6"
                bal:PrereqPackage="yes">
        <ExePackagePayload
            Name="runtime-desktop-8.0.6-windows-x64.exe"
            DownloadUrl="https://download.visualstudio.microsoft.com/download/pr/76e5dbb2-6ae3-4629-9a84-527f8feb709c/09002599b32d5d01dc3aa5dcdffcc984/windowsdesktop-runtime-8.0.6-win-x64.exe"
            Hash="91bec94f32609fd194ac47a893cea1466e6ad25a16bbaf39cd6989fa9f09e865ba87669aabfe26cd3c8f2a57296170cc021dc762e238a6c5cb5e843d3df3169f"
            Size="58663408" />
        <ExitCode Value="0" Behavior="success" />
        <ExitCode Behavior="scheduleReboot" />
    </ExePackage>
    </PackageGroup>
    </Fragment>
</Wix>
```

Run the playwright tests inside the docker container. This command will execute all tests and will create a local folder `playwright-report`, which should be excluded from source control. Before the test can run, run [./joinjson.sh](docker/scripts/joinjson.sh).

```powershell
docker run -it --rm -v ${pwd}:/ws/data -v ${pwd}/playwright-report:/ws/playwright-report wixtoolset npx playwright test
```

## History / Change Log

1. Create the project on [GitHub][GitHub WixToolset-Tutorials] inside the "[n13.org][GitHub Org n13.org] - Open-Source by [KargWare][KargWare Website]"
1. Change UI sequence [UIRef][Wix Toolset UIRef] from `WixUI_Minimal` to `WixUI_Advanced`
1. Use [Wix-Variables][Wix Toolset Wix-Variables] to avoid repeating your self many times, extract version to separate WXI file
1. Add a customized dialog `PrerequisitesDlg` to the default `WixUI_FeatureTree` UI. It is also shared as a [GitHub Gist][GitHub Gist PrerequisitesDlg]. The branch [features/AddPrerequisitesPage][GitHub WixToolset-Tutorials branch AddPrerequisitesPage] will stay.
1. Add a wixtoolset bootstrapper project and add the MSI to it
1. Move the folders to a file 'Directories.wxs', [Folders and Directories in WixToolset][KargWare Notes #8274e8]
1. Support WixToolset v5 driven by firegiant

## Wix Toolset Extensions

Wix Toolset Extensions are stored inside `C:\Program Files (x86)\WiX Toolset v3.11\bin` (replace the version v3.11 with your version) as `.dll` and can be used as references inside your project.  

| Name           | Description                                                                                                              |
| -------------- | ------------------------------------------------------------------------------------------------------------------------ |
| [WixUIExtension][GitHub WixUIExtension] | UI Dialoges, [UIRef][Wix Toolset UIRef], e.g. WixUI_Advanced, WixUI_FeatureTree and WixUI_Mondo |

[ROADMAP]: ./ROADMAP.md
[KargWare Website]: https://kargware.com
[KargWare Notes]: https://notes.kargware.com
[KargWare Notes #8274e8]: https://notes.kargware.com/2020/04/25/Folders-and-Directories-in-WixToolset/
[GitHub Org n13.org]: https://github.com/n13org
[GitHub WixToolset-Tutorials]: https://github.com/n13org/WixToolset-Tutorials
[GitHub WixToolset-Tutorials branch AddPrerequisitesPage]: https://github.com/n13org/WixToolset-Tutorials/tree/features/AddPrerequisitesPage
[GitHub Gist PrerequisitesDlg]: https://gist.github.com/N7K4/8b146328db03484a61543c4f612c5dd3
[Wix Toolset]: http://wixtoolset.org/
[Wix Toolset UIRef]: https://wixtoolset.org/documentation/manual/v3/xsd/wix/uiref.html
[Wix Toolset Wix-Variables]: https://wixtoolset.org/documentation/manual/v3/votive/votive_project_references.html
[Orca - Documenation]: https://docs.microsoft.com/en-us/windows/win32/msi/orca-exe
[SuperOrca]: http://www.pantaray.com/msi_super_orca.html
[GitHub WixUIExtension]: https://github.com/wixtoolset/wix3/tree/develop/src/ext/UIExtension/wixlib
