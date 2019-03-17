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
        .bottom {
            padding: 20px;
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
        .add-pic-zone.square {
            width: 108px;
            height: 108px;
        }
        #live-date, #live-hour {
            display: inline-block;
            width: auto;
            margin-right: 10px;
        }
        #live-time-choose {
            width: auto;
        }
    </style>
    <script>
      var arrayHTML = []
      var laytpl = null

        var route_str = 'sciencePractice_addLiveHerald'
        layui.sessionData('zkyykt_admin_jump_page', {
            key:'left_nav'
            ,value:route_str
        });

        $(function(){
          layui.use(['element', 'table', 'form', 'upload', 'layer', 'laytpl','laydate'], function () {
            var element = layui.element;
            var form = layui.form;
            var layer = window.parent.parent.layer;
            var upload = layui.upload;
            var laydate = layui.laydate;
            laytpl = layui.laytpl

            //日期时间范围
            lay('.live-time')
            // 日期选择
              .each(function () {
                laydate.render({
                  elem: '#live-date',
                  type: 'date',
                  range: '~',
                  format: 'M月d日',
                  min: 0,
                  max: 180,
                  theme: '#33a333',
                  done: function () {
                    var hour = document.getElementById('live-hour')
                    hour.focus()
                  }
                });
              })
              // 时间选择
              .each(function () {
                laydate.render({
                  elem: '#live-hour',
                  type: 'time',
                  range: '~',
                  format: 'HH点mm分',
                  theme: '#33a333',
                });
              })

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

                        // getDataFunc(element, form, layer, upload)
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });

              // 提交表单
              form.on('submit(reason)', function (data) {
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
                    title: o.core_title,
                    address: o.core_address,
                    img: o.core_upload_image_url,
                    begin_date: o.core_day + ' ' + o.core_hour,
                    url: o.core_url,
                    videoType: o.core_videoType,
                    teacher: o.core_teacher,
                    classPassword: o.core_classPassword,
                    // type: o.core_type,
                    // intro: o.core_intro,
                    // video: o.core_upload_video_url,
                  },
                  videoIntros: arrayHTML
                }
                console.log("obj", obj)
                // return
                if('${video}'){
                  console.log("===EDIT=SUBMIT==")
                  obj.video.id = '${video.id}'
                  $.ajax({
                    url: '${ctx}/backActivity/update',
                    type: 'post',
                    data: JSON.stringify(obj),
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (data) {
                      console.log(data)
                      if (data.r == 1) {
                        alert("修改成功")
                        window.location.href = '${ctx}/backMenu/scienceLive'
                      }
                    },
                    error: function (err) {
                      console.log(err);
                    }
                  });
                } else {
                  console.log("===ADD=SUBMIT==")
                  $.ajax({
                    url: '${ctx}/backActivity/add',
                    type: 'post',
                    data: JSON.stringify(obj),
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (data) {
                      console.log(data)
                      if (data.r == 1) {
                        alert("添加成功")
                        window.location.href = '${ctx}/backMenu/scienceLive'
                      }
                    },
                    error: function (err) {
                      console.log(err);
                    }
                  });
                }
              });

            // 添加图片
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

            });

            setContentPageHeight()

        })

        // 表格下半部分添加内容（视频简介/正文）
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
<body>
<div id="content">
    <div class="head">
        <div class="title">
            <a href="${ctx}/backMenu/scienceLive" target="contextRightIframe">
                <img src="${ctx}/static/images/back.png" alt="">
            </a>
            添加预告
        </div>
        <form>
            <div class="core">
                <div class="layui-form">
                    <div class="module-1">
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
                        <div class="layui-form-item">
                            <label class="layui-form-label">标题<span style="color: red">*</span></label>
                            <div class="layui-input-block">
                                <input type="text" name="core_title" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">主讲人<span style="color: red">*</span></label>
                            <div class="layui-input-block">
                                <input type="text" name="core_teacher" required  lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">地址</label>
                            <div class="layui-input-block">
                                <input type="text" name="core_address" required  lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item live-time">
                            <label class="layui-form-label">直播时间<span style="color: red">*</span></label>
                            <div class="layui-inline">
                                <div class="layui-input-inline" id="live-time-choose">
                                    <input name="core_day" type="text" class="layui-input" required id="live-date" placeholder=" - ">
                                    <input name="core_hour" type="text" class="layui-input" required id="live-hour" placeholder=" - ">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">直播课堂地址</label>
                            <div class="layui-input-block">
                                <input type="text" name="core_url" placeholder="不超过16字" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">课堂口令</label>
                            <div class="layui-input-block">
                                <input type="text" name="core_classPassword" autocomplete="off" class="layui-input">
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
                    </div>
                    <div class="gap"></div>
                    <div class="bottom">
                        <div class="layui-form-item">
                            <label class="layui-form-label">视频简介<span style="color: red">*</span></label>

                            <div id="intro_block"></div>

                            <div class="layui-input-block">
                                <div class="layui-btn-group">
                                    <button class="layui-btn" onclick="addHTMLFunc(1)">添加子标题</button>
                                    <button class="layui-btn" onclick="addHTMLFunc(2)">添加文案</button>
                                    <button class="layui-btn" onclick="addHTMLFunc(3)">添加图片</button>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <input type="submit" class="layui-btn" lay-submit lay-filter="reason" value="立即提交">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</div>
</body>
</html>
