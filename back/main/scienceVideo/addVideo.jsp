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
        .float-left {
            float: left;
        }

        .float-right {
            float: right;
        }

        body, h1, h2, h3, h4, h5, h6, p {
            margin: 0;
        }

        .layui-btn-primary, .layui-btn-primary:hover {
            color: #04B75E;
            border: 1px solid #04B75E;
        }

        .layui-btn-primary-red, .layui-btn-primary-red:hover {
            color: #ff0000;
            border: 1px solid #ff0000;
        }

        .layui-btn-primary.del {
            vertical-align: bottom;
        }

        .head {
            margin-bottom: 10px;
        }

        .head .title {
            background: #fff;
            height: 60px;
            line-height: 60px;
            font-size: 16px;
            text-indent: 1em;
            border-bottom: 1px solid #e5e5e5;
            font-weight: 700;
        }

        .head .core {
            background: #fff;
            padding: 20px 20px;
            margin: 0 0 10px;
        }

        .head .core .data {
            line-height: 2;
            font-size: 14px;
        }

        .head .core .data .name span {
            font-size: 36px;
            font-weight: 700;
        }

        .head .core .table {
            padding: 40px 0;
        }

        .table {
            padding: 0 0 20px 20px;
        }

        .head .bottom {
            padding: 20px;
            background: #fff;
        }

        .head .author {
            padding: 0 20px 20px;
            background: #fff;
            margin-bottom: 10px;
        }

        .head .author .title {
            background: #fff;
            height: 60px;
            line-height: 60px;
            font-size: 16px;
            font-weight: 700;
            border: 0;
        }

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

        .upload-button.square {
            left: 130px;
        }

        .layui-input-block {
            margin-top: 10px;
            position: relative;
        }

        .html-module {
            margin-bottom: 10px;
        }

        .layui-input-inlineblock {
            display: inline-block;
        }

        .add-pic-zone {
            width: 180px;
            height: 108px;
        }

        .add-pic-zone.square {
            width: 108px;
            height: 108px;
        }

        .add-pic-zone-default {

        }

        .intro-image-word-type {
            display: inline-block;
            width: 200px;
            margin: 0 10px 0 0;
        }

        .layui-input-inlineblock {
            margin: 10px 0;
        }
    </style>
    <script>
        var arrayHTML = []
        var laytpl = null
        var route_str = 'backMenu_scienceVideo+1'
        var extra_layer_index = 1
        layui.sessionData('zkyykt_admin_jump_page', {
            key: 'left_nav'
            , value: route_str
        });

        $(function () {
            layui.use(['element', 'table', 'form', 'upload', 'layer', 'laytpl'], function () {
                var element = layui.element;
                var form = layui.form;
                var layer = window.parent.parent.layer;
                var upload = layui.upload;
                laytpl = layui.laytpl

                $("#video_source_block").hide()

                // 获取视频分类列表
                $.ajax({
                    url: '${ctx}/backVideo/typeList',
                    type: 'post',
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

                        getDataFunc(element, form, layer, upload)
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });

                // 选择添加本地视频或外链视频
                form.on('select(add_choice)', function (data) {
                    // console.log(data.elem);
                    // console.log(data.othis);
                    console.log(data.value);
                    var v = data.value
                    if (v === '1') {
                        $("#video_source_block").hide()
                        $("#video_local_block").show()
                    } else if (v === '2') {
                        $("#video_local_block").hide()
                        $("#video_source_block").show()
                    }
                });

                // 提交表单
                form.on('submit(next)', function (data) {
                    // 视频简介
                    layui.each($('#intro_block').children(".html-module"),function(index, item){
                        // console.log($(item).children(".content")[0].value)
                        if (arrayHTML[index].type === 1 || arrayHTML[index].type === 2) {
                            arrayHTML[index].content = $(item).children(".content")[0].value
                        }
                    })
                    // console.log("arrayHTML")
                    // console.log(arrayHTML)
                    // return
                    // console.log(data);
                    console.log(data.field);
                    var o = data.field
                    var obj = {
                        video: {
                            name: o.core_name,
                            title: o.core_title,
                            type: o.core_type,
                            intro: o.core_intro,
                            videoType: o.core_videoType,
                            img: o.core_upload_image_url,
                            video: o.core_upload_video_url,
                            teacherName: o.author_name,
                            teacherTitle: o.author_honer,
                            teacherIntro: o.author_intro,
                            teacherImg: o.anthor_upload_image_url
                        },
                        videoIntros: arrayHTML
                    }
                    console.log("obj", obj)
                    // return
                    if('${video}'){
                        console.log("===EDIT=SUBMIT==")
                        obj.video.id = '${video.id}'
                        $.ajax({
                            url: '${ctx}/backVideo/update',
                            type: 'post',
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (data) {
                                console.log(data)
                                if (data.r == 1) {
                                    alert("修改成功")
                                    window.location.href = '${ctx}/backMenu/scienceVideo'
                                }
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                    } else {
                        console.log("===ADD=SUBMIT==")
                        $.ajax({
                            url: '${ctx}/backVideo/add',
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
                });

                var uploadCoverImage = upload.render({
                    index: 0,
                    elem: '#upload_image_button',
                    url: '${ctx}/backVideo/upload/1',
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

                var uploadVideo = upload.render({
                    index: 0,
                    elem: '#upload_video_button',
                    url: '${ctx}/backVideo/upload/0',
                    exts: 'mp4',
                    xhr: xhrOnProgress,
                    progress: function (value) {//上传进度回调 value进度值
                        element.progress('demo', value + '%')//设置页面进度条
                        // console.log(value)
                    },
                    before: function (obj) {
                        // this.index = layer.load(0,{
                        //     offset: (window.parent.parent.innerHeight / 2) + 'px'
                        // });
                        element.progress('demo', '0%')
                        $("#uploadLoadingDiv").show()
                    },
                    done: function (res) {
                        if (res.r === 1) {
                            console.log(res)
                            // layer.close(this.index);
                            $('#upload_video_url').val(res.file);
                            $("#upload_video_button").attr("class", "upload-button layui-btn video").html("替换")
                            document.getElementById('upload_video').innerHTML = '<video src="${ctx}/' + res.file + '" controls></video>'
                            setContentPageHeight()
                        }
                    },
                    error: function (err) {
                        //请求异常回调
                        console.log(err)
                    }
                });

                var uploadAuthorImage = upload.render({
                    index: 0,
                    elem: '#upload_author_image_button',
                    url: '${ctx}/backVideo/upload/1',
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
                            $('#upload_author_image_url').val(res.file);
                            $("#upload_author_image_button").attr("class", "upload-button layui-btn square").html("替换")
                            document.getElementById('upload_author_image').innerHTML = '<img src="${ctx}/' + res.file + '"/>'
                        }
                    },
                    error: function (err) {
                        //请求异常回调
                        console.log(err)
                    }
                });

                var uploadIntroImage = upload.render({
                    index: 0,
                    elem: '#intro_btn_image_add',
                    url: '${ctx}/backVideo/upload/1',
                    exts: 'jpg|jpeg|png',
                    before: function (obj) {
                        this.index = layer.load(0, {
                            offset: (window.parent.parent.innerHeight / 2) + 'px'
                        });
                    },
                    done: function (res) {
                        if (res.r == 1) {
                            console.log(res)
                            layer.close(this.index);
                            $('.intro-image-type').find("input.image").val(res.file)
                            $('.intro-image-type').find(".add-pic-zone")[0].innerHTML = '<img src="${ctx}/' + res.file + '"/>'
                            // reUpload done function
                            var id = '#intro_image_child_replace'
                            var ex_index = 1
                            var func = function (r, ind) {
                                console.log("func START ---")
                                if (r.r == 1) {
                                    layer.close(ind)
                                    $('.intro-image-type').find("input.image").val(r.file)
                                    $('.intro-image-type').find(".add-pic-zone")[0].innerHTML = '<img src="${ctx}/' + r.file + '"/>'
                                }
                            }
                            repeatUploadFunc(id, func, upload, ex_index, layer)
                        }
                    },
                    error: function (err) {
                        //请求异常回调
                        console.log(err)
                    }
                });

                setContentPageHeight()
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

            // b_iframe.height = height + 30;


        };

        var xhrOnProgress = function (fun) {
            // console.log("xhrOnProgress")
            xhrOnProgress.onprogress = fun; //绑定监听
            //使用闭包实现监听绑
            return function () {
                //通过$.ajaxSettings.xhr();获得XMLHttpRequest对象
                var xhr = $.ajaxSettings.xhr();
                //判断监听函数是否为函数
                if (typeof xhrOnProgress.onprogress !== 'function')
                    return xhr;
                //如果有监听函数并且xhr对象支持绑定时就把监听函数绑定上去
                if (xhrOnProgress.onprogress && xhr.upload) {
                    xhr.upload.onprogress = xhrOnProgress.onprogress;
                }
                return xhr;
            }
        }

        function repeatUploadFunc(id, func, upload, index, layer) {
            upload.render({
                index: index,
                elem: id,
                url: '${ctx}/backVideo/upload/1',
                exts: 'jpg|jpeg|png',
                before: function (obj) {
                    index = layer.load(0, {
                        offset: (window.parent.parent.innerHeight / 2) + 'px'
                    });
                },
                done: function (res) {
                    func(res, index)
                }
                , error: function (err) {
                    //请求异常回调
                    console.log(err)
                }
            });
        }

        function getDataFunc(element, form, layer, upload){
            if('${video}'){
                console.log("===EDIT===")
                document.getElementById('title').innerHTML = '编辑视频'
                form.val("aaa", {
                    "core_name": '${video.name}',
                    "core_title": '${video.title}',
                    "core_videoType": '${video.videoType}',
                    "core_type": '${video.type}',
                    "core_intro": '${video.intro}',
                    "core_upload_image_url": '${video.img}',
                    "core_upload_video_url": '${video.video}',
                    "author_name": '${video.teacherName}',
                    "author_honer": '${video.teacherTitle}',
                    "author_intro": '${video.teacherIntro}',
                    "anthor_upload_image_url": '${video.teacherImg}',
                });

                $("#upload_image_button").attr("class", "upload-button layui-btn").html("替换")
                document.getElementById('upload_image').innerHTML = '<img src="${ctx}/' + '${video.img}' + '"/>'
                $("#upload_video_button").attr("class", "upload-button layui-btn video").html("替换")
                document.getElementById('upload_video').innerHTML = '<video src="${ctx}/' + '${video.video}' + '" controls></video>'
                $("#upload_author_image_button").attr("class", "upload-button layui-btn square").html("替换")
                document.getElementById('upload_author_image').innerHTML = '<img src="${ctx}/' + '${video.teacherImg}' + '"/>'

                var id = '${video.id}'
                getDataFunc2(id)

            } else {
                console.log("===ADD===")
            }
        }

        function addHTMLFunc(type){
            console.log("addHTMLFunc")
            arrayHTML.push({
                type:type,
                content:'',
                intro:''
            })
            initTpl()
        }

        function initTpl(){
            console.log("initTpl")
            var data = arrayHTML
            var getTpl = tpl_templet.innerHTML
                ,view = document.getElementById('intro_block');
            // console.log(getTpl)
            // console.log(view)

            laytpl(getTpl).render(data, function(html){
                view.innerHTML = html
                setContentPageHeight()
            });
        }

        // function initTplEdit(){
        //     console.log("initTpl")
        //     var data = arrayHTML
        //     var getTpl = tpl_templet.innerHTML
        //         ,view = document.getElementById('intro_block');
        //     // console.log(getTpl)
        //     // console.log(view)
        //
        //     laytpl(getTpl).render(data, function(html){
        //         view.innerHTML = html
        //         setContentPageHeight()
        //
        //         console.log(111)
        //
        //     });
        //
        // }

        function getDataFunc2(id){
            $.ajax({
                url: '${ctx}/backVideo/get?id=' + id,
                type: 'get',
                dataType: 'json',
                success: function (data) {
                    console.log("success get video", data)
                    if (data.r == 1) {
                        arrayHTML = data.intro
                        console.log(arrayHTML)
                        initTpl()

                        layui.each($('#intro_block').children(".html-module"),function(index, item){
                            if (arrayHTML[index].type === 1 || arrayHTML[index].type === 2) {
                                $(item).children(".content")[0].value = arrayHTML[index].content
                            }
                        })
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

    </script>
    <script type="text/html" id="btn">
        <a class="layui-btn layui-btn-xs" lay-event="show">查看详情</a>
    </script>
    <%-- text/html tpl_templet --%>
    <script id="tpl_templet" type="text/html">

        {{#  layui.each(d, function(index, item){ }}
            {{# if(item.type === 1){ }}
                <div class="layui-input-block html-module">
                    <input type="text" name="bottom_name" placeholder="不超过16字" autocomplete="off"
                           class="layui-input content">
                </div>
            {{# } }}
            {{# if(item.type === 2){ }}
                <div class="layui-input-block html-module">
                    <textarea name="bottom_intro" placeholder="不超过400字" class="layui-textarea content"></textarea>
                </div>
            {{# } }}
        {{#  }); }}

    </script>
</head>
<body onload="setContentPageHeight()">
<div id="content">
    <div class="head layui-form" lay-filter="aaa">
        <div class="title">
            <a href="${ctx}/backMenu/scienceVideo" target="contextRightIframe">
                <img src="${ctx}/static/images/back.png" alt="">
            </a>
            <span id="title">添加视频</span>
        </div>
    <form>
        <div class="core">
            <div class="">
                <div class="layui-form-item">
                    <label class="layui-form-label">标题<span style="color: red">*</span></label>
                    <div class="layui-input-block">
                        <input  required="required" type="text" name="core_name" placeholder="不超过16字" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">一句话简介<span style="color: red">*</span></label>
                    <div class="layui-input-block">
                        <input  required="required"  type="text" name="core_title" placeholder="不超过20字" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">分类<span style="color: red">*</span></label>
                    <div class="layui-input-block">
                        <div class="layui-input-inline">
                            <select  required  name="core_videoType" id="video_type">
                                <option value=""></option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">简介<span style="color: red">*</span></label>
                    <div class="layui-input-block">
                        <textarea  required="required"  name="core_intro" placeholder="不超过400字" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">封面图<span style="color: red">*</span></label>
                    <input  required="required"  type="hidden" id="upload_image_url" name="core_upload_image_url">
                    <div class="layui-input-block">
                        <!--<input type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">-->
                        <div class="add-pic-zone-origin" id="upload_image_button">点击添加</div>
                        <div class="add-pic-zone" id="upload_image">

                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">视频<span style="color: red">*</span></label>
                    <div class="layui-input-block">
                        <div class="layui-input-inline">
                            <select  required="required"  name="core_type" lay-filter="add_choice">
                                <option value="1">添加本地视频</option>
                                <option value="2">添加外部链接</option>
                            </select>
                        </div>
                    </div>
                    <input  required="required"  type="hidden" id="upload_video_url" name="core_upload_video_url">
                    <div class="layui-input-block" style="margin-top: 10px;margin-bottom: 10px" id="video_local_block">
                        <div class="add-pic-zone-origin" id="upload_video_button">点击添加</div>
                        <div class="add-pic-zone video" id="upload_video">

                        </div>
                    </div>
                    <div class="layui-input-block" id="video_source_block">
                        <input  required="required"  type="text" name="core_upload_video_url_outside" placeholder="请输入外部连接" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item" id="uploadLoadingDiv" style="display:none">

                    <label class="layui-form-label">进度条</label>
                    <div class="layui-input-block" style="padding-top: 15px">

                        <div class="layui-progress" lay-showpercent="true" lay-filter="demo">
                            <div class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
        <div class="author">
            <div class="title">
                添加主讲人信息
            </div>
            <div class="">
                <div class="layui-form-item">
                    <label class="layui-form-label">名称<span style="color: red">*</span></label>
                    <div class="layui-input-block">
                        <input  required="required"  type="text" name="author_name" placeholder="不超过16字" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">头衔<span style="color: red">*</span></label>
                    <div class="layui-input-block">
                        <input  required="required"  type="text" name="author_honer" placeholder="不超过20字" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">简介<span style="color: red">*</span></label>
                    <div class="layui-input-block">
                        <textarea required="required" name="author_intro" placeholder="不超过400字" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">照片<span style="color: red">*</span></label>
                    <input  required="required"  type="hidden" id="upload_author_image_url" name="anthor_upload_image_url">
                    <div class="layui-input-block">
                        <div class="add-pic-zone-origin square" id="upload_author_image_button">点击添加</div>
                        <div class="add-pic-zone square" id="upload_author_image">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="bottom">
            <div class="layui-form-item">
                <label class="layui-form-label">视频简介<span style="color: red">*</span></label>
                <div id="intro_block">
                    <!--
                    <div class="layui-input-block html-module">
                        <input type="text" name="bottom_name" placeholder="不超过16字" autocomplete="off"
                               class="layui-input">
                    </div>
                    <div class="layui-input-block html-module">
                        <textarea name="bottom_intro" placeholder="不超过400字" class="layui-textarea"></textarea>
                    </div>
                    <div class="layui-input-block html-module intro-image-type">
                        <input type="hidden" class="image" name="bottom_upload_image_url">
                        <div class="layui-input-block-zero">
                            <div class="add-pic-zone add-pic-zone-default"></div>
                        </div>
                        <div class="layui-input-inlineblock">
                            <input type="text" name="bottom_upload_image_desc" placeholder="不超过16字" autocomplete="off"
                                   class="layui-input intro-image-word-type">
                            <button class="layui-btn layui-btn-primary layui-btn-primary-red del">删除</button>
                            <button class="layui-btn" id="intro_image_child_replace">更换</button>
                        </div>
                    </div>
                    -->
                </div>
                <div class="layui-input-block">
                    <div class="layui-btn-group">
                        <button class="layui-btn" onclick="addHTMLFunc(1)">添加子标题</button>
                        <button class="layui-btn" onclick="addHTMLFunc(2)">添加文案</button>
                        <%--<button class="layui-btn" id="intro_btn_image_add" onclick="addHTML(3)">添加图片</button>--%>
                        <button class="layui-btn" onclick="addHTMLFunc(3)">添加图片</button>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input type="submit" class="layui-btn" lay-submit lay-filter="next" value="立即提交">
                </div>
            </div>
        </div>
    </form>
    </div>
</div>
</div>
</body>
</html>
