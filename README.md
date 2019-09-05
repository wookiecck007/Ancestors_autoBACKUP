# Ancestors_autoBACKUP
TLDR; Downlaod and run the 1click batch file and follow the prompts (THis requires Internet connection for latest code)
else, Download the ps1 file to run the code locally.

```
     __          ______   ____  _  _______ ______       __      ____     ___  
     \ \        / / __ \ / __ \| |/ |_   _|  ____|      \ \    / /_ |   / _ \ 
      \ \  /\  / | |  | | |  | | ' /  | | | |__          \ \  / / | |  | | | |
       \ \/  \/ /| |  | | |  | |  <   | | |  __|          \ \/ /  | |  | | | |
        \  /\  / | |__| | |__| | . \ _| |_| |____          \  /   | | _| |_| |
         \/  \/   \____/ \____/|_|__|_____|______|          \/    |_|(_)\___/ 
         /\                      | |                                        
        /  \   _ __   ___ ___ ___| |_ ___  _ __ ___                         
       / /\ \ | '_ \ / __/ _ / __| __/ _ \| '__/ __|                        
      / ____ \| | | | (_|  __\__ | || (_) | |  \__ \                        
     /_/    \_|_| |_|\___\___|___/\__\___/|_|  |___/  
```
  This is a small powershell backup tool.
  **Download the AncestorsBackup.ps1** to **any directory** and **Run with powershell** **before starting the game**
  Auto Backup Powershell script for Ancestors V1.0 Windows
	To use - Just run the powershell script whilst playing the game.
  
Set the following variables in the powershell script as needed. (Using notepad or similar) Or Use the GUI pop-up when running the Powershell script.

1. Enable/Disable UI interaction for script (TRUE or FALSE)
```
$enableUI = 'TRUE'
```
2. MAXIMUM AMOUNT OF BACKUP SAVES PER SAVE SELECTED (ANY NUMBER BIGGER THAN 1 AND LESS THAN 100)
```
$maxSAVES = 5
```

3. SAVE SLOT TO BACKUP // THE CURRENT SAVE SLOT BEING PLAYED 0 TO 4 WITH 4 BEING THE LAST SAVE SLOT		
```
$SaveSlot = 5
```

4. SAVE SLOT TO ADD THE LAST SAVED BACKUP TO // THE BACKUP SAVE LOADED TO GAME 0 TO 4 WITH 4 BEING THE LAST SAVE SLOT
**To cancel this feature then make _BackupSlot = SaveSlot_**
```
$BackupSlot = 2
```
