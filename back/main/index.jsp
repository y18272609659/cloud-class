<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>示范基地网站系统管理后台</title>
    <meta charset="UTF-8">
    <jsp:include page="../../include.jsp"/>
    <script>
        var pageJumpStatus = true
        var route_obj = {
            video:'scienceVideo+1',
            kids:'selfKids+2',
            science_class:'sciencePractice+3',
            scientists_school:'scientistIntoSchool+4',
            science_camp:'scienceCamp+5',
            principal_bbs:'principalBBS+6',
            activity_apply:'activityOrderApply+7',
            home_recommend:'homeRecommend+8',
            data_statistics:'scienceVideo+9',
            school:'dataStatistics+10',
            admin:'adminAccounts+11',
            teacher:'teacher+12'
        }
        $(function(){

            // 1 getNav 2 sess 3 layui.init 4 calcGap
            // getNav()

            // 临时的
            layui.use('element', function(){
                var element = layui.element;
            });

        })

        function setContentPageHeight() {
            var b_iframe = window.parent.document.getElementById("contextIframe");
            var height = document.getElementById("content").offsetHeight;
            b_iframe.height = height + 500      ;

            console.log("setContentPageHeight")
        }

        function sess(d){
            if (!layui.sessionData('zkyykt_admin_jump_page').left_nav) {

            } else {
                var page = layui.sessionData('zkyykt_admin_jump_page').left_nav.split('_')
                <%--$("#contextRightIframe").attr("src","${ctx}/" + page[0] + "/" + page[1] + "")--%>
                <%--if (page[2] && page[2] === "params") {--%>
                <%--document.getElementById('contextRightIframe').contentWindow.location.href = '${ctx}/' + page[0] + '/' + page[1] + '?' + page[3] + '=' + page[4];--%>
                <%--} else {--%>
                document.getElementById('contextRightIframe').contentWindow.location.href = '${ctx}/' + page[0] + '/' + page[1].split('+')[0];
                // }

                <%--document.getElementById('adminAccounts+11').getElementsByTagName('a')[0].href = "${ctx}/backMenu/adminAccounts"--%>
            }


            layui.use('element', function(){
                var element = layui.element;
                console.log("layui")

                // setContentPageHeight()

                if (!layui.sessionData('zkyykt_admin_jump_page').left_nav) {
                    $("#tree").find("li").eq(0).addClass('layui-this')
                } else {
                    var page = layui.sessionData('zkyykt_admin_jump_page').left_nav.split('_')
                    console.log(document.getElementById(page[1]))
                    document.getElementById(page[1]).className = "layui-nav-item layui-this"
                }

                element.render()


                calcGap(d, element)
                // console.log(calcGap)

                // setContentPageHeight()

                // var inter = setInterval(function(){
                //     setContentPageHeight()
                // },1000)
                // setTimeout(function(){
                //     clearInterval(inter)
                // },10000)
            });
        }

        function getNav(){

            $.ajax({
                url: '${ctx}/backLogin/backMenu',
                type: 'get',
                dataType: 'json',
                success: function (data) {

                    var str = '<ul class="layui-nav layui-nav-tree layui-white" lay-filter="">'

                    // console.log(data.data)
                    var d = data.data
                    layui.each(d, function(index, item){
                        str += ('<li class="layui-nav-item" id="' + route_obj[item.name] + '">\n' +
                                '<a href="${ctx}/' + item.url + '" target="contextRightIframe">' + item.title + '</a>\n' +
                                '</li>\n');
                    })
                    str += '</ul>'

                    document.getElementById('tree').innerHTML = str

                    sess(d)
                },
                error: function (err) {

                }
            });

        }

        function calcGap(arr){
            // arr 原数组（无空位）
            // t_arr 新数组（有空位，按照id排序，没有权限的字段为undefined）
            // index_arr 数组（需要插入gap的位置）

            // console.log("calcGap", arr)

            var index_arr = [0, 6, 7, 9, 11]
            var t_arr = []
            for (var i = 0; i < arr.length; i++) {
                t_arr[arr[i].id] = arr[i]
                t_arr[arr[i].id].index = i
            }
            // var s_arr = t_arr.concat()
            // removeEmptyArrayEle(s_arr, map)
            // console.log("t", t_arr)
            for (var a = index_arr[1]; a > index_arr[0]; a--) {
                if (t_arr[a] === undefined) {
                    continue
                } else {
                    $("#tree").find("li").eq(t_arr[a].index).after('<div style="height:10px"></div>')
                    if (pageJumpStatus) {
                        pageJump()
                    }
                    break
                }
            }
            for (var a = index_arr[2]; a > index_arr[1]; a--) {
                if (t_arr[a] === undefined) {
                    continue
                } else {
                    $("#tree").find("li").eq(t_arr[a].index).after('<div style="height:10px"></div>')
                    if (pageJumpStatus) {
                        pageJump()
                    }
                    break
                }
            }
            for (var a = index_arr[3]; a > index_arr[2]; a--) {
                if (t_arr[a] === undefined) {
                    continue
                } else {
                    $("#tree").find("li").eq(t_arr[a].index).after('<div style="height:10px"></div>')
                    if (pageJumpStatus) {
                        pageJump()
                    }
                    break
                }
            }
            for (var a = index_arr[4]; a > index_arr[3]; a--) {
                if (t_arr[a] === undefined) {
                    continue
                } else {
                    $("#tree").find("li").eq(t_arr[a].index).after('<div style="height:10px"></div>')
                    if (pageJumpStatus) {
                        pageJump()
                    }
                    break
                }
            }

            setContentPageHeight()
        }

        function removeEmptyArrayEle(arr){
            for(var i = 0; i < arr.length; i++) {
                if(arr[i] == undefined) {
                    arr.splice(i,1);
                    i = i - 1;
                }
            }
            return arr;
        }

        function pageJump(){
            if (!layui.sessionData('zkyykt_admin_jump_page').left_nav) {
                $("#tree").find("li").eq(0).find('a')[0].click()
                <%--document.getElementById('contextRightIframe').contentWindow.location.href = '${ctx}/backMenu/scienceVideo'--%>
            } else {
                var page = layui.sessionData('zkyykt_admin_jump_page').left_nav.split('_')
                document.getElementById('contextRightIframe').contentWindow.location.href = '${ctx}/' + page[0] + '/' + page[1].split('+')[0]
            }
            pageJumpStatus = false
        }
    </script>
    <style type="text/css">
        body {
            background-color: rgba(228, 228, 228, 1);
        }
        body,h1,h2,h3,h4,h5,h6,p{
            margin:0;
        }

        .content {
            height:700px;
        }

        .split_li {
            height: 10px;
            background-color: rgba(228, 228, 228, 1);
        }

        .layui-nav-tree .layui-nav-item a {
            position: relative;
            height: 60px;
            line-height: 60px;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            font-weight: 700;
            font-style: normal;
            font-size: 16px;
            color: #666666;
            text-align: left;
            background-color: white;
        }

        .layui-nav-tree .layui-nav-item a:hover {
            background-color: white;
            color: rgba(4, 183, 94, 1);
            text-decoration: none;
        }

        .layui-nav-tree .layui-nav-bar {
            background-color: rgba(4, 183, 94, 1);
        }

        .layui-nav .layui-nav-item a:hover, .layui-nav .layui-this a {
            color: rgba(4, 183, 94, 1);
            background-color: white;
        }

        .layui-white{
            background: transparent;
        }

        a:link {
            text-decoration: none;
        }

        a:visited {
            text-decoration: none;
        }

        a:hover {
            text-decoration: none;
        }

        a:active {
            text-decoration: none;;
        }

        .left_menu {
            display: inline-block;
        }
    </style>
</head>
<body>
<div id="content">
    <div class="layui-row">
        <div class="layui-col-md2">
            <div class="left_menu" id="tree">

                <ul class="layui-nav layui-nav-tree" lay-filter="">

                    <li class="layui-nav-item layui-this" id="scienceVideo+1">
                        <a href="${ctx}/backMenu/scienceVideo" target="contextRightIframe">科学视频</a>
                    </li>
                    <%--<li class="layui-nav-item" id="selfKids+2">--%>
                        <%--<a href="selfKids/index.html" target="contextRightIframe">SELF · Kids</a>--%>
                    <%--</li>--%>
                    <li class="layui-nav-item" id="scienceLive+2">
                        <a href="${ctx}/backMenu/scienceLive" target="contextRightIframe">科学直播课</a>
                    </li>
                    <%--<li class="layui-nav-item" id="scientistIntoSchool+4">--%>
                        <%--<a href="scientistIntoSchool/index.html" target="contextRightIframe">科学家进校园</a>--%>
                    <%--</li>--%>
                    <%--<li class="layui-nav-item" id="scienceCamp+5">--%>
                        <%--<a href="scienceCamp/index.html" target="contextRightIframe">求真科学营</a>--%>
                    <%--</li>--%>
                    <li class="layui-nav-item" id="sciencePractice+3">
                        <a href="${ctx}/backMenu/sciencePractice" target="contextRightIframe">科学实践课</a>
                    </li>
                    <li class="layui-nav-item" id="principalBBS+6">
                        <a href="${ctx}/backMenu/principalBBS" target="contextRightIframe">校长论坛</a>
                    </li>
                    <li class="split_li"></li>
                    <li class="layui-nav-item" id="activityOrderApply+7">
                        <a href="${ctx}/backMenu/activityOrderApply" target="contextRightIframe">预约报名管理</a>
                    </li>

                    <li class="layui-nav-item" id="homeRecommend+8">
                        <a href="${ctx}/backMenu/homeRecommend" target="contextRightIframe">首页推荐</a>
                    </li>
                    <li class="layui-nav-item" id="dataStatistics+9">
                        <a href="${ctx}/backMenu/dataStatistics" target="contextRightIframe">数据统计</a>
                    </li>

                    <li class="split_li"></li>
                    <li class="layui-nav-item" id="schoolAccounts+10">
                        <a href="${ctx}/backMenu/schoolAccounts" target="contextRightIframe">学校账户</a>
                    </li>
                    <li class="layui-nav-item" id="adminAccounts+11">
                        <a href="${ctx}/backMenu/adminAccounts" target="contextRightIframe">管理员账户</a>
                    </li>
                    <li class="layui-nav-item" id="teacher+12">
                        <a href="${ctx}/backMenu/teacher" target="contextRightIframe">主讲老师</a>
                    </li>
                    <li class="split_li"></li>
                </ul>

            </div>
        </div>
        <div class="layui-col-md10">
            <div id="iframe_div" style="padding-left: 20px;">
                <iframe id="contextRightIframe" name="contextRightIframe" width="980" height="800" scrolling="no" frameborder="0"
                        src="${ctx}/backMenu/scienceVideo"></iframe>

            </div>
        </div>
    </div>
</div>



</body>
</html>
