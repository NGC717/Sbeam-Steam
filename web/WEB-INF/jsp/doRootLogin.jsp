<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/12
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台审核登录</title>
</head>
<style>
    body{
        background-image: url("/static/img/user/background_spotlight.jpg");
        background-size: cover;
    }

    label{
        font-size: 30px;
        color: aliceblue;
    }

    input{
        width: 300px;
        height: 40px;
    }

    button{
        width: 90px;
        height: 45px;
        color: aliceblue;
        background-color: #2E9AFE;
        border: none;
        font-size: 15px;
    }
</style>
<body>

<div style="margin-left: 600px;">
    <div style="margin-top: 200px">
        <form action="/root/doRootLogin" method="post">
            <label for="pwd">请输入后台管理员密码</label>
            <br>
            <input type="text" name="rootPwd" id="pwd">
            <br>
            <button style="margin-left: 90px" type="submit">登录</button>
        </form>
    </div>
</div>


</body>
</html>
