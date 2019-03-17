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
        .button{
            padding: 10px 0 0 20px;
        }
    </style>
    <script>
        var browser = new Browser();
        // console.log(browser)
        // browser.transTimeStamp(1540802266000)
        var route_str = 'backMenu_adminAccounts+11'
        layui.sessionData('zkyykt_admin_jump_page', {
            key:'left_nav'
            ,value:route_str
        });

        $(function(){
            layui.use(['element', 'table', 'form'], function(){
                var element = layui.element;
                var table = layui.table;
                var form = layui.form;


                var theTable2 = table.render({
                    elem: '#demo',
                    url: '${ctx}/backAdmin/listByPage/all',
                    width:900,
                    page: true,
                    cols: [[
                        {
                            field: 'name',
                            title: '名称',
                            unresize: false,
                            width: 180,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'account',
                            title: '账号',
                            unresize: false,
                            width: 180,
                            sort: false,
                            align: 'center',

                        },
                        {
                            field: 'ctime',
                            title: '添加时间',
                            unresize: false,
                            width: 180,
                            sort: false,
                            align: 'center',
                            templet: '#time'
                        },
                        {
                            field: 'operation',
                            title: '操作',
                            width: 180,
                            toolbar: '#btn',
                            align: 'center'
                        }
                    ]]
                });

                table.on('tool(test)', function (obj){
                    var data = obj.data
                    var layEvent = obj.event;

                    if (layEvent == 'show') {
                        window.location.href = '${ctx}/backMenu/adminAccountsShow?id=' + data.id
                    } else if (layEvent == 'edit') {
                        window.location.href = '${ctx}/backMenu/adminAccountsAdd?id=' + data.id
                    } else if (layEvent == 'del') {
                        $.ajax({
                            url: '${ctx}/backAdmin/del',
                            type: 'post',
                            data:{
                                id:data.id
                            },
                            dataType: 'json',
                            success: function (data) {
                                alert("删除成功")
                                theTable2.reload()
                            },
                            error: function (err) {

                            }
                        });
                    }
                })

                console.log(table)
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

        function jump(){
            $("#jump")[0].click()
        }

        function search_name(){
            var table = layui.table;
            // console.log(table)
            var name = document.getElementById("input");
            if (name.value != '') {
                table.reload('demo', {
                    url: '${ctx}/backAdmin/listByPage/' + name,
                });
            } else {
                table.reload('demo', {
                    url: '${ctx}/backAdmin/listByPage/all',
                });
            }
        }

    </script>
    <script type="text/html" id="time">
        {{ browser.transTimeStamp(d.ctime) }}
    </script>
    <script type="text/html" id="btn">
        <a class="layui-btn layui-btn-xs" lay-event="show" >查看</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit" >编辑</a>
        <a class="layui-btn layui-btn-xs layui-btn-primary layui-btn-primary-red" lay-event="del">删除</a>
    </script>
</head>
<body>
<div id="content">
    <div class="head">
        <div class="title">
            <%--<a href="./index.index.jsp" target="contextRightIframe">--%>
                <%--<img src="../../../../../static/images/back.png" alt="">--%>
            <%--</a>--%>
            管理员账户

            <div class="select">
                <div class="layui-form">
                    <div class="layui-input-inline">
                        <input id="input" type="text" name="title" required  lay-verify="keyword" placeholder="搜索名称" autocomplete="off" class="layui-input">
                    </div>
                    <button class="layui-btn" onclick="search_name()">搜索</button>
                </div>
            </div>
        </div>

        <div class="button">
            <a href="${ctx}/backMenu/adminAccountsAdd?id=0" style="display: none" id="jump"></a>
            <%--<a href="showAdminAccounts.showAdminAccounts.jsp" style="display: none" id="jump2"></a>--%>
            <button class="layui-btn" lay-submit lay-filter="search" onclick="jump()">添加</button>
        </div>
        <div class="table">
            <div id="demo" lay-filter="test"></div>
        </div>
    </div>
</div>
</div>
</body>
</html>