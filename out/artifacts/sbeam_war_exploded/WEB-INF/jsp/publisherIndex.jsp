<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/19
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发行商</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/publisher/publisherIndex.css">
</head>
<style>
    button{
        background-color: #c0a16b;
        color: aliceblue;
    }
</style>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>
    <div style="float: left">
        <h2>已发行的游戏：</h2>

        <table border="1px">

            <tr>
                <th>游戏名</th>
                <th>开发商</th>
                <th>游戏售价</th>
                <th>总销量</th>
                <th>总收入(￥)</th>
                <th>操作</th>
            </tr>

            <c:forEach items="${games}" var="game">
                <c:if test="${game.GIsPublish == 1}">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${game.GName.length() < 12}">
                                    ${game.GName}
                                </c:when>

                                <c:otherwise>
                                    ${game.GName.substring(0,12)}...
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${game.developer.DName.length() < 12}">
                                    ${game.developer.DName}
                                </c:when>

                                <c:otherwise>
                                    ${game.developer.DName.substring(0,12)}...
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${game.GPrice}</td>
                        <td>${game.GDownloadNum}</td>
                        <td>${game.GPrice * game.GDownloadNum}</td>
                        <td>
                            <a class="btn btn-warning" href="/publish/banGame/${game.GId}">下架</a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
        <div style="margin-bottom:200px">

            <button style="width: 80px;height: 30px">
                <a>
                    当前${pageBean.currentPage }/${pageBean.totalPage }页
                </a>
            </button>

            <button style="width: 80px;height: 30px">
                <a>
                    首页
                </a>
            </button>

            <button style="width: 80px;height: 30px">
                <a>
                    上一页
                </a>
            </button>

            <button style="width: 80px;height: 30px">
                <a>
                    下一页
                </a>
            </button>

            <button style="width: 80px;height: 30px">
                <a>
                    末页
                </a>
            </button>
        </div>
    </div>

    <div style="float: left;margin-left: 50px">
        <h2>尚未发行的游戏：</h2>
        <table border="1px">
            <tr>
                <th>游戏名</th>
                <th>开发商</th>
                <th>游戏售价</th>
                <th>游戏文件是否上传完整</th>
                <th>上传游戏简介</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${games}" var="game">
                <c:if test="${game.GIsPublish == 0}">
                    <tr>
                        <td>${game.GName}</td>
                        <td>${game.developer.DName}</td>
                        <td>${game.GPrice}</td>
                        <td>
                            <c:choose>
                                <c:when test="${game.GIsComplete == 1}">
                                    <p>是</p>
                                </c:when>

                                <c:otherwise>
                                    <a href="/game/uploadFile/${game.GId}" class="btn btn-warning">上传文件</a>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <a href="/game/editIntroduce/${game.GId}/${game.GName}" class="btn btn-primary">上传</a>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${game.GIsCheck == 1}">
                                    <a href="/publish/uploadGameIsPublish/${game.GId}" class="btn btn-primary">发行</a>
                                </c:when>

                                <c:otherwise>
                                    <a href="#" class="btn btn-warning">审核中</a>
                                </c:otherwise>
                            </c:choose>
                            <a href="/game/deleteGameByGId/${game.GId}" class="btn btn-danger">删除</a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </td>
        </table>

        <div>
            <button style="width: 80px;height: 30px">
                <a>
                    当前${pageBean.currentPage }/${pageBean.totalPage }页
                </a>
            </button>

            <button style="width: 80px;height: 30px">
                <a>
                    首页
                </a>
            </button>

            <button style="width: 80px;height: 30px">
                <a>
                    上一页
                </a>
            </button>

            <button style="width: 80px;height: 30px">
                <a>
                    下一页
                </a>
            </button>

            <button style="width: 80px;height: 30px">
                <a>
                    末页
                </a>
            </button>
        </div>

        <div style="float: right;margin-top: 50px">
            <a href="/publish/publishGame" class="btn" style="color: aliceblue;background-color: #2E9AFE">提交新游戏</a>
        </div>

    </div>

</body>
</html>
