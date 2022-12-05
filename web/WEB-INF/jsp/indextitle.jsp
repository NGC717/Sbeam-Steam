<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/12
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/user/indexTitle.css">
</head>
<style>

    #userinfo{
        display: none;
    }


    #user{
        color: aliceblue;
    }

    a{
        font-size: 15px;
    }
</style>
<body>
<div id="indexTitle">

    <div id="logo_div">
        <a href="/user/doIndex"><img style="max-width: 240px" id="logo" src="/static/img/user/logo_sbeam.png"></a>
    </div>

    <div id="title_div">
        <p>
            <a href="/user/doIndex">商店</a>
            &nbsp;

            <a href="#">社区 </a>
            &nbsp;

            <c:if test="${sessionScope.loginUser != null}">
                 <a id="user" >${sessionScope.loginUser.UName} </a>
            </c:if>
            &nbsp;

            <a href="/user/about">关于</a>
            &nbsp;
            <a href="/publish/cooperation">合作</a>
        </p>

        <div id="userinfo" style="position:absolute;left:65px;top:40px;width: 100px;height:200px;background-color: #1f2126;z-index: 10;padding: 10px;color: aliceblue">
            <a href="/user/userinfo">
                <p>个人资料</p>
            </a>

            <a href="/user/friend">
                <p>好友</p>
            </a>

            <a href="/user/inventory">
                <p>库存</p>
            </a>

            <a href="/user/selectCartByUserId">
                <p>购物车</p>
            </a>

            <a href="/user/addCredit/${0}">
                <p>充值</p>
            </a>
        </div>
    </div>

    <div id="login_div">
        <p>
            <c:choose>

                <c:when test="${sessionScope.loginUser == null}">
                    <a href="/user/login">登录</a>
                </c:when>

                <c:otherwise>
                    <span style="color: aliceblue">账户余额:￥${sessionScope.loginUser.UBalance}</span>
                    <span>
                        <img width="40px" height="40px" style="border-radius: 100%" src="${sessionScope.loginUser.userData.avatarPath}">
                    </span>
                    <a href="/user/exit">退出</a>
                </c:otherwise>
            </c:choose>
            <a>|</a>
            <a href="${pageContext.request.contextPath}/user/registerEmail">注册</a>
        </p>
    </div>

    <div>

    </div>
</div>
</body>
<script>
    var user = document.getElementById('user');
    var userinfo = document.getElementById('userinfo');

    user.onmouseover = function () {
        userinfo.style.display = 'block';
    }

    userinfo.onmouseover = function () {
        userinfo.style.display = 'block';
    }

    userinfo.onmouseleave = function () {
        userinfo.style.display = 'none';
    }

</script>
</html>
