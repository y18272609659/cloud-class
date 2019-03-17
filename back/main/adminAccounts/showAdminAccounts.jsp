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
            padding: 20px 20px 0;
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
        .head .core .count{
            font-weight: 700;
            font-size: 18px;
            line-height: 2;
        }
        .table{
            padding: 0 0 20px 20px;
        }

        .title{
            position: relative;
        }
        .select{
            position: absolute;
            width: 345px;
            right: 0;
            top:0;
            font-size: 14px;
            font-weight: 400;
        }

        .word-zone{
            line-height: 2;
            font-size: 14px;
            padding: 20px;
        }
        .word-zone .word-button{
            padding-top: 10px;
            color:#04B75E;
        }
        .word-zone .word-button div span{
            cursor: pointer;
        }

        .desc{
            overflow: hidden;
            word-break: break-all;
        }
        .layui-row{
            padding-bottom: 10px;
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
                var table = layui.table;
                var form = layui.form;

                get()
            });

            setContentPageHeight()
        })

        function get(){
            $.ajax({
                url: '${ctx}/backLogin/menuAll',
                type: 'get',
                dataType: 'json',
                success: function (data) {
                    get2(data.data)
                },
                error: function (err) {

                }
            });
        }
        function get2(all){
            $.ajax({
                url: '${ctx}/backLogin/getRoles?id=' + '${admin.id}',
                type: 'get',
                dataType: 'json',
                success: function (data) {
                    var str = ''
                    var d = data.data
                    for (var i = 0; i < d.length; i++) {
                        if (d[i].status == 1) {
                            str += (all[i].title + "编辑权限" + "<br>")
                        }
                    }
                    console.log(str)
                    document.getElementById('role').innerHTML = str
                },
                error: function (err) {

                }
            });
        }
        function reset() {
            $.ajax({
                url: '${ctx}/backAdmin/passwordReset',
                type: 'post',
                data:{
                    id:'${admin.id}',
                },
                dataType: 'json',
                success: function (data) {
                    alert("重置密码成功")
                    window.location.href = '${ctx}/backMenu/adminAccounts'
                },
                error: function (err) {

                }
            });
        }

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

    </script>
    <script type="text/html" id="btn">
        <a class="layui-btn layui-btn-xs" lay-event="show">查看详情</a>
        <a class="layui-btn layui-btn-xs layui-btn-primary layui-btn-primary-red" lay-event="show">删除</a>
    </script>
</head>
<body onload="setContentPageHeight()">
<div id="content">
    <div class="head">
        <div class="title">
            <a href="./index.index.jsp" target="contextRightIframe">
                <img src="../../../../../static/images/back.png" alt="">
            </a>
            查看管理员账户
        </div>
        <div class="word-zone">
            <div class="layui-row">
                <div class="layui-col-sm2">名称</div>
                <div class="layui-col-sm10 desc">${admin.name}</div>
            </div>
            <div class="layui-row">
                <div class="layui-col-sm2">账号</div>
                <div class="layui-col-sm10 desc">${admin.account}</div>
            </div>
            <div class="layui-row">
                <div class="layui-col-sm2">密码</div>
                <div class="layui-col-sm10 desc"><a class="layui-btn" onclick="reset()">重置</a></div>
            </div>
            <div class="layui-row">
                <div class="layui-col-sm2">简介</div>
                <div class="layui-col-sm10 desc">${admin.intro}</div>
            </div>
            <div class="layui-row">
                <div class="layui-col-sm2">权限</div>
                <div class="layui-col-sm10 desc" id="role"></div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>