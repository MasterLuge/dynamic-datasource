<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>数据源列表</title>
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
<div class="weadmin-nav">
    <span class="layui-breadcrumb">
        <#--<a href="#">首页</a>-->
        <a href="javascropt:void(0)" onclick="window.parent.location.href='/data/source/doLogin';return false;">查询列表</a>
        <a><cite>数据库表列表</cite></a>
  </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right"
   href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">&#x1002;</i>
    </a>
</div>
<#--<div id="testText">-->
    <#--文字内容-->
<#--</div>-->
<div class="weadmin-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 we-search" action="/data/source/tables/">
            搜索：
            <div class="layui-inline">
                <input class="layui-input" placeholder="表名" name="searchTable" id="tt">
            </div>
            <#--<div class="layui-inline">-->
                <#--<input class="layui-input" placeholder="截止日" name="end" id="end">-->
            <#--</div>-->
            <#--<div class="layui-inline">-->
                <#--<input type="text" name="username" placeholder="请输入用户名" autocomplete="off" class="layui-input">-->
            <#--</div>-->
            <button class="layui-btn" lay-submit="" lay-filter="search"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <#--<div class="layui-btn-group demoBtn">-->
        <#--<button class="layui-btn" data-type="getCheckData">获取选中行数据</button>-->
        <#--<button class="layui-btn" data-type="getCheckLength">获取选中数目</button>-->
        <#--<button class="layui-btn" data-type="isAll">验证是否全选</button>-->
        <#--<button class="layui-btn" data-type="getTableFields">查询表</button>-->

    <#--</div>-->
    <#--<div class="weadmin-block">-->
        <#--&lt;#&ndash;<button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>&ndash;&gt;-->
        <#--<button class="layui-btn" onclick="WeAdminShow('添加用户','',600,400)"><i class="layui-icon"></i>添加</button>-->
        <#--<span class="fr" style="line-height:40px">共有数据：${total} 条</span>-->
    <#--</div>-->

    <table class="layui-table" id="tableList" lay-filter="demo"></table>
    <#--<table class="layui-table" id="memberList">-->
        <#--<thead>-->
        <#--<tr>-->
            <#--<th>-->
                <#--<div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>-->
            <#--</th>-->
            <#--&lt;#&ndash;<th>ID</th>&ndash;&gt;-->
            <#--<th>表名</th>-->
            <#--&lt;#&ndash;<th>性别</th>&ndash;&gt;-->
            <#--&lt;#&ndash;<th>手机</th>&ndash;&gt;-->
            <#--&lt;#&ndash;<th>邮箱</th>&ndash;&gt;-->
            <#--&lt;#&ndash;<th>地址</th>&ndash;&gt;-->
            <#--&lt;#&ndash;<th>加入时间</th>&ndash;&gt;-->
            <#--&lt;#&ndash;<th>状态</th>&ndash;&gt;-->
            <#--<th>操作</th>-->
        <#--</tr>-->
        <#--</thead>-->
        <#--<tbody>-->
        <#--<#list tables as table>-->
            <#--<tr data-id="1">-->
                <#--<td>-->
                    <#--<div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id="1"><i class="layui-icon">&#xe605;</i></div>-->
                <#--</td>-->
                <#--<td>${table.tableName}</td>-->

                <#--&lt;#&ndash;<td class="td-status">&ndash;&gt;-->
                    <#--&lt;#&ndash;<span class="layui-btn layui-btn-normal layui-btn-xs">已启用</span></td>&ndash;&gt;-->
                <#--&lt;#&ndash;<td class="td-manage">&ndash;&gt;-->
                    <#--&lt;#&ndash;<a onclick="member_stop(this,'10001')" href="javascript:;" title="启用">&ndash;&gt;-->
                        <#--&lt;#&ndash;<i class="layui-icon">&#xe601;</i>&ndash;&gt;-->
                    <#--&lt;#&ndash;</a>&ndash;&gt;-->
                    <#--&lt;#&ndash;<a title="编辑" onclick="WeAdminEdit('编辑','./edit.html', 1, 600, 400)" href="javascript:;">&ndash;&gt;-->
                        <#--&lt;#&ndash;<i class="layui-icon">&#xe642;</i>&ndash;&gt;-->
                    <#--&lt;#&ndash;</a>&ndash;&gt;-->
                    <#--&lt;#&ndash;<a onclick="WeAdminShow('修改密码','./password.html',600,400)" title="修改密码" href="javascript:;">&ndash;&gt;-->
                        <#--&lt;#&ndash;<i class="layui-icon">&#xe631;</i>&ndash;&gt;-->
                    <#--&lt;#&ndash;</a>&ndash;&gt;-->
                    <#--&lt;#&ndash;<a title="删除" onclick="member_del(this,'要删除的id')" href="javascript:;">&ndash;&gt;-->
                        <#--&lt;#&ndash;<i class="layui-icon">&#xe640;</i>&ndash;&gt;-->
                    <#--&lt;#&ndash;</a>&ndash;&gt;-->
                <#--&lt;#&ndash;</td>&ndash;&gt;-->
            <#--</tr>-->
        <#--</#list>-->
        <#--</tbody>-->
    <#--</table>-->
    <#--<div class="page">-->
        <#--<div>-->
            <#--<a class="prev" href="">&lt;&lt;</a>-->
            <#--<a class="num" href="">1</a>-->
            <#--<span class="current">2</span>-->
            <#--<a class="num" href="">3</a>-->
            <#--<a class="num" href="">489</a>-->
            <#--<a class="next" href="">&gt;&gt;</a>-->
        <#--</div>-->
    <#--</div>-->
