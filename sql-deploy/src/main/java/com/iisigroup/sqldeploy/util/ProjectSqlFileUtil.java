package com.iisigroup.sqldeploy.util;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author AndyChen
 * @version <ul>
 * <li>2019/1/16 AndyChen,new
 * </ul>
 * @since 2019/1/16
 */
public class ProjectSqlFileUtil {
    public static Date getLastDeploySqlDate(File deployFolder) {
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
