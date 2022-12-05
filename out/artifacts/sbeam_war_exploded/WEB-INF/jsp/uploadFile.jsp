<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/9
  Time: 8:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传文件</title>
    <link rel="stylesheet" href="/static/css/publisher/uploadFile.css">
</head>
<body>
<div>
    <jsp:include page="indextitle.jsp"></jsp:include>
</div>
<h2 style="color: aliceblue">上传游戏相关文件</h2>
<form action="/game/doUploadFile/${gId}" method="post" enctype="multipart/form-data">
    <div>
        <label for="uploadFile" style="color: aliceblue;">选择游戏本体文件</label>
        <input type="file" name="uploadFile" id="uploadFile">
    </div>

    <div>
        <label for="headImg" style="color: aliceblue">上传游戏主视图</label>
        <input type="file" name="headImg" id="headImg">
    </div>

    <div>
        <label for="anoImg1" style="color: aliceblue">上传游戏宣传图1</label>
        <input type="file" name="anoImg1" id="anoImg1">
    </div>

    <div>
        <label for="anoImg2" style="color: aliceblue">上传游戏宣传图2</label>
        <input type="file" name="anoImg2" id="anoImg2">
    </div>

    <div>
        <label for="anoImg3" style="color: aliceblue">上传游戏宣传图3</label>
        <input type="file" name="anoImg3" id="anoImg3">
    </div>

    <div>
        <label for="anoImg4" style="color: aliceblue">上传游戏宣传图4</label>
        <input type="file" name="anoImg4" id="anoImg4">
    </div>

    <input type="submit" id="submit"><label for="submit" style="color: aliceblue">提交</label>
    <input type="reset" id="reset"><label for="reset" style="color: aliceblue">重置</label>
</form>

</body>
</html>
