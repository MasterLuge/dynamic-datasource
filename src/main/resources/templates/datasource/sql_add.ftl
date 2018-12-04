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
			<form class="layui-form">

                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                    <legend>数据源</legend>
                </fieldset>

				<div class="layui-form-item">
					<label for="L_username" class="layui-form-label">
		                <span class="we-red">*</span>数据源
		            </label>
					<div class="layui-input-inline">
						<#--<input type="text" id="L_username" name="username" lay-verify="required|nikename" autocomplete="off" class="layui-input">-->
						<select id="dbkey" name="dbkey" lay-verify="required">
                            <!--此处可以建立一个表，遍历得出-->
							<option value="">--数据源--</option>
							<option value="dgjycy" selected>就业创业</option>
							<#--<option value="cajy">长安教育</option>-->
						</select>
					</div>
                    <div class="layui-input-inline">
                        <input name="search_table" id="search_table" class="layui-input" placeholder="填写搜索表名"/>
                    </div>
                    <div class="layui-input-inline">
                        <a class="layui-btn" onclick="addTable()"><i class="layui-icon"></i></a>
                        <#--<a class="layui-btn layui-btn-sm layui-btn-primary" onclick="addTable();"><i class="layui-icon">&#xe608;</i> 查询数据表</a>-->
                    </div>
                </div>

                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                    <legend>表</legend>
                </fieldset>

                <script type="text/html" id="tab_btn">
                    <div class="layui-btn-group tab_toolBtn">
                        <a class="layui-btn" onclick="addField();"><i class="layui-icon"></i> 获取列</a>
                        <#--<button class="layui-btn" data-type="goAdd"><i class="layui-icon"></i>添加</button>-->
                        <#--<button class="layui-btn layui-btn-danger" data-type="del"><i class="layui-icon"></i>批量删除</button>-->
                    </div>
                </script>

                <div class="layui-form-item">
                    <#--<label for="L_email" class="layui-form-label">-->
                        <#--&lt;#&ndash;<span class="we-red">*</span>查询表&ndash;&gt;-->
                        <#--&lt;#&ndash;<a class="layui-btn layui-btn-sm layui-btn-primary" onclick="addField();"><i class="layui-icon">&#xe608;</i> 获取列</a>&ndash;&gt;-->
                    <#--</label>-->
                    <div class="layui-input-block">
						<table id="tabList" lay-filter="tabFilter" class="layui-table"></table>
                        <input id="tables" name="tables" type="hidden" />
                    </div>
                </div>

                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                    <legend>列</legend>
                </fieldset>

                <div class="layui-tab layui-tab-brief">
                    <ul class="layui-tab-title" id="tab_ul">
                        <#--<li class="layui-this">网站设置</li>-->
                        <#--<li>用户管理</li>-->
                    </ul>
                    <div class="layui-tab-content" id="tab_content"></div>
                    <input id="fields" name="fields" type="hidden" />
                    <#--<input id="comments" name="comments" type="text" />-->
                </div>

                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                    <legend>关联条件
                        <a class="layui-btn" onclick="addConnect();"><i class="layui-icon">&#xe608;</i> 添加</a>
                    </legend>
                </fieldset>
                <div class="layui-form-item">
                    <#--<label for="L_email" class="layui-form-label">-->
                        <#--&lt;#&ndash;关联条件&ndash;&gt;-->
                        <#--&lt;#&ndash;<a class="layui-btn layui-btn-sm layui-btn-primary" onclick="addConnect();"><i class="layui-icon">&#xe608;</i> 添加关联条件</a>&ndash;&gt;-->
                    <#--</label>-->
                    <table id="connectTable" class="layui-table">
                        <thead>
                        <tr>
                            <th>被关联列</th>
                            <th>关联条件</th>
                            <th>关联列</th>
                            <th>删除</th>
                        </tr></thead>
                        <tbody class="layui-table-body" id="connectBody">
                        </tbody>
                    </table>
                </div>

                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                    <legend>查询条件
                        <a class="layui-btn" onclick="addQuery();"><i class="layui-icon">&#xe608;</i> 添加</a>
                    </legend>
                </fieldset>
                <div class="layui-form-item">
                    <table id="queryTable" class="layui-table">
                        <thead>
                        <tr>
                            <th>所属表</th>
                            <th>字段名</th>
                            <th>条件</th>
                            <th>值</th>
                            <th>删除</th>

                        </tr></thead>
                        <tbody class="layui-table-body" id="queryBody">
                        </tbody>
                    </table>
                </div>
				<div class="layui-form-item">
					<label for="L_email" class="layui-form-label">
						描述
		            </label>
					<div class="layui-input-block">
						<textarea type="text" id="sql_desc" name="sql_desc" class="layui-textarea"></textarea>
					</div>
				</div>
				<div class="layui-form-item">
					<label for="L_repass" class="layui-form-label">
              </label>
                    <button class="layui-btn" lay-filter="getResult" lay-submit="">获取查询结果</button>
                    <button class="layui-btn" lay-filter="add" lay-submit="">保存</button>
                    <a class="layui-btn" href="javascript:history.go(-1);">返回</a>
				</div>
			</form>
		</div>

        <#--<script type="text/html" id="queryHtml">-->
            <#--<input type="checkbox" name="isQuery" lay-skin="switch" lay-filter="checkQuery" lay-text="是|否" {{d.isQuery}}>-->
        <#--</script>-->
        <script type="text/html" id="showHtml">
            <input type="checkbox" name="isShow" lay-skin="switch" lay-filter="checkShow" lay-text="显示|隐藏" {{d.isShow}}>
        </script>
        <script type="text/html" id="connectHtml">
            <input type="checkbox" name="isConnect" lay-skin="switch" lay-filter="checkConnect" lay-text="关联|不关联" {{d.isConnect}}>
		</script>
        <script type="text/html" id="dictionaryHtml">
            <select name="typegroupname" lay-verify="" lay-search>
                <option value=""></option>
                <#--<#list typegruopList as typegroup>-->
                    <#--<option value="${typegroup.typegroupcode}">${typegroup.typegroupcode}</option>-->
                <#--</#list>-->
            </select>
        </script>

        <script src="/layUI/layui.js" charset="utf-8"></script>
        <script src="/js/sql_add.js" charset="utf-8"></script>
	</body>
\
</html>