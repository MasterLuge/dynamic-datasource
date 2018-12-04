package com.buss.dynamicdatasource.service;


import com.buss.dynamicdatasource.entity.DataSourceSql;

import java.util.List;
import java.util.Map;

public interface DataSourceSqlService {

    /**
     * 获取分页数据
     * @param pageSize
     * @param limit
     * @return
     */
    List getPageList(Integer pageSize, Integer limit);

    /**
     * 获取所有
     */
    List getAll();

    boolean save(DataSourceSql dataSourceSql);

    /**
     *批量删除
     */
    boolean delete(String[] id);

    /**
     * 根据id获取数据
     * @param id
     * @return
     */
    DataSourceSql getById(String id);

    /**
     * 更新
     * @return
     */
    boolean update(DataSourceSql dataSourceSql);


    /**
     * 生成sql语句
     * @param dataSourceSql
     * @return
     */
    String generateSQL(DataSourceSql dataSourceSql);


}
