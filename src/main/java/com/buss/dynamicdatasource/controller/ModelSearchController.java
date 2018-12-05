package com.buss.dynamicdatasource.controller;

import com.buss.dynamicdatasource.entity.DataModelSearch;
import com.buss.dynamicdatasource.service.DataModelSearchService;
import com.buss.dynamicdatasource.service.DataSourceSqlService;
import com.buss.dynamicdatasource.service.TableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
@RequestMapping("/model/search")
public class ModelSearchController {

    @Autowired
    private TableService tableService;

    @Autowired
    private DataSourceSqlService dataSourceSqlService;

    @Autowired
    private DataModelSearchService dataModelSearchService;

    /**
     * 列表页面
     * @return
     */
    @GetMapping("/list")
    public String list(Model m,HttpServletRequest req){
        //全部数据
        List<DataModelSearch> allList = dataModelSearchService.getAll();
        m.addAttribute("total",allList.size());
        return "modelsearch/modelSearchList";
    }


    /**
     * 获取记录
     * @return
     */
    @GetMapping("/datagrid")
    @ResponseBody
    public Map<String,Object> datagrid(HttpServletRequest req,String dbkey){
        System.out.println("datagrid>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        Map<String,Object> map = new HashMap<>();

        Integer page = StringUtils.isEmpty(req.getParameter("page"))?1:Integer.parseInt(req.getParameter("page"));
        Integer limit = StringUtils.isEmpty(req.getParameter("limit"))?10:Integer.parseInt(req.getParameter("limit"));
        //分页数据
        List<DataModelSearch> resultList = dataModelSearchService.getPageList(page,limit,dbkey);
        map.put("resultList",resultList);
        //全部数据
        List<DataModelSearch> allList = dataModelSearchService.getAll();
        map.put("allList",allList);
        return map;
    }


    /**
     * 获取查询结果
     * @param req
     * @param dataModelSearch
     * @return
     */
    @GetMapping("/doSearch")
    @ResponseBody
    public List<Map<String,Object>> doSearch(HttpServletRequest req,DataModelSearch dataModelSearch){
        List<Map<String,Object>> list = new ArrayList<>();
        try{
            if(StringUtils.isEmpty(dataModelSearch.getId())){
                dataModelSearch = dataModelSearchService.getById(dataModelSearch.getId());
                String sql = dataModelSearch.getSql();
                list = tableService.executeSQL(sql,dataModelSearch.getDbkey());
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }


    @GetMapping("/goAdd")
    public String goAdd(HttpServletRequest req){
        return "modelsearch/model_add";
    }

}
