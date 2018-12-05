layui.extend({
    admin: '{/}/weadmin/js/admin'
});
layui.use(['form', 'jquery','util','admin', 'layer','laydate'], function() {
    var form = layui.form,
        $ = layui.jquery,
        util = layui.util,
        admin = layui.admin,
        layer = layui.layer,
        laydate = layui.laydate;


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
    form.on('submit(query)', function(data) {
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


    window.addQuery = function () {
        var index = 0;
        var idVal =  $("#queryBody tr:last").attr("id");
        if(idVal){
            index = Number(idVal.substr(idVal.length - 1)) + 1;
        }
        alert(index);

        var html = "<tr id=\"tr_"+index+"\">\n" +
"                        <td><select name=\"paramType_"+index+"\" id=\"paramType_"+index+"\" lay-filter=\"paramType\" class=\"layui-select\" >\n" +
"                            <option value=\"\">--请选择--</option>\n" +
"                            <option value=\"string\">字符</option>\n" +
"                            <option value=\"number\">数值</option>\n" +
"                            <optgroup label=\"时间\">\n" +
"                                <option value=\"year\">年</option>\n" +
"                                <option value=\"month\">年月</option>\n" +
"                                <option value=\"date\">年月日</option>\n" +
"                                <option value=\"datetime\">日期时间</option>\n" +
"                            </optgroup>\n" +
"                        </select></td>\n" +
"                        <td><input name=\"paramVal_"+index+"\" id=\"paramVal_"+index+"\" class=\"layui-input\"></td>\n" +
"                        <td><span onclick=\"delTr(this);\"><i class=\"layui-icon\">&#xe640;</i></span></td>\n" +
"                    </tr>";

        $("#queryBody").append(html);//添加节点
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
    }

    form.on('select(paramType)',function (data) {
        //获取datatype自定义属性，存放字段的datatype类型
        var obj = data.elem;
        var type = data.value;
        var id = $(obj).attr("id");
        var index = id.substr(id.length-1);
        var target_id = "paramVal_"+index;

        //重生生成页面元素
        var html = "<input type=\"text\" name=\"paramVal_"+index+"\" id=\"paramVal_"+index+"\" class=\"layui-input\" />";
        var parent = $("#"+target_id).parent();
        parent.html(html);

        //如果类型是date，则渲染date
        if(type == 'year' || type == "month" || type == "date" || type == "datetime"){
            //清空值
            $("#"+target_id).val("");
            laydate.render({
                elem: '#'+target_id //指定元素
                ,type: type
            });
        }
        form.render();
    });

    /**
     * 监听查询
     */
    form.on('submit(query)', function(data) {
       //获取dbkey
       var dbkey = $("#dbkey").val();
       //获取查询参数
       var params = [];
       $("input[name^=paramVal_]").each(function () {
           var id = $this.id;
           alert("id:"+id);
       })
    });
});