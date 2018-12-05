package com.buss.dynamicdatasource.entity;

import lombok.Data;

import java.util.Date;

@Data
public class DataModelSearch {

    private String id;
    private String sql;
    private String sql_desc;
    private String dbkey;

    private String query_params;

    private String create_name;
    private String create_by;
    private Date create_date;
    private String update_name;
    private String update_by;
    private Date update_date;

}
