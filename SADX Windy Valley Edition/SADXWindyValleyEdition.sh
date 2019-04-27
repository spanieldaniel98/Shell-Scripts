#!/bin/sh
# Note: to replace Windows line endings with Unix ones (i.e. CRLF -> LF) in this file, 
# run the following command in the command line (in this script's saved directory): 
# sed -i.bak 's/\r$//' SADXWindyValleyEdition.sh
#>>> Script that renders every track in Sonic Adventure DX PC Windy Valley 1 for the authentic '08 <<<#
#>>> pirate version experience (or reverts the game back to normal if this has already been done)! <<<#
# Prompt user to input SADX install directory (containing sonic.exe and subfolders)
read -p "Enter the directory of the folder in which SADX is installed (i.e. where sonic.exe and system, savedata etc. folders should be)" installPath
# Initialise path variables for audio tracks + backup
wmaPath="$installPath/system/sounddata/bgm/wma"
backupPath="$wmaPath/backup"
# If the mod has already been done, revert the game's music back to normal
if [ $(stat -c %s "$wmaPath/advamy.wma") -eq $(stat -c %s "$wmaPath/advbig.wma") ]; then
    printf "Working..."
    # Revert modified tracks to backup, delete empty backup folder
    rm "$wmaPath"/*.wma
    cp -a "$backupPath"/. "$wmaPath"
    rm -r "$backupPath"
    printf " Game reverted back to normal."
# Else make every track Windy Valley 1    
else
    printf "Working..."
    # Initialise tracks and path variables
    tracks=$(find "$wmaPath" -name "*.wma" -not -name "wndyvly1*")
    windyValleyPath="$wmaPath/wndyvly1.wma"
    windyValleyCopyPath="$wmaPath/wndyvly1-copy.wma"
    # Backup original tracks
    mkdir "$backupPath" > /dev/null
    cp -a "$wmaPath"/*.wma "$backupPath"
    # Replace each other track with Windy Valley 1 music
    for track in $tracks; do
        rm "$track"
        cp "$windyValleyPath" "$windyValleyCopyPath"
        mv "$windyValleyCopyPath" "$track"
    done
    printf " Windy Valley Edition created, enjoy!"
fi