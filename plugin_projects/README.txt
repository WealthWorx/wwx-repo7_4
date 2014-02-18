Each plugin should have its own folder inside plugin_projects.  The build will automatically create the plugin jar for each folder and deploy them separately to the target _admin\plugins folder.

Every plugin folder should have the following structure:
- <root>                     : appian-plugin.xml, .classpath, .project, build.xml, any README or help files
- <root>\src\main\java       : all source classes (Java)
- <root>\src\main\resources  : all resource bundles
- <root>\lib                 : any jars necessary for execution of the plugin.  Do not include appian-suiteapi.jar, appian-type.jar, appian-services.jar, appian-common.jar
- <root>\lib-compile         : any jars necessary for compilation of the plugin but not for execution (e.g., jars provided by the app server)
