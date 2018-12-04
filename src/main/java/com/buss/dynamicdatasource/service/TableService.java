package com.buss.dynamicdatasource.service;


import com.buss.dynamicdatasource.entity.TableSearchVo;
import com.buss.dynamicdatasource.entity.UserTables;

import java.util.List;
import java.util.Map;

public interface TableService {

    /***
     * 获取库中所有表
     * @return
     */
    List<UserTables> getAllTables(String dbkey, String searchName);

    /**
     * 获取表的所有字段,分页
     * @return
     */
    List getPageFieldsByTableName(String tableName, String dbkey, Integer beginRow, Integer endRow);

    /**
     *  获取表的所有字段
     * @param tableName
     * @param dbkey
     * @return
     */
    List getFieldsByTableName(String tableName, String dbkey);


    /**
     * 执行sql
     * @return
     */
    List getAllBySQL(TableSearchVo vo, String dbkey);

    List getPageTables(Integer pageSize, Integer limit, String searchName, String dbkey);

    /**
     * 执行sql
     * @param sql
     * @return
     */
    List<Map<String,Object>> executeSQL(String sql, String dbkey);
}
