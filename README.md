# WixToolset-Tutorials

A collection of tutorials for the [Wix Toolset](http://wixtoolset.org/), which include a bunch of samples and examples.  

Wix toolset (v3 and v4) is the tool to create:

* Modern `MSI` setups for the Windows Installer
* Boostrapper `EXE` installer to handle prerequisites
* Custom Actions to write your own C# code inside the Windows Installer

Slogan from the official Website:
> THE MOST POWERFUL SET OF TOOLS AVAILABLE TO CREATE YOUR WINDOWS INSTALLATION EXPERIENCE.

A MSI can be inspected by the tool **Orca** from Microsoft ([Orca - Documenation](https://docs.microsoft.com/en-us/windows/win32/msi/orca-exe)), which is part of the Windows Installer SDK and installed at `C:\Program Files (x86)\Orca\Orca.exe`. As an Alternative there is also [SuperOrca](http://www.pantaray.com/msi_super_orca.html) which is **NOT** from Microsoft.

## Wix Toolset Extensions

Wix Toolset extensions are normally instaleld under `C:\Program Files (x86)\WiX Toolset v3.11\bin\`

| Name           | Description   |
| -------------- | ------------- |
| [WixUIExtension](https://github.com/wixtoolset/wix3/tree/develop/src/ext/UIExtension/wixlib) | UI Dialoges, [UIRef](https://wixtoolset.org/documentation/manual/v3/xsd/wix/uiref.html), e.g. WixUI_Advanced, WixUI_FeatureTree and WixUI_Mondo |

## History

1. Create the project on [GitHub](https://github.com/n13org/WixToolset-Tutorials) inside the "n13.org - Open-Source by [KargWare](https://kargware.com)"
1. Change UI sequence [UIRef](https://wixtoolset.org/documentation/manual/v3/xsd/wix/uiref.html) from `WixUI_Minimal` to `WixUI_Advanced`
1. Use [Wix-Variables](https://wixtoolset.org/documentation/manual/v3/votive/votive_project_references.html) to avoid repeating your self many times, extract version to separate WXI file
