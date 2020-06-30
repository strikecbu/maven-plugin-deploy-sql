package com.iisigroup.sqldeploy.util;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @author AndyChen
 * @version <ul>
 * <li>2019/1/16 AndyChen,new
 * </ul>
 * @since 2019/1/16
 */
public class ProdSqlFileProcessor {

    private static final String BREAK_LINE = System.lineSeparator();

    public static StringBuilder getAllSql(String assignDateStr, String scanFolder, String encoding) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        Date assignDate = null;
        try {
            assignDate = dateFormat.parse(assignDateStr);
        } catch (ParseException e) {
            throw new IllegalArgumentException("assignDate must be yyyyMMdd");
        }


        File folder = new File(scanFolder);
        if(!folder.isDirectory())
            throw new IllegalArgumentException("scanFolder must folder path");

        Map<Long, File> fileMap = new LinkedHashMap<>();
        for (File file : folder.listFiles()) {
            String fileName = file.getName();
            String regExStr = "^.*([0-9]{8}).*\\.sql$";
            Pattern pattern = Pattern.compile(regExStr);
            Matcher matcher = pattern.matcher(fileName);
            if(matcher.find()) {
                Date date;
                try {
                    date = dateFormat.parse(matcher.group(1));
                } catch (ParseException e) {
                    continue;
                }
                int compare = date.compareTo(assignDate);
                if(compare >= 1) {
                    fileMap.put(date.getTime(), file);
                }
            }
        }

        //sort file date
        List<File> needFiles = sortFileDate(fileMap);

        return getAllFileStr(needFiles, encoding);
    }

    private static ArrayList<File> sortFileDate(Map<Long, File> fileMap) {
        Set<Long> keySet = fileMap.keySet();
        Long[] sortKeys = new Long[]{};
        sortKeys = keySet.toArray(sortKeys);
        Arrays.sort(sortKeys);

        ArrayList<File> result = new ArrayList<>();
        for (Long sortKey : sortKeys) {
            File file = fileMap.get(sortKey);
            result.add(file);
        }
        return result;
    }

    private static StringBuilder getAllFileStr(List<File> allFiles, String encoding) {
        StringBuilder result = new StringBuilder();
        for (File file : allFiles) {
            try (
                InputStreamReader fr = new InputStreamReader(new FileInputStream(file), encoding);
                BufferedReader br = new BufferedReader(fr)
            ){
                result.append("--" + file.getName()).append(BREAK_LINE);
                String line = "";
                while ((line = br.readLine()) != null) {
                    result.append(line).append(BREAK_LINE);
                }
            } catch (IOException e) {
                throw new IllegalStateException("can NOT read file: " + file.getName());
            }
            result.append(BREAK_LINE);
        }
        return result;
    }

    public static void writeFile(StringBuilder content, File file, String enconding) {
        try {
            if (file.exists()) {
                file.delete();
            }
            file.createNewFile();
            try (
                 OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(file), enconding);
                 BufferedWriter bw = new BufferedWriter(osw)
            ){
                bw.write(content.toString());
                bw.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static StringBuilder getDiffSqlContent(Date deploySqlDate, File temp) {
        StringBuilder allSqls = new StringBuilder();
        File[] files = Arrays.stream(Objects.requireNonNull(temp.listFiles()))
                .filter(file -> file.getName().toLowerCase().contains("_diff.sql"))
                .collect(Collectors.toList()).toArray(new File[]{});
        try {
            if (files.length > 0) {
                System.out.println("Found diff SQL, checking...");
            }
            final Date compareScanDate = deploySqlDate;
            Map<String, List<String>> sqls = SqlFileProcessor.getAllSqls(files);
            StringBuffer collect = sqls.entrySet().stream()
                    .map(entry -> SqlFileProcessor.convertStrToModel(entry.getKey(), entry.getValue()))
                    .map(sql -> {
                        AtomicBoolean atomicBoolean = new AtomicBoolean(false);
                        StringBuffer buffer = new StringBuffer();
                        buffer.append("--").append(sql.getSqlFileName()).append(System.lineSeparator());
                        Map<Date, StringBuilder> updateSqls = sql.getUpdateSql();
                        updateSqls.entrySet().stream()
                                .filter(entry -> entry.getKey().getTime() > compareScanDate.getTime())
                                .sorted((e1, e2) -> {
                                    long l = e1.getKey().getTime() - e2.getKey().getTime();
                                    return l == 0 ? 0 : (l > 0 ? 1 : -1);
                                })
                                .forEach(entry -> {
                                    System.out.println(sql.getSqlFileName() + " found update SQL date: " + entry.getKey());
                                    buffer.append(entry.getValue()).append(System.lineSeparator());
                                    atomicBoolean.set(true);
                                });
                        if (atomicBoolean.get()) {
                            buffer.append("GO").append(System.lineSeparator());
                        }
                        return buffer;
                    }).collect(StringBuffer::new, StringBuffer::append, StringBuffer::append);
            allSqls.append(collect);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return allSqls;
    }
}
