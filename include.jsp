<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>


<link rel="stylesheet" href="${ctx}/static/layui/css/layui.css">
<%-- font --%>
<link rel="stylesheet" href="${ctx}/static/font-awesome/4.7.0/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<%--[if lt IE 9]--%>
<script src="${ctx}/static/html5/html5.min.js"></script>
<script src="${ctx}/static/html5/respond.min.js"></script>
<%--[endif]--%>

<%--<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU="--%>
        <%--crossorigin="anonymous"></script>--%>
<script src="${ctx}/static/jquery/jquery-1.12.4.min.js"></script>
<script src="${ctx}/static/layui/layui.js"></script>
<script src="${ctx}/static/js/front/Browser.js"></script>
<%-- font --%>
<%--<script src="${ctx}/static/js/front/Browser_run.js"></script>--%>