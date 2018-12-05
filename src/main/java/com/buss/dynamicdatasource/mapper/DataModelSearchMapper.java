package com.buss.dynamicdatasource.mapper;

import com.buss.dynamicdatasource.entity.DataModelSearch;
import com.buss.dynamicdatasource.entity.DataModelSearch;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface DataModelSearchMapper {

    @Select("SELECT * FROM data_model_search")
    List<DataModelSearch> selectAll();


    @Select("select * from (\n" +
            "select rownum rownum_,t.* from data_model_search t where 1=1 ${query} order by t.create_date\n" +
            ") tab where tab.rownum_ >= ${begin} and tab.rownum_ <= ${end}")
    List<DataModelSearch> getPageList(@Param("begin") Integer begin, @Param("end") Integer end,@Param("query") String query);

    @Insert("INSERT INTO data_model_search (ID, DBKEY, SQL, SQL_DESC, CREATE_NAME, CREATE_BY, CREATE_DATE, UPDATE_NAME, UPDATE_BY, UPDATE_DATE)" +
        " values (SYS_GUID(),#{dbkey},#{sql},#{sql_desc},#{create_name},#{create_by},sysdate,'','',null)")
    boolean save(@Param("dbkey") String dbkey, @Param("sql") String sql, @Param("sql_desc") String sql_desc,
                 @Param("create_name") String create_name, @Param("create_by") String create_by);

    @Insert("INSERT INTO data_model_search (ID, DBKEY, TABLES, FIELDS, JOIN_TABLES, JOIN_FIELDS, " +
    "JOIN_CONDI, JOIN_CON_FIELDS, QUERY_FIELDS, QUERY_FIELDS_TYPE,QUERY_CONDI, QUERY_VAL, SQL, SQL_DESC, " +
    "CREATE_NAME, CREATE_BY, CREATE_DATE, UPDATE_NAME, UPDATE_BY, UPDATE_DATE) values " +
    "(SYS_GUID(),#{DataModelSearch.dbkey},#{DataModelSearch.tables},#{DataModelSearch.fields}," +
    "#{DataModelSearch.join_tables},#{DataModelSearch.join_fields},#{DataModelSearch.join_condi}," +
    "#{DataModelSearch.join_con_fields},#{DataModelSearch.query_fields},#{DataModelSearch.query_fields_type},#{DataModelSearch.query_condi}," +
    "#{DataModelSearch.query_val},#{DataModelSearch.sql},#{DataModelSearch.sql_desc}," +
    "#{DataModelSearch.create_name},#{DataModelSearch.create_by},sysdate,null,null,null)")
    boolean save2(@Param("DataModelSearch") DataModelSearch dataModelSearch);

    @Delete("delete from data_model_search where 1=1 and id in (${id})")
    boolean delete(@Param("id") String id);

    @Select("SELECT * FROM data_model_search WHERE ID = #{id}")
    DataModelSearch getById(@Param("id") String id);

    @Update("UPDATE data_model_search SET dbkey=#{DataModelSearch.dbkey},sql=#{DataModelSearch.sql},sql_desc=#{DataModelSearch.sql_desc},update_name=#{DataModelSearch.update_name},update_by=#{DataModelSearch.update_by},update_date=sysdate where id=#{DataModelSearch.id}")
    boolean update(@Param("DataModelSearch") DataModelSearch dataModelSearch);

}
