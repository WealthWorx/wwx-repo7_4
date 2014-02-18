SET CURDIR=%CD%
SET APPIAN_SOURCE=@appian.home@
SET APPIAN_DEST=@appian.bak.dir@
SET BAK_DIR=%date:~-4%%date:~4,2%%date:~7,2%-auto
SET APPIAN_BAK_DIR=%APPIAN_DEST%\%BAK_DIR%

REM The number of kdbs will reflect how many kdbs will remain in the server directory after the script is done.
REM The number of kdbs that will be copied into %APPIAN_BAK_DIR% will be one kdb less than the specified number.
SET NUMBER_KDBS=@kdb.num.maintenance@

cd %APPIAN_SOURCE%/_admin/_scripts/tools/datamaintenance/antScripts
call ant -f aedeletefiles.xml -Dae.source.location="%APPIAN_SOURCE%" -Dkdb.num="%NUMBER_KDBS%" -Dbatchmode="y" -Dkdb.invertselect="y" -Dkdb.high="n" 
call ant -f aecopyfiles.xml -Dae.source.location="%APPIAN_SOURCE%" -Dae.dest.location="%APPIAN_BAK_DIR%" -Dae.datadelete="n" -Dae.copycontents="n" -Dkdb.num="1" -Dkdb.invertselect="y" -Dbatchmode="y"
cd %CURDIR%