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
Function Is-Win11() {
    return ([System.Environment]::OSVersion.Version.Build -ge 22000)
}
# Notes
# [System.Environment]::OSVersion.Version.Major
# [System.Environment]::OSVersion.Version.Minor
# [System.Environment]::OSVersion.Version.Build
# Versions
# Windows Server 2022: Major 10, Minor 0, Build 20348
# Windows Server 2019: Major 10, Minor 0, Build 17763
# Windows Server 2016: Major 10, Minor 0, Build 14393
# Windows Server 2012 R2: Major 6, Minor 3, Build 9600
# Windows Server 2012: Major 6, Minor 2, Build 9200
# Windows Server 2008 R2 SP1: Major 6, Minor 1, Build 7601
# Windows Server 2008 R2: Major 6, Minor 1, Build 7600
# Windows Server 2008 SP2 Update Rollup: Major 6, Minor 0, Build 6003
# Windows Server 2008 SP2: Major 6, Minor 0, Build 6002
# Windows Server 2008: Major 6, Minor 0, Build 6001
# Windows Server 2003 R2: Major 5, Minor 2, Build 3790
# Windows Server 2003 SP2: Major 5, Minor 2, Build 3790
# Windows Server 2000: Major 5, Minor 0, Build 2195
# Windows 11 22H2: Major 10, Minor 0, Build 22621
# Windows 11 21H2: Major 10, Minor 0, Build 22000
# Windows 10 22H2: Major 10, Minor 0, Build 19045
# Windows 10 21H2: Major 10, Minor 0, Build 19044
# Windows 10 21H1: Major 10, Minor 0, Build 19043
# Windows 10 20H2: Major 10, Minor 0, Build 19042
# Windows 10 2004: Major 10, Minor 0, Build 19041
# Windows 10 1909: Major 10, Minor 0, Build 18363
# Windows 10 1903: Major 10, Minor 0, Build 18362
# Windows 10 1809: Major 10, Minor 0, Build 17763
# Windows 10 1803: Major 10, Minor 0, Build 17134
# Windows 10 1709: Major 10, Minor 0, Build 16299
# Windows 10 1703: Major 10, Minor 0, Build 15063
# Windows 10 1607: Major 10, Minor 0, Build 14393
# Windows 10 1511: Major 10, Minor 0, Build 10586
# Windows 10 1507: Major 10, Minor 0, Build 10240
# Windows 8.1 Update: Major 6, Minor 3, Build 9600
# Windows 8.1: Major 6, Minor 3, Build 9200
# Windows 8: Major 6, Minor 2, Build 9200
# Windows 7 SP1: Major 6, Minor 1, Build 7601
# Windows 7: Major 6, Minor 1, Build 7600
# Windows Vista SP2: Major 6, Minor 0, Build 6002
# Windows Vista SP1: Major 6, Minor 0, Build 6001
# Windows Vista: Major 6, Minor 0, Build 6000
# Windows XP SP3: Major 5, Minor 1, Build 2600
# Windows 2000 SP4: Major 5, Minor 0, Build 2195
# Check if Server or Desktop
# (Get-CimInstance -ClassName "Win32_OperatingSystem").ProductType
# (Get-WmiObject -Class "Win32_OperatingSystem").ProductType
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



# Remove Folder recursively, preventing error if not exist
Function Remov-Folde($path_folder) {
    if (Test-Path -Path $path_folder) {
        Get-Item -Path $path_folder | Remove-Item -Recurse -Force
    }
}
# To use,
# Provide $path_folder
# Remov-Folde $path_folder



# Create Folder, preventing error if exist
# Used especially for temp downloads
Function Creat-NewEmpty-Folde($path_folder) {
    Remov-Folde $path_folder
    New-Item -ItemType "directory" -Path $path_folder -Force | Out-Null
}
# To use,
# Provide $path_folder
# Creat-NewEmpty-Folde $path_folder



# Download App
# Given some apps are not on winget
Function Downloa-Ap($url, $dir_installer) {
    Write-Host "Downloading $dir_installer ...."

    # Create new folder
    Creat-NewEmpty-Folde $dir_installer
    
    # Download
    Push-Location -Path $dir_installer
    curl.exe -L -O $url
    Pop-Location

    Write-Host "... Done Downloading $dir_installer"
}
# To use,
# Provide $url $dir_installer
# Downloa-Ap $url $dir_installer



# Install App
# Given folder with one installer file only
Function Instal-Ap($dir_installer, $install_args) {
    Write-Host "Installing $dir_installer ..."
    
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
    
    # Notes
    # Full commands that Invoke Expression actually do
    # Get-ChildItem -Path $dir_installer -Recurse -Filter *.$installer_fileext | % { Start-Process -FilePath $_.FullName -ArgumentList $install_args -Wait }
    # Get-ChildItem -Path $dir_installer -Recurse -Filter *.$installer_fileext | % { Add-AppxPackage -Path $_.FullName }

    Write-Host "... Done Installing $dir_installer"
}
# To use,
# Provide $dir_installer $install_args
# Instal-Ap $dir_installer $install_args



# Appendix


