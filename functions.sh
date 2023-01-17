#!/bin/sh
# Functions

# Download
# curl -L -O "https://raw.githubusercontent.com/tedzhangzg/scripts/main/functions.sh"
# dot sourced into all scripts
# source ./functions.sh



# Clear Terminal History
# 
# Usage
# clearTerminalHistory
# 
function clearTerminalHistory() {
    sudo rm -rf /var/root/.bash_history
    rm -rf $HOME/.bash_history
    rm -rf $HOME/.zsh_history
}



# Get archi, even Rosetta emulation
# 
# Usage
# autodetectArchitecture
# 
function autodetectArchitecture() {
    
    # Using UNIX uname
    arch_name="$(uname -m)"
    
    if [ "${arch_name}" = "arm64" ]
    then
        echo "Auto-detect: Native ARM"
    elif [ "${arch_name}" = "x86_64" ]; then
        # Check if running under Rosetta 2 emulation on ARM
        if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]
        then
            echo "Auto-detect: Rosetta 2 emulation on ARM"
        else
            echo "Auto-detect: Native Intel"
        fi
    else
        echo "Unknown architecture: ${arch_name}"
    fi
    
}



# Compare OS / Get OS
# 
# Usage
# meetMinOS "$requiredver"
# 
function meetMinOS() {

    # Get current OS version
    currentver="$(sw_vers -productVersion)"

    # State required minimum OS
    # $requiredver get from parameter $1
    # requiredver="10.13.6"

    # Check
    if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
        echo "Greater than or equal to ${requiredver}"
    else
        echo "Less than ${requiredver}"
    fi

}



# Get URL from brew JSON file
# 
# Usage
# getURLFromBrew "$brew_cask_name"
# 
function getURLFromBrew() {
    url_json_file="https://formulae.brew.sh/api/cask/$1.json"
    url_brew_package=$(curl -s $url_json_file | python3 -c "import sys, json; print(json.load(sys.stdin)['url'])")
    echo $url_brew_package
}



# Create Folder, preventing error if exist
# 
# Usage
# createNewEmptyFolder "$folder_name"
# 
function createNewEmptyFolder() {
    if [ -d "$1" ]
    then
        rm -rf "$1"
    fi
    mkdir $1
}



# Download Installer
# 
# Usage
# downloadInstaller "$url" "$dir_installer"
# 
function downloadInstaller() {
    echo "Downloading $2 ..."
    
    # Create new folder
    createNewEmptyFolder "$2"
    
    # Download
    pushd $2
    curl -L -O "$1"
    popd
    
    echo "... Done Downloading $2"
}



# Install App pkg
# 
# Usage
# installAppPKG "$dir_installer"
# 
function installAppPKG() {
    echo "Installing $1 ..."
    
    # cd
    pushd "$1"
    
    # Get name
    pkgName=$(ls | egrep '\.pkg$')
    
    # Install
    sudo installer -pkg "$pkgName" -target /
    
    # cd
    popd
    
    echo "... Done Installing $1"
}








# Download .pkg to $HOME/Downloads, Install .pkg, Remove .pkg
# 
# Usage
# pkgDownloadInstall "$url_pkg"
# 
function pkgDownloadInstall() {
    pushd ~/Downloads
    curl -L -o installer.pkg "$1"
    sudo installer -pkg "installer.pkg" -target /
    rm "installer.pkg"
    popd
}



# Mount .dmg, Copy .app into /Applications, Unmount .dmg
# 
# Usage
# dmgCopyApp "$dir_installer" "$name_vol_specific"
# 
function dmgCopyApp() {
    hdiutil attach -quiet -nobrowse -noverify "$1/$(ls $1 | egrep '\.dmg$')"
    if [ "$2" = "" ]
    then
        name_vol="$(ls /Volumes | egrep $1'*')"
    else
        name_vol="$2"
    fi
    name_app=$(ls "/Volumes/$name_vol" | egrep '\.app$')
    sudo cp -R "/Volumes/$name_vol/$name_app" /Applications
    hdiutil detach -quiet "/Volumes/$name_vol"
    name_vol_specific=""
}



# Mount .dmg, Install .app, Unmount .dmg
# 
# Usage
# dmgInstallApp "$dir_installer" "$name_vol_specific"
# 
function dmgInstallApp() {
    hdiutil attach -quiet -nobrowse -noverify "$1/$(ls $1 | egrep '\.dmg$')"
    if [ "$2" = "" ]
    then
        name_vol="$(ls /Volumes | egrep $1'*')"
    else
        name_vol="$2"
    fi
    name_app=$(ls "/Volumes/$name_vol" | egrep '\.app$')
    name_executable=$(ls /Volumes/$name_vol/$name_app/Contents/MacOS)
    sudo /Volumes/$name_vol/$name_app/Contents/MacOS/name_executable
    # open "/Volumes/$name_vol/$name_app"
    hdiutil detach -quiet "/Volumes/$name_vol"
    name_vol_specific=""
}



# Appendix

