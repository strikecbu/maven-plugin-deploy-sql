package com.iisigroup.sqldeploy.util;

import org.junit.Assert;
import org.junit.Test;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.Assert.*;

public class ProdSqlFileProcessorTest {

    private String scanFolderPath = "/Users/maiev/Documents/iisi/IISI_MavenPluginSQL/codeSpace/sql-deploy/src/test/resources/ForDeploy";
    private String deployFolderPath = "/Users/maiev/Documents/iisi/IISI_MavenPluginSQL/codeSpace/sql-deploy/src/test/resources/ForProdDeploy";


    @Test
    public void getAllSql() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

        //read content
        StringBuilder stringBuilder = ProdSqlFileProcessor.getAllSql("20181201", scanFolderPath, "UTF-8");
        Assert.assertTrue(stringBuilder != null && stringBuilder.length() > 0);

        //write content
        String fileName = "DeployTest" + dateFormat.format(new Date()) + ".sql";
        File file = new File(deployFolderPath, fileName);
        ProdSqlFileProcessor.writeFile(stringBuilder, file, "UTF-8");
        Assert.assertTrue(file.exists());
    }

}