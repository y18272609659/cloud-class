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
        input{
            font-size: 14px;
        }

        .layui-nav{
            padding:0;
        }
        .layui-nav-white{
            color:#333;
            background: #fff;
            font-size: 14px;
        }
        .layui-nav .layui-nav-item a{
            color: #333;
            font-size: 14px;
        }
        .layui-nav .layui-nav-item a:hover{
            color:#666;
        }
        .layui-nav .layui-nav-item.layui-this a{
            color:#04B75E;
        }
        .nav-f{
            position: relative;
        }
        .nav-f .select{
            position: absolute;
            width: 300px;
            height: 100%;
            right: 0;
            top:-71px;
        }
        .nav-f .select .layui-form-item{
            margin: 0;

        }

        .layui-tab{
            margin: 0;
        }
        .layui-tab-content{
            padding: 20px;
        }
        .layui-tab-title{
            height: 60px;
            position: relative;
        }
        .layui-tab-title li{
            line-height: 60px;

        }
        .layui-tab-title .layui-this{
            color: #04B75E;
        }
        .layui-tab-title .layui-this:after{
            position: absolute;
            left: 0;
            bottom:0;
            width: 100%;
            height: 5px;
            background: #04B75E;
            transition: all .2s;
            border: 0;
            top:auto;
        }

        .head{
            background: #fff;
        }
        .select{
            position: absolute;
            width: 300px;
            height: 100%;
            right: 0;
            top:0;
        }
        .select .layui-form-item{
            margin: 0;

        }
        .button {
            position: relative;
        }
        .button .layui-form ,.button .layui-form-item{
            display: inline-block;
        }
        .button button{
            vertical-align: top;
        }
        .button .layui-form-item{
            margin: 0;
        }

        /* new */
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
        .select{
            position: absolute;
            width: 345px;
            right: 0;
            top:0;
            font-size: 14px;
            font-weight: 400;
        }
        .button {
            position: relative;
        }
        .head .core .button{
            padding: 20px;
        }
        .button .layui-form ,.button .layui-form-item{
            display: inline-block;
        }
        .button button{
            vertical-align: top;
        }
        .button .layui-form-item{
            margin: 0;
        }
        .head .core .table{
            padding: 0 20px 20px;
        }
    </style>
    <script>
        var route_str = 'sciencePractice_index'
        layui.sessionData('zkyykt_admin_jump_page', {
            key:'left_nav'
            ,value:route_str
        });

        $(function(){
            layui.use(['element', 'form', 'table'], function(){
                var element = layui.element;
                var form = layui.form;
                var table = layui.table;

                var theTable = table.render({
                    elem: '#demo',
                    url: '${ctx}/backVideo/videoList/0/2/all',
                    width:900,
                    data:[{
                        'rank':'1',
                        'name':'小米',
                        'time':1000,
                        'num':100
                    }],
                    page: true,
                    cols: [[
                        {
                            field: 'title',
                            title: '标题',
                            unresize: false,
                            width: 280,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'videoType',
                            title: '类型',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'playNum',
                            title: '状态',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'ctime',
                            title: '添加时间',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'operation',
                            title: '操作',
                            width: 500,
                            toolbar: '#btn',
                            align: 'center'
                        }
                    ]]
                });

        // button event
        table.on('tool(test)', function (obj){
            var this_data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') {
                alert('缺少接口');
                window.location.href = '${ctx}/backMenu/sciencePracticeAdd?id=' + this_data.id
            } else if (layEvent === 'publish' || layEvent === 'cancel_publish') {
                var d = {
                    id:this_data.id
                }
                if (layEvent === 'publish') {
                    d.status = 1
                } else if (layEvent === 'cancel_publish') {
                    d.status = 0
                }
                $.ajax({
                    url: '${ctx}/backVideo/isRelease',
                    type: 'post',
                    data:d,
                    dataType: 'json',
                    success: function (data) {
                        console.log(data);
                        if (data.r == 1) {
                            alert("修改成功")
                        } else {
                            alert(data.msg)
                        }
                        theTable.reload()
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            } else if (layEvent === 'top' || layEvent === 'cancel_top') {
                var d = {
                    id:this_data.id
                }
                if (layEvent === 'top') {
                    d.isTop = 1
                } else if (layEvent === 'cancel_top') {
                    d.isTop = 0
                }
                $.ajax({
                    url: '${ctx}/backVideo/isTop',
                    type: 'post',
                    data:d,
                    dataType: 'json',
                    success: function (data) {
                        console.log(data);
                    if (data.r == 1) {
                        alert("修改成功")
                    } else {
                        alert(data.msg)
                    }
                        theTable.reload()
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            } else if (layEvent === 'del') {
                var d = {
                    id:this_data.id
                }
                $.ajax({
                    url: '${ctx}/backVideo/del',
                    type: 'post',
                    data:d,
                    dataType: 'json',
                    success: function (data) {
                        console.log(data);
                    if (data.r == 1) {
                        alert("删除成功")
                    } else {
                        alert(data.msg)
                    }
                    theTable.reload()
                    },
                    error: function (err) {
                        console.log(err);
                    }
                    });
            }
        })


        // 类型筛选框
        form.on('select(video_type)', function(data){
            document.getElementById('input').value = ''
            console.log(data);
            table.reload('demo', {
                url: '${ctx}/backVideo/videoList/' + data.value + '/2/all',
                page:true
            });
        });

        // 搜素框
              form.on('submit(search_demo)', function(data){
                document.getElementById('video_type').value = 0
                form.render()
                console.log(data);
                var title = data.field.title
                if (title === '') {
                  table.reload('demo', {
                    url: '${ctx}/backVideo/videoList/' + 0 + '/2/all',
                    page:true
                  });
                } else {
                  table.reload('demo', {
                    url: '${ctx}/backVideo/videoList/' + 0 + '/2/' + title,
                    page:true
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

        function jump(){
            $("#jump")[0].click()
        }
        function jump2(){
            $("#jump2")[0].click()
        }

    </script>
    <script type="text/html" id="btn">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>

    {{# if(d.status === 0){ }}
    <a class="layui-btn layui-btn-xs" lay-event="publish">发布</a>
    {{# }else{ }}
    <a class="layui-btn layui-btn-xs layui-btn-primary " lay-event="cancel_publish">取消发布</a>
    {{# } }}

    {{# if(d.isTop === 0){ }}
    <a class="layui-btn layui-btn-xs" lay-event="top">置顶</a>
    {{# }else{ }}
    <a class="layui-btn layui-btn-xs layui-btn-primary " lay-event="cancel_top">取消置顶</a>
    {{# } }}

    {{# if(d.playNum !== undefined){ }}
    <a class="layui-btn layui-btn-xs" lay-event="show">首页推荐</a>
    {{# } }}

    {{# if(d.playNum !== undefined){ }}
    <a class="layui-btn layui-btn-xs layui-btn-primary " lay-event="show">取消推荐</a>
    {{# } }}

    <a class="layui-btn layui-btn-xs layui-btn-primary layui-btn-primary-red" lay-event="del">删除</a>
    </script>
</head>
<body>
<div id="content">
    <div class="head">
        <div class="title">

            科学实践课

            <div class="select">
                <div class="layui-form">
                    <div class="layui-input-inline">
                        <input id="input" type="text" name="title" required  lay-verify="keyword" placeholder="搜索名称" autocomplete="off" class="layui-input">
                    </div>
                    <button class="layui-btn" onclick="search_name()"  lay-submit lay-filter="search_demo">搜索</button>
                </div>
            </div>
        </div>
        <div class="core">
            <div class="button">
                <a href="${ctx}/backMenu/scienceLiveAdd?id=0" style="display: none" id="jump()" onclick="alert('缺少接口')"> </a>
                <button class="layui-btn" lay-submit lay-filter="search" onclick="jump()">添加</button>
                <div class="layui-form">
                    <div class="layui-form-item">
                        <div class="layui-input-inline">
                            <select name="city" lay-verify="required" id="video_type" lay-filter="video_type">
                                <option value="0">全部</option>
                                <option value="1">科学实践课</option>
                                <option value="2">SELF · KIDS</option>
                                <option value="3">科学家进校园</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table">
                <div id="demo" lay-filter="test"></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
