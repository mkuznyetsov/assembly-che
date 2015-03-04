##Build and Run

### Clone the Repository
```sh
git clone https://github.com/codenvy/assembly-che.git
```
### Run the script, that clones all Codenvy repositories
To run the script you need to generate an access token in your github account:
https://help.github.com/articles/creating-an-access-token-for-command-line-use/

Set github token environment variable
```sh
export GITHUB_TOKEN=[paste generated token]
```

Run the  script
```sh
./clone_codenvy.sh
```

### Build and Run Che
```sh
./build.sh
./sdk/assembly-sdk/target/tomcat-ide/bin/che.sh [ start | stop ]
```

Che will be available at ```localhost:8080```

##Add Own Extensions

There are two ways to create own Che assembly with a custom extension: automated and manual. There's no difference in terms of what needs to be done - the script does what you can do by hand to better understand the process.

###Script-Based Approach

Build your extension, copy jar to /ext directory, run extInstall.sh script and start Che:

```sh
cd ~/sdk/assembly-sdk/target/tomcat-ide/ext
cp ~/your-extension-1.1.0-SNAPSHOT.jar .
cd ..
./extInstall.sh
cd ~/sdk
./che.sh start
```
Che will be recompiled and your custom jar will be included to the bundle.

###Creating Che Assembly Manually

####Add Plug-In Dependency

Build your extension:

```sh
mvn clean install
```
Then, add your plug-in as a dependency. When re-compiling Che, the plug-in jar will be picked from your local Maven repository and included in the Che bundle. Add the dependency to:

```sh
~/sdk/assembly-ide/pom.xml
```
as:

```sh
<dependency>
  <groupId>com.your.company</groupId>
  <artifactId>helloworld-extension</artifactId>
  <version>1.0.0-SNAPSHOT</version>
</dependency>
```
Note that the dependenies have to be sorted alphabetically. The dependencies without scope provided come first, and then scope provided second. The best way here is to sort pom.xml just after adding the dependency to make sure it is OK:

```sh
mvn sortpom:sort
```

####Define a Module

Navigate to sdk/assembly-ide/src/main/resources/com/codenvy/ide and open IDE.gwt.xml which species the GWT application and defines all modules. This defines all of the models for the application. When GWT boots, it injects the classes defined in the gwt.xml file from your extension class, HellowWorldExtension. You need to add an inheritance to the extension, provided that the project gwt module is located at */src/main/resources/com/codenvy/ide/ext/helloworld/HelloWorldExtension.gwt.xml*:

```sh
cd ~/sdk/assembly-ide/src/main/resources/com/codenvy/ide
```

And add the following to IDE.gwt.xml:

```sh
<inherits name="com.codenvy.ide.ext.helloworld.HelloWorldExtension"/>
```
Name differes depending on name and location of gwt.xml of a custom extension.

Finally, rebuild Che:

```sh
mvn clean install
```

