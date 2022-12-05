<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/20
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>欢迎来到Sbeam</title>
    <link rel="stylesheet" href="/static/css/user/gameInfo.css">
</head>
<style>
    h2{
        margin: 0 0;
        color: aliceblue;
    }

    h3{
        margin: 5px 0;
        color: aliceblue;
    }

    p{
        margin: 5px 0;
        color: aliceblue;
    }
</style>
<body>
<jsp:include page="indextitle.jsp"></jsp:include>
<div id="navigationBar">
    <button id="btn1">您的商店</button>
    <button id="btn2">新鲜推荐</button>
    <button id="btn3">类别</button>
    <form id="search" action="/game/search" method="post">
        <input id="search_input" name="search" type="text" placeholder="搜索" maxlength="20">
        <input id="search_btn" type="submit" value="">
    </form>
</div>

<div style="position: absolute;left: 300px;top: 240px">
    <div style="width: 850px;height: 400px;background-color: transparent;float: top;left: 308px;top: 250px;margin: 0 0;padding: 0">
        <div style="width: 500px;height:400px;background-color: transparent;float: left">
            <div>
                <img width="500px" height="320px"src="${game.gameData.headImg}">
            </div>
            <div>
                <img width="120px" height="80px" src="${game.gameData.anoImg1}">
                <img width="120px" height="80px" src="${game.gameData.anoImg2}">
                <img width="120px" height="80px" src="${game.gameData.anoImg3}">
                <img width="120px" height="80px" src="${game.gameData.anoImg4}">
            </div>
        </div>

        <div style="background-color: transparent;width: 350px;height: 400px;float: left">
            <div style="padding-left:10px">
                <h3>游戏简介</h3>
                <p>${game.introduceGame.IContent}</p>
                <h3 style="margin-top: 65px">玩家评测:好评如潮</h3>

                <h3>发行日期:2018年4月28日</h3>

                <h3>开发商:${game.developer.DName}</h3>

                <h3>发行商:${game.publisher.PName}</h3>

                <h3>游戏分类:${game.category.CCategory}</h3>
                <hr>
            </div>
        </div>
    </div>

    <div style="float:top;margin-top: 50px">
        <div style="width: 500px;height: 80px;background-color: #4f5e6c">
            <p style="font-size: 25px;color: aliceblue">玩 ${game.GName}</p>
        </div>

        <div style="position: absolute;left: 315px;top: 500px;background-color: black">
            <button style="width: 60px;height: 30px;background-color: black">
                <a style="font-size: 15px">￥${game.GPrice}</a>
            </button>
            <c:choose>
                <c:when test="${isInCartFlag != null}">
                    <button style="width: 120px;height: 30px;background-color: #47D44DFF">
                        <a style="font-size: 15px">已加入购物车</a>
                    </button>
                </c:when>

                <c:when test="${isInInventory != null}">
                    <button style="width: 120px;height: 30px;background-color: #47D44DFF">
                        <a style="font-size: 15px">已在库中</a>
                    </button>
                </c:when>

                <c:otherwise>
                    <button style="width: 120px;height: 30px;background-color: #47D44DFF">
                        <a href="/user/addGameToCart/${game.GId}" style="font-size: 15px">添加至购物车</a>
                    </button>
                </c:otherwise>
            </c:choose>
        </div>

        <div style="margin-top: 50px">
            <h3>系统要求</h3>
            <hr>
            <div style="width: 400px;float: left">
                <p>最低配置: </p>
                <p>操作系统: ${game.lowDeviceConfiguration.LOperationSystem}</p>
                <p>处理器: ${game.lowDeviceConfiguration.LCpu}</p>
                <p>内存: ${game.lowDeviceConfiguration.LRam}</p>
                <p>显卡: ${game.lowDeviceConfiguration.LGpu}</p>
                <p>DirectX 版本: ${game.lowDeviceConfiguration.LDirectx}</p>
                <p>存储空间: 需要 ${game.lowDeviceConfiguration.LRom} 可用空间</p>
            </div>

            <div style="width: 400px;float: left">
                <p>推荐配置: </p>
                <p>操作系统: ${game.recommendDeviceConfiguration.ROperationSystem}</p>
                <p>处理器: ${game.recommendDeviceConfiguration.RCpu}</p>
                <p>内存: ${game.recommendDeviceConfiguration.RRam}</p>
                <p>显卡: ${game.recommendDeviceConfiguration.RGpu}</p>
                <p>DirectX 版本: ${game.recommendDeviceConfiguration.RDirectx}</p>
                <p>存储空间: 需要 ${game.recommendDeviceConfiguration.RRom} 可用空间</p>
            </div>
        </div>
        <div style="height: 1000px;background-color: transparent;margin-top: 350px">
            <div style="background-color: #253B55FF;width: 850px;height: 100px">
                <h2>&nbsp;</h2>
                <h2 style="margin-left: 10px">总体评测:好评如潮</h2>
            </div>

            <div>
                <table>
                    <c:forEach items="${users}" var="user">
                        <tr style="background-color: #1f2126;border-collapse:separate; border-spacing:50px 50px">
                            <td width="200px" style="text-align: center">
                                <img src="/data/avatar/${user.UId}.png" width="50px" height="50px">
                                <h4 style="color: aliceblue;">${user.UName}</h4>
                            </td>
                            <td width="643px">
                                <c:choose>
                                    <c:when test="${user.comment.gcIsGood == 0}">
                                        <img src="/static/img/user/bad.png">
                                        <span style="color: aliceblue">差评</span>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/static/img/user/good.png">
                                        <span style="color: aliceblue">好评</span>
                                    </c:otherwise>
                                </c:choose>
                                <p>${user.comment.gcTime}</p>
                                <p>${user.comment.gcContent}</p>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
