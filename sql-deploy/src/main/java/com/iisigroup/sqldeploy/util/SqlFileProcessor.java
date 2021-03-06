package com.iisigroup.sqldeploy.util;

import com.iisigroup.sqldeploy.model.SQL;
import com.iisigroup.sqldeploy.service.InitailSqlService;
import com.iisigroup.sqldeploy.service.impl.InitailSqlServiceImpl;
import com.java.sqlconverter.SqlCoverter;
import com.java.sqlconverter.model.SqlServerConfig;
import com.java.sqlconverter.util.FileUtil;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;

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
    private static SqlServerConfig dbConfig;

    private InitailSqlService initailSqlService;

    public SqlFileProcessor(String deployFileFormat, SqlServerConfig dbConfig, File scanFolder, File deployFolder) {
        this.deployFileFormat = deployFileFormat;
        SqlFileProcessor.dbConfig = dbConfig;
        this.initailSqlService = new InitailSqlServiceImpl(scanFolder, deployFolder);
    }

    /**
     * 取得所有SQL內容
     * @param allFiles all file
     * @return 以fileName為key，all content add in list
     * @throws IOException
     */
    public static Map<String, List<String>> getAllSqls(File[] allFiles) throws IOException {
        Map<String, List<String>> result = new HashMap<>();

        for (File file : allFiles) {
            //排除非sql檔
            if(!checkSqlFile(file)) {
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

    private static boolean checkSqlFile(File file) {
        String name = file.getName();
        return name.matches(".*\\.sql$");
    }

    /**
     * 轉換SQL string to Model
     * @param sqlName sql file name
     * @param allSqls this sql inside all content
     * @return model of this sql
     */
    public static SQL convertStrToModel(String sqlName, List<String> allSqls) {
        SQL sql = new SQL();
        sql.setSqlFileName(sqlName);
        sql.setWeight(SQL.Weight.NORMAL);
        if(sqlName.toLowerCase().contains("_diff.sql"))
            sql.setWeight(SQL.Weight.LOW);
        int initIndex = 0;
        int updateIndex = 0;
        for (int i = 0; i < allSqls.size(); i++) {
            String line = allSqls.get(i);
            if (line.contains(KEY)) {
                SQL.Type sqlType = getSqlType(line);
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
        sql.setInitSql(getTargetSql(allSqls, initIndex + 1, updateIndex));
        sql.setUpdateSql(getUpdateSql(sqlName, allSqls, updateIndex +1));
        return sql;
    }

    private static void checkUpdateContent(String sqlFileName, Map<Date, StringBuilder> updateSqls, Date dayAfter) {
        System.out.println("Start checking update content...");
        System.out.println("The SQL file name: " + sqlFileName);
        System.out.println("The day after: " + dayAfter);
        Set<Date> allDates = updateSqls.keySet();
        Map<Date, StringBuilder> tests = new HashMap<>();
        for (Date date : allDates) {
            if(date.getTime() > dayAfter.getTime()) {
//                System.out.println("Put update SQL date: " + date);
                tests.put(date, updateSqls.get(date));
            }
        }
        System.out.println("Put all these update SQL dates: " + tests.keySet());
        checkUpdateContent(sqlFileName, tests);
    }

    /**
     * 檢查script中是否帶有delete or drop 相關script字眼
     * only check start with drop or delete these two key words
     * @param sqlFileName sql file name
     * @param updateSqls all update SQL scripts
     */
    private static void checkUpdateContent(String sqlFileName, Map<Date, StringBuilder> updateSqls) {
        StringBuffer allSqls = new StringBuffer();
        for (StringBuilder value : updateSqls.values()) {
            boolean isSkipOn = false;
            String[] lines = value.toString().split(System.lineSeparator());
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

    private static void checkInsertFormat(String sqlStr) {
        String[] lines = sqlStr.split(System.lineSeparator());
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

    private static SQL.Type getSqlType(String line) {
        String orderStr = getOrder(line);
        for (SQL.Type type : SQL.Type.values()) {
            if (type.toString().equals(orderStr)) {
                return type;
            }
        }
        return null;
    }

    private static StringBuilder getTargetSql(List<String> allSqls, int start, int end) {
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
    private static Map<Date, StringBuilder> getUpdateSql(String sqlName, List<String> allSqls, int start) {
        TreeMap<Date, StringBuilder> result = new TreeMap<>();
        int startIndex = 0;
        Date date = null;
        for (int i = start; i < allSqls.size(); i++) {
            String line = allSqls.get(i);
            if(line.contains(KEY)) {

                if (startIndex > 0) {
                    StringBuilder targetSql = getTargetSql(allSqls, startIndex, i);
                    result.put(date, targetSql);
                    startIndex = i;
                } else {
                    startIndex = i;
                }

                String dateStr = getOrder(line);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy,MM,dd");
                try {
                    date = simpleDateFormat.parse(dateStr);
                } catch (ParseException e) {
                    throw new IllegalStateException("SQL: " + sqlName + ", update area date format wrong");
                }
            }

            if( startIndex > 0 && i == allSqls.size() -1) {
                StringBuilder targetSql = getTargetSql(allSqls, startIndex, allSqls.size());
                result.put(date, targetSql);
            }
        }

        return result;
    }

    private static String getOrder(String line) {
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
    public File createUpdateSql(List<SQL> allSqls, Date dayAfter, File folder, String charset) throws IOException {
        StringBuilder writeContent = this.getWriteContent(allSqls, dayAfter);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String todayStr = dateFormat.format(new Date());
        String fileFormat = deployFileFormat;
        // format: DeployUAT{yyyyMMdd}.sql
        String fileName = fileFormat.replace("{yyyyMMdd}", todayStr);
        File deployFile = new File(folder, fileName);

        if(!"".equals(writeContent.toString())) {
            // add update title
            addUpdateTitle(writeContent);
            //加入新增的table schema
            StringBuilder newTableSchemas = initailSqlService.getNewTableSchema(allSqls);
            writeContent.insert(0,newTableSchemas);
            //加入警告訊息
            writeContent.insert(0, addWarningMsg().toString());
            this.writeFile(deployFile, writeContent.toString(), charset);
            ArrayList<String> collect = allSqls.stream()
                    .filter(SQL::isHasUpdate)
                    .collect(ArrayList::new, (list, sql) -> {
                        list.add(sql.getSqlFileName());
                    }, ArrayList::addAll);
            System.out.println("Update SQL file included: " + collect);
            System.out.println("Deploy file info: " + deployFile.getAbsolutePath());
            System.out.println("create deploy SQL was completed!");
        } else {
            System.out.println("there is no any deploy SQL, nothing to create.");
        }
        return deployFile;
    }

    private void addUpdateTitle(StringBuilder writeContent) {
        writeContent.insert(0, "----------------------------------------------- \n\r");
        writeContent.insert(0, "----------------- UPDATE SCRIPT --------------- \n\r");
        writeContent.insert(0, "----------------------------------------------- \n\r");
    }

    private StringBuffer addWarningMsg() {
        StringBuffer result = new StringBuffer();
        if(skipSqls.size() == 0)
            return result;
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
            //避免Jenkins流程重複跑，造成第二次檔案判斷失準，短期內重複跑的檔案不覆蓋
            long nowTime = System.currentTimeMillis();
            long fileModifyTime = deployFile.lastModified();
            final int bufferMins = 3;
            if(nowTime - fileModifyTime < (bufferMins * 60 * 1000))
                return;
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

    public static StringBuilder getWriteContent(List<SQL> allSqls, Date dayAfter) {
        StringBuilder content = new StringBuilder();
        AtomicBoolean anyUpdate = new AtomicBoolean(false);
        allSqls.stream()
                .sorted((a, b) -> -1 * (a.getWeight().getWeight() - b.getWeight().getWeight()))
                .forEach(sql -> {
                    Map<Date, StringBuilder> allUpdates = sql.getUpdateSql();
                    final String sqlFileName = sql.getSqlFileName();
                    //移除--@upsert內的delete內容
                    removeInsertDelete(sql);
                    //TODO validate SQL UPDATE 內容
                    checkUpdateContent(sqlFileName, allUpdates, dayAfter);
                    content.append("--").append(sqlFileName).append(BREAK_LINE);
                    LinkedHashMap<Date, StringBuilder> collect = allUpdates.entrySet().stream()
                            .filter(entry -> {
                                boolean isIncluded = entry.getKey().getTime() > dayAfter.getTime();
                                if(isIncluded)
                                    System.out.println(sqlFileName + " update date included: " + entry.getKey());
                                return isIncluded;
                            })
                            .sorted((e1, e2) -> {
                                long l = e1.getKey().getTime() - e2.getKey().getTime();
                                return l == 0 ? 0 : (l > 0 ? 1 : -1);
                            })
                            .collect(LinkedHashMap::new,
                                    (map1, entry) -> {
                                        map1.put(entry.getKey(), entry.getValue());
                                    }, LinkedHashMap::putAll);
                    System.out.println("Total update date count: " + collect.size());
                    StringBuilder targetDateSql = getTargetDateSql(collect, dayAfter);
                    boolean isThisFileUpdate = false;
                    if (!"".equals(targetDateSql.toString())) {
                        anyUpdate.set(true);
                        isThisFileUpdate = true;
                        sql.setHasUpdate(true);
                    }

                    // 轉換insert SQL to upsert SQL
                    String convertInsertSql = convertInsertToUpsert(sql, targetDateSql.toString()).toString();
                    content.append(convertInsertSql).append(BREAK_LINE);
                    if(isThisFileUpdate)
                        content.append(SQL_SERVER_COMMIT_KEY).append(BREAK_LINE);
                });
        if(anyUpdate.get()) {
            return content;
        } else {
            return new StringBuilder();
        }
    }

    private static StringBuffer convertInsertToUpsert(SQL sql, String data) {
        final String SPLIT_MARK = "go --go";
        final String UPSERT_ON = "--@upsert:on";
        final String UPSERT_OFF = "--@upsert:off";
        if(!data.contains(UPSERT_ON))
            return new StringBuffer(data);
        StringBuffer result = Arrays.stream(data.split(SPLIT_MARK))
                .reduce(new StringBuffer(), (collect, str) -> {
                    StringBuilder sb = new StringBuilder(str);
                    if (sql.getPrimaryKey() != null) {
                        if(!str.contains(UPSERT_ON)) {
                            sb.insert(0, UPSERT_ON + BREAK_LINE);
                        }
                        sb.insert(0, PK_KEY + sql.getPrimaryKey() + BREAK_LINE);
                        if(!str.contains(UPSERT_OFF)) {
                            sb.append(UPSERT_OFF + BREAK_LINE);
                        }
                    }
                    String convertInsertSql = SqlCoverter.convertInsertSql(sb.toString());
                    collect.append(convertInsertSql).append(BREAK_LINE);
                    collect.append(SPLIT_MARK).append(BREAK_LINE);
                    return collect;
                }, StringBuffer::append);

        return result;
    }

    private static StringBuilder getTargetDateSql(Map<Date, StringBuilder> allUpdates, Date dayAfter) {
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

    /**
     * remove all delete SQL contents in --@upsert area
     * @param sql
     */
    private static void removeInsertDelete(SQL sql) {
        Map<Date, StringBuilder> updateSql = sql.getUpdateSql();
        for (Date dateKey : updateSql.keySet()) {
            boolean isUpdertOn = false;
            boolean isDeleteOn = false;
            StringBuilder newSqlLines = new StringBuilder();
            for (String line : updateSql.get(dateKey).toString().split(System.lineSeparator())) {
                if (line.matches("^\\s*" + UPSERT_ON_KEY + ".*")) {
                    isUpdertOn = true;
                    newSqlLines.append(line).append(System.lineSeparator());
                    continue;
                } else if (line.matches("^\\s*" + UPSERT_OFF_KEY + ".*")) {
                    isUpdertOn = false;
                }
                if(!isUpdertOn) {
                    newSqlLines.append(line).append(System.lineSeparator());
                    continue;
                }
                if(line.matches("^(?i)\\s*delete\\s+(from)?.*$")) {
                    isDeleteOn = true;
                    continue;
                }

                if(isDeleteOn && !line.matches("^(?i)\\s*(insert|select|drop|alter|--)+.*")) {
                    continue;
                }

                isDeleteOn = false;
                newSqlLines.append(line).append(System.lineSeparator());
            }
            updateSql.put(dateKey, newSqlLines);
        }

    }




}
