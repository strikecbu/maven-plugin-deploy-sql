package com.iisigroup.sqldeploy.util;

import com.iisigroup.sqldeploy.model.SQL;
import com.java.sqlconverter.SqlCoverter;
import com.java.sqlconverter.model.SqlServerConfig;
import com.java.sqlconverter.util.FileUtil;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author AndyChen
 * @version <ul>
 * <li>2018/8/28 AndyChen,new
 * </ul>
 * @since 2018/8/28
 */
public class SqlFileProcessor {

    private static final String BREAK_LINE = System.lineSeparator();
    private static final String SQL_SERVER_COMMIT_KEY = "GO";
    private static final String KEY = "--{}";
    private static final String PK_KEY = "--@pk:";
    private static final String INIT_KEY = "init";
    private static final String UPDATE_KEY = "update";
    private static final String SKIP_ON_KEY = "--@skip:on";
    private static final String SKIP_OFF_KEY = "--@skip:off";
    private static final String UPSERT_ON_KEY = "--@upsert:on";
    private static final String UPSERT_OFF_KEY = "--@upsert:off";

    public static Map<String, StringBuffer> skipSqls = new HashMap<>();

    private String deployFileFormat;
    private SqlServerConfig dbConfig;

    public SqlFileProcessor(String deployFileFormat, SqlServerConfig dbConfig) {
        this.deployFileFormat = deployFileFormat;
        this.dbConfig = dbConfig;
    }

    /**
     * 取得所有SQL內容
     * @param allFiles all file
     * @return 以fileName為key，all content add in list
     * @throws IOException
     */
    public Map<String, List<String>> getAllSqls(File[] allFiles) throws IOException {
        Map<String, List<String>> result = new HashMap<>();

        for (File file : allFiles) {
            //排除非sql檔
            if(!this.checkSqlFile(file)) {
                System.out.println("skip " + file.getName());
                continue;
            }

            //check SQL 格式
            System.out.println("checking sql file: " + file.getName() + " format and rule...");
            String allSqlStr = FileUtil.readFile(file.getAbsolutePath());
            SqlCoverter.checkSqlFormat(dbConfig, allSqlStr)._checkSqlRule(allSqlStr);

            List<String> allSqls = new ArrayList<>();
            try (
                    FileInputStream fis = new FileInputStream(file);
                    InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
                    BufferedReader br = new BufferedReader(isr)
            ) {
                String line;
                while ((line = br.readLine()) != null) {
                    allSqls.add(line);
                }
                if (allSqls.size() >= 0) {
                    result.put(file.getName(), allSqls);
                }
            }
        }
        return result;
    }

    private boolean checkSqlFile(File file) {
        String name = file.getName();
        return name.matches(".*\\.sql$");
    }

    /**
     * 轉換SQL string to Model
     * @param sqlName sql file name
     * @param allSqls this sql inside all content
     * @return model of this sql
     */
    public SQL convertStrToModel(String sqlName, List<String> allSqls) {
        SQL sql = new SQL();
        sql.setSqlFileName(sqlName);
        int initIndex = 0;
        int updateIndex = 0;
        for (int i = 0; i < allSqls.size(); i++) {
            String line = allSqls.get(i);
            if (line.contains(KEY)) {
                SQL.Type sqlType = this.getSqlType(line);
                if (sqlType != null) {
                    sql.setType(sqlType);
                }
                if (line.contains(INIT_KEY)) {
                    initIndex = i;
                }
                if (line.contains(UPDATE_KEY)) {
                    updateIndex = i;
                    break;
                }
            } else if (line.contains(PK_KEY)) {
                String pkKey = line.replaceAll(PK_KEY, "").trim();
                sql.setPrimaryKey(pkKey);
            }
        }

        if(sql.getType() == null)
            throw new IllegalStateException("SQL: " + sqlName + " not found SQL type");
        if(initIndex == 0)
            throw new IllegalStateException("SQL: " + sqlName + " not found init keyword");
        if(updateIndex == 0)
            throw new IllegalStateException("SQL: " + sqlName + " not found update keyword");
        sql.setInitSql(this.getTargetSql(allSqls, initIndex + 1, updateIndex));
        sql.setUpdateSql(this.getUpdateSql(sqlName, allSqls, updateIndex +1));
        return sql;
    }

    private void checkUpdateContent(String sqlFileName, Map<Date, StringBuilder> updateSqls, Date dayAfter) {
        Set<Date> allDates = updateSqls.keySet();
        Map<Date, StringBuilder> tests = new HashMap<>();
        for (Date date : allDates) {
            if(date.getTime() > dayAfter.getTime()) {
                tests.put(date, updateSqls.get(date));
            }
        }
        checkUpdateContent(sqlFileName, tests);
    }

