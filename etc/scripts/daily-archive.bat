SET CURDIR=%CD%
SET APPIAN_SOURCE=@appian.home@
cd %APPIAN_SOURCE%/_admin/_scripts/tools/datamaintenance/antScripts

REM use this file as an example to daily archive processes
REM Write down the model names that correspond to each model id
REM 4000 = Main Process
REM 4001 = Sub Process 1
REM 4002 = Sub Process 2

REM The following line would archive all instances of process models 4000, 4001 
REM and 4002 which have been completed/cancelled
REM bulk-archive.bat -t30 4001 4002 4003 >> ..\..\logs\bulk_archive.log

REM The following line would archive all instances of process models 4000, 4001 
REM and 4002 which have been completed/cancelled for at least 30 days.  
REM bulk-archive.bat 4001 4002 4003 >> ..\..\logs\bulk_archive.log

cd %CURDIR%