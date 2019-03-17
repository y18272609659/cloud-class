<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <jsp:include page="../../../include.jsp"/>
    <style>
        /*.head{*/
        /*height: 80px;*/
        /*padding: 20px 50px;*/
        /*background: #fff;*/
        /*margin-bottom: 10px;*/
        /*}*/
        .float-left{
            float: left;
        }
        .float-right{
            float: right;
        }
        body,h1,h2,h3,h4,h5,h6,p{
            margin:0;
        }
        .layui-btn-primary,.layui-btn-primary:hover{
            color:#04B75E;
            border:1px solid #04B75E;
        }
        .layui-btn-primary-red,.layui-btn-primary-red:hover{
            color:#ff0000;
            border:1px solid #ff0000;
        }

        .head{
            background: #fff;
            margin-bottom: 10px;
        }
        .head .title{
            height: 60px;
            line-height: 60px;
            font-size: 16px;
            text-indent: 1em;
            border-bottom: 1px solid #e5e5e5;
            font-weight: 700;
        }
        .head .core{
            padding: 20px 0;
        }
        .head .core .data{
            line-height: 2;
            font-size: 14px;
        }
        .head .core .data .name span{
            font-size: 36px;
            font-weight: 700;
        }
        .head .core .table{
            padding: 40px 0;
        }
        .table{
            padding: 0 0 20px 20px;
        }

        .add-pic-zone{
            width: 180px;
            height: 108px;
        }
        .add-pic-zone-default{
            border-radius: 10px;
            background: #e5e5e5;
            border: 1px solid #ccc;
            line-height: 108px;
            font-size: 14px;
            color: #000;
            text-align: center;
            cursor: pointer;
        }

        .gap{
            height: 10px;
            background: rgb(228,228,228);
        }
        .module-1{
            padding-right: 20px;
        }
        .video-zone h6{
            font-size: 14px;
            font-weight: 400;
            line-height: 2;
            white-space:nowrap;
            overflow:hidden;
            text-overflow:ellipsis;
        }
    </style>
    <script>
        var menuAll = []
        // var menuCan = []
        var route_str = 'backMenu_adminAccounts'
        // layui.sessionData('zkyykt_admin_jump_page', {
        //     key:'left_nav'
        //     ,value:route_str
        // });

        $(function(){
            layui.use(['element', 'table', 'form'], function(){
                var element = layui.element;
                var form = layui.form;
                var table = layui.table;

                $.ajax({
                    url: '${ctx}/backLogin/menuAll',
                    type: 'get',
                    dataType: 'json',
                    success: function (data) {
                        var arr = data.data
                        console.log(arr);
                        var str = ''
                        menuAll = arr
                        layui.each(arr, function(index, elem){
                            str += '<input type="checkbox" name="auth_' + elem.name + '" title="' + elem.title + '编辑权限" id="menu_' + elem.id + '" lay-skin="primary" class="my_checkbox"><br>'
                        })
                        document.getElementById('menu').innerHTML = str
                        form.render()

                        if('${admin}'){
                            console.log("===EDIT===")
                            document.getElementById('title').innerHTML = '编辑管理员账号'
                            form.val("aaa", {
                                "name": '${admin.name}',
                                "account": '${admin.account}',
                                <%--"password": '${admin.password}',--%>
                                "intro": '${admin.intro}'
                            });
                            getAuthority(form)
                        } else {
                            console.log("===ADD===")
                        }
                    },
                    error: function (err) {

                    }
                });

                form.on('submit(next)', function (obj) {
                    console.log(obj)
                    var data = obj.field
                    var o = $(".my_checkbox")
                    layui.each(o, function(index, item){
                        data[item.name.substring(5)] = item.checked ? 1 : 0
                    })
                    console.log(data)
                    // can submit ?
                    if (!checkAuth(o)) {
                        alert("至少要选择一个权限！")
                        return
                    }
                    if('${admin}'){
                        console.log("===EDIT===")
                        data.id = '${admin.id}'
                        $.ajax({
                            url: '${ctx}/backAdmin/update',
                            type: 'post',
                            dataType: 'json',
                            data: data,
                            success: function (data) {
                                if (data.r === 1) {
                                    alert("修改成功")
                                    window.location.href = '${ctx}/backMenu/adminAccounts'
                                } else {
                                    alert(data.msg)
                                    return false;
                                }
                            },
                            error: function (err) {
                                // console.log(err);
                                return false;
                            }
                        });
                    } else {
                        console.log("===ADD===")
                        $.ajax({
                            url: '${ctx}/backAdmin/add',
                            type: 'post',
                            dataType: 'json',
                            data: data,
                            success: function (data) {
                                if (data.r === 1) {
                                    alert("添加成功")
                                    window.location.href = '${ctx}/backMenu/adminAccounts'
                                } else {
                                    alert(data.msg)
                                    return false;
                                }
                            },
                            error: function (err) {
                                // console.log(err);
                                return false;
                            }
                        });
                    }
                });
            });

            setContentPageHeight()
        })

        function setContentPageHeight() {
            var b_iframe = window.parent.document.getElementById("contextRightIframe");
            var height = document.getElementById("content").offsetHeight;
            var h = window.parent.document.getElementById("content").offsetHeight;
            var a_iframe = window.parent.parent.document.getElementById("contextIframe");

            if (h >= height) {
                b_iframe.height = h + 30;
                a_iframe.height = h + 100;
            } else {
                b_iframe.height = height + 30;
                a_iframe.height = height + 100;
            }

            // b_iframe.height = height + 30;


        };

        function getAuthority(form){
            $.ajax({
                url: '${ctx}/backLogin/getRoles?id=' + '${admin.id}',
                type: 'get',
                dataType: 'json',
                success: function (data) {
                    var can = data.data
                    layui.each(can, function(index, elem){
                        // document.getElementById('menu_' + elem.menuId).checked = !!elem.status
                        // console.log(document.getElementById('menu_' + elem.menuId))
                        // console.log(!!elem.status)
                        if (!!document.getElementById('menu_' + elem.menuId)) {
                            document.getElementById('menu_' + elem.menuId).checked = (!!elem.status)
                            // console.log(document.getElementById('menu_' + elem.menuId).checked)
                        }
                    })
                    form.render()
                },
                error: function (err) {

                }
            });
        }

        function checkAuth(o){
            for (var i = 0; i < o.length; i++) {
                if(o[i].checked){
                    return true
                }
            }
            return false
        }

    </script>
    <script type="text/html" id="btn">
        <a class="layui-btn layui-btn-xs" lay-event="show">查看详情</a>
    </script>
</head>
<body onload="setContentPageHeight()">
<div id="content">
    <div class="head">
        <div class="title">
            <a href="./index.index.jsp" target="contextRightIframe">
                <img src="../../../../../static/images/back.png" alt="">
            </a>
            <span id="title">添加管理员账号</span>
        </div>
        <div class="core">
            <div class="layui-form" lay-filter="aaa">
                <div class="module-1">
                    <div class="layui-form-item">
                        <label class="layui-form-label">名称<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <input type="text" name="name" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">账号<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <input type="text" name="account" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">密码<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <input id="password" type="password" name="password" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">简介<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <textarea name="intro" placeholder="" class="layui-textarea"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">权限<span style="color: red">*</span></label>
                        <div class="layui-input-block" id="menu">
                            <%--<input type="checkbox" name="video" title="科学视频编辑权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="SELF · Kids编辑权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="科学实践课编辑权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="科学家进校园编辑权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="求真科学营编辑权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="校长论坛编辑权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="活动预约申请查看权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="首页推荐编辑权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="数据统计查看权限" lay-skin="primary">--%>
                            <%--<br>--%>
                            <%--<input type="checkbox" name="" title="学校账户管理权限" lay-skin="primary">--%>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="next">立即提交</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>