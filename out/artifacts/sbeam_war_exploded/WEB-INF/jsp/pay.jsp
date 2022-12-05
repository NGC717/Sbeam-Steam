<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/26
  Time: 20:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购买商品</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">

</head>
<style>
    body{
        margin: 0 auto;
        padding: 0;
        background-image: url("/static/img/user/background_spotlight.jpg");
        background-size: cover;
    }

    h5{
        color: aliceblue;
    }

    h1{
        color: aliceblue;
    }

</style>
<body>
<div style="width: 100%;height: 100px;background-color: #1f2126">
    <img src="/static/img/user/logo_sbeam.png" width="400" height="100px" style="position:absolute;right: 100px">
</div>
<div style="position:absolute;left:20%;width: 500px;height: 500px;">
    <h1>您购买的商品有：</h1>
    <table style = "border-collapse:separate; border-spacing:0 5px">
        <c:forEach items="${carts}" var="cart">
            <tr style="background-color: aliceblue;">
                <td>
                    <span><img src="${cart.game.gameData.headImg}" width="100px" height="50px"></span>
                </td>

                <td>
                    <h4>${cart.game.GName}</h4>
                </td>
                <td>
                    <h4 style="color: #2E9AFE">￥${cart.game.GPrice}</h4>
                </td>
            </tr>
        </c:forEach>
    </table>
    <hr>
    <h5>总计：￥${totalPay}</h5>

    <c:choose>
        <c:when test="${totalPay != 0}">
            <a class="btn" href="/user/doPay" style="width: 100px;height: 50px;background-color: #2E9AFE;font-size: 20px;color: aliceblue">付款</a>
        </c:when>

        <c:otherwise>
            <a class="btn" style="width: 100px;height: 50px;background-color: #2E9AFE;font-size: 20px;color: aliceblue">付款</a>
        </c:otherwise>
    </c:choose>



</div>

<div style="position:absolute;right:300px;top:150px;width: 200px;height: 300px">
<p style="color: aliceblue;font-size: 30px">感谢您在sbeam上的消费,我们将竭力带给您最好的娱乐体验</p>
</div>
</body>
</html>
