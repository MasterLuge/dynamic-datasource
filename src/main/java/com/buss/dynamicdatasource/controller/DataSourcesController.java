package com.buss.dynamicdatasource.controller;

import com.buss.dynamicdatasource.entity.DataSourceSql;
import com.buss.dynamicdatasource.entity.TableSearchVo;
import com.buss.dynamicdatasource.entity.UserTables;
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
@RequestMapping("/data/source")
public class DataSourcesController {

    @Autowired
    private TableService tableService;

    @Autowired
    private DataSourceSqlService dataSourceSqlService;


    /**
     *  登录页面
     * @return
     */
    @GetMapping("/login")
    public String login(){
        return "datasource/login";
    }


    /**
     * 进行登录
     */
    @GetMapping("/doLogin")
    public String doLogin(){
        return "datasource/datasourceList";
    }


    /**
     * 主页
     * @param m
     * @return
     */
    @GetMapping("/main")
    public String main(Model m){
        return "datasource/main";
    }

    /**
     * 获取默认库的所有表
     * @param m
     * @return
     */
    @GetMapping("/get/tables")
    public String getTablesByKey(Model m, HttpServletRequest req, String dbkey){
        String searchName = req.getParameter("searchName");

        m.addAttribute("dbkey",dbkey);
        List<UserTables> tables = tableService.getAllTables(dbkey,searchName);
        m.addAttribute("total",tables.size());
        return "datasource/tableList";
    }

    @GetMapping("/get/tableList")
    @ResponseBody
    public List<UserTables> getTableDatas(HttpServletRequest req, String dbkey){
        String searchName = req.getParameter("searchTable");
        System.out.println("tableList: dbkey>>>>>"+dbkey);
//      String dbkey = req.getParameter("dbkey");

        Integer page = StringUtils.isEmpty(req.getParameter("page"))?1:Integer.parseInt(req.getParameter("page"));
        Integer limit = StringUtils.isEmpty(req.getParameter("limit"))?10:Integer.parseInt(req.getParameter("limit"));
        List<UserTables> tableList = tableService.getPageTables(page,limit,searchName,dbkey);

        return tableList;
    }

    @GetMapping("/all/tables")
    @ResponseBody
    public Map<String,Object> getAllTables(HttpServletRequest req, String dbkey){
        String searchName = req.getParameter("searchName");
        Map<String,Object> map = new HashMap<String,Object>();

        List<UserTables> tableAlls = new ArrayList<UserTables>();
        tableAlls = tableService.getAllTables(dbkey,searchName);


        Integer page = StringUtils.isEmpty(req.getParameter("page"))?1:Integer.parseInt(req.getParameter("page"));
        Integer limit = StringUtils.isEmpty(req.getParameter("limit"))?10:Integer.parseInt(req.getParameter("limit"));
        List<UserTables> tableList = tableService.getPageTables(page,limit,searchName,dbkey);

        map.put("tableAlls",tableAlls);
        map.put("tableList",tableList);
        return map;
    }


    @RequestMapping("/fields")
    public String getFields(HttpServletRequest req, String tableName, Model m, String dbkey){
        tableName = tableName.toUpperCase();
        List<Map<String,Object>> mapList = tableService.getFieldsByTableName(tableName,dbkey);
        m.addAttribute("mapList",mapList);
        return "datasource/fields";
    }

    /**
     * 根据筛选条件查询结果
     * @param req
     * @param vo
     * @return
     */
    @PostMapping("/getResults")
    @ResponseBody
    public List<Map<String,Object>> getResults(HttpServletRequest req, @RequestBody TableSearchVo vo, String dbkey){
        //1.拼接生成sql
        System.out.println("vo:"+vo.toString());
        List<Map<String,Object>> list = tableService.getAllBySQL(vo,dbkey);
        return list;
    }


    /**
     * 获取保存的sql
     */
    @GetMapping("/sql/list")
    public String getSqlList(HttpServletRequest req, Model m, String dbkey){
        dbkey = StringUtils.isEmpty(dbkey)?"":dbkey;
        System.out.println("dbkey:"+dbkey);
        List<DataSourceSql> list = dataSourceSqlService.getAll();
        m.addAttribute("total",list.size());
        return "datasource/sqlList";
    }

    @GetMapping("/get/sqlList")
    @ResponseBody
    public List<DataSourceSql> getSqlList(HttpServletRequest req){
        List<DataSourceSql> list =  new ArrayList<DataSourceSql>();

        Integer page = StringUtils.isEmpty(req.getParameter("page"))?1:Integer.parseInt(req.getParameter("page"));
        Integer limit = StringUtils.isEmpty(req.getParameter("limit"))?10:Integer.parseInt(req.getParameter("limit"));
        list = dataSourceSqlService.getPageList(page,limit);
        return list;
    }


