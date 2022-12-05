<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/13
  Time: 13:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册账户</title>
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap-select.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/user/registerEmail.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/drag.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap-select.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/countrypicker.js"></script>
    <script src="https://v-cn.vaptcha.com/v3.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/drag.js"></script>
    <style>

        .vaptcha-init-loading > a {
            display: inline-block;
            width: 18px;
            height: 18px;
            border: none;
        }

        .vaptcha-init-loading > a img {
            vertical-align: middle;
        }

        .vaptcha-init-loading .vaptcha-text {
            font-family: sans-serif;
            font-size: 12px;
            color: #cccccc;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>
<div id="registerEmail">
    <p id="title">创建您的账户</p>
    <c:if test="${emailIsRegistered != null}">
        <p style="color: red">该邮箱已被注册</p>
    </c:if>

    <c:if test="${emailIsValid != null}">
        <p style="color: red">该邮箱无效</p>
    </c:if>

    <form id="form" action="/user/checkCode" method="post">
        <p style="color: aliceblue">电子邮件地址</p>
        <input id="e1" type="text">
        <p style="color: aliceblue">确认您的电子邮件地址</p>
        <input id="e2" type="text" name="uEmail">
        <p style="color: aliceblue">居住国家/地区</p>
        <select id="select" name="uCountry"
                class="selectpicker countrypicker"
                data-live-search="true"
                data-flag="true"
                data-default="China"></select>
        <h1></h1>

        <div style="width: 300px;height: 50px;">
            <div id="drag"></div>
            <span id="drag_ok" style="color: transparent">1</span>
            <script type="text/javascript">$('#drag').drag();</script>
            <div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';"></div>
        </div>

        <div id="iAgree_div">
            <input id="check" type="checkbox" name="isCheck">
            <p id="iAgree">我已年满13周岁并同意<a href="#">《Sbeam用户协议》</a>和<a href="#">《Sbeam隐私政策》</a>的条款</p>
        </div>
    </form>
    <button id="finish" onclick="submitForm()">继续</button>
</div>
</body>
<script>

    var e1 = document.getElementById('e1');
    var e2 = document.getElementById('e2');
    var check = document.getElementById('check');
    var btn = document.getElementById('finish');
    var form = document.getElementById('form');
    var select = document.getElementById('select');

    function submitForm() {

        if (e1.value === '' || e2.value === ''){
            alert('电子邮箱不能为空');
        }

        if (e2.value !== e1.value) {
            alert('您需要输入相同的邮箱地址');
        }

        if (!check.checked){
            alert('您需要同意《Sbeam 用户协议》才能继续');
        }

        if(e2.value === e1.value && check.checked){
            form.submit();
        }

        if(isDrag === 1){
            alert('您未进行人机验证');
        }
    }

    e1.onblur = function () {
        //判断这个文本框中输入的是不是邮箱
        var reg = /^[0-9a-zA-Z_.-]+[@][0-9a-zA-Z_.-]+([.][a-zA-Z]+){1,2}$/;
        if (reg.test(this.value)) {
            this.style.backgroundColor = "green";
        } else {
            this.style.backgroundColor = "red";
        }
    }

    e2.onblur = function () {
        //判断这个文本框中输入的是不是邮箱
        var reg = /^[0-9a-zA-Z_.-]+[@][0-9a-zA-Z_.-]+([.][a-zA-Z]+){1,2}$/;
        if (reg.test(this.value)) {
            this.style.backgroundColor = "green";
        } else {
            this.style.backgroundColor = "red";
        }
    }
</script>
</html>
