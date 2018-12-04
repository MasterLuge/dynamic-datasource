<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="../../layUI/layui.js"></script>
    <link rel="stylesheet" href="../../layUI/css/layui.css"  media="all">
</head>

<body>

<table class="layui-table">
    <thead>
    <tr>
        <td>序号</td>
        <td>字段名</td>
        <td>字段描述</td>
    </tr>
    </thead>
    <tbody>
    <#list mapList as map>
        <tr>
            <td>${map_index+1}</td>
            <td>${map[0]["columa_name"]}</td>
            <#--<td>${map[0]["column_name"]}</td>-->
            <#--<td>${map["comments"]}</td>-->
        </tr>
    </#list>
    </tbody>
</table>

</body>
</html>
