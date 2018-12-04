package com.buss.dynamicdatasource.vo;

import lombok.Data;

@Data
public class SearchVo {

    private String dbkey;
    private String tables;
    private String fields;
    private String[] querys;
    private String sql_desc;
    private String[] connects;
    private String main_searchTable;
}
