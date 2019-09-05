@echo off
%@Try%
	@echo Downloading script.....
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/wookiecck007/Ancestors_autoBACKUP/master/AncestorsBackup.')) -ErrorVariable ProcessError; echo $ProcessError"
%@EndTry%
:@Catch
	cls
	echo Error
	echo -------------------
	echo Ensure internet conenctivity for downloading the script
	echo -------------------
	pause
:@EndCatch
