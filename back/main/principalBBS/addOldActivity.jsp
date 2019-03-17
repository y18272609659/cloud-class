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
        
        .add-pic-zone img {
            width: 100%;
            height: 100%;
        }
        .upload-button {
            position: absolute;
            left: 200px;
            bottom: 0;
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
            position:relative;
        }
        .layui-input-inlineblock{
            display: inline-block;
        }
        .main_text_input{
	        display:inline-block;
	        width: 70%;
        }
        .show-pic-box{
        	display:none;
        }
        .add-pic-btn{
        	display:inline-block;
        }
        .elem-move-btn{
        	position:absolute;
        	display:inline-block;
        	right:100px;
        	top:41%;
        }
        .showInlineBlock{
        	display:inline-block;
        }
        .replace-video-btn{
        	left:350px;
        }
        .div-inline-block{
        	display:inline-block;
        }
        .select-box{
        	width:50%;
        	margin-left:0;
        }
        .select-result-box{
        	display:none;
        	margin-top:20px;
        }
    </style>
    <script>
    	var arrayHTML = []
	    var table = null
	    var layer = null
	    var laytpl = null
    	var sort = 0
        var route_str = 'principalBBS_addOldActivity'
        layui.sessionData('zkyykt_admin_jump_page', {
            key:'left_nav'
            ,value:route_str
        });

        $(function(){
            layui.use(['element', 'table', 'form','laytpl','layer','upload'], function(){
                var element = layui.element;
                var form = layui.form;
                var upload = layui.upload;
                table = layui.table;
                layer = layui.layer;
                laytpl = layui.laytpl
                
                window.picupload = function(id, pic, showpic) {
                	//console.log('picupload');
                	upload.render({
                    	index: 0,
                        elem: id,
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
                                $(pic).val(res.file);
                                $(id).attr("class", "upload-button layui-btn").html("替换")
                                document.getElementById(showpic).innerHTML = '<img src="${ctx}/' + res.file + '"/>'
                                $("#"+showpic).addClass("showInlineBlock")
                            }
                        },
                        error: function (err) {
                            //请求异常回调
                            console.log(err)
                        }
                    });
                }
                
                window.videoUpload = function(id, video, showVideo){
                	upload.render({
                        index: 0,
                        elem: id,
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
                                $(video).val(res.file);
                                $(id).attr("class", "upload-button layui-btn video replace-video-btn").html("替换")
                                document.getElementById(showVideo).innerHTML = '<video src="${ctx}/' + res.file + '" controls></video>'
                                $("#"+showVideo).addClass("showInlineBlock")
                                $("#uploadLoadingDiv").hide()
                                setContentPageHeight()
                            }
                        },
                        error: function (err) {
                            //请求异常回调
                            console.log(err)
                        }
                    });
                }
                
                picupload('#upload_image_button','#upload_image_url','upload_image')          
                
                getDataFunc(element, form, upload)
                // tpl
                initTpl()

                setContentPageHeight()
                // 选择添加本地视频或外链视频
                form.on('select(add_choice)', function (data) {
                	var index = $(data.elem.outerHTML).attr('d_index')
                    $("#select_video_block_"+index).hide()
                    var v = data.value
                    if (v === '1') {
                        $("#video_source_block_"+index).hide()
                        $("#video_local_block_"+index).show()
                    } else if (v === '2') {
                        $("#video_local_block_"+index).hide()
                        $("#video_source_block_"+index).show()
                    }
                	setContentPageHeight()
                    
                });
                // submit
                form.on('submit(next)', function (data) {
                	getArrayHTML()
                    
                    console.log(data.field);
                    var o = data.field
                    var obj = {
                    	principal: {
                            title: o.core_title,
                            address: o.core_address,
                            img: o.core_upload_image_url
                        },
                        principalIntros:arrayHTML
                    }
                    // console.log("obj", obj)
                    if('${principal}') {
                        console.log("===EDIT===")
                        obj.principal.id = '${principal.id}'
                        console.log("obj", obj)
                        $.ajax({
                            url: '${ctx}/backPrincipalForum//update',
                            type: 'post',
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (data) {
                                console.log(data)
                                if (data.r == 1) {
                                    alert("修改成功")
                                    window.location.href = '${ctx}/backMenu/principalBBS'
                                }else if(data.r == 0){
                                	layer.msg(data.msg)
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
                            url: '${ctx}/backPrincipalForum/add',
                            type: 'post',
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (data) {
                                console.log(data)
                                if (data.r == 1) {
                                    alert("添加成功")
                                    window.location.href = '${ctx}/backMenu/principalBBS'
                                }
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                    }
                });
                
                $(document).on('click','.btn-up',function(e){
                	var parentObj = $(e.target.parentNode).parents('.html-module');
                	var index = $(e.target).attr('d_index');
                	//console.log($(e.target.parentNode).parents('.html-module'));
                	//console.log($(e.target).attr('d_index'));
                	if(index > 0)
                		changeData(index,1)
                })
                $(document).on('click','.btn-down',function(e){
                	var parentObj = $(e.target.parentNode).parents('.html-module');
                	var index = $(e.target).attr('d_index');
                	//console.log($(e.target.parentNode).parents('.html-module'));
                	//console.log($(e.target).attr('d_index'));
                	if(index < arrayHTML.length-1)
                		changeData(index,2)
                })
                $(document).on('click','.btn-del',function(e){
                	var parentObj = $(e.target.parentNode).parents('.html-module');
                	var index = $(e.target).attr('d_index');
                	//console.log($(e.target.parentNode).parents('.html-module'));
                	//console.log($(e.target).attr('d_index'));
                	changeData(index,3)
                })
                
            });
            
        })
        
		function addHTMLFunc(type){
            console.log("addHTMLFunc")
            var index = arrayHTML.length
            arrayHTML.push({
                type:type,
                content:'',
                intro:''
            })
            var data = [{
            	type:type,
            	content:'',
                intro:'',
                index:index
            }]
            initTpl(data)
        }
        function getDataFunc(element, form, upload){
            if('${principal}'){
                console.log("===EDIT===")
                var data = '${principal}'
                document.getElementById('title').innerHTML = '编辑历史记录'
                form.val("aaa", {
                    "core_title": '${principal.title}',
                    "core_address": '${principal.address}',
                    "core_upload_image_url": '${subject.img}',
                });
                $("#upload_image_button").attr("class", "upload-button layui-btn").html("替换")
                document.getElementById('upload_image').innerHTML = '<img src="${ctx}/' + '${video.img}' + '"/>'
                $('#upload_image_url').val('${video.img}');
                console.log(data)
                var id = '${principal.id}'
                getDataFunc2(id)
            } else {
                console.log("===ADD===")
            }
        }
        
        function getDataFunc2(id){
            $.ajax({
                url: '${ctx}/backPrincipalForum/get?id=' + id,
                type: 'get',
                dataType: 'json',
                success: function (data) {
                    console.log("success get video", data)
                    if (data.r == 1) {
                    	console.log(data);
                        arrayHTML = data.intro
                        changeData(0,0)
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
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
            layui.use('form', function(){  //此段代码必不可少,新加载渲染select
    		    var form = layui.form;
    		    form.render();
    		});

        };
        
        
		
        function initTpl(data){
            console.log("initTpl")
            var data = data
            var getTpl = tpl_templet.innerHTML
                ,view = $('#intro_block');
            // console.log(getTpl)
            // console.log(view)

            laytpl(getTpl).render(data, function(html){
                view.append(html)
                setContentPageHeight()
            });
            if(data != undefined){
            	if(data['0'].type == "3"){
            		videoUpload("#upload_video_button_" + data['0'].index + "", "#upload_video_url_" + data['0'].index + "","upload_video_"+ data['0'].index +"")
                }else if(data['0'].type == "4"){
                	picupload("#upload_image_button_" + data['0'].index + "", "#upload_image_url_" + data['0'].index + "","upload_image_"+ data['0'].index +"")
                }
            }
            
        }
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
        };
        
        function getArrayHTML(){
        	layui.each($('#intro_block').children(".html-module"),function(index, item){
                // console.log($(item).children(".content")[0].value)
                if (arrayHTML[index].type === 1 || arrayHTML[index].type === 2) {
                    arrayHTML[index].content = $(item).children(".content")[0].value
                }
                if (arrayHTML[index].type === 3 || arrayHTML[index].type === 4) {
                    arrayHTML[index].content = $(item).children(".content")[0].value
                    if(arrayHTML[index].type === 3){
                    	var videoType = $(item).find('select')[0].value
                    	arrayHTML[index].intro = videoType
                    	if(videoType === '2')
                    		arrayHTML[index].content = $(item).find(".upload_video_url")[0].value
                    }
                }
            })
        }
        //isUp 1 up 2 down 3 del
        function changeData(index,isUp){
        	getArrayHTML()
        	if(isUp === 1){       		
        		arrayHTML = swapArray(arrayHTML,index,parseInt(index)-1)
        	}else if(isUp === 2){
        		arrayHTML = swapArray(arrayHTML,index,parseInt(index)+1)
        	}else if(isUp === 3)
        		arrayHTML.splice(index,1)
        	var data = addArrayKey(arrayHTML)
        	redrawText(data)
        }
        function addArrayKey(arr){
        	var data = []
        	layui.each(arrayHTML,function(index,item){
        		var tamp = {
       				type:item.type,
                    content:item.content,
                    intro:item.intro,
                    index:index	
        		}
        		data.push(tamp)
        	})
        	return data;
        }
        function swapArray(arr, index1, index2) {
       	   arr[index1] = arr.splice(index2, 1, arr[index1])[0];
       	   return arr;
       	}
        
        function redrawText(data){
        	var data = data
            var getTpl = tpl_templet.innerHTML
                ,view = $('#intro_block');
			view.empty();
            laytpl(getTpl).render(data, function(html){
                view.append(html)
                setContentPageHeight()
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
				<div class="layui-input-block html-module layui-row">
					
					<input type="text" placeholder="不超过16字" autocomplete="off"" value = "{{ item.content }}"
                           class="layui-input content main_text_input">
					<div class="elem-move-btn" >
						<button class="layui-btn layui-btn-xs btn-up" d_index="{{ item.index }}">上移</button>
						<button class="layui-btn layui-btn-xs btn-del" d_index="{{ item.index }}">删除</button>
						<button class="layui-btn layui-btn-xs btn-down" d_index="{{ item.index }}">下移</button>
					</div>
                </div>   
            {{# } }}
            {{# if(item.type === 2){ }}
                <div class="layui-input-block html-module">
                    <textarea placeholder="不超过400字"  value = "{{ item.content }}" class="layui-textarea content main_text_input"></textarea>
					<div class="elem-move-btn" d_index="{{ item.index }}">
						<button class="layui-btn layui-btn-xs btn-up" d_index="{{ item.index }}">上移</button>
						<button class="layui-btn layui-btn-xs btn-del" d_index="{{ item.index }}">删除</button>
						<button class="layui-btn layui-btn-xs btn-down" d_index="{{ item.index }}">下移</button>
					</div>
                </div>
            {{# } }}
			{{# if(item.type === 3){ }}
                <div class="layui-form-item layui-input-block html-module">
                    <input type="hidden" id="upload_video_url_{{ item.index }}"  class="content"  value = "{{ item.content }}">
					{{# if(item.content === '' ){ }}
						<div class="layui-input-block select-box" id="select_video_block_{{ item.index }}">
                            <select  required="required" name="core_type" d_index="{{ item.index }}" lay-filter="add_choice">
								<option value="0">请选择</option>
                            	<option value="1">添加本地视频</option>
                            	<option value="2">添加外部链接</option>
                        	</select>
                        </div>
						
						
                    	<div class="div-inline-block select-result-box" id="video_local_block_{{ item.index }}">
                        	<div class="add-pic-zone add-pic-zone-default add-pic-btn" id="upload_video_button_{{ item.index }}">点击添加视频</div>
							<div class="add-pic-zone show-pic-box" id="upload_video_{{ item.index }}"></div>
                    	</div>

                    	<div id="video_source_block_{{ item.index }}" class="select-result-box">
                        	<input  required="required" id="upload_video_url_outside_{{ item.index }}"  type="text" placeholder="请输入外部连接" autocomplete="off"
                               	class="layui-input main_text_input upload_video_url">
                    	</div>

						
				   {{# }else{ }}
						{{# if(item.intro === '1'){ }}
							<div style="display: none;" class="layui-input-block select-box" id="select_video_block_{{ item.index }}">
                            	<select value="1" required="required" name="core_type" d_index="{{ item.index }}" lay-filter="add_choice">
									<option value="0">请选择</option>
                            		<option value="1"selected = "selected">添加本地视频</option>
                            		<option value="2">添加外部链接</option>
                        		</select>
                        	</div>
							<div class="upload-button layui-btn video replace-video-btn" id="upload_video_button_{{ item.index }}">替换</div>
							<div class="add-pic-zone show-pic-box showInlineBlock" id="upload_video_{{ item.index }}">
								<video src="${ctx}/{{ item.content }}" controls></video>
							</div>
						{{# }else{ }}
							<div style="display: none;" class="layui-input-block select-box" id="select_video_block_{{ item.index }}">
                            	<select value="2" required="required" name="core_type" d_index="{{ item.index }}" lay-filter="add_choice">
									<option value="0">请选择</option>
                            		<option value="1">添加本地视频</option>
                            		<option value="2" selected = "selected">添加外部链接</option>
                        		</select>
                        	</div>
							<div id="video_source_block_{{ item.index }}">
                        		<input value="{{ item.content }}"  required="required" id="upload_video_url_outside_{{ item.index }}"  type="text" placeholder="请输入外部连接" autocomplete="off"
                               		class="layui-input main_text_input upload_video_url">
                    		</div>
						{{# } }}
						
					{{# } }}
					
					<div class="elem-move-btn" d_index="{{ item.index }}">
						<button class="layui-btn layui-btn-xs btn-up" d_index="{{ item.index }}">上移</button>
						<button class="layui-btn layui-btn-xs btn-del" d_index="{{ item.index }}">删除</button>
						<button class="layui-btn layui-btn-xs btn-down" d_index="{{ item.index }}">下移</button>
					</div>
					
                </div>		
            {{# } }}
			{{# if(item.type === 4){ }}
                <div class="layui-input-block html-module">
                    <input type="hidden" id="upload_image_url_{{ item.index }}"  class="content"  value = "{{ item.content }}">
					{{# if(item.content === '' ){ }}
						<div class="add-pic-zone add-pic-zone-default add-pic-btn" id="upload_image_button_{{ item.index }}">点击添加图片</div>
						<div class="add-pic-zone show-pic-box" id="upload_image_{{ item.index }}"></div>
					{{# }else{ }}
						<div class="upload-button layui-btn" id="upload_image_button_{{ item.index }}">替换</div>
						<div class="add-pic-zone show-pic-box showInlineBlock" id="upload_image_{{ item.index }}">
							<img src="${ctx}/{{ item.content }}"/>
						</div>
					{{# } }}
					
					<div class="elem-move-btn" d_index="{{ item.index }}">
						<button class="layui-btn layui-btn-xs btn-up" d_index="{{ item.index }}">上移</button>
						<button class="layui-btn layui-btn-xs btn-del" d_index="{{ item.index }}">删除</button>
						<button class="layui-btn layui-btn-xs btn-down" d_index="{{ item.index }}">下移</button>
					</div>
					
                </div>
            {{# } }}
        {{#  }); }}

    </script>
</head>
<body onload="setContentPageHeight()">
<div id="content">
    <div class="head">
        <div class="title">
            <a href="${ctx}/backMenu/scienceVideo" target="contextRightIframe">
                <img src="${ctx}/static/images/back.png" alt="">
            </a>
            <span id="title">添加历史活动</span>
        </div>
        <div class="core">
            <div class="layui-form" lay-filter="aaa">
                <div class="module-1">
                    <div class="layui-form-item">
                        <label class="layui-form-label">标题<span style="color: red">*</span></label>
                        <div class="layui-input-block">
                            <input type="text" name="core_title" required  lay-verify="required" placeholder="不超过16字" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">地址</label>
                        <div class="layui-input-block">
                            <input type="text" name="core_address" required  lay-verify="required"  autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">封面图<span style="color: red">*</span></label>
                        <input type="hidden" id="upload_image_url" name="core_upload_image_url" name="core_upload_image_url">
                        <div class="layui-input-block">                     	
                            <!--<input type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">-->
                            <div class="add-pic-zone add-pic-zone-default" id="upload_image_button">点击添加</div>
                            <div class="add-pic-zone" id="upload_image">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="gap"></div>
                <div class="module-1">
                    <div class="layui-form-item" style="padding-top: 20px">
                        <label class="layui-form-label">正文<span style="color: red">*</span></label>
                    </div>
                    <div id="intro_block">
                        <!-- 
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
                        <div class="layui-input-block html-module">
                            <div class="layui-input-inlineblock">
                                <div class="add-pic-zone add-pic-zone-default">点击添加</div>
                            </div>
                            <button class="layui-btn layui-btn-primary layui-btn-primary-red del">删除</button>
                        </div>
                         -->
                     </div>
                       
                       
                <div class="layui-form-item" id="uploadLoadingDiv" style="display:none">

                    <label class="layui-form-label">进度条</label>
                    <div class="layui-input-block" style="padding-top: 15px">
                        <div class="layui-progress" lay-showpercent="true" lay-filter="demo">
                            <div class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>
                        </div>
                    </div>
                </div>      
                <div class="layui-form-item">
                	<div class="layui-input-block">
                         <div class="layui-btn-group">
                             <button class="layui-btn" onclick="addHTMLFunc(1)">添加子标题</button>
                             <button class="layui-btn" onclick="addHTMLFunc(2)">添加文案</button>
                             <button class="layui-btn" onclick="addHTMLFunc(3)">添加视频</button>
                             <button class="layui-btn" onclick="addHTMLFunc(4)">添加图片</button>
                         </div>
                     </div>
                </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                    	<input type="submit" class="layui-btn" lay-submit lay-filter="next" value="立即提交"></input>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>