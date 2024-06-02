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

## WixToolset v5

### Visual Studio Extension

Install [HeatWave for VS2022 by FireGiant](https://marketplace.visualstudio.com/items?itemName=FireGiant.FireGiantHeatWaveDev17) to Visual Studio 2022.
With this extension WixToolset v5 will be available and be supported.

### Offical documentation for WixToolset v5

* [Get started with WiX](https://wixtoolset.org/docs/intro/)
* [Update from v4 to v5](https://wixtoolset.org/docs/fivefour/)
* [Update from v3 to v4](https://wixtoolset.org/docs/fourthree/)

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
