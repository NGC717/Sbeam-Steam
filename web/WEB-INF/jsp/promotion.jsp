<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/24
  Time: 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>促销</title>
</head>
<style>
    body{
        background-image: url("/static/img/user/background_spotlight.jpg");
        background-size: cover;
    }

    h1{
        color: aliceblue;
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

    span{
        color: aliceblue;
    }

</style>
<body>
<div style="float:left;">
    <h4>设置促销游戏</h4>
    <form id="form" action="/root/addRoll" method="post">
        <span>游戏ID</span><input type="number" name="gId">
        <span>库存总量</span><input type="number" name="gTotal">
        <span>游戏售价</span><input type="number" name="gPrice">
        <span>发售日期</span><input type="datetime-local" id="time" name="gBeginTime">
        <button id="btn">提交</button>
    </form>
</div>

<div style="float: left;margin-left: 150px">
    <h1>正在促销</h1>
    <table border="1px">
       <tr>
           <th>游戏ID</th>
           <th>游戏名称</th>
           <th>库存总量</th>
           <th>销售量</th>
           <th>库存剩余</th>
       </tr>
        <c:forEach items="${games}" var="game">
            <tr>
                <td>${game.GId}</td>
                <td>${game.GName}</td>
                <td>${game.GTotal}</td>
                <td>${game.GTotal - game.GResidue}</td>
                <td>${game.GResidue}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    var btn = document.getElementById("btn");
    var gBeginTime = document.getElementById("time").value;

    btn.onclick = function () {

        var bTime = new Date(gBeginTime);

        var curTime = new Date().getTime();

        if (bTime - curTime < 0){
            alert('时间小于当前时间');
        }else {
            document.getElementById('form').submit();
        }
    }
</script>
</html>
