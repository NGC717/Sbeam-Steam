<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/25
  Time: 22:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>特惠</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<style>
    p{
        width: 150px;
        font-size: 30px;
        color: aliceblue;
    }

    body{
        background-image: url("/static/img/user/background_spotlight.jpg");
        background-size: cover;
    }

    .name{
        font-size: 15px;
    }
</style>
<body>
<div style="margin-left: 300px">
    <div>
        <p id="test"></p>
    </div>
    <table border="1px">
        <tr>
            <th></th>
            <th style="color: aliceblue">商品名称</th>
            <th style="color: aliceblue">特惠价格</th>
            <th style="color: aliceblue">商品数量</th>
            <th></th>
        </tr>
        <tr>
            <td><img src="/data/gameImg/${games[0].GId}/headImg.png" width="300px" height="120px"></td>
            <td><p class="name">${games[0].GName}</p></td>
            <td><p>￥${games[0].GPrice}</p></td>
            <td><p id="num0">${games[0].GResidue}</p></td>
            <td>
                <span style="float:left;width: 150px">
                    <c:choose>
                        <c:when test="${games[0].already != null}">
                            <a class="btn btn-primary">已拥有</a>
                        </c:when>

                        <c:when test="${games[0].state == 1}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已在库中</a>
                        </c:when>

                        <c:when test="${games[0].state == 2}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已购买</a>
                        </c:when>

                        <c:otherwise>
                            <p id="ti0" style="width: 150px;font-size: 15px;color: aliceblue"></p>
                            <a id="buy0" class="btn" style="background-color: #5e5e5e;width:150px;color: aliceblue">购买</a>
                        </c:otherwise>
                    </c:choose>
                </span>
            </td>
        </tr>

        <tr>
            <td><img src="/data/gameImg/${games[1].GId}/headImg.png" width="300px" height="120px"></td>
            <td><p  class="name">${games[1].GName}</p></td>
            <td><p>￥${games[1].GPrice}</p></td>
            <td><p id="num1">${games[1].GResidue}</p></td>
            <td>
                <span style="float:left;width: 150px">
                    <c:choose>
                        <c:when test="${games[1].already != null}">
                            <a class="btn btn-primary">已拥有</a>
                        </c:when>

                        <c:when test="${games[1].state == 1}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已在库中</a>
                        </c:when>

                        <c:when test="${games[1].state == 2}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已购买</a>
                        </c:when>

                        <c:otherwise>
                            <p id="ti1" style="width: 150px;font-size: 15px;color: aliceblue"></p>
                            <a id="buy1" class="btn" style="background-color: #5e5e5e;width:150px;color: aliceblue">
                            购买
                        </a>
                        </c:otherwise>
                    </c:choose>
                </span>
            </td>
        </tr>

        <tr>
            <td><img src="/data/gameImg/${games[2].GId}/headImg.png" width="300px" height="120px"></td>
            <td><p  class="name">${games[2].GName}</p></td>
            <td><p>￥${games[2].GPrice}</p></td>
            <td><p id="num2">${games[2].GResidue}</p></td>
            <td>
                <span style="float:left;width: 150px">
                    <c:choose>
                        <c:when test="${games[2].already != null}">
                            <a class="btn btn-primary">已拥有</a>
                        </c:when>

                        <c:when test="${games[2].state == 1}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已在库中</a>
                        </c:when>

                        <c:when test="${games[2].state == 2}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已购买</a>
                        </c:when>

                        <c:otherwise>
                            <p id="ti2" style="width: 150px;font-size: 15px;color: aliceblue"></p>
                            <a id="buy2" class="btn" style="background-color: #5e5e5e;width:150px;color: aliceblue">
                            购买
                        </a>
                        </c:otherwise>
                    </c:choose>
                </span>
            </td>
        </tr>

        <tr>
            <td><img src="/data/gameImg/${games[3].GId}/headImg.png" width="300px" height="120px"></td>
            <td><p  class="name">${games[3].GName}</p></td>
            <td><p>￥${games[3].GPrice}</p></td>
            <td><p id="num3">${games[3].GResidue}</p></td>
            <td>
                <span style="float:left;width: 150px">
                    <c:choose>
                        <c:when test="${games[3].already != null}">
                            <a class="btn btn-primary">已拥有</a>
                        </c:when>

                        <c:when test="${games[3].state == 1}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已在库中</a>
                        </c:when>

                        <c:when test="${games[3].state == 2}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已购买</a>
                        </c:when>

                        <c:otherwise>
                            <p id="ti3" style="width: 150px;font-size: 15px;color: aliceblue"></p>
                            <a id="buy3" class="btn" style="background-color: #5e5e5e;width:150px;color: aliceblue">
                            购买
                        </a>
                        </c:otherwise>
                    </c:choose>
                </span>
            </td>
        </tr>

        <tr>
            <td><img src="/data/gameImg/${games[4].GId}/headImg.png" width="300px" height="120px"></td>
            <td><p  class="name">${games[4].GName}</p></td>
            <td><p>￥${games[4].GPrice}</p></td>
            <td><p id="num4">${games[4].GResidue}</p></td>
            <td>
                <span style="float:left;width: 150px">
                    <c:choose>
                        <c:when test="${games[4].already != null}">
                            <a class="btn btn-primary">已拥有</a>
                        </c:when>

                        <c:when test="${games[4].state == 1}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已在库中</a>
                        </c:when>

                        <c:when test="${games[4].state == 2}">
                            <a class="btn btn-primary" style="color: aliceblue;width: 150px">已购买</a>
                        </c:when>

                        <c:otherwise>
                            <p id="ti4" style="width: 150px;font-size: 15px;color: aliceblue"></p>
                            <a id="buy4" href="" class="btn" style="background-color: #5e5e5e;width:150px;color: aliceblue">
                            购买
                        </a>
                        </c:otherwise>
                    </c:choose>
                </span>
            </td>
        </tr>
    </table>
    <c:if test="${success != null}">
        <a class="btn btn-warning" style="color: aliceblue;font-size: 30px">购买成功!</a>
    </c:if>
