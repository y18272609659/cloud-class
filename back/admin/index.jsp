<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>求真云课堂管理系统</title>
    <meta charset="UTF-8">
    <jsp:include page="../../include.jsp"/>
    <script>
        $(function(){
            layui.use('element', function(){
                var element = layui.element;
            });

            // setContentPageHeight()
        })

        function setContentPageHeight() {
            var b_iframe = window.parent.document.getElementById("contextIframe");
            var height = document.getElementById("content").offsetHeight;
            b_iframe.height = height + 30;
        };

        // 设置用户账号信息
        function setUserInfo() {
          console.log('调到setUserInfo函数了')
          $.ajax({
            url: '${ctx}/backAdmin/get',
            type: 'get',
            dataType: 'json',
            success: function (data) {
              console.log(data)
              document.getElementById('name').innerText = data.data.name
              document.getElementById('ctime').innerText =  getTime(data.data.ctime)
            },
            error: function (err) {
              console.log(err);
            }
          });
        }

        // 该函数用于将时间戳转成年月日
        function getTime(time) {
          var date = new Date(time);
          Y = date.getFullYear() + '-';
          M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
          D = date.getDate() + ' ';
          h = date.getHours() + ':';
          m = date.getMinutes() + ':';
          s = date.getSeconds();
          return Y+M+D+h+m+s //呀麻碟
        }
    </script>
    <style type="text/css">
        body {
            background-color: rgba(228, 228, 228, 1);
        }
        body,h1,h2,h3,h4,h5,h6,p{
            margin:0;
        }

        .head{
            width: 100%;
            min-height: 100px;
            background: #fff;
        }
        .title{
            height: 60px;
            line-height: 60px;
            border-bottom: 1px solid #e5e5e5;
            font-size: 18px;
            font-weight: 700;
            text-indent: 1em;
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
    </style>
</head>
<body onload="setUserInfo()">
<div id="content">
    <div class="head">
        <div class="title">
            <a href="${ctx}/backMenu/home" target="_parent">
                <img src="${ctx}/static/images/back.png" alt="">
            </a>
            账户信息
        </div>
        <div class="word-zone">
            <div class="layui-row">
                <div class="layui-col-sm2">账号名</div>
                <div class="layui-col-sm10" id="name"></div>
            </div>
            <!--<div class="layui-row">-->
                <!--<div class="layui-col-sm2">密码</div>-->
                <!--<div class="layui-col-sm10">XXX初级中学</div>-->
            <!--</div>-->
            <div class="layui-row">
                <div class="layui-col-sm2">账号创建时间</div>
                <div class="layui-col-sm10" id="ctime"></div>
            </div>
        </div>
    </div>
</div>



</body>
</html>
