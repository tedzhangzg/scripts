# Script
# Function References

# To download and include
# Invoke-Expression $($(Invoke-WebRequest "https://raw.githubusercontent.com/tedzhangzg/scripts/main/functions.ps1" -UseBasicParsing).Content)



# Clear Powershell History
Function Clear-PSHistory() {
    if (Test-Path -Path (Get-PSReadlineOption).HistorySavePath) {
        Remove-Item -Path $(Split-Path -Path (Get-PSReadlineOption).HistorySavePath -Parent) -Recurse
    }
    Write-Host "Powershell history cleared."
}
# To use,
# Just call function



# Clear Windows Defender History
Function Clear-WinDefHist() {
    Set-MpPreference -ScanPurgeItemsAfterDelay 1
    Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows Defender\Scans\History\Service" -Recurse | Remove-Item -Recurse -Force
}
# To use,
# Just call function



# Check Windows 11
$running_Win11 = [System.Environment]::OSVersion.Version.Build -ge 22000
# Windows 10 21H1 has Build 19043
# To use,
# Just call function



# Create Folder, preventing error if exist
# Used especially for temp downloads
Function Creat-Folde($path_folder) {
    if (Test-Path -Path $path_folder) {
        Remove-Item -Path $path_folder -Recurse -Force
    }
    New-Item -ItemType "directory" -Path $path_folder | Out-Null
}
# Remove Folder recursively, preventing error if not exist
Function Remov-Folde($path_folder) {
    if (Test-Path -Path $path_folder) {
        Remove-Item -Path $path_folder -Recurse -Force
    }
}
# To use,
# Just call function



# Get URL from winget
# Useful for manual install or when hash isn't updated in manifest
Function Get-URL-FromWinget($app_wgname) {

    # Winget show info - returns array with elements from each line of winget show
    $arr_wgshow = $(winget show --id $app_wgname)

    # Get array with element 0 = line with "Download Url"
    $arr_wgshow_url = $arr_wgshow -match "Download Url"

    # Get string value from one-element array
    $str_element = $arr_wgshow_url[0]

    # Get URL
    $url = $str_element.Substring($str_element.IndexOf(": ") + 2)
    return $url

}
# To use,
# Provide $app_wgname
# Get-URL-FromWinget $app_wgname



# Install App
# Given folder with one installer file only
Function Instal-Ap($dir_installer, $install_args) {
    Write-Host "Installing $dir_installer ..."
    
    # Set var for this use
    # $installer_fileext = ""

    # Get installer file extension if null
    if ($null -eq $installer_fileext) {
        $installer_fileext = (Get-ChildItem -Path $dir_installer).Extension.Substring(1)
    }
    
    # Install, based on what the extension is
    if ( ($installer_fileext -eq "msi") -or ($installer_fileext -eq "msp") -or ($installer_fileext -eq "exe") ) {
        Invoke-Expression "Get-ChildItem -Path `$dir_installer -Recurse -Filter *.`$installer_fileext | % { Start-Process -FilePath `$_.FullName -ArgumentList `$install_args -Wait }"
    } elseif ( ($installer_fileext -like "app*") -or ($installer_fileext -like "msix*") ) {
        Invoke-Expression "Get-ChildItem -Path `$dir_installer -Recurse -Filter *.`$installer_fileext | % { Add-AppxPackage -Path `$_.FullName }"
    }

    # Clear var for next use
    Remove-Variable installer_fileext

    # Commands inside Invoke Expression
    # Get-ChildItem -Path $dir_installer -Recurse -Filter *.$installer_fileext | % { Start-Process -FilePath $_.FullName -ArgumentList $install_args -Wait }
    # Get-ChildItem -Path $dir_installer -Recurse -Filter *.$installer_fileext | % { Add-AppxPackage -Path $_.FullName }

    Write-Host "... Done Installing"
}
# To use,
# Provide $dir_installer $install_args
# Instal-Ap $dir_installer $install_args



# Download App
# Given some apps are not on winget
Function Downloa-Ap($url, $dir_installer) {
    Write-Host "Downloading $dir_installer ...."

    # Create new folder
    if (-Not (Test-Path -Path $dir_installer)) {
        New-Item -ItemType "directory" -Path $dir_installer | Out-Null
    } else {
        Get-ChildItem -Path $dir_installer -Recurse | Remove-Item -Recurse
    }

    # Download
    Push-Location -Path $dir_installer
    curl.exe -L -O $url
    Pop-Location

    Write-Host "... Done Downloading"
}
# To use,
# Provide $url $dir_installer
# Downloa-Ap $url $dir_installer



# Check and Install WinGet
Function Instal-Winge() {
    
    # Initial Location
    $to_pop_location = 0
    if ([string]$(Get-Location) -eq "C:\Windows\system32") {
        Push-Location -Path $HOME\Downloads
        $to_pop_location = 1
    }
    
    
    # C++ Desktop Bridge 14

    # Param
    $dir_installer = "VCPP_CPPDB14x86"
    $install_args = ""
    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_cppdb14x86
        Downloa-Ap $url $dir_installer
    }
    # Install
    Instal-Ap $dir_installer $install_args
    
    # Param
    $dir_installer = "VCPP_CPPDB14x64"
    $install_args = ""
    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_cppdb14x64
        Downloa-Ap $url $dir_installer
    }
    # Install
    Instal-Ap $dir_installer $install_args
    
    
    # NuGet

    Install-PackageProvider -Name "NuGet" -Force | Out-Null
    Register-PackageSource -Name "nuget.org" -Location "https://www.nuget.org/api/v2" -ProviderName "NuGet" -Force | Out-Null
    Install-Package "Microsoft.UI.Xaml" -Force | Out-Null


    # WinGet

    # Param
    $dir_installer = "WinGet"
    $install_args = ""

    # Download
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_winget
        Downloa-Ap $url $dir_installer
    }
    Instal-Ap $dir_installer $install_args
    
    
    # Return to previous location
    if ($to_pop_location -eq 1) {
        Pop-Location
        $to_pop_location = 0
    }

}
# To use,
# Just call function



# Appendix


