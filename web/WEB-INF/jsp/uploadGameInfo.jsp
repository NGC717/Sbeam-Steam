<%--
  Created by IntelliJ IDEA.
  User: LQ
  Date: 2021/7/19
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传游戏</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <style>
        body{
            margin-top: 30px;
            margin-left: 10px;
            background-image: url("/static/img/user/acct_creation_bg.jpg");
            background-size: cover;
        }
        button{
            background-color: #2E9AFE;
            color: aliceblue;
            width: 80px;
            height: 30px;
            border: none;
        }

        label{
            color: aliceblue;
        }

        p{
            color: aliceblue;
        }

        h5{
            color: aliceblue;
        }

        h1{
            color: aliceblue;
        }

        input{
            width: 200px;
            height: 30px;
            background-color: #1f2126;
            color: aliceblue;
        }
    </style>
</head>
<body>
<div>
    <h1>上传游戏配置</h1>
    <a href="/publish/publisherIndex" class="btn btn-primary" style="color: aliceblue;text-decoration: none">返回</a></button>
</div>
<hr>
    <div>
        <form id="form" action="/publish/uploadGameConfiguration" method="post">

            <label for="gName">游戏名称</label>
                <input type="text" name="gName" id="gName">
            <label for="dName">开发商</label>
                <input type="text" name="dName" id="dName">
            <label for="gPrice">游戏售价:￥</label>
            <input type="number" name="gPrice" id="gPrice">
            <hr>

            <h5>游戏配置</h5>

                <div style="float: left;margin-left: 300px">
                    <p>最低游戏配置</p>
                    <label for="lOperationSystem">操作系统</label><br>
                    <input type="text" name="lOperationSystem" id="lOperationSystem"><br>
                    <label for="lCpu">处理器</label><br>
                    <input type="text" name="lCpu" id="lCpu"><br>
                    <label for="lRam">内存</label><br>
                    <input type="text" name="lRam" id="lRam"><br>
                    <label for="lGpu">显卡</label><br>
                    <input type="text" name="lGpu" id="lGpu"><br>
                    <label for="lDirectx">DirectX版本</label><br>
                    <input type="text" name="lDirectx" id="lDirectx"><br>
                    <label for="lRom">硬盘空间</label><br>
                    <input type="text" name="lRom" id="lRom">
                </div>


                <div style="float: left;margin-left: 300px">
                    <p>推荐游戏配置</p>
                    <label for="rOperationSystem">操作系统</label><br>
                    <input type="text" name="rOperationSystem" id="rOperationSystem"><br>
                    <label for="rCpu">处理器</label><br>
                    <input type="text" name="rCpu" id="rCpu"><br>
                    <label for="rRam">内存</label><br>
                    <input type="text" name="rRam" id="rRam"><br>
                    <label for="rGpu">显卡</label><br>
                    <input type="text" name="rGpu" id="rGpu"><br>
                    <label for="rDirectx">DirectX版本</label><br>
                    <input type="text" name="rDirectx" id="rDirectx"><br>
                    <label for="rRom">硬盘空间</label><br>
                    <input type="text" name="rRom" id="rRom">
                </div>

            <div style="position: absolute;left: 620px;top: 620px">
                <button id="submit">继续</button>
            </div>

        </form>
    </div>
</body>
<script>

    let gName = document.getElementById('gName');
    let dName = document.getElementById('dName');
    let gPrice = document.getElementById('gPrice');

    let lOperationSystem = document.getElementById('lOperationSystem');
    let lCpu = document.getElementById('lCpu');
    let lRam = document.getElementById('lRam');
    let lGpu = document.getElementById('lGpu');
    let lDirectx = document.getElementById('lDirectx');
    let lRom = document.getElementById('lRom');

    let rOperationSystem = document.getElementById('rOperationSystem');
    let rCpu = document.getElementById('rCpu');
    let rRam = document.getElementById('rRam');
    let rGpu = document.getElementById('rGpu');
    let rDirectx = document.getElementById('rDirectx');
    let rRom = document.getElementById('rRom');

    let submitBtn = document.getElementById('submit');

    submitBtn.onclick = function (){
        if (
            gName.value ==='' ||
            dName.value ==='' ||
            gPrice.value ==='' ||

            lOperationSystem.value ==='' ||
            lCpu.value ==='' ||
            lRam.value ==='' ||
            lGpu.value ==='' ||
            lDirectx.value ==='' ||
            lRom.value ==='' ||

            rOperationSystem.value ==='' ||
            rCpu.value ==='' ||
            rRam.value ==='' ||
            rGpu.value ==='' ||
            rDirectx.value ==='' ||
            rRom.value ===''
        ){
            alert('请完善所有信息');
            return false;
        }else {
            document.getElementById('form').submit();
        }
    }
</script>
</html>
