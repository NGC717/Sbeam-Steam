<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/26
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>付款</title>
</head>
<style>
    body{
        background-image: url("/static/img/user/background_spotlight.jpg");
        background-size: cover;
    }

    label{
        color: aliceblue;
        font-size: 30px;
    }

    p{
        color: aliceblue;
        font-size: 30px;
    }

    #submit{
        background-color: #2E9AFE;
        color: aliceblue;
        width: 90px;
        height: 30px;
        font-size: 20px;
        border-radius: 5px;
        border-color: transparent;
    }

    #pwd{
        width: 300px;
        height: 50px;
    }

    #ident{
        font-size: 20px;
    }

    button{
        color: aliceblue;
        font-size: 15px;
    }
</style>
<body>
<div style="margin-left: 400px;margin-top: 100px">
    <c:if test="${pwdError != null}">
        <p style="color:red">密码输入错误</p>
    </c:if>

    <p id="countDown"></p>

    <form id="form" action="/order/verify" method="post">
        <label id="ident" for="pwd">请输入登陆密码以验证您的身份</label>
        <br>
        <input type="password" name="pwd" id="pwd">
        <br>
        <p style="margin-top: 20px">确认付款</p>
        <button id="submit">提交</button>
    </form>
</div>
</body>
<script>

    var isout = false;

    var time = new Date().getTime() + 60*1000;

    function getTime() {

        var t = time - new Date().getTime();

        var down = document.getElementById("countDown");

        var show = Math.floor(t/1000);

        down.innerHTML = "请在"+show+"秒内确认付款";

        if (show <= 0){
            down.innerHTML = "已超时，请重新购买！";
            isout = true;
            clearInterval(inter);
        }
    }

    getTime();

    var inter = setInterval("getTime()",500);

    var btn = document.getElementById("submit");

    btn.onclick = function (){
        if (!isout){

            document.getElementById("form").submit();
        }else {
            return false;
        }
    }
</script>
</html>
