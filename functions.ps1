# Script
# Function References

# To download and include
# Invoke-Expression $($(Invoke-WebRequest "https://raw.githubusercontent.com/tedzhangzg/scripts/main/functions.ps1" -UseBasicParsing).Content)



# Clear Powershell History
# 
# Usage
# Clear-PSHistory
# 
Function Clear-PSHistory() {
    if (Test-Path -Path (Get-PSReadlineOption).HistorySavePath) {
        Remove-Item -Path $(Split-Path -Path (Get-PSReadlineOption).HistorySavePath -Parent) -Recurse
    }
    Write-Host "Powershell history cleared."
}



# Clear Windows Defender History
# 
# Usage
# Clear-WinDefHist
# 
Function Clear-WinDefHist() {
    Set-MpPreference -ScanPurgeItemsAfterDelay 1
    Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows Defender\Scans\History\Service" -Recurse | Remove-Item -Recurse -Force
}



# Check Windows 11
# 
# Usage
# Is-Win11
# 
Function Is-Win11() {
    return ([System.Environment]::OSVersion.Version.Build -ge 22000)
}
# 
# Notes
# [System.Environment]::OSVersion.Version.Major
# [System.Environment]::OSVersion.Version.Minor
# [System.Environment]::OSVersion.Version.Build
# 
# Versions
# Windows Server 2022: 10, 0, 20348
# Windows Server 2019: 10, 0, 17763
# Windows Server 2016: 10, 0, 14393
# Windows Server 2012 R2: 6, 3, 9600
# Windows Server 2012: 6, 2, 9200
# Windows Server 2008 R2 SP1: 6, 1, 7601
# Windows Server 2008 R2: 6, 1, 7600
# Windows Server 2008 SP2 Update Rollup: 6, 0, 6003
# Windows Server 2008 SP2: 6, 0, 6002
# Windows Server 2008: 6, 0, 6001
# Windows Server 2003 R2: 5, 2, 3790
# Windows Server 2003 SP2: 5, 2, 3790
# Windows Server 2000: 5, 0, 2195
# Windows 11 22H2: 10, 0, 22621
# Windows 11 21H2: 10, 0, 22000
# Windows 10 22H2: 10, 0, 19045
# Windows 10 21H2: 10, 0, 19044
# Windows 10 21H1: 10, 0, 19043
# Windows 10 20H2: 10, 0, 19042
# Windows 10 2004: 10, 0, 19041
# Windows 10 1909: 10, 0, 18363
# Windows 10 1903: 10, 0, 18362
# Windows 10 1809: 10, 0, 17763
# Windows 10 1803: 10, 0, 17134
# Windows 10 1709: 10, 0, 16299
# Windows 10 1703: 10, 0, 15063
# Windows 10 1607: 10, 0, 14393
# Windows 10 1511: 10, 0, 10586
# Windows 10 1507: 10, 0, 10240
# Windows 8.1 Update: 6, 3, 9600
# Windows 8.1: 6, 3, 9200
# Windows 8: 6, 2, 9200
# Windows 7 SP1: 6, 1, 7601
# Windows 7: 6, 1, 7600
# Windows Vista SP2: 6, 0, 6002
# Windows Vista SP1: 6, 0, 6001
# Windows Vista: 6, 0, 6000
# Windows XP SP3: 5, 1, 2600
# Windows 2000 SP4: 5, 0, 2195
# 
# Check if Server or Desktop
# (Get-CimInstance -ClassName "Win32_OperatingSystem").ProductType
# (Get-WmiObject -Class "Win32_OperatingSystem").ProductType



# Get URL from winget
# 
# Usage
# Get-URL-FromWinget "$app_wgname"
# 
# Useful for manual install or when hash isn't updated in manifest
Function Get-URL-FromWinget($app_wgname) {

    # winget show - return array
    $arr_wgshow = $(winget show --id $app_wgname)

    # Search array for "Installer Url" - return 1-element array
    $arr_wgshow_url = $arr_wgshow -match "Installer Url"

    # Get string value from 1-element array
    $str_element = $arr_wgshow_url[0]

    # Get URL
    $url = $str_element.Substring($str_element.IndexOf(": ") + 2)

    # Return
    return $url

}



# Remove Folder recursively, preventing error if not exist
# 
# Usage
# Remov-Folde "$path_folder"
# 
Function Remov-Folde($path_folder) {
    if (Test-Path -Path $path_folder) {
        Get-Item -Path $path_folder | Remove-Item -Recurse -Force
    }
}



# Create Folder, preventing error if exist
# 
# Usage
# Creat-NewEmpty-Folde "$path_folder"
# 
Function Creat-NewEmpty-Folde($path_folder) {
    Remov-Folde $path_folder
    New-Item -ItemType "directory" -Path $path_folder -Force | Out-Null
}



# Download Installer
# 
# Usage
# Downloa-Installe "$url" "$dir_installer"
# 
Function Downloa-Installe($url, $dir_installer) {
    Write-Host "Downloading $dir_installer ...."

    # Create new folder
    Creat-NewEmpty-Folde $dir_installer
    
    # Download
    Push-Location -Path $dir_installer
    curl.exe -L -O $url
    Pop-Location

    Write-Host "... Done Downloading $dir_installer"
}



# Install App
# 
# Usage
# Instal-Ap "$dir_installer" "$install_args"
# 
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



# Appendix


