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

        .enroll-a,.enroll-a:hover{
            color: #04B75E;;
        }
    </style>
    <script>
        var route_str = 'principalBBS_index'
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
                    url: '${ctx}/backPrincipalForum/list/all',
                    width:900,
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
                            width: 400,
                            toolbar: '#btn',
                            align: 'center'
                        }
                    ]]
                });
                var theTable2 = table.render({
                    elem: '#demo2',
                    url: '',
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
                            field: 'time',
                            title: '创建时间',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'enroll',
                            title: '报名人数',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center',
                            toolbar: '#enroll',
                        },
                        {
                            field: 'people',
                            title: '预约人数',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'operation',
                            title: '操作',
                            width: 400,
                            toolbar: '#btn',
                            align: 'center'
                        }
                    ]]
                });

                table.on('tool(history)', function (obj){
                	var data = obj.data; //获得当前行数据
                	var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                	var tr = obj.tr; //获得当前行 tr 的DOM对象
                	console.log(obj)
                	switch(obj.event){
	                    case 'edit':
	                    	window.location.href = '${ctx}/backMenu/principalBBSAddHistory?id=' + data.id
	                    	break;
	                    case 'status':
	                    	var postData = {
                            	'id':data.id,
                            	'status':data.status === 0 ? 1 : 0
                            };
	                    	$.ajax({
	                            url: '${ctx}/backPrincipalForum//isRelease',
	                            type: 'post',
	                            data:JSON.stringify(postData),
	                            dataType: 'json',
	                            contentType: "application/json",
	                            success: function (data) {
	                                console.log(data)
	                                if (data.r == 1) {
	                                	layer.msg('成功')
	                                    obj.update({
	                                    	status: data.status === 0 ? 1 : 0
	                                     });
	                                }else if(data.r == 0){
	                                	layer.msg(data.msg)
	                                }
	                            },
	                            error: function (err) {
	                                console.log(err);
	                            }
	                        });
	                    	break;
	                    case 'toTop':
	                    	var postData = {
	                            	'id':data.id,
	                            	'isTop':data.isTop === 0 ? 1 : 0
	                            };
	                    	$.ajax({
	                            url: '${ctx}/backPrincipalForum/isTop',
	                            type: 'post',
	                            data:JSON.stringify(postData),
	                            dataType: 'json',
	                            contentType: "application/json",
	                            success: function (data) {
	                                console.log(data)
	                                if (data.r == 1) {
	                                	layer.msg('成功')
	                                    obj.update({
	                                    	isTop: data.isTop === 0 ? 1 : 0
	                                     });
	                                }else if(data.r == 0){
	                                	layer.msg(data.msg)
	                                }
	                            },
	                            error: function (err) {
	                                console.log(err);
	                            }
	                        });
	                      	break;
	                    case 'del':
	                    	var postData = {
                            	'id':data.id
                            };
	                    	$.ajax({
	                            url: '${ctx}/backPrincipalForum/del',
	                            type: 'post',
	                            data:JSON.stringify(postData),
	                            dataType: 'json',
	                            contentType: "application/json",
	                            success: function (data) {
	                                console.log(data)
	                                if (data.r == 1) {
	                                	layer.msg('成功')
	                                	obj.del()
	                                }else if(data.r == 0){
	                                	layer.msg(data.msg)
	                                }
	                            },
	                            error: function (err) {
	                                console.log(err);
	                            }
	                        });
	                    	break;
	                  };
                })
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
		{{# if(d.isTop === 0){ }}
			<a class="layui-btn layui-btn-xs" lay-event="toTop">置顶</a>
		{{# }else{ }}
			<a class="layui-btn layui-btn-xs" lay-event="toTop">取消置顶</a>
        {{# } }}
		{{# if(d.status === 0){ }}
			<a class="layui-btn layui-btn-xs" lay-event="status">发布</a>
		{{# }else{ }}
			<a class="layui-btn layui-btn-xs" lay-event="status">取消发布</a>
        {{# } }}
        <a class="layui-btn layui-btn-xs layui-btn-primary layui-btn-primary-red" lay-event="del">删除</a>
    </script>
    <script type="text/html" id="enroll">
        <a class="enroll-a" lay-event="show" href="enroller.html">123</a>
    </script>
</head>
<body>
<div id="content">
    <div class="head">
        <div class="nav-f">
            <div class="layui-tab" lay-filter="demo">
                <ul class="layui-tab-title">
                    <li class="layui-this">历史</li>
                    <li>预告</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <a href="${ctx}/backMenu/principalBBSAddHistory?id=0" style="display: none" id="jump"> </a>
                        <div class="button">
                            <button class="layui-btn" lay-submit lay-filter="search" onclick="jump()">添加</button>
                            <div class="select">
                                <div class="layui-form">
                                    <div class="layui-form-item">
                                        <div class="layui-input-inline">
                                            <input type="text" name="title" required  lay-verify="keyword" placeholder="搜索标题" autocomplete="off" class="layui-input">
                                        </div>
                                        <button class="layui-btn" lay-submit lay-filter="search">搜索</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="table">
                            <div id="demo" lay-filter="history"></div>
                        </div>
                    </div>
                    <div class="layui-tab-item">
                        <a href="${ctx}/backMenu/principalBBSAddLiveHerald?id=0" style="display: none" id="jump2"></a>
                        <div class="button">
                            <button class="layui-btn" lay-submit lay-filter="search" onclick="jump2()">添加</button>
                            <div class="select">
                                <div class="layui-form">
                                    <div class="layui-form-item">
                                        <div class="layui-input-inline">
                                            <input type="text" name="title" required  lay-verify="keyword" placeholder="搜索标题" autocomplete="off" class="layui-input">
                                        </div>
                                        <button class="layui-btn" lay-submit lay-filter="search">搜索</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="table">
                            <div id="demo2" lay-filter="test2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>