    @RequestMapping("/doSearch")
    public String doSearch(HttpServletRequest req, String tableName, Model m, String dbkey){
        tableName = tableName.toUpperCase();
        List<Map<String,Object>> mapList = tableService.getFieldsByTableName(tableName,dbkey);
        m.addAttribute("mapList",mapList);
        return "datasource/fields";
    }


    @GetMapping("/query/list")
    public String queryList(HttpServletRequest req, DataSourceSql dataSourceSql, Model m){
        //根据dbkey，决定要使用的数据源
        dataSourceSql = dataSourceSqlService.getById(dataSourceSql.getId());

        //列注释
        String comments = dataSourceSql.getComments();
        if(!StringUtils.isEmpty(comments)){
            String[] commentArr = comments.split(",");
            Map<String,Object> commentMap = new HashMap<>();
            for(String c:commentArr){
                String[] str = c.split("_");
                if(str.length == 2){//有注释的
                    commentMap.put(str[0],str[1]);
                }else if(str.length == 1){//没有注释的，注释设置""
                    commentMap.put(str[0],"");
                }
            }
            m.addAttribute("commentMap",commentMap);
        }
        List<Map<String,Object>> resultMapList = tableService.executeSQL(dataSourceSql.getSql(),dataSourceSql.getDbkey());
        m.addAttribute("resultMapList",resultMapList);
        return "datasource/queryList";
    }



    @GetMapping("/doQuery")
    @ResponseBody
    public List doQuery(HttpServletRequest req, String sql, String dbkey){
        List<Map<String,Object>> resultMapList = tableService.executeSQL(sql,dbkey);
        return resultMapList;
    }

    @GetMapping("/goAdd")
    public String goAdd(HttpServletRequest req, Model m){
        //t_s_typegroup,是不是每个数据源都有
//      List<Map<String,Object>> typegroupList = tableService.executeSQL();
//        m.addAttribute("typegroupList",typegroupList);
        return "datasource/sql_add";
    }

    @PostMapping("/get/result")
    @ResponseBody
    public DataSourceSql getResult(HttpServletRequest req, @RequestBody DataSourceSql dataSourceSql){
        //获取到sql与dbkey
        String sql = dataSourceSqlService.generateSQL(dataSourceSql);
        dataSourceSql.setSql(sql);
        return dataSourceSql;
    }

    @PostMapping("/doAdd")
    @ResponseBody
    public boolean doAdd(HttpServletRequest req, @RequestBody DataSourceSql dataSourceSql){
        System.out.println("dataSrouceSql:"+dataSourceSql);
        String sql = dataSourceSqlService.generateSQL(dataSourceSql);
        dataSourceSql.setSql(sql);
        return dataSourceSqlService.save(dataSourceSql);
    }

    @DeleteMapping("/del")
    @ResponseBody
    public void del(HttpServletRequest req, String id){
        String[] idArr = id.split(",");
        System.out.println("id:"+idArr.toString());
        dataSourceSqlService.delete(idArr);
    }

    /**
     * 根据id获取
     */
    @GetMapping("/update/{id}")
    public String goUpdate(HttpServletRequest req, @PathVariable("id") String id, Model m){
        DataSourceSql dataSourceSql =  dataSourceSqlService.getById(id);
        m.addAttribute("dataSourceSql",dataSourceSql);
        return "datasource/sql_update";
    }

    @PostMapping("/do/update")
    @ResponseBody
    public boolean update(@RequestBody DataSourceSql dataSourceSql){
        System.out.println("dataSourceSql:"+dataSourceSql);
        return dataSourceSqlService.update(dataSourceSql);
    }

    @GetMapping("/all/fields")
    @ResponseBody
    public Map<String,Object> getFieldsByTableName(HttpServletRequest req, String table, String dbkey){
        Map<String,Object> map = new HashMap<String,Object>();

        Integer page = StringUtils.isEmpty(req.getParameter("page"))?1:Integer.parseInt(req.getParameter("page"));
        Integer limit = StringUtils.isEmpty(req.getParameter("limit"))?10:Integer.parseInt(req.getParameter("limit"));
        //查询分页数据
        List<Map<String,Object>> fieldPageList = tableService.getPageFieldsByTableName(table,dbkey,page,limit);
        map.put("fieldPageList",fieldPageList);
        //查询总数据
        List<Map<String,Object>> fieldAllList = tableService.getFieldsByTableName(table,dbkey);
        map.put("fieldAllList",fieldAllList);
        return map;
    }

}
