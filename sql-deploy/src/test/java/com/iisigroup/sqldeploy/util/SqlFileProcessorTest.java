package com.iisigroup.sqldeploy.util;

import com.iisigroup.sqldeploy.model.SQL;
import org.junit.Assert;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class SqlFileProcessorTest {
    SqlFileProcessor sqlFileProcessor = new SqlFileProcessor("DeployUAT{yyyyMMdd}.sql");
    @Test
    public void test_full_flow_read_to_write() throws IOException, ParseException {
        File testScanFolder = new File("target/test-classes/ForScan");
        File testDeployFolder = new File("target/test-classes/ForDeploy");
        Map<String, List<String>> allSqls = sqlFileProcessor.getAllSqls(testScanFolder.listFiles());
        Assert.assertNotNull(allSqls);

        List<SQL> sqlList = new ArrayList<>();
        Set<String> keys = allSqls.keySet();
        for (String key : keys) {
            SQL sql = sqlFileProcessor.convertStrToModel(key, allSqls.get(key));
            Assert.assertNotNull(sql);
            sqlList.add(sql);
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        sqlFileProcessor.createUpdateSql(sqlList, dateFormat.parse("20180821"), testDeployFolder);
        String todayStr = dateFormat.format(new Date());
        String fileName = "DeployUAT" + todayStr + ".sql";
        File deployFile = new File(testDeployFolder, fileName);

        Assert.assertTrue(deployFile.exists());


        sqlFileProcessor.createInitSql(sqlList, testDeployFolder);
        String initFileName = "DeployUAT_Init.sql";
        File deployInitFile = new File(testDeployFolder, initFileName);
        Assert.assertTrue(deployInitFile.exists());

    }





}