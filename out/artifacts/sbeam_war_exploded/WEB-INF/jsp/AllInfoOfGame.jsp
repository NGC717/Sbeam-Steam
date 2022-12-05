<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/12
  Time: 11:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>游戏信息</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">

</head>
<body>
<h1>游戏审核</h1>
<hr>
<div>
    <a href="/root/updateGameIsCheck/${game.GId}" class="btn btn-primary">通过</a>
    <a href="/root/deleteGame/${game.GId}"class="btn btn-danger">退回</a>
</div>
<div>
    <div>
        <p>游戏名称：${game.GName}</p>
    </div>
    <div>
        <p>游戏宣传图</p>
        <img src="${game.gameData.headImg}" width="300px" height="200px">
        <img src="${game.gameData.anoImg1}" width="300px" height="200px">
        <img src="${game.gameData.anoImg2}" width="300px" height="200px">
        <img src="${game.gameData.anoImg3}" width="300px" height="200px">
        <img src="${game.gameData.anoImg4}" width="300px" height="200px">
    </div>

    <div>
        <p>游戏简介</p>
        <p>${game.introduceGame.IContent}</p>
    </div>
</div>
</body>
</html>
