<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/23
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>游戏简介</title>
</head>
<body>

<h1>游戏名称：${Gname}</h1>

    <c:choose>
        <c:when test="${introduceGame == null}">
            <form action="/game/uploadGameIntroduce" method="post">
                <input hidden name="gId" value="${Gid}">
                <label for="iContent">上传游戏简介</label>
                    <input type="submit" value="提交">
                <br>
                <textarea name="iContent" id="iContent" rows="10" cols="30" placeholder="输入游戏简介"></textarea>
            </form>
        </c:when>

        <c:otherwise>
            <form action="/game/updateGameIntroduce" method="post">
                <input hidden name="gId" value="${Gid}">
                <label for="ixContent">更新游戏简介</label>
                    <input type="submit" value="提交">
                <br>
                <textarea name="iContent" id="ixContent" rows="10" cols="30">
                    ${introduceGame.IContent}
                </textarea>
            </form>
        </c:otherwise>
    </c:choose>

</body>

</html>
