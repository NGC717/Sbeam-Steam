<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/26
  Time: 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>为您的sbeam钱包充值</title>
</head>
<style>
    body{
        margin: 0 auto;
        padding: 0;
        background-color: #1f2126;
    }
    h3{
        color: aliceblue;
    }

    .money_div{
        padding: 0;
        width: 600px;
        height: 100px;
        background-color: #5e5e5e;
        margin-bottom: 10px;
    }

    .money_div:hover{
        background-color: #5cb85c;
    }

    p{
        color: aliceblue;
    }
</style>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>

<div style="margin-left: 20%">
    <h1 style="color: aliceblue">为您的 SBEAM 钱包充值</h1>
    <h3>为${sessionScope.loginUser.UName} 的钱包充值</h3>
    <h3>您的“Sbeam 钱包”资金可用于购买 Sbeam 上的任何一款游戏，或者用于支持 Sbeam 交易的游戏中的购买行为。</h3>
    <h3>下订单之前，您有机会检查您的订单。</h3>
    <h4 style="color: red">每周日中午12点至每周一中午12点沙箱环境进行维护，期间可能出现不可用，敬请谅解。</h4>
</div>

<div style="margin-left: 20%">
    <c:if test="${balanceNotEnough != null}">
        <h5 style="color: red">您账户余额不足请充值后再付款</h5>
    </c:if>
    <a href="/pay/addCredit/${1}">
        <div class="money_div">
            <div style="width: 200px;height: 100px;padding:10px;background-color: transparent">
                <h1 style="color: aliceblue;">充值￥30</h1>
            </div>
        </div>
    </a>


    <a href="/pay/addCredit/${2}">
        <div class="money_div">
            <div style="width: 200px;height: 100px;padding:10px;background-color: transparent">
                <h1 style="color: aliceblue;">充值￥60</h1>
            </div>
        </div>
    </a>


    <a href="/pay/addCredit/${3}">
        <div class="money_div">
            <div style="width: 200px;height: 100px;padding:10px;background-color: transparent">
                <h1 style="color: aliceblue;">充值￥150</h1>
            </div>
        </div>
    </a>


    <a href="/pay/addCredit/${4}">
        <div class="money_div">
            <div style="width: 200px;height: 100px;padding:10px;background-color: transparent">
                <h1 style="color: aliceblue;">充值￥300</h1>
            </div>
        </div>
    </a>


    <a href="/pay/addCredit/${5}">
        <div class="money_div">
            <div style="width: 200px;height: 100px;padding:10px;background-color: transparent">
                <h1 style="color: aliceblue;">充值￥600</h1>
            </div>
        </div>
    </a>

    <div style="margin-top: 100px"></div>
</div>
</body>
</html>
