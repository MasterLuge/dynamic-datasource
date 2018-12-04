package com.buss.dynamicdatasource.entity;

import lombok.Data;

import java.util.List;

@Data
public class TableSearchVo {

    private List<String> fieldList;

    private List<String> queryList;

    private String tableName;
}
