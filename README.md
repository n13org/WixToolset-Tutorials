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

| Name           | Description                                         | Source                                                          |
| -------------- | --------------------------------------------------- | --------------------------------------------------------------- |
| WixUIExtension | UI Dialoges, e.g. WixUI_Advanced, WixUI_FeatureTree | C:\Program Files (x86)\WiX Toolset v3.11\bin\WixUIExtension.dll |

## History

1. Create the project on [GitHub](https://github.com/n13org/WixToolset-Tutorials) inside the "n13.org - Open-Source by [KargWare](https://kargware.com)"
1. Change UI sequence [UIRef](https://wixtoolset.org/documentation/manual/v3/xsd/wix/uiref.html) from `WixUI_Minimal` to `WixUI_Advanced`
1. Use [Wix-Variables](https://wixtoolset.org/documentation/manual/v3/votive/votive_project_references.html) to avoid repeating your self many times, extract version to separate WXI file
1. Add a customized dialog `PrerequisitesDlg` to the default `WixUI_FeatureTree` UI. It is also shared as a [GitHub Gist](https://gist.github.com/N7K4/8b146328db03484a61543c4f612c5dd3). The branch `features/AddPrerequisitesPage` will stay.