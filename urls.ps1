# Script
# URL References

# To download and include
# Invoke-Expression $($(Invoke-WebRequest "https://raw.githubusercontent.com/tedzhangzg/scripts/main/urls.ps1" -UseBasicParsing).Content)



# Script to Add Microsoft Store
$url_addmsstore = "https://github.com/kkkgo/LTSC-Add-MicrosoftStore/archive/refs/heads/master.zip"

# C++ Runtime framework packages for Desktop Bridge
$url_cppdb14_x86 = "https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx"
$url_cppdb14_x64 = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"

# Windows Package Manager
$url_winget = "https://github.com/microsoft/winget-cli/releases/download/v1.3.2091/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
# Old Version
# $url_winget = "https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
# $url_winget = "https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
# $url_winget = "https://github.com/microsoft/winget-cli/releases/download/v1.0.11692/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
# $url_winget = "https://github.com/microsoft/winget-cli/releases/download/v1.0.11451/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# Microsoft .NET Framework 4.8.1
$url_dotnetfw481 = "https://go.microsoft.com/fwlink/?linkid=2203305"

# Microsoft .NET Framework 1.1
$url_dotnetfw11rtm = "https://raw.githubusercontent.com/not001praween001/stockMN-exe/master/stockMN_1.3.1/dotnetfx.exe"
$url_dotnetfw11sp1 = "https://download.microsoft.com/download/8/b/4/8b4addd8-e957-4dea-bdb8-c4e00af5b94b/NDP1.1sp1-KB867460-X86.exe"

# Visual C++ Redistributable
$url_vcpp2005_x86 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE"
$url_vcpp2005_x64 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE"
$url_vcpp2008_x86 = "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"
$url_vcpp2008_x64 = "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe"
$url_vcpp2010_x86 = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"
$url_vcpp2010_x64 = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"
$url_vcpp2012_x86 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"
$url_vcpp2012_x64 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
$url_vcpp2013_x86 = "https://aka.ms/highdpimfc2013x86enu"
$url_vcpp2013_x64 = "https://aka.ms/highdpimfc2013x64enu"
$url_vcpp2015ToLatest_x86 = "https://aka.ms/vs/17/release/vc_redist.x86.exe"
$url_vcpp2015ToLatest_x64 = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$url_vcpp2015ToLatest_a64 = "https://aka.ms/vs/17/release/vc_redist.arm64.exe"

# C++ Runtime v11.0 framework package for Desktop Bridge (Project Centennial)
$url_cppdb11_x86 = "https://download.microsoft.com/download/3/B/C/3BC60F47-6A7C-4D46-8CFB-C2E746EF336E/vc_uwpdesktop.110.exe"

# C++ Runtime v12 framework package for Desktop Bridge (Project Centennial)
$url_cppdb12_x86 = "https://download.microsoft.com/download/2/1/F/21F05B77-C444-46C0-B357-7EBC78C95CE2/vc_uwpdesktop.120.exe"

# Linux kernel update package x64
$url_wsl2kernel = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"

# Visual Studio Code
$url_vscode_x86 = "https://code.visualstudio.com/sha/download?build=stable&os=win32"
$url_vscode_x64 = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"

# Windows Essentials 2012
$url_winessen = "https://archive.org/download/wlsetup-all_201802/wlsetup-all.exe"

# Skype MSI
$url_skypemsi = "http://go.skype.com/msi-download"

# Google Drive
$url_googledrive = "https://dl.google.com/drive-file-stream/GoogleDriveSetup.exe"

# TeamViewer QuickSupport v13
$url_teamviewer = "https://download.teamviewer.com/download/version_13x/TeamViewerQS.exe"

# Java 8 JRE x86
$url_java8_x86 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_341-b10/424b9da4b48848379167015dcc250d8d/windows-i586/jre-8u341-windows-i586.exe"

# Java 10 JRE
$url_java10 = "https://javadl.oracle.com/webapps/download/GetFile/10.0.2+13/19aef61b38124481863b1413dce1855f/windows-i586/jre-10.0.2_windows-x64_bin.exe"

# Java 11 JDK
$url_java11 = ""

# Java 17 JDK
$url_java17 = "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe"

# Office 2013 ODT
$url_odt2013 = "https://download.microsoft.com/download/6/2/3/6230F7A2-D8A9-478B-AC5C-57091B632FCF/officedeploymenttool_x86_5031-1000.exe"

# Microsoft Access Database Engine
$url_msaccessdbeng_2010_x86 = "https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine.exe"
$url_msaccessdbeng_2010_x64 = "https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine_X64.exe"
$url_msaccessdbeng_2016_x86 = "https://download.microsoft.com/download/3/5/C/35C84C36-661A-44E6-9324-8786B8DBE231/accessdatabaseengine.exe"
$url_msaccessdbeng_2016_x64 = "https://download.microsoft.com/download/3/5/C/35C84C36-661A-44E6-9324-8786B8DBE231/accessdatabaseengine_X64.exe"

# KMS
$url_convr2v = "https://raw.githubusercontent.com/abbodi1406/C2R-R2V-AIO/master/C2R-R2V-AIO.cmd"
$url_micactscr = "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/All-In-One-Version/MAS_AIO.cmd"



# Appendix


