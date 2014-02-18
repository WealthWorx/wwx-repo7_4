echo off
set project=
set /p project=Enter the project name (or 'trunk' if using the psbuild trunk): 
if not '%project%'=='trunk' set project=branches/%project%

TortoiseProc.exe /command:export /path:https://frost.appian.com/svn/psshared/psbuild/%project%/ /closeonend:1
TortoiseProc.exe /command:add /path:.. /closeonend:1
echo DONE! Now commit the new files and folders to your repository.
pause
