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
        body{
            min-height:450px;
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
    </style>
    <script>
        var anotherTableHeight = 0
        var route_str = 'backMenu_scienceVideo+1'
        layui.sessionData('zkyykt_admin_jump_page', {
            key:'left_nav'
            ,value:route_str
        });

        $(function(){
            layui.use(['element', 'form', 'table'], function(){
                var element = layui.element;
                var form = layui.form;
                var table = layui.table;


                // 视频表
                var theTable = table.render({
                    elem: '#demo',
                    url: '${ctx}/backVideo/videoList/0/2/all',
                    width:900,
                    // data:[{
                    //     'rank':'1',
                    //     'name':'小米',
                    //     'time':1000,
                    //     'num':100
                    // }],
                    page: true,
                    cols: [[
                        {
                            field: 'name',
                            title: '视频标题',
                            unresize: false,
                            width: 280,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'videoType',
                            title: '视频分类',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'playNum',
                            title: '播放量',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'adminId',
                            title: '发布者',
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
                            field: 'score',
                            title: '评分',
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
                    ,done:function(){
                        setContentPageHeight(1)
                    }
                });
                // 专题表
                var theTable2 = table.render({
                    elem: '#demo2',
                    url: '${ctx}/backSubject/list/all',
                    width:900,
                    // data:[{
                    //     'rank':'1',
                    //     'name':'小米',
                    //     'time':1000,
                    //     'num':100
                    // }],
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
                            title: '创建时间',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'num',
                            title: '视频数量',
                            unresize: false,
                            width: 120,
                            sort: false,
                            align: 'center'
                        },
                        {
                            field: 'operation',
                            title: '操作',
                            width: 450,
                            toolbar: '#btn',
                            align: 'center'
                        }
                    ]]
                    ,done:function(){
                        setContentPageHeight(2)
                    }
                });
                // button event
                // edit publish(cancel_publish) top(cancel_top) recommend(cancel_recommend) delete
                table.on('tool(test)', function (obj){
                    var this_data = obj.data;
                    var layEvent = obj.event;
                    if (layEvent === 'edit') {
                        // alert("???")
                        window.location.href = '${ctx}/backMenu/scienceVideoAdd?id=' + this_data.id
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
                table.on('tool(test2)', function (obj){
                    var this_data = obj.data;
                    var layEvent = obj.event;
                    if (layEvent === 'edit') {
                        window.location.href = '${ctx}/backMenu/scienceVideoAddSeminar?id=' + this_data.id
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
                            url: '${ctx}/backSubject/isRelease',
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
                                theTable2.reload()
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
                            url: '${ctx}/backSubject/isTop',
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
                                theTable2.reload()
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
                            url: '${ctx}/backSubject/del',
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
                                theTable2.reload()
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                    }
                })

                // setInterval(function(){
                //     setContentPageHeight()
                // },1000)
                // setContentPageHeight()

                // get typeList
                $.ajax({
                    url: '${ctx}/backVideo/typeList',
                    type: 'get',
                    dataType: 'json',
                    success: function (data) {
                        console.log("select", data)
                        if (data.r == 1) {
                            var obj = data.data
                            for (var i = 0; i < obj.length; i++) {
                                $("#video_type").append("<option value=" + obj[i].id + ">" + obj[i].name + "</option>")
                            }
                        }
                        form.render();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });

                // select
                form.on('select(video_type)', function(data){
                    document.getElementById('input_1').value = ''
                    console.log(data);
                    table.reload('demo', {
                        url: '${ctx}/backVideo/videoList/' + data.value + '/2/all',
                        page:true
                    });
                });

                // input 1
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

                // input 2
                form.on('submit(search_demo2)', function(data){
                    console.log(data);
                    var title = data.field.title2
                    if (title === '') {
                        table.reload('demo2', {
                            url: '${ctx}/backSubject/list/all',
                            page:true
                        });
                    } else {
                        table.reload('demo2', {
                            url: '${ctx}/backSubject/list/' + title,
                            page:true
                        });
                    }
                });

            });


        })

        function setContentPageHeight(x) {
            // anotherTableHeight 当一个表加载完之后，那个tab的高度
            // 如果发现另一个tab加载过而且更高，就不再计算iframe高度

            var b_iframe = window.parent.document.getElementById("contextRightIframe");
            var height = document.getElementById("content").offsetHeight;
            var h = window.parent.document.getElementById("tree").offsetHeight;
            var a_iframe = window.parent.parent.document.getElementById("contextIframe");

            console.log(a_iframe.height, height)

            if (!!x) {
                if (anotherTableHeight && anotherTableHeight > height) {
                    return
                } else {
                    anotherTableHeight = height
                }
            }

            if (height < 450) {
                b_iframe.height = 450
                return
            }

            // if (h >= height) {
            //     b_iframe.height = h ;
            //     a_iframe.height = h ;
            // } else {
                b_iframe.height = height ;
                a_iframe.height = height > 550 ? height : 550 ;
            // }



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
<body onload="setContentPageHeight()">
<div id="content">
    <div class="head">
        <div class="nav-f">
            <!--<ul class="layui-nav layui-nav-white" lay-filter="">-->
                <!--<li class="layui-nav-item layui-this"><a href="">视频</a></li>-->
                <!--<li class="layui-nav-item"><a href="">专题</a></li>-->
            <!--</ul>-->
            <!--<div class="select">-->
                <!--<div class="layui-form">-->
                    <!--<div class="layui-form-item">-->
                        <!--<div class="layui-input-block">-->
                            <!--<select name="interest" lay-filter="aihao">-->
                                <!--<option value="0">写作</option>-->
                                <!--<option value="1">阅读</option>-->
                            <!--</select>-->
                        <!--</div>-->
                    <!--</div>-->
                <!--</div>-->
            <!--</div>-->
            <div class="layui-tab" lay-filter="demo">
                <ul class="layui-tab-title">
                    <li class="layui-this">视频</li>
                    <li>专题</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <a href="${ctx}/backMenu/scienceVideoAdd?id=0" style="display: none" id="jump"> </a>
                        <div class="button">
                            <button class="layui-btn" lay-submit lay-filter="search" onclick="jump()">添加</button>
                            <div class="layui-form">
                                <div class="layui-form-item">
                                    <div class="layui-input-inline">
                                        <select name="city" lay-filter="video_type" id="video_type">
                                            <option value="0">全部</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="select">
                                <div class="layui-form">
                                    <div class="layui-form-item">
                                        <div class="layui-input-inline">
                                            <input id="input_1" type="text" name="title" required  lay-verify="keyword" placeholder="搜索视频标题" autocomplete="off" class="layui-input">
                                        </div>
                                        <button class="layui-btn" lay-submit lay-filter="search_demo">搜索</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="table">
                            <div id="demo" lay-filter="test"></div>
                        </div>
                    </div>
                    <div class="layui-tab-item">
                        <a href="${ctx}/backMenu/scienceVideoAddSeminar?id=0" style="display: none" id="jump2"></a>
                        <div class="button">
                            <button class="layui-btn" lay-submit lay-filter="search" onclick="jump2()">添加</button>
                            <div class="select">
                                <div class="layui-form">
                                    <div class="layui-form-item">
                                        <div class="layui-input-inline">
                                            <input type="text" name="title2" placeholder="搜索标题" autocomplete="off" class="layui-input">
                                        </div>
                                        <button class="layui-btn" lay-submit lay-filter="search_demo2">搜索</button>
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