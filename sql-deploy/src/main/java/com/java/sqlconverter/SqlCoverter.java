package com.java.sqlconverter;

import com.java.sqlconverter.constant.ConvertType;
import com.java.sqlconverter.factory.InsertAndUpdateConverterFactory;
import com.java.sqlconverter.model.CommentCheckReport;
import com.java.sqlconverter.model.SQLDetails;
import com.java.sqlconverter.model.SqlServerConfig;
import com.java.sqlconverter.model.SyntaxCheckReport;
import com.java.sqlconverter.util.SQLUtil;
import com.java.sqlconverter.validate.SQLCommentCheck;
import com.java.sqlconverter.validate.builder.SQLSyntaxCheckBuilder;

import java.util.List;

/**
 * @author AndyChen
 * @version <ul>
 * <li>2018/12/22 AndyChen,new
 * </ul>
 * @since 2018/12/22
 */
public class SqlCoverter {


    private static SqlCoverter object = new SqlCoverter();

    public static SqlCoverter checkSqlFormat(SqlServerConfig config, String sqlText) {
        return object._checkSqlFormat(config, sqlText);
    }

    public SqlCoverter _checkSqlFormat(SqlServerConfig config, String sqlText) {
        if(config == null || config.getHost() == null || config.getPort() == null || config.getUserName() == null || config.getPassword() == null) {
            System.out.println("access SQL server connection information is not prepare.");
            System.out.println("skip check Sql format.");
            return this;
        }
        String osName = System.getProperty("os.name").toLowerCase();
        if(!osName.contains("mac")) {
            //1.check sql檔案格式是否正確
            SyntaxCheckReport syntaxCheckReport = SQLSyntaxCheckBuilder
                    .build()
                    .setSqlFileText(sqlText)
                    .setHost(config.getUserName())
                    .setPort(config.getPort())
                    .setUserName(config.getUserName())
                    .setPassword(config.getPassword())
                    .create()
                    .check();
            if (!syntaxCheckReport.isSyntaxCorrect()) {
                throw new IllegalArgumentException("SQL syntax is not correct: \n" + syntaxCheckReport.getErrorMessage());
            }
        } else {
            System.out.println("check sql file format function is not support mac os");
            return this;
        }
        System.out.println("checking sql file format is completed");
        return this;
    }

    public static SqlCoverter checkSqlRule(String sqlText) {
        return object._checkSqlRule(sqlText);
    }

    public SqlCoverter _checkSqlRule(String sqlText) {
        //2.check 自定義註釋是否正確 如:--{} init等等
        SQLDetails sqlDetails = new SQLDetails(
                SQLUtil.complementDummyInsertSemicolonAndReplaceSensitiveWordsInInsertValues(sqlText)
        );
        SQLCommentCheck commentCheck = new SQLCommentCheck(sqlText);
        commentCheck.register(new CommentRuleByAndy());
        commentCheck.register(new CommentRuleByMark());
        List<CommentCheckReport> commentCheckReports = commentCheck.generateCommentAndLine().processCommentRule();
        if (!commentCheck.isAllPass()) {
            String errorMessage = SQLUtil.generateErrorMessageFromReports(commentCheckReports, false);
            throw new IllegalArgumentException(errorMessage);
        }
        System.out.println("checking sql file rules is completed");
        return this;
    }

    public static String convertInsertSql(String sqlText) {
        SQLDetails sqlDetails = new SQLDetails(
                SQLUtil.complementDummyInsertSemicolonAndReplaceSensitiveWordsInInsertValues(sqlText)
        );

        //3.將insert轉換成update + insert (upsert)
        String newSqlFileText = InsertAndUpdateConverterFactory
                .createConverter(sqlDetails, ConvertType.INSERT)
                .convert2Upsert();
        return SQLUtil.removeUpsertComments(SQLUtil.recoverInsertSql(newSqlFileText));
    }

}
