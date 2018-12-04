<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>数据档案配置化管理系统</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="shortcut icon" href="../../../weadmin/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../../../weadmin/css/font.css">
	<link rel="stylesheet" href="../../../weadmin/css/weadmin.css">
    <script src="../../../layUI/layui.js" charset="utf-8"></script>

</head>
<body class="login-bg">
    
    <div class="login">
        <div class="message">数据档案配置化管理</div>
        <div id="darkbannerwrap"></div>
        
        <form method="post" class="layui-form" >
            <input name="username" placeholder="用户名" value="admin"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" value="123456" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input class="loginin" value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
            <#--<div>-->
            	<#--请随意输入，即可登录。-->
            <#--</div>-->
        </form>
    </div>

    <script type="text/javascript">
        
        	layui.extend({
				admin: '{/}../../weadmin/js/admin'
			});
            layui.use(['form','admin'], function(){
              var form = layui.form
              	,admin = layui.admin;
              //监听提交
              form.on('submit(login)', function(data){

                  location.href='/data/source/doLogin';
                  // layer.msg(JSON.stringify(data.field),function(){
                  //    location.href='/data/source/doLogin';
                  // });
                  return false;
              });
            });   
    </script>  
    <!-- 底部结束 -->
</body>
</html>