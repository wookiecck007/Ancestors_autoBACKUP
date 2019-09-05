#     __          ______   ____  _  _______ ______       __      ____     ___  
#     \ \        / / __ \ / __ \| |/ |_   _|  ____|      \ \    / /_ |   / _ \ 
#      \ \  /\  / | |  | | |  | | ' /  | | | |__          \ \  / / | |  | | | |
#       \ \/  \/ /| |  | | |  | |  <   | | |  __|          \ \/ /  | |  | | | |
#        \  /\  / | |__| | |__| | . \ _| |_| |____          \  /   | | _| |_| |
#         \/  \/   \____/ \____/|_|__|_____|______|          \/    |_|(_)\___/ 
#         /\                      | |                                        
#        /  \   _ __   ___ ___ ___| |_ ___  _ __ ___                         
#       / /\ \ | '_ \ / __/ _ / __| __/ _ \| '__/ __|                        
#      / ____ \| | | | (_|  __\__ | || (_) | |  \__ \                        
#     /_/    \_|_| |_|\___\___|___/\__\___/|_|  |___/                        
#########
#	This is a small powershell backup tool
#
#	To use - Just run the powershell script whilst playing the game.
#  	Set the variable below - under globaL Variables or Use the GUI pop-up when running the Powershell script.    

###Global Variables
#USE UI TO ENTER VALUES BELOW / ELSE MANUAL (TRUE or FALSE)
$enableUI = 'TRUE'
#MAXIMUM AMOUNT OF BACKUP SAVES PER SAVE SELECTED (ANY NUMBER BIGGER THAN 1 AND LESS THAN 100)
$maxSAVES = 5
#SAVE SLOT TO BACKUP // THE CURRENT SAVE SLOT BEING PLAYED 0 TO 4 WITH 4 BEING THE LAST SAVE SLOT		
$SaveSlot = 5
#SAVE SLOT TO ADD THE LAST SAVED BACKUP TO // THE BACKUP SAVE LOADED TO GAME 0 TO 4 WITH 4 BEING THE LAST SAVE SLOT
$BackupSlot = 2
##To cancel this feature then make BackupSlot = SaveSlot



