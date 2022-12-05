<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/27
  Time: 7:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发表评测</title>
</head>
<body>
    <div>
        <form action="/user/doComment" method="post">
            <input type="text" hidden name="gId" value="${gId}">

            <label><input type="radio" name="gcIsGood" value="1">好评</label>
            <label><input type="radio" name="gcIsGood" value="0">差评</label>
            <input type="submit" value="发布">
            <br>
            <textarea name="gcContent" rows="10" cols="20px" placeholder="留下你对这款游戏的评价吧"></textarea>

        </form>
    </div>
</body>
</html>