</div>
<!--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>-->
<script src="../../../layUI/layui.js" charset="utf-8"></script>
<script src="../../../weadmin/js/eleDel.js" type="text/javascript" charset="utf-8"></script>
<script>


    layui.use(['table','form'], function(){

        var table = layui.table
            ,form = layui.form
            ,$ = layui.$;

        table.render({
            elem: '#tableList'
            ,url:'/data/source/get/tableList'
            ,where: {
                dbkey:'${dbkey}'
            }
            ,toolbar: true
            ,title: '数据库表'
            ,totalRow: true
            ,cols: [[
                {
                    type:'checkbox',fixed:'left'
                }
                ,{
                    field:'tableName', title:'表名', width:300, fixed: 'left',
                    unresize: true, sort: true
                    // ,totalRowText: '合计行'
                }
                ,{
                    field:'comments',title:'表描述',width:300
                }
                // ,{field:'username', title:'用户名', width:120, edit: 'text'}
                // ,{field:'sex', title:'性别', width:80, edit: 'text', sort: true}
                // ,{field:'logins', title:'登入次数', width:100, sort: true, totalRow: true}
            ]]
            ,page: true
            ,response: {
                statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
            }
            ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
                return {
                    "code": 200, //解析接口状态
                    "msg": res.message, //解析提示文本
                    "count": ${total}, //解析数据长度
                    "data": res //解析数据列表
                };
            }
        });

        //监听提交
        form.on('submit(search)', function(data){
            var searchTable = data.field.searchTable;
            // layer.msg(searchTable);
            table.reload('tableList', {
                url: '/data/source/get/tableList'
                ,where: {
                    searchTable: searchTable,
                    dbkey:'${dbkey}'
                } //设定异步数据接口的额外参数
            });
            return false;
        });

        var active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('tableList'),data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            ,getCheckLength: function(){ //获取选中数目
                var checkStatus = table.checkStatus('tableList')
                        ,data = checkStatus.data;
                layer.msg('选中了：'+ data.length + ' 个');
            }
            ,isAll: function(){ //验证是否全选
                var checkStatus = table.checkStatus('tableList');
                layer.msg(checkStatus.isAll ? '全选': '未全选')
            }
            ,getTableFields: function () {//返回表所有字段值
                var checkStatus = table.checkStatus('tableList'),data = checkStatus.data;
                var tableNameArr = [];
                for(var x in data){
                    tableNameArr.push(data[x].tableName);
                }
                var tableName = tableNameArr.join();

                // if(tableName){
                //     layer.open({
                //         title: '表字段',
                //         type: 2,
                //         area: ['500px','500px'],
                //         content: '/data/source/doSearch?tableName='+tableNameArr
                //     });
                // }
            }
        };
        //给按钮添加点击事件，回调执行方法
        $('.demoBtn .layui-btn').on('click',function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });

</script>

</body>

</html>