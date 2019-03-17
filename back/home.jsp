<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>求真云课堂管理系统</title>
    <meta charset="UTF-8">
    <jsp:include page="../include.jsp"/>
    <script>
        $(function(){
            $('#admin_exit').hide();
            layui.use(['element', 'layer'], function(){
                var element = layui.element;
            });

            // setContentPageHeight()
            isLogin();
        });

        // function setContentPageHeight() {
        //     var b_iframe = window.parent.document.getElementById("contextIframe");
        //     var height = document.getElementById("content").offsetHeight;
        //     b_iframe.height = height + 30;
        // };
        function isLogin() {
            $.ajax({
                url: '${ctx}/backLogin/isLogin',
                type: 'get',
                dataType: 'json',
                success: function (data) {
                    console.log(data);
                    if (data.r == 1) {
                        document.getElementById('admin_name').innerHTML = layui.data('zkyykt_admin').account
                        $('#admin_exit').show();
                        console.log("isLogin --1");
                        document.getElementById('contextIframe').contentWindow.location.href = '${ctx}/backMenu/adminHome';
                    } else {
                        layui.sessionData('zkyykt_admin_jump_page', {
                            key:'left_nav'
                            ,remove: true
                        });
                        $('#admin_exit').hide();
                        document.getElementById('contextIframe').contentWindow.location.href = '${ctx}/backMenu/loginView';
                    }
                },
                error: function (err) {

                }
            });
        }

        function logout() {
            $.ajax({
                url: '${ctx}/backLogin/logout',
                type: 'post',
                dataType: 'json',
                data: '',
                success: function (data) {
                    isLogin();
                },
                error: function (err) {
                    // console.log(err);
                }
            });
        }

        function login(email, password) {
            $.ajax({
                url: '${ctx}/backLogin/login',
                type: 'post',
                dataType: 'json',
                data: {
                    account: email,
                    password: password
                },
                success: function (data) {
                    // console.log(data);

                    if (data.r === 1) {
                        layui.data('zkyykt_admin', {
                            key:'account'
                            ,value:email
                        });
                        isLogin();
                    } else {
                        alert(data.msg);
                        return false;
                    }
                },
                error: function (err) {
                    // console.log(err);
                    return false;
                }
            });
        }

        function msgModel(text) {
            var layer = layui.layer;
            layer.msg(text);
        }
    </script>
    <style type="text/css">
        body {
            background-color: rgba(228, 228, 228, 1);
        }
        body,h1,h2,h3,h4,h5,h6,p{
            margin:0;
        }

        .content {

        }

        #nav {
            margin: 0px auto;
            width: 1200px;
            min-width: 1200px;

            line-height: 60px;
        }

        #iframe_div {
            margin: 10px auto;
            width: 1200px;
            /*min-width: 1200px;*/
        }

        #nav div span {
            color: rgb(51, 51, 51);
            /*margin-left: 10px;*/
            font-weight: 700;
            font-style: normal;
            font-size: 18px;
            text-align: left;
        }

        .hide {
            display: none;
        }

        #contextIframe {
            /*min-height: 450px;*/
        }

        h1{
            font-size: 20px;
            padding-left: 50px;
            font-weight: 700;
        }
        #nav .logo{
            position: absolute;
            top:20px;
            left:0;
            width: 35px;
            height: 35px;
            background: #fff;
            display: block;
        }
        .layui-nav-white{
            color:#333;
            background: #fff;
            font-weight: 700;
            font-size: 18px;
        }
        .layui-nav .layui-nav-item a{
            color: #333;
            font-size: 18px;
        }
        .layui-nav .layui-nav-item a:hover{
            color:#666;
        }
        .layui-nav .layui-nav-item.layui-this a{
            color:#04B75E;
        }
        .nav-f{
            background: #fff;
        }

        .right-nav a {
            padding: 0 10px;
        }

        .layui-layer-content{
            padding: 20px;
        }
    </style>
    <script>

        // 获取用户账号名
        function getUserName() {
          console.log('调到getUserName函数了')
          $.ajax({
            url: '${ctx}/backAdmin/get',
            type: 'get',
            dataType: 'json',
            success: function (data) {
              console.log(data)
              document.getElementById('admin_name').innerText = data.data.name
            },
            error: function (err) {
              console.log(err);
            }
          });
        }
    </script>
</head>
<body onload="getUserName()">
<div class="content">
    <div class="nav-f">
        <div id="nav">
        <div class="layui-row">
            <div class="layui-col-md4">
                <h1><a href="${ctx}/backMenu/home" target="_parent">求真云课堂管理系统</a></h1>
                <span class="logo"></span>
            </div>
            <!--<div class="layui-col-md4">-->
                <!--<div class="layui-form">-->
                    <!--<div class="layui-form-item" style="margin-bottom: 0;padding-top: 11px">-->
                        <!--<div class="layui-input-inline">-->
                            <!--<input type="text" name="title" required  lay-verify="keyword" placeholder="请输入关键字" autocomplete="off" class="layui-input">-->
                        <!--</div>-->
                        <!--<button class="layui-btn" lay-submit lay-filter="search">搜索</button>-->
                    <!--</div>-->
                <!--</div>-->
            <!--</div>-->
            <div id="admin_exit" class="layui-col-md-offset4 layui-col-md4 right-nav" style="text-align: right;font-weight: 700">
                <!--<span class="layui-breadcrumb" lay-separator="&nbsp;">-->
                <a href='${ctx}/backMenu/adminInfo2' target="contextIframe" id="admin_name"></a>
                    <a href="javascript:void(0)" style="padding-right: 10px" onclick="logout()">退出</a>
                <!--</span>-->
            </div>
        </div>
        <!--<div class="layui-row">-->
            <!--<div class="layui-col-md12">-->
                <!--<ul class="layui-nav layui-nav-white" lay-filter="">-->
                    <!--<li class="layui-nav-item layui-this"><a href="">首页</a></li>-->
                    <!--<li class="layui-nav-item"><a href="">基地学校</a></li>-->
                    <!--<li class="layui-nav-item"><a href="">科学视频</a></li>-->
                    <!--<li class="layui-nav-item"><a href="">SELF · Kids</a></li>-->
                    <!--<li class="layui-nav-item"><a href="">科学实践课</a></li>-->
                    <!--<li class="layui-nav-item"><a href="">科学家进校园</a></li>-->
                <!--</ul>-->
            <!--</div>-->
        <!--</div>-->
    </div>
    </div>
    <div id="iframe_div">
        <iframe id="contextIframe" name="contextIframe" width="100%" height="650" scrolling="no" frameborder="0" src="${ctx}/backMenu/loginView">
        </iframe>
    </div>
</div>



</body>
</html>
