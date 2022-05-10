#!/bin/sh
# Functions

# Download
# curl -L -O "https://raw.githubusercontent.com/tedzhangzg/scripts/main/functions.sh"
# dot sourced into all scripts
# source ./functions.sh



# Clear Terminal History
function clrHist() {
    rm -rf ~/.bash_history
    rm -rf ~/.zsh_history
}


# Get archi, even Rosetta emulation
function getarch() {
    
    # Using UNIX uname
    arch_name="$(uname -m)"
    
    if [ "${arch_name}" = "x86_64" ]
    then
        # Check if running under Rosetta 2 emulation on ARM
        if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]
        then
            echo "Architecture autodetech: Rosetta 2 emulation on ARM"
        else
            echo "Architecture autodetech: Native Intel"
        fi 
    elif [ "${arch_name}" = "arm64" ]; then
        echo "Architecture autodetech: Native ARM"
    else
        echo "Unknown architecture: ${arch_name}"
    fi
    
}



# Download .pkg, Install .pkg
# 
# Usage
# pkgdlinst "$link_to_pkg"
# 
function pkgdlinst() {
    pushd ~/Downloads
    curl -L -o installer.pkg "$1"
    sudo installer -pkg "installer.pkg" -target /
    rm "installer.pkg"
    popd
}



# Mount .dmg, Copy .app into /Applications
# 
# Usage
# dmgcpapp "$dir_installer" "$name_vol_specific"
# 
function dmgcpapp() {
    hdiutil attach -quiet -nobrowse -noverify "$1/$(ls $1 | egrep '\.dmg$')"
    if [ "$2" = "" ]
    then
        name_vol="$(ls /Volumes | egrep $1'*')"
    else
        name_vol="$2"
    fi
    name_app=$(ls "/Volumes/$name_vol" | egrep '\.app$')
    if [ -d "/Applications/$name_app" ]
    then
        sudo rm -rf "/Applications/$name_app"
    fi
    sudo cp -R "/Volumes/$name_vol/$name_app" /Applications
    hdiutil detach -quiet "/Volumes/$name_vol"
    name_vol_specific=""
}



# Mount .dmg, Open .app to install
# 
# Usage
# dmgopinsapp "$dir_installer" "$name_vol_specific"
# 
function dmgopinsapp() {
    hdiutil attach -quiet -nobrowse -noverify "$1/$(ls $1 | egrep '\.dmg$')"
    if [ "$2" = "" ]
    then
        name_vol="$(ls /Volumes | egrep $1'*')"
    else
        name_vol="$2"
    fi
    name_app=$(ls "/Volumes/$name_vol" | egrep '\.app$')
    open "/Volumes/$name_vol/$name_app"
    hdiutil detach -quiet "/Volumes/$name_vol"
    name_vol_specific=""
}



# Compare macOS version
function meetMinOS() {

    # Get current OS version
    currentver="$(sw_vers -productVersion)"

    # State required minimum OS
    # requiredver="10.13.6"

    # Check
    if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
        echo "Greater than or equal to ${requiredver}"
    else
        echo "Less than ${requiredver}"
    fi

}


