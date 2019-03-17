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

            layui.use(['element', 'layer'], function(){
                var element = layui.element;

                console.log(layui.sessionData('zkyykt_admin_video'))
            });

            // setContentPageHeight()
            // isLogin();


        })

        // function setContentPageHeight() {
        //     var b_iframe = window.parent.document.getElementById("contextIframe");
        //     var height = document.getElementById("content").offsetHeight;
        //     b_iframe.height = height + 30;
        // };

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
</head>
<body>
<div class="content">

</div>



</body>
</html>
