# WixToolset-Tutorials

A collection of tutorials for the [Wix Toolset](http://wixtoolset.org/), which include a bunch of samples and examples.  

Wix toolset (v3 and v4) is the tool to create:

* Modern `MSI` setups for the Windows Installer
* Boostrapper `EXE` installer to handle prerequisites
* Custom Actions to write your own C# code inside the Windows Installer

Slogan from the official Website:
> THE MOST POWERFUL SET OF TOOLS AVAILABLE TO CREATE YOUR WINDOWS INSTALLATION EXPERIENCE.

## Wix Toolset Extensions

|      Name      |           Description            |                             Source                              |
| -------------- | -------------------------------- | --------------------------------------------------------------- |
| WixUIExtension | UI Dialoges, e.g. WixUI_Advanced | C:\Program Files (x86)\WiX Toolset v3.11\bin\WixUIExtension.dll |

## History

1. Create the project on [GitHub](https://github.com/n13org/WixToolset-Tutorials) inside the n13.org - Open-Source by [KargWare](https://kargware.com)
1. Change UI sequence [UIRef](https://wixtoolset.org/documentation/manual/v3/xsd/wix/uiref.html) from `WixUI_Minimal` to `WixUI_Advanced`
1. Use Wix-Variables to avoid repeating your self many times
