package com.buss.dynamicdatasource.entity;

import lombok.Data;

import java.util.Date;

@Data
public class DataSourceSql {

    private String id;
    private String sql;
    private String sql_desc;
    private String dbkey;
    /**要查询的表**/
    private String tables;
    /**要显示的列**/
    private String fields;
    /**列注释**/
    private String comments;
    /**查询的主表(要被关联的表)**/
    private String main_table;
    /**要被关联的表**/
    private String join_tables;
    /**要被关联的字段**/
    private String join_fields;
    /**关联条件**/
    private String join_condi;
    /**关联字段**/
    private String join_con_fields;

    /**查询字段*/
    private String query_fields;
    /**查询字段类型**/
    private String query_fields_type;
    /**查询条件*/
    private String query_condi;
    /**条件值*/
    private String query_val;

    private String create_name;
    private String create_by;
    private Date create_date;

    private String update_name;
    private String update_by;
    private Date update_date;

}
