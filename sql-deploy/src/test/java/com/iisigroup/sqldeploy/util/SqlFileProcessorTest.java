package com.iisigroup.sqldeploy.util;

import com.iisigroup.sqldeploy.model.SQL;
import com.java.sqlconverter.model.SqlServerConfig;
import org.junit.Assert;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class SqlFileProcessorTest {
    SqlServerConfig dbConfg = new SqlServerConfig("", "", "", "");
    SqlFileProcessor sqlFileProcessor = new SqlFileProcessor("DeployUAT{yyyyMMdd}.sql", dbConfg);
    @Test
    public void test_full_flow_read_to_write() throws IOException, ParseException {
        File testScanFolder = new File("/Users/maiev/Documents/iisi/IISI_MavenPluginSQL/codeSpace/sql-deploy/target/test-classes/ForScan");
        File testDeployFolder = new File("/Users/maiev/Documents/iisi/IISI_MavenPluginSQL/codeSpace/sql-deploy/target/test-classes/ForDeploy");
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
        sqlFileProcessor.createUpdateSql(sqlList, dateFormat.parse("20190110"), testDeployFolder, "UTF-8");
        String todayStr = dateFormat.format(new Date());
        String fileName = "DeployUAT" + todayStr + ".sql";
        File deployFile = new File(testDeployFolder, fileName);

        Assert.assertTrue(deployFile.exists());


        sqlFileProcessor.createInitSql(sqlList, testDeployFolder, "UTF-8");
        String initFileName = "DeployUAT_Init.sql";
        File deployInitFile = new File(testDeployFolder, initFileName);
        Assert.assertTrue(deployInitFile.exists());

    }





}