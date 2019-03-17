<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <jsp:include page="../include.jsp"/>
</head>
<style type="text/css">

    body {
        background-color: rgba(228, 228, 228, 1);
    }

    #content {
    }

    .form_div{
        margin: 0px auto;
        width: 595px;
        /*height: 315px;*/
        background-color: white;
        box-shadow: 0px 2px 5px rgba(107, 107, 107, 0.349019607843137);
    }
    .title{
        height: 75px;
        line-height: 75px;
        background-color: rgba(242, 242, 242, 1);
        font-weight: 700;
        font-style: normal;
        font-size: 16px;
        text-align: left;
        padding: 0 80px;
        overflow:hidden;

    }
    .input-div{
        padding: 30px  80px 0px;
    }
    .float-left{
        float: left;
        position: relative;
    }
    .float-left .logo{
        position: absolute;
        top:20px;
        left:0;
        width: 35px;
        height: 35px;
        background: #fff;
        display: block;
    }
    .float-right{
        float: right;
    }
    .title .float-left{
        padding-left: 50px;
    }
    .title .float-right{
        color: #04B75E;
        font-size: 14px;
        font-weight: 400;
        cursor: pointer;
    }
    .submit{
        padding-bottom: 50px;
    }

    .layui-form-item{
        position: relative;
    }
    .layui-form-item .vcode{
        background: #fff;
        height: 38px;
        width: 100px;
        position: absolute;
        right: 0;
        top:0;
    }


</style>
<script>
    // window.onload = function () {
    //     document.body.style.fontSize = 62.5 + "%"
    // }

    $(function () {

        setContentPageHeight();

        layui.use('form', function () {
            var form = layui.form;
            //登录按钮绑定事件
            form.on('submit(loginBtn)', function (data) {
                var email = data.field.email
                var password = data.field.password
                window.parent.login(email, password);
            })
        });
    });


    function setContentPageHeight() {
        var b_iframe = window.parent.document.getElementById("contextIframe");
        var height = document.getElementById("content").scrollHeight + 50;
        b_iframe.height = height
    }



</script>
<body>
<div id="content">
    <div style="height: 120px"></div>
    <div class="form_div">
        <div class="layui-form">
            <div class="title layui-clear">
                <p class="float-left">
                    求真云课堂
                    <span class="logo"></span>
                </p>
                <p class="float-right">示范基地 &gt;</p>
            </div>
            <div class="input-div">
                <div class="layui-form-item">
                    <input type="text" id="email" name="email" required lay-verify="required" placeholder="请输入账号"
                           autocomplete="off" class="layui-input" value="">
                </div>
                <div class="layui-form-item">
                    <input type="password" id="password" name="password" required lay-verify="required"
                           placeholder="请输入密码"
                           autocomplete="off" class="layui-input" value="">
                </div>
                <%--<div class="layui-form-item">--%>
                    <%--<input type="password" id="code" name="code" required lay-verify="required"--%>
                           <%--placeholder="请输入右侧验证码"--%>
                           <%--autocomplete="off" class="layui-input" value="">--%>
                    <%--<img class="vcode" src="" alt="">--%>
                <%--</div>--%>
                <div class="layui-form-item submit" style="margin-top: 45px">
                    <button class="layui-btn  layui-btn-fluid" lay-submit lay-filter="loginBtn" style="background-color: rgba(4, 183, 94, 1);">登录</button>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">

</script>
</body>
</html>
