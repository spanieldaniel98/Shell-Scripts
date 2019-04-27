#>>> Script that renders every track in Sonic Adventure DX PC Windy Valley 1 for the authentic '08 <<<#
#>>> pirate version experience (or reverts the game back to normal if this has already been done)! <<<#

# Prompt user to input SADX install directory (containing sonic.exe and subfolders)
$installPath = Read-Host -Prompt "Enter the directory of the folder in which SADX is installed (i.e. where sonic.exe and system, savedata etc. folders should be)"

# Initialise path variables for audio tracks + backup
$wmaPath = $installPath + "\system\sounddata\bgm\wma"
$backupPath = $wmaPath + "\backup"

# If the mod has already been done, revert the game's music back to normal
if((Get-Item ($wmaPath + "\advamy.wma")).length -eq (Get-Item ($wmaPath + "\advbig.wma")).length) {
    Write-Host "Working..." -NoNewLine
    
    # Revert modified tracks to backup, delete empty backup folder
    Remove-Item ($wmaPath + "\*") -Filter *.wma
    Copy-Item ($backupPath + "\*") $wmaPath
    Remove-Item $backupPath -Recurse
    
    Write-Host " Game reverted back to normal."
}

# Else make every track Windy Valley 1
else {
    Write-Host "Working..." -NoNewLine

    # Initialise tracks and path variables
    $tracks = Get-ChildItem ($wmaPath + "\*") -Filter *.wma -Exclude wndyvly1.wma,wndyvly1-copy.wma
    $windyValleyPath = $wmaPath + "\wndyvly1.wma"
    $windyValleyCopyPath = $wmaPath + "\wndyvly1-copy.wma"
    
    # Backup original tracks
    New-Item -ItemType Directory $backupPath | Out-Null
    Copy-Item ($wmaPath + "\*") -Filter *.wma $backupPath
    
    # Replace each other track with Windy Valley 1 music
    foreach ($track in $tracks) { 
        rm $track
        Copy-Item $windyValleyPath $windyValleyCopyPath
        Rename-Item $windyValleyCopyPath $track
    }
    Write-Host " Windy Valley Edition created, enjoy!"
}