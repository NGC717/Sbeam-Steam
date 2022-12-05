<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/26
  Time: 23:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的库存</title>
</head>
<style>
  body{
    margin: 0 0;
    padding: 0;
    background-color: #1f2126;
  }

  td{
    color: aliceblue;
  }

  th{
    color: aliceblue;
  }
</style>
<body>
<div>
  <jsp:include page="indextitle.jsp"></jsp:include>
</div>

<div>
  <table border="1px">
    <tr>
      <th>游戏名</th>
      <th>操作</th>
    </tr>
    <c:forEach items="${games}" var="game">
      <tr>
        <td>${game.GName}</td>
        <td>
          <a href="/game/doDownload/${game.GId}">下载</a>
          <a href="/user/comment/${game.GId}">发表评论</a>
        </td>
      </tr>
    </c:forEach>
    <tr></tr>
  </table>
</div>
<div></div>

</body>
</html>
