<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/5
  Time: 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>搜索</title>
</head>

<style>
  body{
    width: 100%;
    margin: 0 auto;
    padding: 0;
    background-image: url("/static/img/user/background_spotlight.jpg");
    background-size: cover;
  }

  #navigationBar{
    position: absolute;
    left: 20%;
    top: 20%;
    background-color: #2E9AFE;
    width: 820px;
    height: 30px;
    display: flex;
    font-weight: bold;
  }

  button{
    background-color: transparent;
    border-color: transparent;
    color: aliceblue;
  }

  #search{
    position: absolute;
    left:500px;
    top: 0px;
    margin-left: 146px;
  }

  #search_btn{
    position: absolute;
    top: 0px;
    width: 30px;
    height: 30px;
    border-color: transparent;
    background-image: url("/static/img/user/search_icon_btn.png");
  }

  #search_input{
    border-color: transparent;
    height: 30px;
    background-color: #0080FF;
    font-weight: bold;
    color: aliceblue;
  }

  .name_div{
    float: left;
    background-color: #1e3040;
    width: 300px;
    height: 70px;
    margin-left: 0px;
    margin-top: 10px;
    padding: 10px;
  }

  .price_div{
    float: left;
    background-color: #1e3040;
    width: 85px;
    height: 80px;
    margin-left: 0px;
    margin-top: 10px;
    padding-top: 10px;
  }

  .name_div:hover~.price_div{
    background-color: #a7cbe0;
  }

  .name_div:hover{
    background-color: #a7cbe0;
  }

  a {
    color: aliceblue;
    text-decoration: none;
  }


  tr {
    display: block;
    margin: 2px 0;
  }
</style>
<body>
<jsp:include page="indextitle.jsp"></jsp:include>
<div id="navigationBar">
  <button id="btn1"><a>您的商店</a></button>
  <button id="btn2"><a>新鲜推荐</a></button>
  <button id="btn3"><a>类别</a></button>
  <form id="search" action="/game/search" method="post">
    <input id="search_input" name="search" type="text" placeholder="搜索" maxlength="20">
    <input id="search_btn" type="submit" value="">
  </form>
</div>

<div style="width: 500px;height: 500px;position: absolute;left: 300px;top: 200px">

  <div style="float:left">
    <p style="color: aliceblue;font-weight: bolder;background-color:#163f5f;width: 150px;height: 30px;border-radius: 5px">当前分类：${category}</p>
    <div style="width: 655px;height: 666px;padding: 0">

      <table>
        <c:forEach items="${games}" var="game">
          <tr>
            <td>
              <a href="/game/${game.GId}">
                <div style="float: left;background-color: #5cb85c;width: 200px;height: 80px">
                  <img src="${game.gameData.headImg}" width="200px" height="90px">
                </div>
              </a>

            </td>

            <td>
              <a href="/game/${game.GId}">
                <div class="name_div">
                  <h3 style="color: aliceblue">${game.GName}</h3>
                  <h6 style="color: #5e5e5e">${game.category.CCategory}</h6>
                </div>
              </a>

            </td>

            <td>
              <a href="/game/${game.GId}">
                <div class="price_div">
                  <h3 style="color: aliceblue">￥${game.GPrice}</h3>
                </div>
              </a>
            </td>
          </tr>

        </c:forEach>
      </table>
    </div>

  </div>
</div>
</body>
</html>

