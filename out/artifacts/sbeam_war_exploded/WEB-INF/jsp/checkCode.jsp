<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/14
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>验证邮箱</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/user/checkCode.css">
</head>
<body>
<p id="title">验证您的电子邮箱</p>
<div id="checkCode">
<p id="info">请查看 ${insertUser.UEmail} 中来自 Sbeam 的电子邮件，以完成您的帐户设置。</p>

    <c:if test="${isCheckCodeRight != null}">
        <p id="res">验证码错误，请重新输入</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/user/codeRight?e=${insertUser.UEmail}&c=${insertUser.UCountry}" method="post">
        <label for="input">验证码：</label>
        <input id="input" type="text" name="checkCode" maxlength="6">
        <input type="submit" value="验证">
    </form>
</div>

<div id="error">
    <h4>没收到我们的电子邮件？</h4>
    <h5>如果您尚未收到我们的电子邮件，请尝试下述的步骤来排除故障：</h5>
    <h5>&nbsp;1.复查您的电子邮件地址"${insertUser.UEmail}"拼写正确无误。</h5>
    <h5>&nbsp;2.请检查您的垃圾邮件和已删除邮件目录下是否有来自 sbeam 的邮件。有时电子邮件会被您的电子邮箱服务商错误的识别为垃圾邮件。</h5>
    <h5>&nbsp;3.稍等片刻。有时电子邮件服务器运行缓慢需要花一些时间来接收电子邮件。</h5>
    <h4>某些电子邮件提供商就是无法接收 Sbeam 的邮件。如果您依然无法找到我们的邮件，我们建议您在 Sbeam 使用一个不同的电子邮件地址。</h4>
</div>
</body>
</html>
