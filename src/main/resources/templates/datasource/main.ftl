<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>数据查询系统</title>
    <script src="../../layUI/layui.js"></script>
    <link rel="stylesheet" href="../../layUI/css/layui.css"  media="all">

</head>
<body class="layui-layout-body">
<div class="layui-layout">
    <div class="layui-header">
        <div class="layui-logo">数据查询系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <#--<ul class="layui-nav layui-layout-left">-->
            <#--<li class="layui-nav-item"><a href="">控制台</a></li>-->
            <#--<li class="layui-nav-item"><a href="">用户</a></li>-->
            <#--<li class="layui-nav-item">-->
                <#--<a href="javascript:;">其它系统</a>-->
                <#--<dl class="layui-nav-child">-->
                    <#--<dd><a href="">邮件管理</a></dd>-->
                    <#--<dd><a href="">消息管理</a></dd>-->
                    <#--<dd><a href="">授权管理</a></dd>-->
                <#--</dl>-->
            <#--</li>-->
        <#--</ul>-->
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退出</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="iframeTabs">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">数据源</a>
                    <dl class="layui-nav-child">
                        <dd lay-id="1"><a href="javascript:;" data-options="{url:'/data/source/get/tables',title:'表格',id:'1'}">就业创业</a></dd>
                        <dd><a href="javascript:;">列表二</a></dd>
                        <dd><a href="javascript:;">列表三</a></dd>
                        <dd><a href="">超链接</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <!--中间主体-->
    <div class="layui-body" id="container">
        <div class="layui-tab" lay-filter="tabs" lay-allowClose="true">
            <ul class="layui-tab-title">
                <li class="layui-this">首页</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    首页内容
                </div>
            </div>
        </div>
    </div>

    <#--<div class="layui-body">-->
        <#--<!-- 内容主体区域 ,展示数据源&ndash;&gt;-->
        <#--<div style="padding: 15px;">-->
            <#--<table class="layui-table">-->
                <#--<colgroup>-->
                    <#--<col width="150">-->
                    <#--<col width="150">-->
                    <#--<col width="200">-->
                    <#--<col>-->
                <#--</colgroup>-->
                <#--<thead>-->
                <#--<tr>-->
                    <#--<th>数据源名称</th>-->
                    <#--<th>描述</th>-->
                <#--</tr>-->
                <#--</thead>-->
                <#--<tbody>-->
                <#--<tr>-->
                    <#--<td>就业创业</td>-->
                    <#--<td>xxxxxx</td>-->
                <#--</tr>-->
                <#--</tbody>-->
            <#--</table>-->
        <#--</div>-->

    <#--</div>-->

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        <#--© layui.com - 底部固定区域-->
    </div>
</div>
<script>
    //JavaScript代码区域
    layui.use('element', function() {
        var element = layui.element;
        element.on('nav(iframeTabs)', function (elem) {
            /*使用DOM操作获取超链接的自定义data属性值*/
            var options = eval('(' + elem.context.dataset.options + ')');
            var url = options.url;
            var title = options.title;
            var id = options.id;
            //判断是否存在此title，存在则激活否则就新增,此处一直新增
            element.tabAdd('tabs', {
                title: title,
                content: '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>',
                id: id
            });
            //激活此tab

        });
    });

</script>
</body>
</html>