<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/9
  Time: 8:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传结果</title>
</head>
<body>

<c:choose>
    <c:when test="${uploadFlag == 1}">
        <h1>上传成功</h1>
    </c:when>

    <c:when test="${uploadFlag == 2}">
        <h1>上传文件大小为0</h1>
    </c:when>

    <c:when test="${uploadFlag == 3}">
        <h1>未选择上传文件</h1>
    </c:when>

    <c:otherwise>
        <h1>上传失败</h1>
    </c:otherwise>
</c:choose>

</body>
</html>
