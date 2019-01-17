package com.iisigroup.sqldeploy;


import com.iisigroup.sqldeploy.model.SQL;
import com.iisigroup.sqldeploy.util.ProdSqlFileProcessor;
import com.iisigroup.sqldeploy.util.ProjectSqlFileUtil;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Goal which create deploy SQL file.
 */
@Mojo(name = "gen-prod-sql")
public class ProdSqlGenMojo extends AbstractMojo {

    /**
     * Location of scan folder
     */
    @Parameter(property = "scanUatFolder", required = true)
    private File scanUatFolder;

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


    public void execute() throws MojoExecutionException {
        List<SQL> sqlList = new ArrayList<>();
        System.out.println("scanUatFolder: " + scanUatFolder.getAbsolutePath());
        if(scanUatFolder == null || !scanUatFolder.isDirectory() || deployProdFolder == null) {
            throw new MojoExecutionException("make sure scanUatFolder and deployProdFolder is correct!");
        }
        System.out.println("deployProdFolder: " + deployProdFolder.getAbsolutePath());
        if(!deployProdFolder.exists() || !deployProdFolder.isDirectory()) {
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
        StringBuilder allSqls = ProdSqlFileProcessor.getAllSql(dateFormat.format(deploySqlDate), scanUatFolder.getAbsolutePath(), inputCharset);

        //產生deploy SQL
        System.out.println("Ready to create deploy Prod SQL...");
        String fileName = fileFormat.replace("{yyyyMMdd}", dateFormat.format(new Date()));
        File createFile = new File(deployProdFolder, fileName);
        ProdSqlFileProcessor.writeFile(allSqls, createFile, outputCharset);

        System.out.println("create deploy Prod SQL done!");
    }
}