###	DO NOT EDIT BEYOND THIS (OR DO - BUT IF YOU DELETE YOUR 300HOUR SAVE, THEN GOOD LUCK)
if($enableUI -eq 'TRUE'){
	clear
	echo "Use default values?`r`n`r`nMax Saves`t5`r`nSave slot`t5`r`nBackup slot`t2`r`n`r`nEnter to continue`r`n"
	$defaults = Read-Host -Prompt 'N or No otherwise'
	if($defaults){
		clear
		$maxSAVES = Read-Host -Prompt 'Input maximum saves to back up (1 to 20):'
		$maxSAVES = $maxSAVES -as [int]
		if(-not(($maxSAVES -ge 1) -and ($maxSAVES -le 20))){
			$maxSAVES = 2
		}
		clear
		echo "Please input the save slot that will be backed up (1 to 5)`r`n`r`n`r`nFor Example: If you are to select Slot 5 you will `r`nbe playing your save game from the following slot:`r`n`r`n`r`nSLOT 1 ->`t`t%%%%%%%%%%%%%%%%`r`n`r`nSLOT 2 ->`t`t%%%%%%%%%%%%%%%%`r`n`r`nSLOT 3 ->`t`t%%%%%%%%%%%%%%%%`r`n`r`nSLOT 4 ->`t`t%%%%%%%%%%%%%%%%`r`n`r`nSLOT 5 ->`t      ->%%CURRENT SAVE%%<-`r`n`r`n"
		$SaveSlot = Read-Host -Prompt 'Selected Backup Slot'
		$SaveSlot = $SaveSlot -as [int]
		if(-not(($SaveSlot -ge 1) -and ($SaveSlot -le 5))){
			$SaveSlot = 5
		}
		clear
		echo "Input the backup slot (last save that will be loaded)(1 to 5)`r`n`r`n`r`nFor Example: If you are to select the backup Slot 2 `r`nand the play slot as 5 you will see the following:`r`n`r`n`r`nSLOT 1 ->`t`t%%%%%%%%%%%%%%%%`r`n`r`nSLOT 2 ->`t`t%%PREVIOUS SAVE%`r`n`r`nSLOT 3 ->`t`t%%%%%%%%%%%%%%%%`r`n`r`nSLOT 4 ->`t`t%%%%%%%%%%%%%%%%`r`n`r`nSLOT 5 ->`t      ->%%CURRENT SAV%%<-`r`n`r`n`r`n`r`n#  #  #  #  #  #  #  !WARNING!#  #  #  #  #  #  #  `r`n`r`nIF YOU SELECT A SLOT WITH A EXISTING SAVED GAME `r`nTHEN THIS WILL ERASE YOU EXISTING SAVE GAME. `r`n`r`n`t\/ TO DISABLE THIS FEATURE \/`r`nSELECT THE SAME SLOT AS YOUR SAVE SLOT`r`n`r`n"
		$BackupSlot = Read-Host -Prompt 'Selected Save load Slot'
		$BackupSlot = $BackupSlot -as [int]
		if(-not(($mSAVES -ge 1) -and ($mSAVES -le 5))){
			$mSAVES = 5
		}
		clear
		echo "Please confirm the following:`r`n`r`n`r`n"
		echo "Save slot being backed up:`t`t$SaveSlot`r`n(File: $global:currentSAVE)`r`n"
		echo "Backup slot being loaded:`t`t$BackupSlot`r`n(File: $global:backupSAVE)`r`n"
		echo "Maximum amount of saves to keep:`t$maxSAVES`r`n(Folder: $global:SavePath)`r`n`r`n"
		$confirm = Read-Host -Prompt 'Confirm with Y or YES'
		if(-not(($confirm -eq 'Y' ) -or ($confirm -eq 'YES' ))){
			exit
		}
	}
}
$global:mSAVES = $maxSAVES
$global:currentSAVE = "Savegame$($SaveSlot-1)"	
$global:backupSAVE = "Savegame$($BackupSlot-1)"
$global:SavePath = "$env:LOCALAPPDATA\Ancestors\Saved\SaveGames"
cd $global:SavePath
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "$env:LOCALAPPDATA\Ancestors\Saved\SaveGames"
$watcher.Filter = "$global:currentSAVE.sav"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true  
$action = {
			cd $global:SavePath
				function KEEP-Max-Saves {
				cd $global:SavePath
					if((Get-ChildItem $global:currentSAVE*).Name.GetType().Name -eq "Object[]"){
						if((Get-ChildItem $global:currentSAVE*).Name.Length -1 -gt $global:mSAVES){
							Remove-Item (Get-ChildItem $global:currentSAVE*).Name[0]
							KEEP-Max-Saves
						}
					}
				}
				function Last-Save-Load {
				cd $global:SavePath
					if((Get-ChildItem $global:currentSAVE*).Name.GetType().Name -eq "Object[]"){
						Copy-Item (Get-ChildItem $global:currentSAVE*).Name[(Get-ChildItem $global:currentSAVE*).Name.Length - 3]  "$global:SavePath\$global:backupSAVE.sav" -Force
					}
				}
			Start-sleep 1
			Copy-Item "$global:currentSAVE.sav" "$global:currentSAVE-$(Get-Date -Format 'yy-MM-dd_HH-mm').bckp"
			if($global:currentSAVE -ne $global:backupSAVE){
				Last-Save-Load
			}
			KEEP-Max-Saves
}
echo "Save game checker"
echo "Awaiting changes to $currentSAVE.sav at $env:LOCALAPPDATA\Ancestors\Saved\SaveGames"
Register-ObjectEvent $watcher "Changed" -Action $action
clear
echo "Backup running:`r`n`r`n`r`n"
echo "Save slot being backed up:`t`t$SaveSlot`r`n(File: $global:currentSAVE)`r`n"
echo "Backup slot being loaded:`t`t$BackupSlot`r`n(File: $global:backupSAVE)`r`n"
echo "Maximum amount of saves to keep:`t$maxSAVES`r`n(Folder: $global:SavePath)`r`n`r`n"
echo "The game should lauch now. (If not launched please run it manually)`r`n`r`n"
Start-Process "com.epicgames.launcher://apps/Amaranth?action=launch&silent=true"
echo "Close this window to stop the backup process"
while ($true) {sleep 1}
