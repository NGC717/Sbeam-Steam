<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/12
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>休闲小游戏</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">

</head>
<style>
    body{
        margin: 0 0;
        padding: 0;
        background-color: #1f2126;
    }
</style>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>

<div style="float:left;margin-left: 400px;margin-top: 100px">
    <div>
        <img src="/static/img/game/snake.png" width="300px" height="300px">
    </div>
    <div style="margin-left:100px">
        <h1><a class="btn btn-warning" href="/game/snake">开始游戏</a></h1>
    </div>
</div>

<div style="float:left;margin-left: 100px;margin-top: 100px">
    <div>
        <img src="/static/img/game/tetris.png" width="300px" height="300px">
    </div>
    <div style="margin-left:100px">
        <h1><a class="btn btn-warning" href="/game/tetris">开始游戏</a></h1>
    </div>
</div>
</body>
</html>
