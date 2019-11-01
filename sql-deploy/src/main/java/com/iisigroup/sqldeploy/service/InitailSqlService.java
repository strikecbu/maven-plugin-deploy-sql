package com.iisigroup.sqldeploy.service;

import com.iisigroup.sqldeploy.model.SQL;

import java.util.List;

/**
 * @author AndyChen
 * @version <ul>
 * <li>2019/10/31 AndyChen,new
 * </ul>
 * @since 2019/10/31
 */
public interface InitailSqlService {

    StringBuilder getNewTableSchema(List<SQL> allSqls);
}
