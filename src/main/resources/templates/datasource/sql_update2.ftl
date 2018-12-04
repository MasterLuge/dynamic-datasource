<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>新增查询</title>
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
		<div class="weadmin-body">
			<form class="layui-form" lay-filter="sqlForm">
				<input type="text" name="id" hidden value="${dataSourceSql.id}"/>
				<div class="layui-form-item">
					<label for="L_username" class="layui-form-label">
		                <span class="we-red">*</span>数据源
		            </label>
					<div class="layui-input-inline">
						<#--<input type="text" id="L_username" name="username" lay-verify="required|nikename" autocomplete="off" class="layui-input">-->
						<select name="dbkey" lay-verify="required">
							<option value="">--数据源--</option>
							<option value="dgjycy">就业创业</option>
							<option value="cajy">长安教育</option>
						</select>
					</div>
					<#--<div class="layui-form-mid layui-word-aux">-->
						<#--请设置至少5个字符，将会成为您唯一的登录名-->
					<#--</div>-->
				</div>
				<#--<div class="layui-form-item">-->
				    <#--<label for="L_sex" class="layui-form-label">性别</label>-->
				    <#--<div class="layui-input-block" id="L_sex">-->
				      <#--<input type="radio" name="sex" value="男" title="男" checked>-->
				      <#--<input type="radio" name="sex" value="女" title="女">-->
				      <#--<input type="radio" name="sex" value="未知" title="未知">-->
				    <#--</div>-->
				<#--</div>-->

				<div class="layui-form-item">
					<label for="L_email" class="layui-form-label">
		                <span class="we-red">*</span>sql
		            </label>
					<div class="layui-input-block">
						<#--<input type="text" id="sql" name="sql" lay-verify="required" class="layui-input">-->
                        <textarea name="sql" required lay-verify="required" class="layui-textarea"></textarea>
					</div>
				</div>
				<div class="layui-form-item">
					<label for="L_email" class="layui-form-label">
		                <#--<span class="we-red">*</span>-->
						描述
		            </label>
					<div class="layui-input-block">
						<textarea type="text" id="sql_desc" name="sql_desc" class="layui-textarea"></textarea>
					</div>

				</div>
				<div class="layui-form-item">
					<label for="L_repass" class="layui-form-label">
              </label>
					<button class="layui-btn" lay-filter="update" lay-submit="">确定修改</button>
                    <a class="layui-btn" href="javascript:history.go(-1);">返回</a>
				</div>
			</form>
		</div>
        <script src="/layUI/layui.js" charset="utf-8"></script>
		
		<script>
			layui.extend({
                admin: '{/}/weadmin/js/admin'
			});
			layui.use(['form', 'jquery','util','admin', 'layer'], function() {
				var form = layui.form,
					$ = layui.jquery,
					util = layui.util,
					admin = layui.admin,
					layer = layui.layer;

				form.val("sqlForm",{
				    "dbkey":"${dataSourceSql.dbkey}"
					,"sql":"${dataSourceSql.sql}"
					,"sql_desc":"${dataSourceSql.sql_desc}"
				});

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
				form.on('submit(update)', function(data) {
					//console.log(data.field);
					var f = data.field;
					layer.msg(JSON.stringify(f));
					$.ajax({
						url: '/data/source/do/update',
						type: 'post',
						dataType:'json',
                        contentType: "application/json;charset=UTF-8",
						data : JSON.stringify(f),
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
							});
						}
					});
					return false;//阻止跳转
				});
			});
		</script>
	</body>

</html>