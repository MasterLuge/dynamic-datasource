package com.buss.dynamicdatasource.service.impl;


import com.buss.dynamicdatasource.entity.DataModelSearch;
import com.buss.dynamicdatasource.mapper.DataModelSearchMapper;
import com.buss.dynamicdatasource.service.DataModelSearchService;
import com.commons.annotation.DS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.StringJoiner;

@Service
@DS("dgjycy")
public class DataModelSearchServiceImpl implements DataModelSearchService {

    @Autowired
    private DataModelSearchMapper dataModelSearchMapper;

    @Override
    public List<DataModelSearch> getPageList(Integer pageSize, Integer limit,String dbkey) {
        String query = "";

        if(!StringUtils.isEmpty(dbkey)){
            query = " and dbkey = '"+dbkey+"'";
        }

        Integer beginRow = (pageSize-1)*limit+1;
        Integer endRow = pageSize*limit;
        return dataModelSearchMapper.getPageList(beginRow,endRow,query);
    }

    @Override
    public List<DataModelSearch> getAll() {
        return dataModelSearchMapper.selectAll();
    }


    @Override
    public boolean save(DataModelSearch dataModelSearch) {
        //获取当前登录人的姓名和账号
        //模拟为admin和管理员
        dataModelSearch.setCreate_name("管理员");
        dataModelSearch.setCreate_by("admin");
//      return dataModelSearchMapper.save(DataModelSearch.getDbkey(),DataModelSearch.getSql(),DataModelSearch.getSql_desc(),DataModelSearch.getCreate_name(),DataModelSearch.getCreate_by());
        return dataModelSearchMapper.save2(dataModelSearch);
    }

    @Override
    public boolean delete(String[] id) {
        StringJoiner sj = new StringJoiner("','","'","'");
        for(String i:id){
            sj.add(i);
        }
        System.out.println("id:"+sj.toString());
//      return true;
        return dataModelSearchMapper.delete(sj.toString());
    }

    @Override
    public DataModelSearch getById(String id) {
        return dataModelSearchMapper.getById(id);
    }


    @Override
    public boolean update(DataModelSearch dataModelSearch) {
        //获取当前登录人
        dataModelSearch.setUpdate_by("admin");
        dataModelSearch.setUpdate_name("管理员");
        return dataModelSearchMapper.update(dataModelSearch);
    }
}
