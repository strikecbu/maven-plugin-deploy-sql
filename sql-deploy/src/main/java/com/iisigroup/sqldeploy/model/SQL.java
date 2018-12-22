package com.iisigroup.sqldeploy.model;

import java.util.Date;
import java.util.Map;

/**
 * @author AndyChen
 * @version <ul>
 * <li>2018/8/28 AndyChen,new
 * </ul>
 * @since 2018/8/28
 */
public class SQL {

    public enum Type {
        SYS_TYPE, TRANS_TYPE, NORMAL_TYPE
    }

    private String sqlFileName;
    private Type type;
    private String primaryKey;
    private StringBuilder initSql;
    private Map<Date, StringBuilder> updateSql;

    public String getSqlFileName() {
        return sqlFileName;
    }

    public void setSqlFileName(String sqlFileName) {
        this.sqlFileName = sqlFileName;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getPrimaryKey() {
        return primaryKey;
    }

    public void setPrimaryKey(String primaryKey) {
        this.primaryKey = primaryKey;
    }

    public StringBuilder getInitSql() {
        return initSql;
    }

    public void setInitSql(StringBuilder initSql) {
        this.initSql = initSql;
    }

    public Map<Date, StringBuilder> getUpdateSql() {
        return updateSql;
    }

    public void setUpdateSql(Map<Date, StringBuilder> updateSql) {
        this.updateSql = updateSql;
    }
}
