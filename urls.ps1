# Script
# URL References

# To download and include
# Invoke-Expression $($(Invoke-WebRequest "https://raw.githubusercontent.com/tedzhangzg/scripts/main/urls.ps1" -UseBasicParsing).Content)



# Script to Add Microsoft Store
$url_addmsstore = "https://github.com/kkkgo/LTSC-Add-MicrosoftStore/archive/refs/heads/master.zip"

# C++ Runtime framework packages for Desktop Bridge
$url_cppdb_14_a64 = "https://aka.ms/Microsoft.VCLibs.arm64.14.00.Desktop.appx"
$url_cppdb_14_x64 = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
$url_cppdb_14_x86 = "https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx"

# NuGet
# Microsoft.UI.Xaml
# 2.8
$url_nuget_msuixaml = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6"
# 2.7
# $url_nuget_msuixaml = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3"

# Windows Package Manager
$url_winget = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# Microsoft .NET Framework 4.8.1
$url_dotnetfw_481 = "https://go.microsoft.com/fwlink/?linkid=2203305"

# Microsoft .NET Framework 1.1
$url_dotnetfw_11rtm = "https://raw.githubusercontent.com/not001praween001/stockMN-exe/master/stockMN_1.3.1/dotnetfx.exe"
$url_dotnetfw_11sp1 = "https://download.microsoft.com/download/8/b/4/8b4addd8-e957-4dea-bdb8-c4e00af5b94b/NDP1.1sp1-KB867460-X86.exe"

# .NET Core
$url_dotnet5HB = "https://download.visualstudio.microsoft.com/download/pr/05726c49-3a3d-4862-9ff8-0660d9dc3c52/71c295f9287faad89e2d3233a38b44fb/dotnet-hosting-5.0.17-win.exe"
$url_dotnet5DRT_a64 = "https://download.visualstudio.microsoft.com/download/pr/be25784a-4231-4c53-ba6e-869166ef523f/9602c6c0d358d31dc710fd0573fc39e0/windowsdesktop-runtime-5.0.17-win-arm64.exe"
$url_dotnet5DRT_x64 = "https://download.visualstudio.microsoft.com/download/pr/3aa4e942-42cd-4bf5-afe7-fc23bd9c69c5/64da54c8864e473c19a7d3de15790418/windowsdesktop-runtime-5.0.17-win-x64.exe"
$url_dotnet5DRT_x86 = "https://download.visualstudio.microsoft.com/download/pr/b6fe5f2a-95f4-46f1-9824-f5994f10bc69/db5ec9b47ec877b5276f83a185fdb6a0/windowsdesktop-runtime-5.0.17-win-x86.exe"
$url_dotnet31HB = "https://download.visualstudio.microsoft.com/download/pr/6744eb9d-dcd4-4386-9d87-b03b70fc58ce/818fadf3f3d919c17ba845b2195bfd9b/dotnet-hosting-3.1.32-win.exe"
$url_dotnet31DRT_x64 = "https://download.visualstudio.microsoft.com/download/pr/b92958c6-ae36-4efa-aafe-569fced953a5/1654639ef3b20eb576174c1cc200f33a/windowsdesktop-runtime-3.1.32-win-x64.exe"
$url_dotnet31DRT_x86 = "https://download.visualstudio.microsoft.com/download/pr/3f353d2c-0431-48c5-bdf6-fbbe8f901bb5/542a4af07c1df5136a98a1c2df6f3d62/windowsdesktop-runtime-3.1.32-win-x86.exe"
$url_dotnet21HB = "https://download.visualstudio.microsoft.com/download/pr/cf7b17e3-ed6d-4ded-8ae6-9f83ffaaca98/9d2ca844baa4a4a9ed83861ffc8e293e/dotnet-hosting-2.1.30-win.exe"

# Visual C++ Redistributable
$url_vcpp_2005_x64 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE"
$url_vcpp_2005_x86 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE"
$url_vcpp_2008_x64 = "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe"
$url_vcpp_2008_x86 = "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"
$url_vcpp_2010_x64 = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"
$url_vcpp_2010_x86 = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"
$url_vcpp_2012_x64 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
$url_vcpp_2012_x86 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"
$url_vcpp_2013_x64 = "https://aka.ms/highdpimfc2013x64enu"
$url_vcpp_2013_x86 = "https://aka.ms/highdpimfc2013x86enu"
$url_vcpp_2015Plus_a64 = "https://aka.ms/vs/17/release/vc_redist.arm64.exe"
$url_vcpp_2015Plus_x64 = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$url_vcpp_2015Plus_x86 = "https://aka.ms/vs/17/release/vc_redist.x86.exe"

