# Script
# Function References

# To download and include
# Invoke-Expression $($(Invoke-WebRequest "https://raw.githubusercontent.com/tedzhangzg/shellscripts/main/functions.ps1" -UseBasicParsing).Content)



# Clear Powershell History
Function Clear-PSHistory() {
    if (Test-Path -Path (Get-PSReadlineOption).HistorySavePath) {
        Remove-Item -Path $(Split-Path -Path (Get-PSReadlineOption).HistorySavePath -Parent) -Recurse
    }
    "Powershell history cleared."
}
# To use,
# Just call function



# Check Windows 11
$running_Win11 = [System.Environment]::OSVersion.Version.Build -ge 20000
# Windows 10 21H1 has Build 19043
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
    "Installing $dir_installer ..."
    
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

    "... Done Installing"
}
# To use,
# Provide $dir_installer $install_args
# Instal-Ap $dir_installer $install_args



# Download App
# Given some apps are not on winget
Function Downloa-Ap($url, $dir_installer) {
    "Downloading $dir_installer ...."

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

    "... Done Downloading"
}
# To use,
# Provide $url $dir_installer
# Downloa-Ap $url $dir_installer



# Check and Install WinGet
Function Instal-Winge() {
    
    # Go to working directory
    # Push-Location -Path $HOME\Downloads
    
    # C++ Desktop Bridge 14 x86
    $dir_installer = "VCPP_CPPDB14x86"
    $install_args = ""
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_cppdb14x86
        Downloa-Ap $url $dir_installer
    }
    Instal-Ap $dir_installer $install_args
    
    # C++ Desktop Bridge 14 x64
    $dir_installer = "VCPP_CPPDB14x64"
    $install_args = ""
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_cppdb14x64
        Downloa-Ap $url $dir_installer
    }
    Instal-Ap $dir_installer $install_args
    
    # WinGet
    $dir_installer = "WinGet"
    $install_args = ""
    if (-Not (Test-Path -Path $dir_installer)) {
        $url = $url_winget
        Downloa-Ap $url $dir_installer
    }
    Instal-Ap $dir_installer $install_args
    
    # Return to previous directory
    # Pop-Location
    
}
# To use,
# Just call function



# Appendix

