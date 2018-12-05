<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>查询结果</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../../weadmin/css/font.css">
    <link rel="stylesheet" href="../../../weadmin/css/weadmin.css">
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<table id="resultTab" lay-filter="result">
    <#if resultMapList?? && (resultMapList?size > 0)>
    <thead><tr>
        <th lay-data="{field:'XH', width:100}">序号</th>
        <#list resultMapList[0]?keys as key>
            <th nowrap lay-data="{field:'${key}',sort:true}">${key}</th>
        </#list>
    </tr></thead>
    <tbody>
        <#list resultMapList as resultMap>
            <tr>
                <td nowrap>${(resultMap_index+1)?c}</td>
                <#list resultMap?keys as key>
                    <td nowrap>${resultMap[key]!}</td>
                </#list>
            </tr>
        </#list>
    </tbody>
    </#if>
</table>
<div id="resultTab2"></div>

<script src="../../../layUI/layui.js" charset="utf-8"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;

        //转换静态表格
        table.init('result', {
            //支持所有基础参数
            elem: '#resultTab'
            ,title: '结果表'
            ,height: 500 //设置高度
            ,limit: 50 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
            ,limits:[50,100,150,200,250,300]
            ,page: true
            ,toolbar: true
            ,cellMinWidth: 180
            ,cols: [[
            <#if resultMapList?? && (resultMapList?size > 0)>
                {field:'XH', title:'序号'}
                <#list resultMapList[0]?keys as key>
                   ,{field:'${key}', title:'${key}',sort:true}
                </#list>
            </#if>
            ]]
        });
    });
</script>

</body>

</html>