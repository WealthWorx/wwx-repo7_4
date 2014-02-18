rem ### -*- batch file -*- ######################################################
rem #                                                                          ##
rem #  JBoss Bootstrap Script Configuration                                    ##
rem #                                                                          ##
rem #############################################################################

rem This batch file is executed by standalone.bat to initialize the environment 
rem variables that standalone.bat uses. Use standalone.custom.bat to add additional 
rem custom java opts or to change user mem args.

rem When JBoss shuts down, this prevents "Press any key to continue..."
set NOPAUSE=true

rem JBoss Command Line Options

rem This references the Appian ear in URL form, used as a deploy directory
set "APPIAN_HOME_EAR=@appian.home@/runtime_ear"

rem Suggested default memory settings for Oracle JVM
set USER_MEM_ARGS=-Xms2048m -Xmx2048m -XX:PermSize=256m -XX:MaxPermSize=256m 

rem URI Encoding: The setting for URI encoding is only system-wide
set "URI_ENC=-Dorg.apache.catalina.connector.URI_ENCODING=UTF-8"

rem Set appserver to GMT timezone
set JAVA_TIMEZONE=GMT

rem JBoss is running as a server, so no need for graphics support
set JAVA_GRAPHICS_HEADLESS=true

rem With Oracle JVMs reduce the RMI GCs to once per hour
set JAVA_GC_SETTINGS=-Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 -XX:+UseConcMarkSweepGC

rem Clustering and customer-configured options

if "%OS%" == "Windows_NT" (
  set "DIRECTORY_NAME=%~dp0%"
) else (
  set DIRECTORY_NAME=.\
)

rem Call an optional configuration file with customer-configured options
if "x%STANDALONE_CUSTOM%" == "x" (   
   set "STANDALONE_CUSTOM=%DIRECTORY_NAME%standalone.custom.bat"
)
if exist "%STANDALONE_CUSTOM%" (
   echo Calling "%STANDALONE_CUSTOM%"
   call "%STANDALONE_CUSTOM%" %*
)

rem Java Options
if "x%CUSTOM_JAVA_OPTS%" == "x" (
  set "JAVA_OPTS=%USER_MEM_ARGS% %JAVA_GC_SETTINGS% %URI_ENC% -Duser.timezone=%JAVA_TIMEZONE% -Djava.awt.headless=%JAVA_GRAPHICS_HEADLESS% -Djava.net.preferIPv4Stack=true"
) else (
  set "JAVA_OPTS=%USER_MEM_ARGS% %JAVA_GC_SETTINGS% %URI_ENC% -Duser.timezone=%JAVA_TIMEZONE% -Djava.awt.headless=%JAVA_GRAPHICS_HEADLESS% -Djava.net.preferIPv4Stack=true %CUSTOM_JAVA_OPTS%"
)

rem Appian Deployment
set "JAVA_OPTS=%JAVA_OPTS% -Dappian.home.ear=%APPIAN_HOME_EAR%"

rem Warn when resolving remote XML DTDs or schemas.
set "JAVA_OPTS=%JAVA_OPTS% -Dorg.jboss.resolver.warning=true"

rem Set the default configuration file to use if -c or --server-config are not used
set "JAVA_OPTS=%JAVA_OPTS% -Djboss.server.default.config=standalone.xml"

rem Sample JPDA settings for remote socket debugging
rem set "JAVA_OPTS=%JAVA_OPTS% -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n"

rem Sample JPDA settings for shared memory debugging 
rem set "JAVA_OPTS=%JAVA_OPTS% -Xrunjdwp:transport=dt_shmem,address=jboss,server=y,suspend=n"
