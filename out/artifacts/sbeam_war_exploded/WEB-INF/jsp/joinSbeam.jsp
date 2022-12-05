<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/19
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>加入Sbeam</title>
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/publisher/joinSbeam.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap-select.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap-select.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/countrypicker.js"></script>

    <style>
        #join{
            position: absolute;
            left: 550px;
            top: 20%;
            padding-top: 20px;
            padding-left: 50px;
            width: 500px;height: 350px;
        }

        label{
            text-align: right;
        }

        input{
            background-color: #32353c;
            width: 280px;
            height: 40px;
            color: aliceblue;
        }

        button{
            background-color: #2E9AFE;
            color: aliceblue;
            border: none;
            width: 100px;
            height: 40px;
        }
    </style>
</head>
<body>
    <div style="position: absolute;left: 580px;margin-top: 50px">
        <h1 style="color: aliceblue">申请与Sbeam成为合作伙伴</h1>
    </div>
    <div id="join">
        <form id="form" action="/publish/register?uId=${sessionScope.loginUser.UId}" method="post">
            <label for="publish" style="color: aliceblue">发行商名称</label><br>
            <input type="text" name="pName" id="publish"><br>
            <label for="bankNum" style="color: aliceblue">收款银行账号</label><br>
            <input type="text" name="pBank" id="bankNum"><br>
            <label for="officeName" style="color: aliceblue">公司/工作室名称</label><br>
            <input type="text" name="pOfficeName" id="officeName"><br>
            <label for="location" style="color: aliceblue">公司/工作室地点</label><br>
            <input type="text" name="pOfficeLocation" id="location"><br>
            <label for="pTele" style="color: aliceblue">公司/工作室联系电话</label><br>
            <input type="text" name="pTele" id="pTele"><br>
            <p style="color: aliceblue">所在国家/地区</p>
            <select id="select" name="pOfficeCountry"
                    class="selectpicker countrypicker"
                    data-live-search="true"
                    data-flag="true"
                    data-default="China"></select>

            <div style="position: absolute;left: 100px;top: 450px">
                <button><a href="/user/doIndex" style="color: aliceblue;text-decoration: none">返回首页</a></button>
                <button id="submit">提交申请</button>
            </div>
        </form>
    </div>
</body>

<script>
    let publishInput = document.getElementById('publish');
    let bankNumInput = document.getElementById('bankNum');
    let officeNameInput = document.getElementById('officeName');
    let locationInput = document.getElementById('location');
    let pTeleInput = document.getElementById('pTele');

    let submitBtn = document.getElementById('submit');

    submitBtn.onclick = function () {

        if (
            publishInput.value ==='' ||
            bankNumInput.value ==='' ||
            officeNameInput.value ==='' ||
            locationInput.value ==='' ||
            pTeleInput.value ===''
        ){
            alert('请完善所有信息');
            return false;
        }else {
            document.getElementById('form').submit();
        }
    }
</script>
</html>