# C++ Runtime v11.0 framework package for Desktop Bridge (Project Centennial)
$url_cppdb_11_x86 = "https://download.microsoft.com/download/3/B/C/3BC60F47-6A7C-4D46-8CFB-C2E746EF336E/vc_uwpdesktop.110.exe"

# C++ Runtime v12 framework package for Desktop Bridge (Project Centennial)
$url_cppdb_12_x86 = "https://download.microsoft.com/download/2/1/F/21F05B77-C444-46C0-B357-7EBC78C95CE2/vc_uwpdesktop.120.exe"

# Linux kernel update package x64
$url_wsl2kernel_a64 = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_arm64.msi"
$url_wsl2kernel_x64 = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"

# Visual Studio Code
$url_vscode_a64 = "https://code.visualstudio.com/sha/download?build=stable&os=win32-arm64"
$url_vscode_x64 = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"
$url_vscode_x86 = "https://code.visualstudio.com/sha/download?build=stable&os=win32"

# Windows Essentials 2012
$url_winessentials_2012 = "https://archive.org/download/wlsetup-all_201802/wlsetup-all.exe"

# Skype MSI
$url_skypemsi = "http://go.skype.com/msi-download"

# Google Drive
$url_googledrive = "https://dl.google.com/drive-file-stream/GoogleDriveSetup.exe"

# TeamViewer QuickSupport v13
$url_teamviewerqs_13 = "https://download.teamviewer.com/download/version_13x/TeamViewerQS.exe"

# Java JRE
$url_javajre_8_x64 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_431-b10/0d8f12bc927a4e2c9f8568ca567db4ee/windows-i586/jre-8u431-windows-x64.exe"
$url_javajre_8_x86 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_431-b10/0d8f12bc927a4e2c9f8568ca567db4ee/windows-i586/jre-8u431-windows-i586.exe"
$url_javajre_10_x64 = "https://javadl.oracle.com/webapps/download/GetFile/10.0.2+13/19aef61b38124481863b1413dce1855f/windows-i586/jre-10.0.2_windows-x64_bin.exe"

# Java JDK
$url_javajdk_8_x64 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_381-b09/8c876547113c4e4aab3c868e9e0ec572/windows-i586/jdk-8u381-windows-x64.exe"
$url_javajdk_8_x86 = "https://javadl.oracle.com/webapps/download/GetFile/1.8.0_381-b09/8c876547113c4e4aab3c868e9e0ec572/windows-i586/jdk-8u381-windows-i586.exe"
$url_javajdk_10_x64 = "https://javadl.oracle.com/webapps/download/GetFile/10.0.2+13/19aef61b38124481863b1413dce1855f/windows-i586/jdk-10.0.2_windows-x64_bin.exe"
$url_java_11_x64 = "https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java11020/jdk-11.0.20_windows-x64_bin.exe"
$url_java_17_x64 = "https://download.oracle.com/java/17/archive/jdk-17.0.8_windows-x64_bin.exe"

# Office 2013 ODT
$url_odt_2013 = "https://download.microsoft.com/download/6/2/3/6230F7A2-D8A9-478B-AC5C-57091B632FCF/officedeploymenttool_x86_5031-1000.exe"

# Microsoft Access Database Engine
$url_msaccessdbengine_2010_x64 = "https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine_X64.exe"
$url_msaccessdbengine_2010_x86 = "https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine.exe"
$url_msaccessdbengine_2016_x64 = "https://download.microsoft.com/download/3/5/C/35C84C36-661A-44E6-9324-8786B8DBE231/accessdatabaseengine_X64.exe"
$url_msaccessdbengine_2016_x86 = "https://download.microsoft.com/download/3/5/C/35C84C36-661A-44E6-9324-8786B8DBE231/accessdatabaseengine.exe"

# KMS
$url_micactscr = "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/All-In-One-Version-KL/MAS_AIO.cmd"
$url_convr2v = "https://raw.githubusercontent.com/abbodi1406/C2R-R2V-AIO/master/C2R-R2V-AIO.cmd"



# Appendix


