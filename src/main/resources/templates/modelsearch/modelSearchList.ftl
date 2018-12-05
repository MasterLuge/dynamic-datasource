<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>固定模板参数查询列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/weadmin/css/font.css">
    <link rel="stylesheet" href="/weadmin/css/weadmin.css">
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-nav">
    <span class="layui-breadcrumb">
        <a>
          <cite>常用查询</cite></a>
    </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">&#x1002;</i></a>
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 we-search">
            搜索：
            <div class="layui-inline">
                <input class="layui-input" placeholder="数据源" name="dbkey" id="dbkey">
            </div>
            <button class="layui-btn" lay-submit="doSearch()" lay-filter="search"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <script type="text/html" id="toolBtn">
    <div class="layui-btn-group toolBtn">
        <button class="layui-btn" data-type="goAdd"><i class="layui-icon"></i>添加</button>
        <#--<button class="layui-btn layui-btn-danger" data-type="del"><i class="layui-icon"></i>批量删除</button>-->
    </div>
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="query">预设查询参数</a>
        <#--<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>-->
    </script>
    <table class="layui-table" id="list" lay-filter="sqlFilter"></table>
</div>
<script src="../../../layUI/layui.js" charset="utf-8"></script>
<script src="../../../weadmin/js/eleDel.js" type="text/javascript" charset="utf-8"></script>
<script>
    layui.use(['table','laytpl'], function(){
        var table = layui.table;

        table.render({
            elem: '#list'
            ,url: '/model/search/datagrid&dbkey=dgjycy'
            ,toolbar: '#toolBtn'
            ,title: '查询表'
            ,cellMinWidth: 150
            ,totalRow: true
            ,cols: [[
                {type:'checkbox',fixed:'left'}
                ,{field:'id', title:'主键', sort: true, hide:true}
                ,{field:'sql', title:'sql语句', width:300,fixed: 'left'}
                ,{field:'sql_desc', title:'描述'}
                ,{field:'dbkey', title:'数据源'}
                ,{field:'query_params', title:'查询参数'}

                ,{field:'create_name', title:'创建人姓名'}
                ,{field:'create_by', title:'创建人'}
                ,{field:'create_date', title:'创建时间',width:180,templet: '<div>{{ layui.laytpl.toDateString(d.create_date) }}</div>'}

                ,{field:'update_name', title:'更新人姓名'}
                ,{field:'update_by', title:'更新人'}
                ,{field:'update_date', title:'更新时间',width:180,templet: '<div>{{ layui.laytpl.toDateString(d.update_date) }}</div>'}
                ,{title:'操作',fixed: 'right', width: 165, align:'center', toolbar: '#barDemo'}
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

        var $ = layui.$,active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('sqlList'),data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            ,getCheckLength: function(){ //获取选中数目
                var checkStatus = table.checkStatus('sqlList')
                        ,data = checkStatus.data;
                layer.msg('选中了：'+ data.length + ' 个');
            }
            ,isAll: function(){ //验证是否全选
                var checkStatus = table.checkStatus('sqlList');
                layer.msg(checkStatus.isAll ? '全选': '未全选');
            }
            ,goAdd: function(){//新增查询]
                document.location = "/model/search/goAdd";
            }
            ,del: function(){//批量删除
                var checkStatus = table.checkStatus('sqlList'),data = checkStatus.data;
                layer.confirm('选中了'+data.length+'行，确认删除?', {icon: 3, title:'提示'}, function(index){
                    //获取选中的id
                    var idArr = [];
                    for(var x in data){
                        idArr.push(data[x].id);
                    }
                    $.ajax({
                        url: '/data/source/del',
                        type: 'post',
                        // dataType:'json',
                        // contentType: "application/json;charset=UTF-8",
                        data : {
                            '_method': 'DELETE',
                            'id': idArr.join()
                        },
                        sync: false,
                        cache: false,
                        success : function(){
                            layer.close(index);
                            table.reload('sqlList');
                        }
                    });
                });
            }
        };
        //给按钮添加点击事件，回调执行方法
        $('.toolBtn .layui-btn').on('click',function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //监听行工具事件
        table.on('tool(sqlFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
            ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.msg('查看操作');
            } else if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令
                });
            } else if(layEvent === 'edit'){//修改
                document.location = "/data/source/update/"+data.id;
            } else if(layEvent === 'query'){//执行查询操作
                // document.location = "/data/source/query/list?sql="+data.sql+"&dbkey="+data.dbkey;
                document.location = "/data/source/query/list?id="+data.id;
            }
        });


        //时间戳的处理
        layui.laytpl.toDateString = function(d, format){
            var date = new Date(d || new Date())
            ,ymd = [
                this.digit(date.getFullYear(), 4)
                ,this.digit(date.getMonth() + 1)
                ,this.digit(date.getDate())
            ]
            ,hms = [
                this.digit(date.getHours())
                ,this.digit(date.getMinutes())
                ,this.digit(date.getSeconds())
            ];

            format = format || 'yyyy-MM-dd HH:mm:ss';

            return format.replace(/yyyy/g, ymd[0])
                    .replace(/MM/g, ymd[1])
                    .replace(/dd/g, ymd[2])
                    .replace(/HH/g, hms[0])
                    .replace(/mm/g, hms[1])
                    .replace(/ss/g, hms[2]);
        };

        //数字前置补零
        layui.laytpl.digit = function(num, length, end){
            var str = '';
            num = String(num);
            length = length || 2;
            for(var i = num.length; i < length; i++){
                str += '0';
            }
            return num < Math.pow(10, length) ? str + (num|0) : num;
        };
    });

</script>

</body>

</html>