    /**
     * 檢查script中是否帶有delete or drop 相關script字眼
     * only check start with drop or delete these two key words
     * @param sqlFileName sql file name
     * @param updateSqls all update SQL scripts
     */
    private void checkUpdateContent(String sqlFileName, Map<Date, StringBuilder> updateSqls) {
        StringBuffer allSqls = new StringBuffer();
        for (StringBuilder value : updateSqls.values()) {
            boolean isSkipOn = false;
            String[] lines = value.toString().split("\n");
            for (String line : lines) {
                if(line.matches("^\\s*" + SKIP_ON_KEY + ".*")) {
                    isSkipOn = true;
                    continue;
                } else if(line.matches("^\\s*" + SKIP_OFF_KEY + ".*")) {
                    isSkipOn = false;
                }
                if(isSkipOn) {
                    allSqls.append("-- ").append(line).append("\n");
                    continue;
                }

                if(line.matches("^(?i)\\s*drop\\s+table\\s*.*$")) {
                    System.out.println("Script validate fail : " + line);
                    throw new IllegalStateException("NOT allow drop table script in the update area!");
                }
                if(line.matches("^(?i)\\s*delete\\s+(from)?\\s*.*$")) {
                    System.out.println("Script validate fail : " + line);
                    throw new IllegalStateException("NOT allow delete script in the update area!");
                }
            }
            if(isSkipOn)
                throw new IllegalStateException("NOT found close skip mark words (--@skip:off)");

            checkInsertFormat(value.toString());
        }
        if(!"".equals(allSqls.toString()))
            skipSqls.put(sqlFileName, allSqls);
    }

    private void checkInsertFormat(String sqlStr) {
        String[] lines = sqlStr.split("\n");
        boolean isUpdertOn = false;
        for (String line : lines) {
            if(line.matches("^\\s*" + UPSERT_ON_KEY + ".*")) {
                isUpdertOn = true;
            } else if(line.matches("^\\s*" + UPSERT_OFF_KEY + ".*")) {
                isUpdertOn = false;
            }
            if(isUpdertOn) {
                //  block REPLACE(NEWID(),'-','')
                if(line.matches("(?i).*REPLACE\\s*\\(\\s*NEWID\\s*\\(\\)\\s*,\\s*'-'\\s*,\\s*''\\s*\\).*$")) {
                    System.out.println("Script validate fail : " + line);
                    throw new IllegalStateException("NOT allow insert script with REPLACE(NEWID(),'-','') !");
                }
                continue;
            }

            if(line.matches("^(?i)\\s*insert(\\s+into)?\\s*.*$")) {
                System.out.println("Script validate fail : " + line);
                throw new IllegalStateException("NOT allow insert script without @upsert in the update area!");
            }
        }
        if(isUpdertOn)
            throw new IllegalStateException("NOT found close upsert mark words (--@upsert:off)");

    }

    private SQL.Type getSqlType(String line) {
        String orderStr = this.getOrder(line);
        for (SQL.Type type : SQL.Type.values()) {
            if (type.toString().equals(orderStr)) {
                return type;
            }
        }
        return null;
    }

    private StringBuilder getTargetSql(List<String> allSqls, int start, int end) {
        if(end == 0)
            end = allSqls.size();
        StringBuilder result = new StringBuilder();
        for (int i = start; i < end; i++) {
            String line = allSqls.get(i);
            result.append(line).append(BREAK_LINE);
        }
        return result;
    }

    /**
     * 取得Update內容，以關鍵字為定位點，擷取中間內容
     * @param sqlName sql file name
     * @param allSqls all sql content
     * @param start update keyword start index
     * @return update date is key, update sql in content
     */
    private Map<Date, StringBuilder> getUpdateSql(String sqlName, List<String> allSqls, int start) {
        TreeMap<Date, StringBuilder> result = new TreeMap<>();
        int startIndex = 0;
        Date date = null;
        for (int i = start; i < allSqls.size(); i++) {
            String line = allSqls.get(i);
            if(line.contains(KEY)) {

                if (startIndex > 0) {
                    StringBuilder targetSql = this.getTargetSql(allSqls, startIndex, i);
                    result.put(date, targetSql);
                    startIndex = i;
                } else {
                    startIndex = i;
                }

                String dateStr = this.getOrder(line);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy,MM,dd");
                try {
                    date = simpleDateFormat.parse(dateStr);
                } catch (ParseException e) {
                    throw new IllegalStateException("SQL: " + sqlName + ", update area date format wrong");
                }
            }

            if( startIndex > 0 && i == allSqls.size() -1) {
                StringBuilder targetSql = this.getTargetSql(allSqls, startIndex, allSqls.size());
                result.put(date, targetSql);
            }
        }

        return result;
    }

