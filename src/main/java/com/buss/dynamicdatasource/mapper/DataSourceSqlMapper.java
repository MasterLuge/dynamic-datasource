package com.buss.dynamicdatasource.mapper;

import com.buss.dynamicdatasource.entity.DataSourceSql;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface DataSourceSqlMapper {

    @Select("SELECT * FROM data_source_sql")
    List<DataSourceSql> selectAll();


    @Select("select * from (\n" +
            "select rownum rownum_,t.* from data_source_sql t order by t.create_date\n" +
            ") tab where tab.rownum_ >= ${begin} and tab.rownum_ <= ${end}")
    List<DataSourceSql> getPageList(@Param("begin") Integer begin, @Param("end") Integer end);

    @Insert("INSERT INTO data_source_sql (ID, DBKEY, SQL, SQL_DESC, CREATE_NAME, CREATE_BY, CREATE_DATE, UPDATE_NAME, UPDATE_BY, UPDATE_DATE)" +
        " values (SYS_GUID(),#{dbkey},#{sql},#{sql_desc},#{create_name},#{create_by},sysdate,'','',null)")
    boolean save(@Param("dbkey") String dbkey, @Param("sql") String sql, @Param("sql_desc") String sql_desc,
                 @Param("create_name") String create_name, @Param("create_by") String create_by);

    @Insert("INSERT INTO data_source_sql (ID, DBKEY, TABLES, FIELDS, JOIN_TABLES, JOIN_FIELDS, " +
    "JOIN_CONDI, JOIN_CON_FIELDS, QUERY_FIELDS, QUERY_FIELDS_TYPE,QUERY_CONDI, QUERY_VAL, SQL, SQL_DESC, " +
    "CREATE_NAME, CREATE_BY, CREATE_DATE, UPDATE_NAME, UPDATE_BY, UPDATE_DATE) values " +
    "(SYS_GUID(),#{dataSourceSql.dbkey},#{dataSourceSql.tables},#{dataSourceSql.fields}," +
    "#{dataSourceSql.join_tables},#{dataSourceSql.join_fields},#{dataSourceSql.join_condi}," +
    "#{dataSourceSql.join_con_fields},#{dataSourceSql.query_fields},#{dataSourceSql.query_fields_type},#{dataSourceSql.query_condi}," +
    "#{dataSourceSql.query_val},#{dataSourceSql.sql},#{dataSourceSql.sql_desc}," +
    "#{dataSourceSql.create_name},#{dataSourceSql.create_by},sysdate,null,null,null)")
    boolean save2(@Param("dataSourceSql") DataSourceSql dataSourceSql);

    @Delete("delete from data_source_sql where 1=1 and id in (${id})")
    boolean delete(@Param("id") String id);

    @Select("SELECT * FROM DATA_SOURCE_SQL WHERE ID = #{id}")
    DataSourceSql getById(@Param("id") String id);

    @Update("UPDATE DATA_SOURCE_SQL SET dbkey=#{dataSourceSql.dbkey},sql=#{dataSourceSql.sql},sql_desc=#{dataSourceSql.sql_desc},update_name=#{dataSourceSql.update_name},update_by=#{dataSourceSql.update_by},update_date=sysdate where id=#{dataSourceSql.id}")
    boolean update(@Param("dataSourceSql") DataSourceSql dataSourceSql);

}
