package com.iisigroup.sqldeploy;


import com.iisigroup.sqldeploy.model.SQL;
import com.iisigroup.sqldeploy.util.ProdSqlFileProcessor;
import com.iisigroup.sqldeploy.util.ProjectSqlFileUtil;
import org.apache.commons.io.FileUtils;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Goal which create deploy SQL file.
 */
@Mojo(name = "gen-prod-sql")
public class ProdSqlGenMojo extends AbstractMojo {

    /**
     * Location of scan folder
     */
    @Parameter(property = "scanUatFolder", required = true)
    private File[] scanUatFolders;

    /**
     * Location of place deploy sql folder
     */
    @Parameter(property = "deployProdFolder", required = true)
    private File deployProdFolder;

    /**
     * 產出Deploy SQL 檔名format，會替換掉{yyyyMMdd}變成今日日期
     * ex: DeployUAT{yyyyMMdd}.sql -> DeployUAT20180828.sql
     */
    @Parameter(defaultValue = "DeployPROD{yyyyMMdd}.sql", property = "fileFormat")
    private String fileFormat;

    @Parameter(property = "scanDate")
    private String scanDate;

    @Parameter(defaultValue = "false", property = "initCreate")
    private boolean initCreate;

    @Parameter(defaultValue = "UTF-8", property = "outputCharset")
    private String outputCharset;

    @Parameter(defaultValue = "UTF-8", property = "inputCharset")
    private String inputCharset;

    /**
     * Location of place deploy citi sql folder
     */
    @Parameter(property = "changeSqlFolder")
    private File changeSqlFolder;

    @Parameter(property = "changeSqlName")
    private String changeSqlName;

    public ProdSqlGenMojo() {
    }

    public ProdSqlGenMojo(File[] scanUatFolders, File deployProdFolder, String fileFormat, String scanDate,
                          boolean initCreate, String outputCharset, String inputCharset, File changeSqlFolder,
                          String changeSqlName) {
        this.scanUatFolders = scanUatFolders;
        this.deployProdFolder = deployProdFolder;
        this.fileFormat = fileFormat;
        this.scanDate = scanDate;
        this.initCreate = initCreate;
        this.outputCharset = outputCharset;
        this.inputCharset = inputCharset;
        this.changeSqlFolder = changeSqlFolder;
        this.changeSqlName = changeSqlName;
    }

    public void execute() throws MojoExecutionException {
        List<SQL> sqlList = new ArrayList<>();
        if(scanUatFolders == null || deployProdFolder == null) {
            throw new MojoExecutionException("make sure scanUatFolder and deployProdFolder have values!");
        }
        for (File scanUatFolder : scanUatFolders) {
            System.out.println("scanUatFolder: " + scanUatFolder.getAbsolutePath());
            if(!scanUatFolder.isDirectory()) {
                throw new MojoExecutionException("make sure scanUatFolder is correct folder!");
            }
        }
        System.out.println("deployProdFolder: " + deployProdFolder.getAbsolutePath());
        if(!deployProdFolder.exists() || !deployProdFolder.isDirectory()) {
            System.out.println("create deployProdFolder: " + deployProdFolder.getAbsolutePath());
            deployProdFolder.mkdirs();
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

        //最後日期
        Date deploySqlDate = ProjectSqlFileUtil.getLastDeploySqlDate(deployProdFolder);

        //指定日期
        if(scanDate != null) {
            try {
                deploySqlDate = dateFormat.parse(scanDate);
                System.out.println("Assign date is " + deploySqlDate);
            } catch (ParseException e) {
                //do nothing
            }
        }

        // 取得指定日期之後的SQL file
        File tempDirectory = FileUtils.getTempDirectory();
        File temp = new File(tempDirectory, String.valueOf(new Random().nextInt(9999)));
        for (File scanUatFolder : scanUatFolders) {
            for (File file : scanUatFolder.listFiles()) {
                try {
                    FileUtils.copyFileToDirectory(file, temp, true);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        StringBuilder allSqls = ProdSqlFileProcessor.getAllSql(dateFormat.format(deploySqlDate), temp.getAbsolutePath(), inputCharset);

        // diff SQL get update script
        allSqls.append(ProdSqlFileProcessor.getDiffSqlContent(deploySqlDate, temp));

        //產生deploy SQL
        System.out.println("Ready to create deploy Prod SQL...");
        String fileName = fileFormat.replace("{yyyyMMdd}", dateFormat.format(new Date()));
        File createFile = new File(deployProdFolder, fileName);
        ProdSqlFileProcessor.writeFile(allSqls, createFile, outputCharset);

        //將產出的SQL複製改名到changes.sql
        if (changeSqlFolder != null && changeSqlName != null) {
            final File changeSqlFile = new File(changeSqlFolder, changeSqlName);
            try {

                FileUtils.copyFile(createFile, changeSqlFile, false);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        System.out.println("Prod SQL info: " + createFile.getAbsolutePath());
        System.out.println("Create deploy Prod SQL done!");
    }

}
