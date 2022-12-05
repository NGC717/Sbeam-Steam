<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/26
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/user/shopCart.css">
</head>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>
<div id="navigationBar">
    <button id="btn1">您的商店</button>
    <button id="btn2">新鲜推荐</button>
    <button id="btn3">类别</button>
    <button id="btn4">充值</button>
    <form id="search" action="#" method="post">
        <input id="search_input" type="text" placeholder="搜索" maxlength="20">
        <input id="search_btn" type="submit" value="">
    </form>
</div>

<div style="position: absolute;left: 20%;top: 200px">
    <h2>您的购物车</h2>
    <table style = "border-collapse:separate; border-spacing:0 5px">
        <c:forEach items="${carts}" var="cart">
            <tr style="background-color: #1f2126;">
                <td>
                    <span><img src="${cart.game.gameData.headImg}" width="200px" height="80px"></span>
                </td>
                <td>
                    <h4>${cart.game.GName}</h4>
                </td>
                <td>
                    <h4 style="color: #2E9AFE">￥${cart.game.GPrice}</h4>
                </td>
                <td>
                    <a href="/user/removeGameFromCart/${cart.game.GId}" class="btn btn-primary" style="width: 81px;height: 41px">移除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <tr>
        <span>
            <a href="/user/doIndex" class="btn btn-primary" style="width: 80px;height: 41px;font-size: 15px">继续购物</a>
        </span>

        <span>
            <a href="/user/pay" class="btn btn-primary" style="width: 80px;height: 41px;font-size: 15px">付款</a>
        </span>
        <span style="color: aliceblue">
            总计:￥${totalPay}
        </span>
    </tr>
</div>
</body>
</html>
