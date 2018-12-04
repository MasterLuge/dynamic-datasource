package com.buss.dynamicdatasource.service.impl;


import com.buss.dynamicdatasource.entity.DataSourceSql;
import com.buss.dynamicdatasource.mapper.DataSourceSqlMapper;
import com.buss.dynamicdatasource.service.DataSourceSqlService;
import com.commons.annotation.DS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.StringJoiner;

@Service
@DS("dgjycy")
public class DataSourceSqlServiceImpl implements DataSourceSqlService {

    @Autowired
    private DataSourceSqlMapper dataSourceSqlMapper;

    @Override
    public List<DataSourceSql> getPageList(Integer pageSize, Integer limit) {


        Integer beginRow = (pageSize-1)*limit+1;
        Integer endRow = pageSize*limit;
        return dataSourceSqlMapper.getPageList(beginRow,endRow);
    }

    @Override
    public List getAll() {
        return dataSourceSqlMapper.selectAll();
    }


    @Override
    public boolean save(DataSourceSql dataSourceSql) {
        //获取当前登录人的姓名和账号
        //模拟为admin和管理员
        dataSourceSql.setCreate_name("管理员");
        dataSourceSql.setCreate_by("admin");
//      return dataSourceSqlMapper.save(dataSourceSql.getDbkey(),dataSourceSql.getSql(),dataSourceSql.getSql_desc(),dataSourceSql.getCreate_name(),dataSourceSql.getCreate_by());
        return dataSourceSqlMapper.save2(dataSourceSql);
    }

    @Override
    public boolean delete(String[] id) {
        StringJoiner sj = new StringJoiner("','","'","'");
        for(String i:id){
            sj.add(i);
        }
        System.out.println("id:"+sj.toString());
//      return true;
        return dataSourceSqlMapper.delete(sj.toString());
    }

    @Override
    public DataSourceSql getById(String id) {
        return dataSourceSqlMapper.getById(id);
    }


    @Override
    public boolean update(DataSourceSql dataSourceSql) {
        //获取当前登录人
        dataSourceSql.setUpdate_by("admin");
        dataSourceSql.setUpdate_name("管理员");
        return dataSourceSqlMapper.update(dataSourceSql);
    }


    @Override
    public String generateSQL(DataSourceSql dataSourceSql) {
        //查询的表
        StringBuffer sbf = new StringBuffer("SELECT ");
        //要查询的字段
        sbf.append(dataSourceSql.getFields());
        sbf.append(" FROM  ");
        //查询的主表
        sbf.append(dataSourceSql.getMain_table());
        //拼接关联语句部分
//        String[] jcfArr = dataSourceSql.getJoin_con_fields().split(",");
        String[] jcfArr = StringUtils.isEmpty(dataSourceSql.getJoin_con_fields())?new String[]{}:dataSourceSql.getJoin_con_fields().split(",");
        String[] jfArr = StringUtils.isEmpty(dataSourceSql.getJoin_fields())?new String[]{}:dataSourceSql.getJoin_fields().split(",");
        String[] jcArr = StringUtils.isEmpty(dataSourceSql.getJoin_condi())?new String[]{}:dataSourceSql.getJoin_condi().split(",");
        String[] jtArr = StringUtils.isEmpty(dataSourceSql.getJoin_tables())?new String[]{}:dataSourceSql.getJoin_tables().split(",");
        for(int i = 0 ;i < jcArr.length ; i ++){
            sbf.append(" ");
            sbf.append(jcArr[i]);
            sbf.append(" ");
            sbf.append(jtArr[i]);
            sbf.append(" ");
            sbf.append(" on ");
            sbf.append(jfArr[i]);
            sbf.append(" = ");
            sbf.append(jcfArr[i]);
        }

        //拼接查询条件
        sbf.append(" where 1 = 1");
        String[] qfArr = StringUtils.isEmpty(dataSourceSql.getQuery_fields())?new String[]{}:dataSourceSql.getQuery_fields().split(",");
        String[] qftArr = StringUtils.isEmpty(dataSourceSql.getQuery_fields_type())?new String[]{}:dataSourceSql.getQuery_fields_type().split(",");
        String[] qcArr = StringUtils.isEmpty(dataSourceSql.getQuery_condi())?new String[]{}:dataSourceSql.getQuery_condi().split(",");
        String[] qvArr = StringUtils.isEmpty(dataSourceSql.getQuery_val())?new String[]{}:dataSourceSql.getQuery_val().split("\\|\\|");

        for(int i = 0 ; i < qfArr.length ; i ++){
            sbf.append(" and ");
            sbf.append(qfArr[i]);
            sbf.append(" ");
            if(qcArr[i].contains("#*")){//判断是否包含了#*,包含则替换
                String str = qcArr[i].replace("#*",qvArr[i]);
                sbf.append(str);
            }else{
                sbf.append(qcArr[i]);
                sbf.append(" ");
                sbf.append(qvArr[i]);
            }
        }
        return sbf.toString();
    }



}
