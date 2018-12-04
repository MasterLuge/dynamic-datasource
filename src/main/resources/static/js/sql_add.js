layui.extend({
    admin: '{/}/weadmin/js/admin'
});

layui.use(['form','table', 'jquery','util','admin', 'layer','laydate'], function() {
    var form = layui.form,
        $ = layui.jquery,
        util = layui.util,
        admin = layui.admin,
        layer = layui.layer,
        table = layui.table,
        laydate = layui.laydate;
    var fieArr = new Array();
    // var tableContent = [];

    //自定义验证规则
    form.verify({
        pass: [/(.+){6,12}$/, '密码必须6到12位'],
        repass: function(value) {
            if($('#L_pass').val() != $('#L_repass').val()) {
                return '两次密码不一致';
            }
        }
    });
    //失去焦点时判断值为空不验证，一旦填写必须验证
    $('input[name="email"]').blur(function(){
        //这里是失去焦点时的事件
        if($('input[name="email"]').val()){
            $('input[name="email"]').attr('lay-verify','email');
        }else{
            $('input[name="email"]').removeAttr('lay-verify');
        }
    });

    //监听提交
    form.on('submit(add)', function(data) {
        //console.log(data.field);
        var f = data.field;
        // alert(JSON.stringify(f));
        //提取要素
        //1.数据源
        var dbkey = f.dbkey;
        //2.表名称
        var tables = f.tables;
        //3.查询的字段名
        var fields = f.fields;

        //被关联的列
        var join_fields = [];
        //被关联的表
        var join_tables = [];
        //关联条件
        var join_condi = [];
        //关联的列
        var join_con_fields = [];

        //4.1获取关联条件
        var connectList = $("#connectBody").children("tr");
        for(var i = 0 ; i < connectList.length ; i++){
            var tdArr = connectList.eq(i).find("td");
            //被关联的列
            join_fields.push(tdArr.eq(0).find("select").val());
            //关联条件
            join_condi.push(tdArr.eq(1).find("select").val());
            //关联的列
            var field = tdArr.eq(2).find("select").val();
            join_tables.push(field.split(".")[0]);
            join_con_fields.push(tdArr.eq(2).find("select").val());
        }

        //4.2查询条件    遍历条件table表
        var trList = $("#queryBody").children("tr");
        //被查询的列
        var query_fields = [];
        //列注释
        var fields_comment = [];
        //列的数据类型
        var query_fields_type = [];
        //关联条件
        var query_condi = [];
        //查询的值
        var query_val = [];
        for(var i = 0 ; i < trList.length ; i++){
            var tdArr = trList.eq(i).find("td");
            //表名
            var query_tables = tdArr.eq(0).find("select").val();
            //字段名
            query_fields.push(query_tables+"."+tdArr.eq(1).find("select").val());
            //字段列的类型
            var dataType = tdArr.eq(1).find("select").find("option:selected").attr("fieldtype")
            //值
            query_fields_type.push(dataType);
            if("DATE" == dataType){
                var val = "to_date('"+tdArr.eq(3).find("input").val()+"','yyyy-MM-dd')";
                query_val.push(val);
            }else{
                query_val.push(tdArr.eq(3).find("input").val());
            }
            //条件
            query_condi.push(tdArr.eq(2).find("select").val());
        }
        //5.描述
        var sql_desc = f.sql_desc;
        //6.获取查询主表(激活的表)
        var main_table = $(".layui-show").find("table").eq(0).attr("id");

        $.ajax({
            url: '/data/source/doAdd',
            type: 'post',
            dataType:'json',
            contentType: "application/json;charset=UTF-8",
            // data : JSON.stringify(f),
            data:JSON.stringify({
                dbkey:dbkey
                ,tables:tables
                ,fields:fields
                ,main_table:main_table
                ,join_tables:join_tables.join()
                ,join_fields:join_fields.join()
                ,join_condi:join_condi.join()
                ,join_con_fields:join_con_fields.join()
                ,query_fields:query_fields.join()
                ,query_fields_type:query_fields_type.join()
                ,query_condi:query_condi.join()
                ,query_val:query_val.join()
                ,sql_desc:sql_desc
            }),
            sync: false,
            cache: false,
            success : function(result){
                layer.msg('提交成功，返回列表页面'
                    ,{
                        icon:1,
                        time:2000
                    }
                    ,function(){
                        document.location.href = '/data/source/sql/list';
                        // return false;
                    });
            }
        });
        return false;//阻止跳转
    });

    /**
     * 获取列
     * **/
    //点击添加查询表
    window.addTable = function(){
        //获取要搜索的表名
        var searchName = $("#search_table").val();
        // $('#tabList').html('');
        var dbkey = $("#dbkey").val();
        //1.获取数据源的值,进行渲染
        // layer.msg(dbkey);
        if(dbkey){
            table.render({
                elem: '#tabList'
                ,url:'/data/source/all/tables'
                ,where: {
                    dbkey:dbkey
                    ,searchName:searchName.trim()
                }
                ,toolbar: '#tab_btn'
                ,title: '查询数据表'
                ,totalRow: true
                ,cols: [[
                    {
                        field:'tab_checkbox',type:'checkbox',fixed:'left',event:'changeCheckbox'
                    }
                    ,{
                        field:'tableName', title:'表名', width:300, fixed: 'left',
                        unresize: true, sort: true
                        // ,totalRowText: '合计行'
                    }
                    ,{
                        field:'comments',title:'表描述',width:300
                    }
                ]]
                ,page: true
                ,response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
                ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                    // alert(res.tableAlls.length);
                    return {
                        "code": 200, //解析接口状态
                        "msg": '查询结果', //解析提示文本
                        "count": res.tableAlls.length, //解析数据长度
                        "data": res.tableList //解析数据列表
                    };
                }
            });
        }else{
            layer.msg('请先选择数据源');
            return false;
        }
    }
    
    var tables = [];
    var table_fieldMap = new Map();

    window.addField = function () {
        //每次点击都要重新初始化，否则会叠加
        tables = [];
        searchArr = [];//清空查询字段
        //获取表以及表对应的字段信息
        var dbkey = $("#dbkey").val();
        //获取选中的表
        var checkStatus = table.checkStatus('tabList'),data = checkStatus.data;
        if(data && data.length > 0){
            //清空
            $("#tab_ul").html("");//清空ul
            $("#tab_content").html("");//清空展示内容区
            $("#connectBody").html("");//清空关联条件区
            $("#queryBody").html("");//清空关联条件区
            $("#tables").val("");//清空查询表
            $("#fields").val("");//清空字段表

            for(var x = 0 ; x < data.length ; x++){
                tables.push(data[x].tableName);
                var id = data[x].tableName;
                //动态添加li
                // var tableHtml = getTableHtml(data[x].tableName,dbkey);
                var tableHtml = "<table id=\""+id+"\" lay-filter=\"tabFilter\" class=\"layui-table\"></table>";
                if(x == 0){
                    $("#tab_ul").append("<li class=\"layui-this\">表"+data[x].tableName+"</li>");
                    //获取数据表列，并生成table的html
                    $("#tab_content").append("<div class=\"layui-tab-item layui-show\">"+tableHtml+"</div>");
                }else{
                    $("#tab_ul").append("<li>表"+data[x].tableName+"</li>");
                    $("#tab_content").append("<div class=\"layui-tab-item\">"+tableHtml+"</div>");
                }
                var tableStr = tables.join();
                $("#tables").val(tableStr);//重新赋值要查询的表
                //渲染字段表
                table.render({
                    elem: '#'+id
                    ,url:'/data/source/all/fields'
                    ,where: {
                        dbkey:dbkey,
                        table:data[x].tableName
                    }
                    // ,toolbar: '#searchField'
                    ,title: '查询列'
                    ,totalRow: true
                    ,data: fieArr
                    ,cols: [[
                        // {type:'checkbox',fixed:'left'}
                        {field:'TABLE_NAME', title:'所属表'}
                        ,{field:'COLUMN_NAME', title:'列名'}
                        ,{field:'DATA_TYPE', title:'数据类型'}
                        ,{field:'DATA_LENGTH', title:'列长度'}
                        ,{field:'NULLABLE', title:'列是否可为空'}
                        ,{field:'COMMENTS', title:'列描述'}
                        //每个数据源都有吗
                        // ,{field: 'dictionary',title: '字典code',templet: '#dictionaryHtml',unresize: true}
                        ,{field: 'isShow',title: '是否显示',templet: '#showHtml',unresize: true}
                        ,{field: 'isConnect',title: '设为关联条件',templet: '#connectHtml',unresize: true}
                    ]]
                    ,page: true
                    ,response: {
                        statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                    }
                    ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                        // alert(res.length);
                        return {
                            "code": 200, //解析接口状态
                            "msg": '查询结果', //解析提示文本
                            "count": res.fieldAllList.length, //解析数据长度
                            "data": res.fieldPageList, //解析数据列表
                            "all":res.fieldAllList
                        };
                    }
                    ,done: function(res){//再次查询重置条件表(重新查询需要给条件项已存在的表下拉添加表选项)
                        var list = res.all;
                        var arr = [];
                        for(var i in list){
                            var obj = {"COLUMN_NAME":list[i].COLUMN_NAME,"DATA_TYPE":list[i].DATA_TYPE}
                            // arr.push(list[i].COLUMN_NAME);
                            arr.push(obj);
                        }
                        table_fieldMap.set(list[0].TABLE_NAME,arr);
                        //已存在的下拉选项添加opt,此次查询没有的表要删除
                        // $("select[id^='tablename_'] ").each(function(index,e){
                        //     for(var x in tables){
                        //         var len = $(this).find("option[value='"+tables[x]+"']").length;
                        //         // alert(len);
                        //         if(len <= 0){//添加
                        //             $(this).append("<option value=\""+tables[x]+"\">"+tables[x]+"</option>");
                        //         }
                        //     }
                        // });
                    }
                });
            }
        }else{
            layer.msg('请先选择表');
            return false;
        }
    }

    function getTableHtml(tableName,dbkey){
        var html = "";
        $.ajax({
            url:'/data/source/all/fields',
            type:'get',
            data:{
                dbkey:dbkey
                ,tables:tableName
            },
            async:false,
            success:function (fieldList) {
                alert(fieldList);
                //表头
                html = "<table id=\""+tableName+"\" lay-filter=\"result\">" +
                    "<thead><tr>" +
                    "<th lay-data=\"{field\:\'XH\', width\:100}\">序号</th>";
                    for(var key in fieldList[0]){
                        html += "<th nowrap lay-data=\"{field\:\'"+key+"\'}\">"+key+"</th>";
                    }
                    //添加开关
                    html += "<th nowrap data=\"{field\:\'isShow\',template:\'#showHtml\'}\">是否显示</th><th nowrap data=\"{field:'isConnect',template:'#connectHtml'}\">是否关联</th>";
                    //表body部分
                    html += "</tr></thead><tbody>";
                    for(var i = 0 ; i < fieldList.length ; i++){
                        html += "<tr><td nowrap>"+Number(i+1)+"</td>";
                        for(var key in fieldList[i]){
                            html += "<td nowrap>"+fieldList[i][key]+"</td>";
                        }
                        html += "</tr>";
                    }
                    html += "</tbody></table>";
            }
        });
        return html;
    }

    var searchArr = [];
    var commentArr = [];
    form.on('switch(checkShow)',function(obj){
        // var fields = layui.table.cache.fieldList;
        // 获取当前控件
        var selectIfKey=obj.othis;
        // 获取当前所在行
        var parentTr = selectIfKey.parents("tr");
        // 获取当前所在行的索引
        var parentTrIndex = parentTr.attr("data-index");
        var tid = $(".layui-show").find("table").attr("id");
        var fields =  table.cache[tid];

        var e = fields[parentTrIndex].TABLE_NAME+"."+fields[parentTrIndex].COLUMN_NAME;
        var index = searchArr.indexOf(e);
        // alert(fields[parentTrIndex].TABLE_NAME+"."+fields[parentTrIndex].COLUMN_NAME);
        if(obj.elem.checked == true ) {//添加该列为查询列
            //并且在searchArr中没有此元素，则添加
            if(index == -1){//未找到该元素
                searchArr.push(fields[parentTrIndex].TABLE_NAME+"."+fields[parentTrIndex].COLUMN_NAME);
                // commentArr.push(fields[parentTrIndex].TABLE_NAME+"."+fields[parentTrIndex].COLUMN_NAME+"-"+fields[parentTrIndex].COMMENTS);
            }
        }else{//移除该元素
            if(index > -1){//找到了该元素
                searchArr.splice(index,1);
                // commentArr.splice(index,1);
            }
        }
        //重新赋值
        $("#fields").val(searchArr.join());
        $("#comments").val(commentArr.join());
    });

    connectArr = [];
    form.on('switch(checkConnect)',function (obj) {
        var selectIfKey=obj.othis;
        // 获取当前所在行
        var parentTr = selectIfKey.parents("tr");
        // 获取当前所在行的索引
        var parentTrIndex = parentTr.attr("data-index");
        //获取当前激活的tab的id
        var tid = $(".layui-show").find("table").attr("id");
        var fields =  table.cache[tid];

        var cont = fields[parentTrIndex].TABLE_NAME +"."+ fields[parentTrIndex].COLUMN_NAME;
        var index = connectArr.indexOf(cont);

        var connectTrList = $("#connectBody").find("tr");

        if(obj.elem.checked == true) {//设为关联列
            //获取到当前行的表名和字段名
            if(index == -1){
                connectArr.push(cont);
                //已经存在tr的添加此选项
                var tableOpts = "<option value=\""+cont+"\">"+cont+"</option>";

                for(var i = 0 ; i < connectTrList.length ; i++){
                    var tr = connectTrList.eq(i);
                    $(tr).find("select[id^='con_field']").append(tableOpts);
                    $(tr).find("select[id^='con_joinfield']").append(tableOpts);
                    // $("select[id='con_field_"+index+"']").append(tableOpts);
                    // $("select[id='con_joinfield_"+index+"']").append(tableOpts);
                }
            }
        }else{//移除关联列
            if(index > -1){
                connectArr.splice(index,1);
            }
            //已经存在的tr删除此选项,判断是否选中，选中的要移除整行
            for(var i = 0 ; i < connectTrList.length ; i++){
                var tr = connectTrList.eq(i);

                if($(tr).find("select[id^='con_field']").val() == cont ||
                    $(tr).find("select[id^='con_joinfield']").val() == cont){//该值至少被其中一个选中，移除整行
                    $(tr).remove();
                }else{//移除该选项
                    $(tr).find("select[id^='con_field']").find("option[value='"+cont+"']").remove();
                    $(tr).find("select[id^='con_joinfield']").find("option[value='"+cont+"']").remove();
                }
            }
        }
        //重新渲染
        form.render();
    });

    window.addQuery = function(){
        //判断是否已经查出字段表
        var fields = layui.table.cache.fieldList;
        // if(!fields){
        //     layer.msg('请先完成表的查询');
        //     return false;
        // }

        var index = 0;
        var idVal =  $("#queryTable tr:last").attr("id");
        if(idVal){
            index = Number(idVal.substr(idVal.length - 1)) + 1;
        }
        var html = "<tr id=\"queryTr_"+index+"\">" +
            "<td><select id=\"tablename_"+index+"\" lay-filter=\"query_tableName\" name=\"tablename["+index+"]\" class=\"layui-select\" ></select></td>" +
            "<td><select id=\"field_"+index+"\" lay-filter=\"query_field\" fType=\"\" name=\"field\" class=\"layui-form-select\" onchange=\"setValCss(this);\"><option value=\"\">--请选择--</option></select></td>" +
            "<td><select id=\"condi_"+index+"\" name=\"condi\" class=\"layui-form-select\">" +
            "<option value=\"\">--请选择--</option>" +
            "<option value=\">\">大于</option>" +
            "<option value=\">=\">大于等于</option>" +
            "<option value=\"=\">等于</option>" +
            "<option value=\"<=\">小于等于</option>" +
            "<option value=\"<\">小于</option>" +
            "<option value=\"like \'%#*%\'\">全匹配</option>" +
            "<option value=\"like \'#*%\'\">左匹配</option>" +
            "<option value=\"like \'%#*\'\">右匹配</option>" +
            "</select></td>" +
            "<td><input type=\"text\" name=\"queryVal_"+index+"\" id=\"queryVal_"+index+"\" class=\"layui-input\" /></td>" +
            "<td><span onclick=\"delTr(this);\"><i class=\"layui-icon\">&#xe640;</i></span></td>" +
            "</tr>";
        $("#queryBody").append(html);//添加节点
        //添加表选项
        var tableOpts = "<option value=\"\">--请选择--</option>";
        for(var x in tables){
            tableOpts += "<option value=\""+tables[x]+"\">"+tables[x]+"</option>"
        }
        $("select[id='tablename_"+index+"']").append(tableOpts);
        //重新渲染表单
        form.render();
    }

    /**
     * 查询条件，根据表名获取字段名称
     */
    form.on('select(query_tableName)',function (data) {
        var obj = data.elem;
        var id = $(obj).attr("id");
        var index = id.substr(id.length-1);
        $("#field_"+index).html("<option value=\"\">--请选择--</option>");

        if(data.value){//根据表名添加对应的字段名为选项
            var fieldOpts = "";
            var fs = table_fieldMap.get(data.value);
            for(var x in fs){
                var fieldName = fs[x].COLUMN_NAME;
                var fieldType = fs[x].DATA_TYPE;
                fieldOpts += "<option value=\""+fieldName+"\" fieldType=\""+fieldType+"\">"+fieldName+"</option>"
            }
            $("#field_"+index).append(fieldOpts);
        }
        //重新渲染表单
        form.render();
    });

    /**
     * 根据要查询的字段，datatype属性
     * @param obj
     */
    form.on('select(query_field)',function (data) {
        //获取datatype自定义属性，存放字段的datatype类型
        var obj = data.elem;
        var id = $(obj).attr("id");
        var index = id.substr(id.length-1);
        //获取类型
        var fieldtype = $(obj).find("option:selected").attr("fieldtype");
        var target_id = "queryVal_"+index;
        //如果类型是date，则渲染date
        if(fieldtype == 'DATE'){
            //清空值
            $("#"+target_id).val("");
            laydate.render({
                elem: '#'+target_id //指定元素
            });
        }else{
            //重生生成页面元素
            var html = "<input type=\"text\" name=\"queryVal_"+index+"\" id=\"queryVal_"+index+"\" class=\"layui-input\" />";
            var parent = $("#"+target_id).parent();
            parent.html(html);
        }
        form.render();
    });


    /**
     * 添加连接条件
     */
    window.addConnect = function(){
        //判断是否已经查出字段表
        if(connectArr.length <= 0){
            layer.msg("请先选择关联列");
            return false;
        }

        var index = 0;
        var idVal =  $("#connectTable tr:last").attr("id");
        if(idVal){
            index = Number(idVal.substr(idVal.length - 1)) + 1;
        }
        var html = "<tr id=\"connectTr_"+index+"\">" +
            "<td><select id=\"con_field_"+index+"\" name=\"field\" class=\"layui-form-select\" ></select></td>" +
            "<td><select id=\"con_condi_"+index+"\" name=\"condi\" class=\"layui-form-select\" >" +
            "<option value=\"\">--请选择--</option>" +
            "<option value=\"left join\">左连接</option>" +
            "<option value=\"right join\">右连接</option>" +
            "<option value=\"inner join\">内连接</option>" +
            "<option value=\"full join\">外连接</option>" +
            "</select></td>" +
            "<td><select id=\"con_joinfield_"+index+"\" name=\"joinfield\" class=\"layui-form-select\" >" +
            "</select></td>" +
            "<td><span onclick=\"delTr(this);\"><i class=\"layui-icon\">&#xe640;</i></span></td>" +
            "</tr>";
        $("#connectBody").append(html);//添加节点
        //添加表选项
        var tableOpts = "<option value=\"\">--请选择--</option>";
        for(var x in connectArr){
            tableOpts += "<option value=\""+connectArr[x]+"\">"+connectArr[x]+"</option>"
        }
        $("select[id='con_field_"+index+"']").append(tableOpts);
        $("select[id='con_joinfield_"+index+"']").append(tableOpts);

        //重新渲染表单
        form.render();
    }

    /**
     * 删除当前行元素
     * @param obj
     */
    window.delTr = function (obj){
        //获取父元素
        var grandP = $(obj).parent().parent();
        grandP.remove();

        // //获取上一个兄弟节点的id属性，截取最后一位为index
        // var id = $(obj).prev().attr("id");
        // var index = id.substr(id.length-1);
        // alert(id+"||"+index);
        // //删除当前行
        // $("#queryTr_"+index).remove();
        //重新排序
    }

    //监听提交
    form.on('submit(getResult)', function(data) {
        //console.log(data.field);
        var f = data.field;
        //提取要素
        //1.数据源
        var dbkey = f.dbkey;
        //2.表名称
        var tables = f.tables;
        //3.查询的字段名
        var fields = f.fields;

        if(!fields){
            layer.msg("请先选择查询的列");
            return false;
        }

        //被关联的列
        var join_fields = [];
        //被关联的表
        var join_tables = [];
        //关联条件
        var join_condi = [];
        //关联的列
        var join_con_fields = [];

        //4.1获取关联条件
        var connectList = $("#connectBody").children("tr");
        for(var i = 0 ; i < connectList.length ; i++){
            var tdArr = connectList.eq(i).find("td");
            //被关联的列
            join_fields.push(tdArr.eq(0).find("select").val());
            //关联条件
            join_condi.push(tdArr.eq(1).find("select").val());
            //关联的列
            var field = tdArr.eq(2).find("select").val();
            join_tables.push(field.split(".")[0]);
            join_con_fields.push(tdArr.eq(2).find("select").val());
        }

        //4.2查询条件    遍历条件table表
        var trList = $("#queryBody").children("tr");
        //被查询的列
        var query_fields = [];
        //列的数据类型
        var query_fields_type = [];
        //查询条件
        var query_condi = [];
        //查询的值
        var query_val = [];
        for(var i = 0 ; i < trList.length ; i++){
            var tdArr = trList.eq(i).find("td");
            //表名
            if(tdArr.eq(0).find("select").val()){
                var query_tables = tdArr.eq(0).find("select").val();
                //字段名
                query_fields.push(query_tables+"."+tdArr.eq(1).find("select").val());
                //条件
                query_condi.push(tdArr.eq(2).find("select").val());
                //值
                //判断字段类型
                var dataType = tdArr.eq(1).find("select").find("option:selected").attr("fieldtype");
                query_fields_type.push(dataType);
                if("DATE" == dataType){
                    var val = "to_date('"+tdArr.eq(3).find("input").val()+"','yyyy-MM-dd')";
                    query_val.push(val);
                }else{
                    query_val.push(tdArr.eq(3).find("input").val());
                }
            }
        }
        //5.描述
        var sql_desc = f.sql_desc;
        //6.获取查询主表(激活的表)
        var main_table = $(".layui-show").find("table").eq(0).attr("id");

        $.ajax({
            url: '/data/source/get/result',
            type: 'post',
            dataType:'json',
            contentType: "application/json;charset=UTF-8",
            // data : JSON.stringify(f),
            data:JSON.stringify({
                dbkey:dbkey
                ,tables:tables
                ,fields:fields
                ,main_table:main_table
                ,join_tables:join_tables.join()
                ,join_fields:join_fields.join()
                ,join_condi:join_condi.join()
                ,join_con_fields:join_con_fields.join()
                ,query_fields:query_fields.join()
                ,query_fields_type:query_fields_type.join()
                ,query_condi:query_condi.join()
                ,query_val:query_val.join("||")
                ,sql_desc:sql_desc
            }),
            sync: false,
            cache: false,
            success : function(result){
                var sql = result.sql;
                var url = "/data/source/query/list?sql="+sql+"&dbkey="+dbkey;
                WeAdminShow('查询结果',encodeURI(url));
            }
        });
        return false;//阻止跳转
    });

    table.on('tool(tabFilter)',function (obj) {
        //获取事件
        var layEvent = obj.event;
        if(layEvent == 'changeCheckbox'){
            //获取当前的checkbox，并改变cache中对应的值,未选改为选中，选中则改为未选中
            var c = table.cache;
            console.log(c);

        }
        return false;
    });

});