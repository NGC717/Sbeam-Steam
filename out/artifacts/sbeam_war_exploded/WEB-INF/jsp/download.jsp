<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/9
  Time: 9:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table>
    <tr>
        <th>编号</th>
        <th>游戏名称</th>
        <th>上传时间</th>
        <th>操作</th>
    </tr>

    <c:forEach items="${games}" var="game">
        <tr>
            <td>${game.id}</td>
            <td>${game.name}</td>
            <td>${game.uploadTime}</td>
            <td><button><a href="/user/doDownload/${game.id}">下载</a></button></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
