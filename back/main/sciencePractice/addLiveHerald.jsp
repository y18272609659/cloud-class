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
        .layui-btn-primary.del{
            vertical-align: bottom;
        }
        .layui-form-label{
            width: 100px;
        }
        .layui-input-block{
            margin-left: 130px;
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

        .gap{
            height: 10px;
            background: rgb(228,228,228);
        }
        .module-1{
            padding-right: 20px;
        }
        .video-zone h6{
            font-size: 14px;
            font-weight: 400;
            line-height: 2;
            white-space:nowrap;
            overflow:hidden;
            text-overflow:ellipsis;
        }

        .html-module{
            margin-bottom: 10px;
        }
        .layui-input-inlineblock{
            display: inline-block;
        }
    </style>
    <script>
        var route_str = 'sciencePractice_addLiveHerald'
        layui.sessionData('zkyykt_admin_jump_page', {
            key:'left_nav'
            ,value:route_str
        });

        $(function(){
            layui.use(['element', 'table', 'form'], function(){
                var element = layui.element;
                var form = layui.form;


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

    </script>
    <script type="text/html" id="btn">
        <a class="layui-btn layui-btn-xs" lay-event="show">查看详情</a>
    </script>
</head>
<body>
<div id="content">
    <div class="head">
        <div class="title">
            <a href="./index.index.jsp" target="contextRightIframe">
                <img src="../../../../../static/images/back.png" alt="">
            </a>
            添加预告
        </div>
        <div class="core">
            <div class="layui-form">
                <div class="module-1">
                    <div class="layui-form-item">
                        <label class="layui-form-label">标题<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <input type="text" name="title" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">地址</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">直播时间<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <input type="text" name="title" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">直播课堂地址<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <input type="text" name="title" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">封面图<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <!--<input type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">-->
                            <div class="add-pic-zone add-pic-zone-default">点击添加</div>
                        </div>
                    </div>
                </div>
                <div class="gap"></div>
                <div class="module-1">
                    <div class="layui-form-item" style="padding-top: 20px">
                        <label class="layui-form-label">正文<span style="color: red">*</span></label>
                        <div class="layui-input-block html-module">
                            <input type="text" name="title" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-input-block html-module">
                            <textarea name="desc" placeholder="不超过400字" class="layui-textarea"></textarea>
                        </div>
                        <div class="layui-input-block html-module">
                            <div class="layui-input-inlineblock">
                                <div class="add-pic-zone add-pic-zone-default">点击添加</div>
                            </div>
                            <button class="layui-btn layui-btn-primary layui-btn-primary-red del">删除</button>
                        </div>
                        <!--<div class="layui-input-block html-module">-->
                            <!--<div class="layui-input-inlineblock">-->
                                <!--<div class="add-pic-zone add-pic-zone-default">点击添加</div>-->
                            <!--</div>-->
                            <!--<button class="layui-btn layui-btn-primary layui-btn-primary-red del">删除</button>-->
                        <!--</div>-->
                        <div class="layui-input-block">
                            <div class="layui-btn-group">
                                <button class="layui-btn">添加子标题</button>
                                <button class="layui-btn">添加文案</button>
                                <!--<button class="layui-btn">添加视频</button>-->
                                <button class="layui-btn">添加图片</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="reason">立即提交</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>