package com.iisigroup.sqldeploy;


import com.iisigroup.sqldeploy.model.SQL;
import com.iisigroup.sqldeploy.util.SqlFileProcessor;
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
@Mojo(name = "gen-sql", defaultPhase = LifecyclePhase.PACKAGE)
public class SqlGenMojo extends AbstractMojo {

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
    @Parameter(defaultValue = "DeployUAT{yyyyMMdd}.sql", property = "fileFormat")
    private String fileFormat;

    @Parameter(property = "scanDate")
    private String scanDate;

    @Parameter(defaultValue = "false", property = "initCreate")
    private boolean initCreate;



    public void execute() throws MojoExecutionException {
        SqlFileProcessor fileProcessor = new SqlFileProcessor(fileFormat);
        List<SQL> sqlList = new ArrayList<>();
        if(scanFolder == null || !scanFolder.isDirectory() || deployFolder == null || !deployFolder.isDirectory()) {
            throw new MojoExecutionException("make sure scanFolder and deployFolder is correct!");
        }

        //SQL string to Model
        System.out.println("Ready to scan SQL file...");
        try {
            Map<String, List<String>> allSqls = fileProcessor.getAllSqls(scanFolder.listFiles());
            Set<String> keys = allSqls.keySet();
            for (String key : keys) {
                SQL sql = fileProcessor.convertStrToModel(key, allSqls.get(key));
                sqlList.add(sql);
            }
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }

        //最後日期
        Date deploySqlDate = this.getLastDeploySqlDate(deployFolder);

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
                fileProcessor.createInitSql(sqlList, deployFolder);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }

        //產生deploy SQL
        System.out.println("Ready to create deploy SQL...");
        try {
            fileProcessor.createUpdateSql(sqlList, deploySqlDate, deployFolder);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Date getLastDeploySqlDate(File deployFolder) {
        File[] files = deployFolder.listFiles();
        Map<Long, String> fileDateMapping = new HashMap<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

        for (File file : files) {
            String fileName = file.getName();
            String regExStr = "^Deploy.*([0-9]{8}).*\\.sql";
            Pattern pattern = Pattern.compile(regExStr);
            Matcher matcher = pattern.matcher(fileName);
            if(matcher.find()) {
                String dateStr = matcher.group(1);
                // 今日的deploy file要略過
                String todayStr = dateFormat.format(new Date());
                if(todayStr.equals(dateStr)) {
                    System.out.println("found today deploy SQL, skip it!");
                    continue;
                }
                Date date = null;
                try {
                    date = dateFormat.parse(dateStr);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                fileDateMapping.put(date.getTime(), fileName);
            }
        }
        if(fileDateMapping.size() == 0) {
            System.out.println("not found any deploy file!");
            return new Date(0);
        }
        long lastDate = 0;
        for (Long dateTime : fileDateMapping.keySet()) {
            if(dateTime > lastDate) {
                lastDate = dateTime;
            }
        }
        Date deploySqlDate = new Date(lastDate);
        String yyyyMMdd = new SimpleDateFormat("yyyyMMdd").format(deploySqlDate);
        System.out.println("Last deploy date is " + yyyyMMdd);
        return deploySqlDate;
    }
    



}
