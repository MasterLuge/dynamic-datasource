package com.buss.dynamicdatasource.service.impl;


import com.buss.dynamicdatasource.entity.TableSearchVo;
import com.buss.dynamicdatasource.entity.UserTables;
import com.buss.dynamicdatasource.mapper.TableMapper;
import com.buss.dynamicdatasource.service.TableService;
import com.commons.annotation.DS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

@Service
@DS("dgjycy")
public class TableServiceImpl implements TableService {

    @Autowired
    private TableMapper tableMapper;

    @DS("#dbkey") //默认是master可以省略这个注解,如果在类上注解了其他库，则@DS("master")不能省略
    @Override
    public List<UserTables> getAllTables(String dbkey, String searchName) {
        String searchSql = "";
        if(!StringUtils.isEmpty(searchName)){
            searchName = searchName.replace(",","|").toUpperCase();
            searchSql += " AND regexp_like(table_name,'("+searchName+")')";
//            searchSql += " AND table_name like '%"+searchName.toUpperCase()+"%'";
        }
        return tableMapper.getAllTables(searchSql);
    }

    @DS("#dbkey")
    @Override
    public List<UserTables> getPageTables(Integer pageSize, Integer limit, String searchName, String dbkey) {

        String queryStr = "";
        if(!StringUtils.isEmpty(searchName)){
            searchName = searchName.replace(",","|").toUpperCase();
            queryStr += " AND regexp_like(u.table_name,'("+searchName+")')";
//            queryStr += " and table_name like '%"+searchName.toUpperCase()+"%'";
        }

        Integer beginRow = (pageSize-1)*limit+1;
        Integer endRow = pageSize*limit;
        return tableMapper.getPageTables(beginRow,endRow,queryStr);
    }

    @DS("#dbkey")
    @Override
    public List getPageFieldsByTableName(String tableName,String dbkey,Integer page,Integer limit) {
        Integer beginRow = (page-1)*limit+1;
        Integer endRow = page*limit;
        return tableMapper.getPageFieldsByTableName(tableName,beginRow,endRow);
    }

    @DS("#dbkey")
    @Override
    public List getFieldsByTableName(String tableName,String dbkey) {
        return tableMapper.getFieldsByTableName(tableName);
    }

    @DS("#dbkey")
    @Override
    public List getAllBySQL(TableSearchVo vo, String dbkey) {
        List<String> fieldList = vo.getFieldList();
        List<String> queryList = vo.getQueryList();
        String fields = "";
        String querys = "";
        if(fieldList != null && fieldList.size() > 0){
            StringJoiner joiner = new StringJoiner(",");
            for(String field:fieldList){
                fields = joiner.add(field).toString();
            }
        }else{
            fields = "*";
        }
        //查询条件
        for(String query:queryList){
            querys += " AND "+query;
        }
        List resultList = tableMapper.getAllBySQL(fields,vo.getTableName().toUpperCase(),querys);
//        List resultList = tableMapper.getAllBySQL2(fields,querys);
        return resultList;
    }

    @DS("#dbkey")
    @Override
    public List<Map<String,Object>> executeSQL(String sql,String dbkey) {
        return tableMapper.executeSQL(sql);
    }
}
