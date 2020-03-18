package com.iisigroup.sqldeploy;


import com.iisigroup.sqldeploy.model.SQL;
import com.iisigroup.sqldeploy.util.ProjectSqlFileUtil;
import com.iisigroup.sqldeploy.util.SqlFileProcessor;
import com.java.sqlconverter.model.SqlServerConfig;
import org.apache.commons.io.FileUtils;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.LifecyclePhase;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Goal which create deploy SQL file.
 */
@Mojo(name = "gen-sql", defaultPhase = LifecyclePhase.PACKAGE)
public class SqlGenMojo extends AbstractMojo {

    /**
     * Location of scan folder
     */
    @Parameter(property = "scanFolder", required = true)
    private File[] scanFolder;

    /**
     * Location of place deploy sql folder
     */
    @Parameter(property = "deployFolder", required = true)
    private File deployFolder;

    /**
     * 產出Deploy SQL 檔名format，會替換掉{yyyyMMdd}變成今日日期
     * ex: DeployUAT{yyyyMMdd}.sql -> DeployUAT20180828.sql
     */
    @Parameter(defaultValue = "DeployUAT{yyyyMMdd}.sql", property = "fileFormat")
    private String fileFormat;

    @Parameter(property = "scanDate")
    private String scanDate;

    @Parameter(defaultValue = "false", property = "initCreate")
    private boolean initCreate;

    @Parameter(defaultValue = "UTF-8", property = "outputCharset")
    private String outputCharset;


    // SQL server connection config
    @Parameter(property = "host")
    private String host;

    @Parameter(property = "port")
    private String port;

    @Parameter(property = "userName")
    private String userName;

    @Parameter(property = "password")
    private String password;


    public void execute() throws MojoExecutionException {
        SqlServerConfig dbConfg = new SqlServerConfig(host, port, userName, password);

        //支援多資料夾傳入，將檔案先copy到temp folder
        // TODO 目前不支援同檔名辨識，會被覆蓋！ 會影響到deployTable file正確性。
        final File temp = FileUtils.getTempDirectory();
        final File tempDirectory = new File(temp, UUID.randomUUID().toString());
        tempDirectory.mkdirs();
        System.out.println("==== All folder list files ====");
        for (File folder : scanFolder) {
            if(folder == null || !folder.isDirectory() || deployFolder == null || !deployFolder.isDirectory()) {
                throw new MojoExecutionException("make sure scanFolder and deployFolder is correct!");
            }
            System.out.println("Folder: " + folder.getName());
            final List<File> list = Arrays.asList(Objects.requireNonNull(folder.listFiles()));
            System.out.println("Files: ");
            for (File file : Objects.requireNonNull(folder.listFiles())) {
                System.out.println(file.getAbsolutePath());
                try {
                    FileUtils.copyFileToDirectory(file, tempDirectory);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        System.out.println("==== ==================== ====");

        SqlFileProcessor fileProcessor = new SqlFileProcessor(fileFormat, dbConfg, tempDirectory, deployFolder);
        List<SQL> sqlList = new ArrayList<>();
        if(deployFolder != null && !deployFolder.exists()) {
            deployFolder.mkdirs();
        }

        //SQL string to Model
        System.out.println("Ready to scan SQL file...");
        try {
            Map<String, List<String>> allSqls = fileProcessor.getAllSqls(Objects.requireNonNull(tempDirectory.listFiles()));
            Set<String> keys = allSqls.keySet();
            for (String key : keys) {
                SQL sql = fileProcessor.convertStrToModel(key, allSqls.get(key));
                sqlList.add(sql);
            }
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }

        //最後日期
        Date deploySqlDate = ProjectSqlFileUtil.getLastDeploySqlDate(deployFolder);

        //指定日期
        if(scanDate != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            try {
                deploySqlDate = dateFormat.parse(scanDate);
                System.out.println("Assign date is " + deploySqlDate);
            } catch (ParseException e) {
                //do nothing
            }
        }

        //init產生
        if(initCreate) {
            System.out.println("Ready to create deploy init SQL...");
            try {
                fileProcessor.createInitSql(sqlList, deployFolder, outputCharset);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        //產生deploy SQL
        System.out.println("Ready to create deploy SQL...");
        try {
            fileProcessor.createUpdateSql(sqlList, deploySqlDate, deployFolder, outputCharset);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
