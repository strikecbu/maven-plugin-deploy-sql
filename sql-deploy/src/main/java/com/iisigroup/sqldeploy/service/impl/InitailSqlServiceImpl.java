package com.iisigroup.sqldeploy.service.impl;

import com.iisigroup.sqldeploy.model.SQL;
import com.iisigroup.sqldeploy.service.InitailSqlService;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author AndyChen
 * @version <ul>
 * <li>2019/10/31 AndyChen,new
 * </ul>
 * @since 2019/10/31
 */
public class InitailSqlServiceImpl implements InitailSqlService {

    private File scanFolder;
    private File deployFolder;

    public InitailSqlServiceImpl(File scanFolder, File deployFolder) {
        this.scanFolder = scanFolder;
        this.deployFolder = deployFolder;
    }

    @Override
    public StringBuilder getNewTableSchema(List<SQL> allSqls) {
        StringBuilder result = new StringBuilder();
        File checkFile = new File(deployFolder, "deployTable");
        List<String> checkedTableNames = getCheckedTableName(checkFile);
        File[] sqlFiles = scanFolder.listFiles(new FilenameFilter() {
            @Override
            public boolean accept(File dir, String name) {
                return name.matches("^.*\\.sql$");
            }
        });

        ArrayList<String> needInitTableFileNames = new ArrayList<>();
        for (File sqlFile : sqlFiles) {
            String tableFileName = sqlFile.getName();
            if(checkedTableNames.contains(tableFileName))
                continue;
            needInitTableFileNames.add(sqlFile.getName());
        }

        result.append("----------------------------------------------- \n\r");
        result.append("------------ ADD NEW TABLE SCHEMA ------------- \n\r");
        result.append("----------------------------------------------- \n\r");
        int count = 0;
        for (SQL sql : allSqls) {
            if(needInitTableFileNames.contains(sql.getSqlFileName())) {
                System.out.println("Find new Table: " + sql.getSqlFileName());
                result.append("-- Table name: ").append(sql.getSqlFileName()).append("\n\r");
                result.append(sql.getInitSql());
                result.append("\n\r");
                result.append("GO");
                result.append("\n\r");
                count++;
            }
        }
        if(count == 0) //沒有任何異動即跳出
            return new StringBuilder();

        //回填deploy table
        needInitTableFileNames.addAll(checkedTableNames);
        if(checkFile.exists()) {
            checkFile.delete();
        }
        byte[] bytes =
                needInitTableFileNames.toString().replace("[", "").replace("]", "").getBytes(StandardCharsets.UTF_8);
        try {
            Files.write(checkFile.toPath(), bytes);
        } catch (IOException e) {
            throw new IllegalStateException("Can NOT create new deployTable file");
        }

        return result;
    }

    private List<String> getCheckedTableName(File checkFile) {
        try {
            byte[] bytes = Files.readAllBytes(checkFile.toPath());
            String allLines = new String(bytes, StandardCharsets.UTF_8);
            allLines = allLines.replaceAll(" ", "");
            System.out.println("Already deploy table: " + allLines);
            return Arrays.asList(allLines.split(","));
        } catch (IOException e) {
            System.out.println("Fail to read check table file");
        }
        return new ArrayList<>();
    }
}
