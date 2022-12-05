<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/25
  Time: 22:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人资料</title>
</head>
<style>
    body{
        background-color: #1f2126;
    }

    p{
        color: aliceblue;
    }
</style>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>
<div style="position: absolute;left: 20%;top: 150px">
    <div>
        <img width="200px" height="200px" src="${sessionScope.loginUser.userData.avatarPath}">
        <form action="/user/uploadAvatar" method="post" enctype="multipart/form-data">
            <input type="file" name="avatar" value="上传头像">
            <input type="submit" value="更新头像">
        </form>
    </div>

    <div>
        <p>用户名：${sessionScope.loginUser.UName}</p>
        <p>邮箱：${sessionScope.loginUser.UEmail}</p>
        <p>国家：${sessionScope.loginUser.UCountry}</p>
        <p>创建账户时间：${sessionScope.loginUser.UCreatTime}</p>
    </div>
</div>


</body>
</html>