    private String getOrder(String line) {
        return line.replace(KEY, "").trim();
    }

    /**
     * create update deploy sql
     * @param allSqls all sql model in list
     * @param dayAfter 指定的日期之後的SQL
     * @param folder 產出目錄
     * @param charset 指定的file encode
     * @throws IOException
     */
    public void createUpdateSql(List<SQL> allSqls, Date dayAfter, File folder, String charset) throws IOException {
        StringBuilder writeContent = this.getWriteContent(allSqls, dayAfter);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String todayStr = dateFormat.format(new Date());
        String fileFormat = deployFileFormat;
        // format: DeployUAT{yyyyMMdd}.sql
        String fileName = fileFormat.replace("{yyyyMMdd}", todayStr);
        File deployFile = new File(folder, fileName);

        if(!"".equals(writeContent.toString())) {
            writeContent.insert(0, addWarningMsg().toString());
            this.writeFile(deployFile, writeContent.toString(), charset);
            System.out.println("create deploy SQL was completed!");
        } else {
            System.out.println("there is no any deploy SQL, nothing to create.");
        }
    }

    private StringBuffer addWarningMsg() {
        StringBuffer result = new StringBuffer();
        //title
        result.append("----------  Waring!!! Some Script Had Been Skip Validate! ------------");
        result.append("\n");
        for (String fileName : skipSqls.keySet()) {
            result.append("-- fileName: ").append(fileName).append("\n");
            result.append(skipSqls.get(fileName));
            result.append("\n");
        }
        result.append("----------------------------------------------------------------------");
        result.append("\n");
        return result;
    }

    private void writeFile(File deployFile, String content, String charset) throws IOException {
        if (deployFile.exists()) {
            deployFile.delete();
        } else {
            deployFile.createNewFile();
        }

        if(charset == null || "".equals(charset))
            charset = "UTF-8";
        try (
                FileOutputStream fos = new FileOutputStream(deployFile);
                OutputStreamWriter osw = new OutputStreamWriter(fos, charset);
                BufferedWriter bw = new BufferedWriter(osw)
        ) {
            bw.write(content);
            bw.flush();
        }

    }

    private StringBuilder getWriteContent(List<SQL> allSqls, Date dayAfter) {
        StringBuilder content = new StringBuilder();
        boolean anyUpdate = false;
        for (SQL sql : allSqls) {
            Map<Date, StringBuilder> allUpdates = sql.getUpdateSql();
            String sqlFileName = sql.getSqlFileName();
            //TODO validate SQL UPDATE 內容
            checkUpdateContent(sqlFileName, allUpdates, dayAfter);
            content.append("--").append(sqlFileName).append(BREAK_LINE);
            StringBuilder targetDateSql = this.getTargetDateSql(allUpdates, dayAfter);
            if(!"".equals(targetDateSql.toString()))
                anyUpdate = true;

            // 轉換insert SQL to upsert SQL
            if(sql.getPrimaryKey() != null) {
                targetDateSql.insert(0, PK_KEY + sql.getPrimaryKey() + BREAK_LINE);
            }
            String convertInsertSql = SqlCoverter.convertInsertSql(targetDateSql.toString());
            content.append(convertInsertSql).append(BREAK_LINE);
            content.append(SQL_SERVER_COMMIT_KEY).append(BREAK_LINE);
        }
        if(anyUpdate) {
            return content;
        } else {
            return new StringBuilder();
        }
    }

    private StringBuilder getTargetDateSql(Map<Date, StringBuilder> allUpdates, Date dayAfter) {
        StringBuilder result = new StringBuilder();
        Set<Date> allDates = allUpdates.keySet();
        for (Date date : allDates) {
            if(date.getTime() > dayAfter.getTime()) {
                result.append(allUpdates.get(date));
            }
        }
        return result;
    }

    /**
     * create init deploy sql
     * @param allSqls all sql model in list
     * @param folder 產出目錄
     * @param charset file encoding
     * @throws IOException
     */
    public void createInitSql(List<SQL> allSqls, File folder, String charset) throws IOException {
        StringBuilder content = new StringBuilder();
        for (SQL sql : allSqls) {
            String sqlFileName = sql.getSqlFileName();
            StringBuilder initSql = sql.getInitSql();
            content.append("--").append(sqlFileName).append(BREAK_LINE);
            content.append(initSql).append(BREAK_LINE);
            content.append(SQL_SERVER_COMMIT_KEY).append(BREAK_LINE);
        }
        String fileName = "DeployUAT_Init.sql";
        File deployFile = new File(folder, fileName);
        this.writeFile(deployFile, content.toString(), charset);
        System.out.println("create deploy init SQL was completed!");
    }





}
