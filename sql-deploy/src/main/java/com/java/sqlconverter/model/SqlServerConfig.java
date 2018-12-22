package com.java.sqlconverter.model;

/**
 * @author AndyChen
 * @version <ul>
 * <li>2018/12/22 AndyChen,new
 * </ul>
 * @since 2018/12/22
 */
public class SqlServerConfig {

    private String host;
    private String port;
    private String userName;
    private String password;

    public SqlServerConfig(String host, String port, String userName, String password) {
        this.host = host;
        this.port = port;
        this.userName = userName;
        this.password = password;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
