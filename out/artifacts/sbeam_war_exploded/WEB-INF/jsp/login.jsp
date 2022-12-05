<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/9
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录sbeam</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/user/login.css">
</head>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>
<c:if test="${isLogFlag != null}">
    <h4 style="color: red;text-align: center">请先登录Sbeam账户</h4>
</c:if>

<c:if test="${isLoginSuccess != null}">
    <h4 style="color: red">未找到该用户或密码错误，请重新登录</h4>
</c:if>

<div style="position: absolute;left: 30%;top: 30%">
    <form action="${pageContext.request.contextPath}/user/doLogin" method="post">
        <label for="username" style="color: aliceblue;font-size: 30px">账户名称</label>
        <br>
            <input type="text" name="name" id="username" style="width: 300px;height: 30px;background-color: #32353c;border: none;color: aliceblue">
        <br>
        <div style="margin-top: 10px"></div>
        <label for="password" style="color: aliceblue;font-size: 30px">密码</label><br>
            <input type="password" name="password" id="password" style="width: 300px;height: 30px;background-color: #32353c;border: none;color: aliceblue">
        <br>

        <input type="submit" value="登录" style="background-color: #3897eb;border: none;width: 100px;height: 30px;color: aliceblue;margin-left: 100px;margin-top: 20px">
        <br>

    </form>
    <a href="/user/registerEmail">没有账户？去注册-></a>
</div>

</body>
</html>
