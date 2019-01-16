package com.iisigroup.sqldeploy;


import com.iisigroup.sqldeploy.model.SQL;
import com.iisigroup.sqldeploy.util.ProdSqlFileProcessor;
import com.iisigroup.sqldeploy.util.ProjectSqlFileUtil;
import com.iisigroup.sqldeploy.util.SqlFileProcessor;
import com.java.sqlconverter.model.SqlServerConfig;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Goal which create deploy SQL file.
 */
@Mojo(name = "gen-prod-sql", defaultPhase = LifecyclePhase.PACKAGE)
public class ProdSqlGenMojo extends AbstractMojo {

    /**
     * Location of scan folder
     */
    @Parameter(property = "scanFolder", required = true)
    private File scanFolder;

    /**
     * Location of place deploy sql folder
     */
    @Parameter(property = "deployFolder", required = true)
    private File deployFolder;

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


    public void execute() throws MojoExecutionException {
        List<SQL> sqlList = new ArrayList<>();
        if(scanFolder == null || !scanFolder.isDirectory() || deployFolder == null || !deployFolder.isDirectory()) {
            throw new MojoExecutionException("make sure scanFolder and deployFolder is correct!");
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

        //最後日期
        Date deploySqlDate = ProjectSqlFileUtil.getLastDeploySqlDate(deployFolder);

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
        StringBuilder allSqls = ProdSqlFileProcessor.getAllSql(dateFormat.format(deploySqlDate), scanFolder.getAbsolutePath(), inputCharset);

        //產生deploy SQL
        System.out.println("Ready to create deploy Prod SQL...");
        String fileName = fileFormat.replace("{yyyyMMdd}", dateFormat.format(new Date()));
        File createFile = new File(deployFolder, fileName);
        ProdSqlFileProcessor.writeFile(allSqls, createFile, outputCharset);

        System.out.println("create deploy Prod SQL done!");
    }
}
