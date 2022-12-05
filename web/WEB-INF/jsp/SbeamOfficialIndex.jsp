<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/12
  Time: 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台管理</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<style>
    body{
        background-image: url("/static/img/user/background_spotlight.jpg");
        background-size: cover;
    }

    h4{
        color: aliceblue;
    }

    th{
        color: aliceblue;
    }

    td{
        color: aliceblue;
    }
    h1{
        color: aliceblue;
    }

    input{
        width: 100px;
    }

    p{
        color: aliceblue;
    }
</style>
<body>
<h1>Sbeam后台审核及管理</h1>
<a href="/root/getPromotion" class="btn btn-primary" style="color: aliceblue">设置促销游戏</a>
<hr>
<div style="float:left;margin-right: 100px">
    <h4>申请成为发行商</h4>
    <table border="1px" style="text-align: center">
        <tr>
            <th>发行商名称</th>
            <th>银行账号</th>
            <th>公司名/工作室名</th>
            <th>工作地址</th>
            <th>国家</th>
            <th>电话</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${publisherList}" var="publisher">
            <tr>
                <td>${publisher.PName}</td>
                <td>${publisher.PBank}</td>
                <td>${publisher.POfficeName}</td>
                <td>${publisher.POfficeLocation}</td>
                <td>${publisher.POfficeCountry}</td>
                <td>${publisher.PTele}</td>

                <td>
                    <a href="/root/publisherPass/${publisher.PId}" class="btn btn-primary">通过</a>
                    <a href="/root/publisherNotPass/${publisher.PId}"class="btn btn-danger">退回</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<div style="float:left;">
    <h4>游戏审核</h4>
    <table border="1px" style="text-align: center">
        <tr>
            <th>游戏名</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${games}" var="game">
            <tr>
                <td>${game.GName}</td>
                <td>
                    <a href="/root/gameInfo/${game.GId}" class="btn btn-warning">详细信息</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
