# maven-plugin-deploy-sql
This plugin help you auto gen SQL script by date, that you don't have to concern which script should give or not.

Also, transform insert script to upsert script. make that script can re-run again and again. 

## How to USE
1. Install the plugin use maven:
```
mvn install
```
2. Import to your project plugin managment:
```
<plugin>
  <groupId>com.iisigroup.sqldeploy</groupId>
  <artifactId>sql-deploy</artifactId>
  <version>${version}</version>
</plugin>
```
3. SQL sample see TEST.sql

4. Set in maven build:
```
<plugin>
  <groupId>com.iisigroup.sqldeploy</groupId>
  <artifactId>sql-deploy</artifactId>
  <executions>
    <execution>
      <goals>
        <goal>gen-sql</goal>
      </goals>
      <phase>package</phase>
      <configuration>
        <deployFolder>${project.parent.basedir}/src/DeploySQL</deployFolder>
        <scanFolder>${project.parent.basedir}/src/ddl</scanFolder>
        <outputCharset>UTF-16LE</outputCharset>
      </configuration>
    </execution>
  </executions>
</plugin>
```

