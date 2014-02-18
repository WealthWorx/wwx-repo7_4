set NOPAUSE=true
pushd %~dp0
call jboss-cli.bat --user=@jboss.management.user.username@ --password=@jboss.management.user.password@ --connect command=:shutdown
popd
