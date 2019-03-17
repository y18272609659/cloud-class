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
        .add-pic-zone img{
            width: 100%;
            height: 100%;
        }

        .gap{
            height: 10px;
            background: rgb(228,228,228);
        }
        .module-1{
            padding-right: 20px;
        }
        .video-zone{
            height:181px;
            padding-bottom:15px;
        }
        .video-zone h6{
            font-size: 14px;
            font-weight: 400;
            line-height: 2;
            white-space:nowrap;
            overflow:hidden;
            text-overflow:ellipsis;
        }

        .layui-layer-content{
            padding: 20px;
        }

        /* upload */
        .add-pic-zone {
            width: 180px;
            height: 108px;
        }
        .add-pic-zone.video {
            width: 320px;
            height: 180px;
        }
        .add-pic-zone-origin {
            width: 180px;
            height: 108px;
            border-radius: 10px;
            background: #e5e5e5;
            border: 1px solid #ccc;
            line-height: 108px;
            font-size: 14px;
            color: #000;
            text-align: center;
            cursor: pointer;
            position: absolute;
            top: 0;
            left: 0;
            position: absolute;
            z-index: 1;
        }
        .add-pic-zone-origin.square {
            width: 108px;
        }
        .have-image {
            background: #fff;
            position: relative;
            font-size: 0;
            border: 0;
            border-radius: 0;
        }
        .add-pic-zone img {
            width: 100%;
            height: 100%;
        }
        .add-pic-zone video {
            width: 100%;
            height: 100%;
        }
        .upload-button {
            position: absolute;
            left: 200px;
            bottom: 0;
        }
        .upload-button.video {
            left: 340px;
        }
    </style>
    <script>
        var table = null
        var layer = null
        var laytpl = null
        var videoData = [
            // {
            // img:"upload/img/96c6b1034e3b4c8ca3475a6af7c28398.png",
            // name:"标题"
            // }
        ]
        var originVideoData = []
        var newVideoData = []
        // var layer = window.parent.parent.parent.layer
        var route_str = 'scienceVideo_addSeminar'
        layui.sessionData('zkyykt_admin_jump_page', {
            key:'left_nav'
            ,value:route_str
        });

        $(function(){
            layui.use(['element', 'table', 'form', 'layer', 'laytpl', 'upload'], function(){
                var element = layui.element;
                var form = layui.form;
                var upload = layui.upload;
                table = layui.table;
                layer = layui.layer;
                laytpl = layui.laytpl

                var uploadCoverImage = upload.render({
                    index: 0,
                    elem: '#upload_image_button',
                    url: '${ctx}/backSubject/upload',
                    exts: 'jpg|jpeg|png',
                    before: function (obj) {
                        this.index = layer.load(0, {
                            offset: (window.parent.parent.innerHeight / 2) + 'px'
                        });
                    },
                    done: function (res) {
                        if (res.r === 1) {
                            console.log(res)
                            layer.close(this.index);
                            $('#upload_image_url').val(res.file);
                            $("#upload_image_button").attr("class", "upload-button layui-btn").html("替换")
                            document.getElementById('upload_image').innerHTML = '<img src="${ctx}/' + res.file + '"/>'
                        }
                    },
                    error: function (err) {
                        //请求异常回调
                        console.log(err)
                    }
                });

                getDataFunc(element, form, upload)


                // 视频表

                // tpl
                initTpl()

                setContentPageHeight()

                // submit
                form.on('submit(next)', function (data) {
                    console.log(data.field);
                    var o = data.field
                    var subjectVideo = []
                    var obj = {
                        subject: {
                            title: o.core_name,
                            intro: o.core_intro,
                            img: o.core_upload_image_url
                        }
                    }

                    layui.each($(".video-zone-item"), function(index, item){
                        console.log(item.getElementsByTagName('input')[0].value)
                        subjectVideo.push({videoId:item.getElementsByTagName('input')[0].value})
                    })
                    obj.subjectVideo = subjectVideo
                    // console.log("obj", obj)

                    if('${subject}') {
                        console.log("===EDIT===")
                        obj.subject.id = '${subject.id}'
                        console.log("obj", obj)
                        $.ajax({
                            url: '${ctx}/backSubject/update',
                            type: 'post',
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (data) {
                                console.log(data)
                                if (data.r == 1) {
                                    alert("添加成功")
                                    window.location.href = '${ctx}/backMenu/scienceVideo'
                                }
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                    } else {
                        console.log("===ADD===")
                        console.log("obj", obj)
                        $.ajax({
                            url: '${ctx}/backSubject/add',
                            type: 'post',
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (data) {
                                console.log(data)
                                if (data.r == 1) {
                                    alert("添加成功")
                                    window.location.href = '${ctx}/backMenu/scienceVideo'
                                }
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                    }
                })
            });


        })

        function setContentPageHeight() {
            var b_iframe = window.parent.document.getElementById("contextRightIframe");
            var height = document.getElementById("content").offsetHeight;
            var h = window.parent.document.getElementById("tree").offsetHeight;
            var a_iframe = window.parent.parent.document.getElementById("contextIframe");

            if (h >= height) {
                b_iframe.height = h + 0;
                a_iframe.height = h + 0;
            } else {
                b_iframe.height = height + 0;
                a_iframe.height = height + 0;
            }

            console.log("setContentPageHeight", b_iframe.height, a_iframe.height)

            // b_iframe.height = height + 30;


        };

        function layerStart(){
            var ind = layer.open({
                title: '添加视频'
                ,shade: 0
                ,type: 1
                ,offset: ['100px', '20px']
                ,content: '<div id="demo" lay-filter="test"></div>'
                ,success: function(layero, index){

                    var l = "#" + layero.find("#demo")[0].id

                    var theTable = table.render({
                        elem: l,
                        url: '${ctx}/backVideo/videoList/0/2/all',
                        width:900,
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
                            // {
                            //     field: 'videoType',
                            //     title: '视频分类',
                            //     unresize: false,
                            //     width: 120,
                            //     sort: false,
                            //     align: 'center'
                            // },
                            // {
                            //     field: 'playNum',
                            //     title: '播放量',
                            //     unresize: false,
                            //     width: 120,
                            //     sort: false,
                            //     align: 'center'
                            // },
                            // {
                            //     field: 'adminId',
                            //     title: '发布者',
                            //     unresize: false,
                            //     width: 120,
                            //     sort: false,
                            //     align: 'center'
                            // },
                            {
                                field: 'ctime',
                                title: '添加时间',
                                unresize: false,
                                width: 120,
                                sort: false,
                                align: 'center'
                            },
                            // {
                            //     field: 'score',
                            //     title: '评分',
                            //     unresize: false,
                            //     width: 120,
                            //     sort: false,
                            //     align: 'center'
                            // },
                            {
                                field: 'operation',
                                title: '操作',
                                width: 400,
                                toolbar: '#btn',
                                align: 'center'
                            }
                        ]]
                        ,done:function(res){
                            layer.style(ind, {
                                left: '20px'
                            });
                            console.log("table", res)

                            table.on('tool(test)', function (obj) {
                                console.log("obj.data", obj.data)
                                var data = obj.data
                                var layEvent = obj.event;
                                if (layEvent === 'show') {
                                    layui.sessionData('zkyykt_admin_video', {
                                        key:'video'
                                        ,value:obj.data.video
                                    })
                                    window.open("${ctx}/backMenu/adminVideoView")
                                } else if (layEvent === 'select') {
                                    if (!checkArrayRepeat(data.id, videoData)) {
                                        alert("这个视频已经添加过了！")
                                        return
                                    }
                                    var a = {
                                        id:data.id,
                                        img:data.img,
                                        name:data.name
                                    }
                                    videoData.push(a)
                                    initTpl()
                                    layer.closeAll()
                                    setContentPageHeight()
                                }
                            })
                        }
                    });


                }
            })
        }

        function initTpl(){
            var data = videoData
            var getTpl = tpl_templet.innerHTML
                ,view = document.getElementById('tpl');

            laytpl(getTpl).render(data, function(html){
                view.innerHTML = html + "<div class=\"layui-col-sm3 video-zone\">\n" +
                    "                                    <div class=\"add-pic-zone add-pic-zone-default\" onclick=\"layerStart()\">点击添加</div>\n" +
                    "                                </div>";
            });
        }

        function checkArrayRepeat(id, arr){
            var bool = true
            layui.each(arr, function(index, item){
                console.log(id, item)
                if (item.id === id) {
                    bool = false
                }
            })
            return bool
        }

        function getDataFunc(element, form, upload){
            if('${subject}'){
                console.log("===EDIT===")
                document.getElementById('title').innerHTML = '编辑专题'
                form.val("aaa", {
                    "core_name": '${subject.title}',
                    "core_intro": '${subject.intro}',
                    "core_upload_image_url": '${subject.img}',
                });
                $("#upload_image_button").attr("class", "upload-button layui-btn").html("替换")
                document.getElementById('upload_image').innerHTML = '<img src="${ctx}/' + '${subject.img}' + '"/>'

                $.ajax({
                    url: '${ctx}/backSubject/get',
                    type: 'post',
                    data: {
                        id:'${subject.id}'
                    },
                    dataType: 'json',
                    success: function (data) {
                        console.log("success", data)
                        if (data.r == 1) {
                            originVideoData = data.videos
                            var length = originVideoData.length
                            layui.each(originVideoData, function(index, item){
                                var end = false
                                if (index === length - 1) {
                                    end = true
                                }
                                getSingleVideoFunc(item.videoId, item, end)
                                // console.log("111", singleVideo)
                                // item.img = singleVideo.img
                                // item.name = singleVideo.name
                            })
                            // console.log("after", originVideoData)
                            // videoData = originVideoData
                            // initTpl()
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
                <%--originVideoData = '${videos}'--%>
                console.log("originVideoData", originVideoData)
                getVideoDataFunc(element, form, upload)
            } else {
                console.log("===ADD===")
            }
        }

        function getVideoDataFunc(element, form, upload){
            var arr = originVideoData
            // for () {
            //
            // }
        }

        // get array中每一个视频中的图片标题
        function getSingleVideoFunc(id, item, end){
            var d = null
            $.ajax({
                url: '${ctx}/backVideo/get?id=' + id,
                type: 'get',
                <%--data: {--%>
                    <%--id:'${subject.id}'--%>
                <%--},--%>
                dataType: 'json',
                success: function (data) {
                    console.log("success single video", data)
                    if (data.r == 1) {
                        item.img = data.data.img
                        item.name = data.data.name
                        newVideoData.push({
                            id:id,              // videoId
                            img:item.img,
                            name:item.name
                        })
                        if (end) {
                            console.log("end", originVideoData)
                            videoData = originVideoData
                            initTpl()
                            setTimeout(function(){
                                recalcVideoDataFunc()
                            },3000)
                        }
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function deleteVideoFunc(index){
            videoData.splice(index,1)
            initTpl()
        }

        function recalcVideoDataFunc(){
            layui.each(videoData, function(index, item){
                if (!item.img || !item.name) {
                    console.log("recalcVideoDataFunc run")
                    for (var i = 0; i < newVideoData.length; i++) {
                        if (item.videoId === newVideoData[i].id) {
                            item.img = newVideoData[i].img
                            item.name = newVideoData[i].name
                        }
                    }
                }
            })
        }

    </script>
    <%-- text/html btn --%>
    <script type="text/html" id="btn">
        <a class="layui-btn layui-btn-xs" lay-event="show">预览</a>
        <a class="layui-btn layui-btn-xs" lay-event="select">选择</a>
    </script>
    <%-- text/html tpl_templet --%>
    <script id="tpl_templet" type="text/html">
        <ul>
            {{#  layui.each(d, function(index, item){ }}
            <div class="layui-col-sm3 video-zone video-zone-item">
                <div class="add-pic-zone">
                    <img src="${ctx}/{{ item.img }}" alt="">
                </div>
                <h6>{{ item.name }}</h6>
                <input type="hidden" value="{{ item.id }}">
                <div class="button-zone">
                    <button class="layui-btn layui-btn-sm">上移</button>
                    <button class="layui-btn layui-btn-sm layui-btn-primary layui-btn-primary-red" onclick="deleteVideoFunc({{index}})">删除</button>
                    <button class="layui-btn layui-btn-sm">下移</button>
                </div>
            </div>
            {{#  }); }}
        </ul>
    </script>
</head>
<body onload="setContentPageHeight()">
<div id="content">
    <div class="head">
        <div class="title">
            <a href="${ctx}/backMenu/scienceVideo" target="contextRightIframe">
                <img src="${ctx}/static/images/back.png" alt="">
            </a>
            <span id="title">添加专题</span>
        </div>
        <div class="core">
            <div class="layui-form" lay-filter="aaa">
                <div class="module-1">
                    <div class="layui-form-item">
                        <label class="layui-form-label">标题<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <input type="text" name="core_name" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">简介<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <textarea name="core_intro" placeholder="不超过400字" class="layui-textarea"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">封面图<span style="color: red">*</span></label>
                        <input type="hidden" id="upload_image_url" name="core_upload_image_url">
                        <div class="layui-input-block">
                            <!--<input type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">-->
                            <div class="add-pic-zone-origin" id="upload_image_button">点击添加</div>
                            <div class="add-pic-zone" id="upload_image">

                            </div>
                        </div>
                    </div>
                    <%--<div class="layui-form-item">--%>
                        <%--<div class="layui-input-block">--%>
                            <%--<button class="layui-btn" lay-submit lay-filter="next">保存并下一步</button>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                </div>
                <div class="gap"></div>
                <div class="module-1">
                    <div class="layui-form-item" style="padding-top: 20px">
                        <label class="layui-form-label">视频<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <div class="layui-row " id="tpl">
                                <%--<div class="layui-col-sm3 video-zone">--%>
                                    <%--<div class="add-pic-zone"></div>--%>
                                    <%--<h6>标题</h6>--%>
                                    <%--<div class="button-zone">--%>
                                        <%--<button class="layui-btn layui-btn-sm">上移</button>--%>
                                        <%--<button class="layui-btn layui-btn-sm layui-btn-primary layui-btn-primary-red">删除</button>--%>
                                        <%--<button class="layui-btn layui-btn-sm">下移</button>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<div class="layui-col-sm3 video-zone">--%>
                                    <%--<div class="add-pic-zone add-pic-zone-default" onclick="layerStart()">点击添加</div>--%>
                                <%--</div>--%>
                            </div>
                        </div>
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

</body>
</html>