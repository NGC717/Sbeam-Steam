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
    <title>欢迎来到Sbeam</title>
    <link rel="stylesheet" href="/static/css/user/index.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="/static/js/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script language="JavaScript">
        history.pushState(null,null,document.URL);
        window.addEventListener("popstate",function () {
            history.pushState(null,null,document.URL);
        });
    </script>
</head>
<body>
<div>
<jsp:include page="indextitle.jsp"></jsp:include>
</div>

<div id="navigationBar">
    <button id="btn1"><a>您的商店</a></button>
    <button id="btn2"><a>新鲜推荐</a></button>
    <button id="btn3"><a>类别</a></button>
        <form id="search" action="/game/search" method="post">
            <input id="search_input" name="search" type="text" placeholder="搜索" maxlength="20">
            <input id="search_btn" type="submit" value="">
        </form>
</div>

<div>
    <img src="/static/img/user/steamcards_promo_02.png" style="max-width: 210px;position: absolute;left: 50px;top: 250px">
    <div style="position: absolute;left: 50px;top: 365px">
        <p style="color: aliceblue;font-size: 12px">按分类浏览</p>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/1">免费游玩</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/2">休闲</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/3">体育</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/4">冒险</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/5">动作</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/6">大型多人在线</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/7">模拟</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/8">独立</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/9">竞速</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/10">策略</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/selectGamesByCategory/11">角色扮演</a><br>
        <a style="font-size: 15px;color: #2E9AFE" href="/game/canPlay">休闲小游戏</a>
    </div>
</div>

<div id="choice_recommend">
    <p style="color: aliceblue;font-weight: bolder">精选和推荐</p>
    <div id="recommend" class="carousel slider" data-ride="carousel">
        <ul class="carousel-indicators" style="position: absolute;left: 0px;top: 400px">
            <li data-target="#recommend" data-slide-to="0" class="active"></li>
            <li data-target="#recommend" data-slide-to="1" class="active"></li>
            <li data-target="#recommend" data-slide-to="2" class="active"></li>
            <li data-target="#recommend" data-slide-to="3" class="active"></li>
            <li data-target="#recommend" data-slide-to="4" class="active"></li>
            <li data-target="#recommend" data-slide-to="5" class="active"></li>
            <li data-target="#recommend" data-slide-to="6" class="active"></li>
            <li data-target="#recommend" data-slide-to="7" class="active"></li>
        </ul>

        <div class="carousel-inner">
                <div class="carousel-item active">
                    <div style="width: 890px;height:400px;background-color: #1f2126">
                        <img src="/static/img/user/welcome.png" width="890px" height="400px">
                    </div>
                </div>

                <c:forEach items="${recommendGames}" var="recommendGame">
                    <div class="carousel-item">
                        <div style="width: 890px;height:400px;background-color: #1f2126">
                            <div style="float: left;width: 540px;height: 400px">
                                <a href="/game/${recommendGame.GId}">
                                    <img src="${recommendGame.gameData.headImg}" style="width: 540px" height="400px">
                                </a>
                            </div>

                            <div style="float: left">
                                <div style="margin-left: 20px;width: 330px;height: 80px"><p style="color: aliceblue;font-size: 28px">${recommendGame.GName}</p></div>

                                <div>
                                    <div style="margin: 10px">
                                        <span><img src="${recommendGame.gameData.anoImg1}" width="160px" height="100px"></span>
                                        <span><img src="${recommendGame.gameData.anoImg2}" width="160px" height="100px"></span>
                                    </div>

                                    <div style="margin: 10px">
                                        <span><img src="${recommendGame.gameData.anoImg3}" width="160px" height="100px"></span>
                                        <span><img src="${recommendGame.gameData.anoImg4}" width="160px" height="100px"></span>
                                    </div>

                                    <div style="margin-top: 20px;margin-left: 10px">
                                        <span><p style="color: aliceblue">价格：${recommendGame.GPrice}￥</p></span>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>
        </div>

        <a class="carousel-control-prev" href="#recommend" data-slide="prev"
        style="position: absolute;left: -90px;top: 0px">
            <span class="carousel-control-prev-icon"></span>
        </a>

        <a class="carousel-control-next" href="#recommend" data-slide="next"
           style="position: absolute;left: 845px;top: 0px;">
            <span class="carousel-control-next-icon"></span>
        </a>

    </div>

    <div style="height: 100px; width: 100%"></div>

    <div>
        <p style="color: aliceblue;font-weight: bolder">限量优惠</p>

        <c:choose>
            <c:when test="${promotionGames == null}">
               <img src="/static/img/user/tip.png" width="500px" height="80px">
            </c:when>

            <c:otherwise>
                <div>
                    <a href="/promotion/game">
                        <img width="176px" height="88px" src="/data/gameImg/${promotionGames[0].GId}/headImg.png">
                    </a>

                    <a href="/promotion/game">
                        <img width="176px" height="88px" src="/data/gameImg/${promotionGames[1].GId}/headImg.png">
                    </a>

                    <a href="/promotion/game">
                        <img width="176px" height="88px" src="/data/gameImg/${promotionGames[2].GId}/headImg.png">
                    </a>

                    <a href="/promotion/game">
                        <img width="176px" height="88px" src="/data/gameImg/${promotionGames[3].GId}/headImg.png">
                    </a>

                    <a href="/promotion/game">
                        <img width="176px" height="88px" src="/data/gameImg/${promotionGames[4].GId}/headImg.png">
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>


    <div style="margin-top: 88px">

        <div style="float:left">
            <p style="color: aliceblue;font-weight: bolder;background-color:#163f5f;width: 70px;height: 30px;border-radius: 5px">热门商品</p>
            <div style="width: 655px;height: 666px">

                <table>
                    <c:forEach items="${pageBean.list}" var="game">
                        <tr>
                            <td>
                                <a href="/game/${game.GId}">
                                    <div style="float: left;background-color: #5cb85c;width: 200px;height: 90px">
                                        <img src="${game.gameData.headImg}" width="200px" height="90px">
                                    </div>
                                </a>

                            </td>

                            <td>
                                <a href="/game/${game.GId}">
                                    <div class="name_div">
                                        <h6 style="color: aliceblue">${game.GName}</h6>
                                        <h6 style="color: #5e5e5e">${game.category.CCategory}</h6>
                                    </div>
                                </a>

                            </td>

                            <td>
                                <a href="/game/${game.GId}">
                                    <div class="price_div">
                                        <h6 style="color: aliceblue">￥${game.GPrice}</h6>
                                    </div>
                                </a>
                            </td>
                        </tr>

                    </c:forEach>
                    <tr>
                        <td colspan="3">
                            <div>

                                <span style="color: aliceblue">当前${pageBean.currentPage }/${pageBean.totalPage }页</span>   &nbsp;&nbsp;

                                <button style="width: 90px;height: 30px">
                                    <a href="/game/selectAllGamesPage/1">首页</a>
                                </button>

                                <button style="width: 90px;height: 30px">
                                    <a href="/game/selectAllGamesPage/${pageBean.currentPage-1}">上一页 </a>
                                </button>

                                <button style="width: 90px;height: 30px">
                                    <a href="/game/selectAllGamesPage/${pageBean.currentPage+1}">下一页 </a>
                                </button>

                                <button style="width: 90px;height: 30px">
                                    <a href="/game/selectAllGamesPage/${pageBean.totalPage}">末页</a>
                                </button>
                            </div>
                        </td>
                    </tr>
                </table>

                <div style="margin:100px;width: 10px;height: 10px"></div>

            </div>

        </div>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/static/js/index.js"></script>
</html>
