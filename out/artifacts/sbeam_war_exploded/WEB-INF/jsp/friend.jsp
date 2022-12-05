<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/8/11
  Time: 21:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加好友</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="/static/plugins/jquery/jquery-2.1.4.min.js"></script>
    <script src="/static/plugins/layer/layer.js"></script>
</head>

<style>
    body{
        margin: 0 0;
        padding: 0;
        background-color: #1f2126;
    }

    input{
        background-color: aliceblue;
        color: #2E9AFE;
    }

    label{
        color: aliceblue;
    }

    td{
        background-color: #2E9AFE;
    }
</style>
<body>
<div>
    <jsp:include page="indextitle.jsp"/>
</div>
<div style="float:left;width: 200px;height: 100px"></div>
<div style="float:left;margin-top: 50px">
    <h1 style="color: aliceblue">根据用户名添加好友</h1>
    <form id="form" action="/user/selectFriendByName" method="post">
        <input type="search" name="friendName" id="input_search">
        <button id="submit" style="width: 60px;height: 30px;background-color: #2E9AFE;color: aliceblue;border: none">搜索</button>
    </form>
    <c:choose>
        <c:when test="${isExists != null}">
            <h2 style="color: red">未查询到该用户</h2>
        </c:when>

        <c:when test="${friend == null}"></c:when>

        <c:when test="${wasFriend != null}">
            <a class="btn btn-warning">已是好友</a>
        </c:when>

        <c:otherwise>
            <table>
                <tr>
                    <td>
                        <img src="${friend.userData.avatarPath}" width="30px" height="30px">
                    </td>
                    <td>
                        <h3 style="color: aliceblue;margin-right: 100px">
                                ${friend.UName}
                        </h3>
                    </td>
                    <td>
                        <a class="btn btn-warning" href="/user/addFriend/${friend.UId}">添加好友</a>
                    </td>
                </tr>
            </table>
        </c:otherwise>
    </c:choose>

    <hr>

    <table border="1px">
        <c:forEach items="${friends}" var="friend">
            <tr>
                <td>
                    <img src="${friend.userData.avatarPath}" width="30px" height="30px">
                </td>
                <td>
                    <h3 style="color: aliceblue;margin-right: 100px">
                        ${friend.UName}
                    </h3>
                </td>

                <td>
                    <c:choose>
                        <c:when test="${friend.isOnline != null}">
                            <a class="btn" style="color: aliceblue;background-color: #5cb85c">在线</a>
                            <a class="btn btn-warning" href="/user/chatWithFriend/${friend.UId}">聊天</a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn" style="color: aliceblue;background-color: #5e5e5e">离线</a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<div style="float:left;margin-left: 50px;margin-top: 50px">
    <h1 style="color:aliceblue">好友申请</h1>
    <table>
        <c:forEach items="${waitForPassing}" var="pass">
            <tr>
                <td>
                    <img src="${pass.userData.avatarPath}" width="30px" height="30px">
                </td>
                <td>
                    <h3 style="color: aliceblue;margin-right: 100px">
                            ${pass.UName}
                    </h3>
                </td>
                <td>
                    <a class="btn btn-warning" href="/user/friendReqPass/${pass.UId}">通过</a>
                </td>

                <td>
                    <a class="btn btn-danger" href="#">拒绝</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>

<script>

    var serach = document.getElementById('input_search');
    var form = document.getElementById('form');
    var searchBtn = document.getElementById('submit');

    searchBtn.onclick = function () {

        if(serach.value === ''){
            alert('搜索内容不能为空');
            return false;
        }else {
            form.submit();
        }
    }

</script>
</html>
