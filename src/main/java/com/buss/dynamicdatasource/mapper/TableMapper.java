package com.buss.dynamicdatasource.mapper;

import com.buss.dynamicdatasource.entity.UserTables;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface TableMapper {

    @Select("SELECT table_name tableName FROM user_tables WHERE 1=1 ${searchSql} ORDER BY table_name ")
    List<UserTables> getAllTables(@Param("searchSql") String searchSql);

    @Select("select * from (\n" +
            "select rownum rownum_,tableName,comments from ( \n" +
            "select u.table_name tableName,c.comments comments FROM user_tables u,user_tab_comments c where 1=1 and u.table_name = c.table_name ${queryStr} ORDER BY u.table_name\n" +
            ")) t where t.rownum_ >=${begin} and t.rownum_ <= ${end}")
    List<UserTables> getPageTables(@Param("begin") Integer begin, @Param("end") Integer end, @Param("queryStr") String queryStr);

    @Select("select * from (select rownum rownum_,t.* from (select ut.TABLE_NAME,ut.COLUMN_NAME,uc.comments,ut.DATA_TYPE,ut.DATA_LENGTH,ut.NULLABLE\n" +
            "from user_tab_columns ut inner JOIN user_col_comments uc\n" +
            "on ut.TABLE_NAME = uc.table_name \n" +
            "and ut.COLUMN_NAME = uc.column_name where ut.Table_Name=#{tableName} order by ut.column_name) t) tab where tab.rownum_ >= #{beginRow} and tab.rownum_ <= #{endRow}")
    List<Map<String,Object>> getPageFieldsByTableName(@Param("tableName") String tableName, @Param("beginRow") Integer beginRow, @Param("endRow") Integer endRow);

    @Select("select ut.TABLE_NAME,ut.COLUMN_NAME,uc.comments,ut.DATA_TYPE,ut.DATA_LENGTH,ut.NULLABLE\n" +
            "from user_tab_columns ut inner JOIN user_col_comments uc\n" +
            "on ut.TABLE_NAME = uc.table_name \n" +
            "and ut.COLUMN_NAME = uc.column_name where ut.Table_Name=#{tableName} order by ut.column_name")
    List<Map<String,Object>> getFieldsByTableName(@Param("tableName") String tableName);

    @Select(value = "SELECT ${fields} FROM ${tableName} WHERE 1 = 1 ${queryStr}")
    List<Map<String,Object>> getAllBySQL(@Param("fields") String fields, @Param("tableName") String tableName, @Param("queryStr") String queryStr);

    @Select("${sql}")
    List<Map<String,Object>> executeSQL(@Param("sql") String sql);

}
