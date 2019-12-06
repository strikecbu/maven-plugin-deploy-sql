package com.java.sqlconverter;

import com.java.sqlconverter.model.CommentCheckReport;
import com.java.sqlconverter.util.StringUtil;
import com.java.sqlconverter.validate.CommentAndLine;
import com.java.sqlconverter.validate.CommentRule;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author MarkHuang
 * @version <ul>
 * <li>2018/12/21, MarkHuang,new
 * </ul>
 * @since 2018/12/21
 */
public class CommentRuleByMark implements CommentRule {
    private final List<String> regexs = Arrays.asList(
            "--@\\s*?pk\\s*?:\\s*?.+",
            "--@\\s*?upsert\\s*?:\\s*?(on|off)",
            "--@skip:on\\s*?", "--@skip:off\\s*?"
    );

    @Override
    public CommentCheckReport checkComment(List<CommentAndLine> commentAndLines) {
        List<String> errorMessages = new ArrayList<>();
        errorMessages.addAll(checkFormatCorrect(commentAndLines));
        errorMessages.addAll(checkLogicRational(commentAndLines));
        boolean isPass = errorMessages.size() == 0;
        return new CommentCheckReport(isPass, errorMessages);
    }

    @Override
    public boolean isLineNeedCheck(String line) {
        return line.matches("^(--@.*)$");
    }

    private List<String> checkFormatCorrect(List<CommentAndLine> commentAndLines) {
        List<String> errorMessages = new ArrayList<>();
        for (CommentAndLine commentAndLine : commentAndLines) {
            String comment = commentAndLine.getComment();
            int line = commentAndLine.getLine();
            if (comment.indexOf("--@") == 0) {
                boolean isPass = StringUtil.checkStringMatchRegexs(comment, regexs);
                if (!isPass) {
                    String correctFormat = "--@update:on/off|--@pk:primaryKey";
                    errorMessages.add(String.format("LineNo:%d wrong format: %s, the correct format is %s",
                            line, comment, correctFormat
                    ));
                }
            }
        }
        return errorMessages;
    }

    private List<String> checkLogicRational(List<CommentAndLine> commentAndLines) {
        List<String> errorMessages = new ArrayList<>();
        int upsertOnCount = 0;
        int upsertOffCount = 0;
        boolean isPkDeclare = false;
        for (CommentAndLine commentAndLine : commentAndLines) {
            String comment = commentAndLine.getComment();
            int line = commentAndLine.getLine();
            if (comment.contains("pk")) {
                isPkDeclare = true;
            } else if (comment.matches("--@\\s*upsert\\s*:\\s*on")) {
                upsertOnCount += 1;
            } else if (comment.matches("--@\\s*upsert\\s*:\\s*off")) {
                upsertOffCount++;
                if (upsertOnCount < upsertOffCount) {
                    errorMessages.add(String.format("LineNo:%d: Before uppsert:off, you MUST declare upsert:on keyword", line));
                }
            }
        }
        if (upsertOnCount > 0 && !isPkDeclare) {
            errorMessages.add("If declare upsert, you MUST declare =>pk:primaryKey in the head");
        }
        return errorMessages;
    }
}