</div>
</body>
<script>

    var buy4 = document.getElementById("buy4");
    var buy3 = document.getElementById("buy3");
    var buy2 = document.getElementById("buy2");
    var buy1 = document.getElementById("buy1");
    var buy0 = document.getElementById("buy0");

   function getTime(){

       var time = Date.now();

       var ti0 = document.getElementById("ti0");

       var diff = ${games[0].GBeginTime}-time;

       var d = Math.floor(diff/1000/3600/24);
       var h = Math.floor((diff/1000/60/60)%24);
       var m = Math.floor((diff/1000/60)%60);
       var s = Math.floor((diff/1000)%60);

       if (diff > 0){
           ti0.innerHTML = "还剩"+d+"天"+h+"时"+m+"分"+s+"秒";
       }else {
           buy4.style.backgroundColor="#5d9a45";
           buy4.href="/order/"+${games[0].GId};
       }

       var time1 = Date.now();

       var ti1 = document.getElementById("ti1");

       var diff1 = ${games[1].GBeginTime}-time1;

       var d1 = Math.floor(diff1/1000/3600/24);
       var h1 = Math.floor((diff1/1000/60/60)%24);
       var m1 = Math.floor((diff1/1000/60)%60);
       var s1 = Math.floor((diff1/1000)%60);

       if (diff1 > 0){
           ti1.innerHTML = "还剩"+d1+"天"+h1+"时"+m1+"分"+s1+"秒";

       }else {
           buy4.style.backgroundColor="#5d9a45";
           buy4.href="/order/"+${games[1].GId};
       }

       var time2 = Date.now();

       var ti2 = document.getElementById("ti2");

       var diff2 = ${games[2].GBeginTime}-time2;

       var d2 = Math.floor(diff2/1000/3600/24);
       var h2 = Math.floor((diff2/1000/60/60)%24);
       var m2 = Math.floor((diff2/1000/60)%60);
       var s2 = Math.floor((diff2/1000)%60);

       if (diff2 > 0){
           ti2.innerHTML = "还剩"+d2+"天"+h2+"时"+m2+"分"+s2+"秒";
       }else {
           buy4.style.backgroundColor="#5d9a45";
           buy4.href="/order/"+${games[2].GId};
       }


       var time3 = Date.now();

       var ti3 = document.getElementById("ti3");

       var diff3 = ${games[3].GBeginTime}-time3;

       var d3 = Math.floor(diff3/1000/3600/24);
       var h3 = Math.floor((diff3/1000/60/60)%24);
       var m3 = Math.floor((diff3/1000/60)%60);
       var s3 = Math.floor((diff3/1000)%60);


       if (diff3 > 0){
           ti3.innerHTML = "还剩"+d3+"天"+h3+"时"+m3+"分"+s3+"秒";

       }else {
           buy4.style.backgroundColor="#5d9a45";
           buy4.href="/order/"+${games[3].GId};
       }

       var time4 = Date.now();

       var ti4 = document.getElementById("ti4");

       var diff4 = ${games[4].GBeginTime}-2*time4;

       var d4 = Math.floor(diff4/1000/3600/24);
       var h4 = Math.floor((diff4/1000/60/60)%24);
       var m4 = Math.floor((diff4/1000/60)%60);
       var s4 = Math.floor((diff4/1000)%60);

       if (diff4 > 0){
           ti4.innerHTML = "还剩"+d4+"天"+h4+"时"+m4+"分"+s4+"秒";
       }else {
           buy4.style.backgroundColor="#5d9a45";
           buy4.href="/order/"+${games[4].GId};
       }

       $.ajax({
           type:"POST",
           url:"/promotion/getNum/${games[4].GId}",
           dataType:"text",
           success:function (data) {
               document.getElementById("num4").innerHTML=data;
           },
       });

       $.ajax({
           type:"POST",
           url:"/promotion/getNum/${games[3].GId}",
           dataType:"text",
           success:function (data) {
               document.getElementById("num3").innerHTML=data;
           },
       });

       $.ajax({
           type:"POST",
           url:"/promotion/getNum/${games[2].GId}",
           dataType:"text",
           success:function (data) {
               document.getElementById("num2").innerHTML=data;
           },
       });

       $.ajax({
           type:"POST",
           url:"/promotion/getNum/${games[1].GId}",
           dataType:"text",
           success:function (data) {
               document.getElementById("num1").innerHTML=data;
           },
       });

       $.ajax({
           type:"POST",
           url:"/promotion/getNum/${games[0].GId}",
           dataType:"text",
           success:function (data) {
               document.getElementById("num0").innerHTML=data;
           },
       });
   }

   setInterval("getTime()",1000);

</script>
</html>
