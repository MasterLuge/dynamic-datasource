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
        <div class="layui-form-item">
            <label for="L_username" class="layui-form-label">
                <span class="we-red">*</span>数据源
            </label>
            <div class="layui-input-inline">
            <#--<input type="text" id="L_username" name="username" lay-verify="required|nikename" autocomplete="off" class="layui-input">-->
                <select name="dbkey" lay-verify="required">
                    <option value="">--数据源--</option>
                    <option value="dgjycy" selected>就业创业</option>
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

        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
            <legend>预设参数
                <a class="layui-btn" onclick="addQuery();"><i class="layui-icon">&#xe608;</i> 添加</a>
            </legend>
        </fieldset>
        <div class="layui-form-item">
            <table id="query_params" class="layui-table">
                <thead>
                <tr>
                    <#--<th>表名</th>-->
                    <#--<th>字段名</th>-->
                    <th>类型</th>
                    <th>值</th>
                    <th>删除</th>
                </tr></thead>
                <tbody class="layui-table-body" id="queryBody">
                    <#--<tr id="tr_0">-->
                        <#--<td><select name="paramType_0" id="paramType_0" lay-filter="paramType" class="layui-select" >-->
                            <#--<option value="">--请选择--</option>-->
                            <#--<option value="String">字符</option>-->
                            <#--<option value="Number">数值</option>-->
                            <#--<optgroup label="时间">-->
                                <#--<option value="year">年</option>-->
                                <#--<option value="month">年月</option>-->
                                <#--<option value="date">年月日</option>-->
                                <#--<option value="datetime">日期时间</option>-->
                            <#--</optgroup>-->
                        <#--</select></td>-->
                        <#--<td><input name="paramVal_0" id="paramVal_0" class="layui-input"></td>-->
                        <#--<td><span onclick="delTr(this);"><i class="layui-icon">&#xe640;</i></span></td>-->
                    <#--</tr>-->
                </tbody>
            </table>
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
            <button class="layui-btn" lay-filter="query" lay-submit="">查询</button>
            <button class="layui-btn" lay-filter="add" lay-submit="">保存</button>
            <a class="layui-btn" href="javascript:history.go(-1);">返回</a>
        </div>
    </form>
</div>
<script src="/layUI/layui.js" charset="utf-8"></script>
<script src="/js/model.js" charset="utf-8"></script>
</body>

</html>