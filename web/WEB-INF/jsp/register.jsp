<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/9
  Time: 13:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册账户</title>
    <link rel="stylesheet" href="/static/css/user/register.css">
</head>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>
<div id="register_div">
    <p id="title">创建您的账户</p>
    <c:if test="${isRegistered != null}">
        <p style="color: red">当前名称已存在</p>
    </c:if>
    <form id="form" action="/user/doRegister?uEmail=${insertUser.UEmail}&uCountry=${insertUser.UCountry}" method="post">
        <p style="color: aliceblue">Sbeam账户名称</p>
        <input id="name" type="text" name="uName" >
        <p style="color: aliceblue">选择密码</p>
        <input id="pw1" type="password" >
        <p style="color: aliceblue">确认密码</p>
        <input id="pw2" type="password" name="uPassword" ><br>
        <h1></h1>
    </form>

    <button id="finish">注册</button>

</div>
</body>
<script src="${pageContext.request.contextPath}/static/js/register.js"></script>
</html>
