package com.buss.dynamicdatasource.service;


import com.buss.dynamicdatasource.entity.DataModelSearch;

import java.util.List;

public interface DataModelSearchService {

    /**
     * 获取分页数据
     * @param pageSize
     * @param limit
     * @return
     */
    List<DataModelSearch> getPageList(Integer pageSize, Integer limit,String dbkey);

    /**
     * 获取所有
     */
    List<DataModelSearch> getAll();

    boolean save(DataModelSearch dataModelSearch);

    /**
     *批量删除
     */
    boolean delete(String[] id);

    /**
     * 根据id获取数据
     * @param id
     * @return
     */
    DataModelSearch getById(String id);

    /**
     * 更新
     * @return
     */
    boolean update(DataModelSearch dataModelSearch);

}
