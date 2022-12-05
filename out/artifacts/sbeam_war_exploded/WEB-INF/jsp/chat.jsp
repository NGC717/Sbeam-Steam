<%@ page import="com.sbeam.util.Resources" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>聊天</title>
  <link rel="stylesheet" href="/static/plugins/amaze/css/amazeui.min.css">
  <link rel="stylesheet" href="/static/plugins/amaze/css/admin.css">
  <link rel="stylesheet" href="/static/plugins/contextjs/css/context.standalone.css">
  <script src="/static/plugins/jquery/jquery-2.1.4.min.js"></script>
  <script src="/static/plugins/layer/layer.js"></script>
  <script src="/static/plugins/amaze/js/amazeui.min.js"></script>
  <script src="/static/plugins/amaze/js/app.js"></script>
  <script src="/static/plugins/laypage/laypage.js"></script>
  <script src="/static/plugins/contextjs/js/context.js"></script>
  <script src="/static/plugins/sockjs/sockjs.js"></script>
  </style>
</head>
<body>
<div class="am-cf admin-main" style="margin-bottom: 100px;background-color: #1f2126;width: 100%;height: 100%">
  <div class="admin-content" style="background-color: #1f2126;width: 100%;height: 100%">

    <div>
      <jsp:include page="indextitle.jsp"/>
    </div>

    <div class="" style="width: 80%;float:left;background-color: #1f2126">
      <!-- 聊天区 -->
      <div class="am-scrollable-vertical am-comment-success" id="chat-view" style="height: 510px;background-color: #1f2126">
        <ul class="am-comments-list am-comments-list-flip" style="color: aliceblue" id="chat"></ul>
      </div>
      <!-- 输入区 -->
      <div class="am-form-group am-form" style="background-color: #1f2126">
        <textarea style="color: aliceblue;background-color: #1f2126;resize: none" class="" id="message" name="message" rows="5"  placeholder="这里输入你想发送的信息..."></textarea>
      </div>

      <!-- 按钮区 -->
      <div class="am-btn-group am-btn-group-xs" style="float:right;background-color: #1f2126">
        <button class="am-btn am-btn-primary" type="button" onclick="getConnection()"><span class="am-icon-plug"></span> 连接</button>
        <button class="am-btn am-btn-primary" type="button" onclick="closeConnection()"><span class="am-icon-remove"></span> 断开</button>
        <button class="am-btn am-btn-primary" type="button" onclick="checkConnection()"><span class="am-icon-bug"></span> 检查</button>
        <button class="am-btn am-btn-primary" type="button" onclick="clearConsole()"><span class="am-icon-trash-o"></span> 清屏</button>
        <button class="am-btn am-btn-primary" type="button" onclick="sendMessage()"><span class="am-icon-commenting"></span> 发送</button>
      </div>
    </div>
    <!-- 列表区 -->
    <div class="am-panel am-pa" style="float:right;width: 20%;background-color: #1f2126">

      <div class="am-panel-hd" style="background-color: #1f2126">
        <h3 class="am-panel-title" style="color: aliceblue">聊天室在线好友:<span id="onlinenum"></span></h3>
      </div>

      <ul class="am-list am-list-static am-list-striped" ></ul>

      <ul class="am-list am-list-static am-list-striped" style="background-color: #1f2126" id="list"></ul>

    </div>
  </div>
</div>
<a href="#" class="am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}">
  <span class="am-icon-btn am-icon-th-list"></span></a>
<script>
  var sendTarget = "";

  if("${message}"){
    layer.msg('${message}', {
      offset: 0
    });
  }
  if("${error}"){
    layer.msg('${error}', {
      offset: 0,
      shift: 6
    });
  }

  var wsServer = null;
  var ws = null;
  wsServer = "ws://" + location.host+"${pageContext.request.contextPath}" + "/chatServer";	//WebServer的路径
  ws = new WebSocket(wsServer); //创建WebSocket对象
  ws.onopen = function (evt) {  //打开时候进行额回掉函数
    layer.msg("已经建立连接", { offset: 0}); //提示已经建立
  };
  ws.onmessage = function (evt) { //用于显示后台传递的数据
    analysisMessage(evt.data);  //解析后台传回的消息,并予以展示
  };
  ws.onerror = function (evt) {  //错误提示
    layer.msg("产生异常", { offset: 0});
  };
  ws.onclose = function (evt) {//关闭提示
    layer.msg("已经关闭连接", { offset: 0});
  };
  /**
   * 连接按钮，进行连接
   */
  function getConnection(){
    if(ws == null){
      ws = new WebSocket(wsServer); //创建WebSocket对象
      ws.onopen = function (evt) {
        layer.msg("成功建立连接!", { offset: 0});
      };
      ws.onmessage = function (evt) {
        analysisMessage(evt.data);  //解析后台传回的消息,并予以展示
      };
      ws.onerror = function (evt) {
        layer.msg("产生异常", { offset: 0});
      };
      ws.onclose = function (evt) {
        layer.msg("已经关闭连接", { offset: 0});
      };
    }else{
      layer.msg("连接已存在!", { offset: 0, shift: 6 });
    }
  }
  /**
   * 关闭连接
   */
  function closeConnection(){
    if(ws != null){
      ws.close();
      ws = null;
      $("#list").html("");    //清空在线列表
      layer.msg("已经关闭连接", { offset: 0});
    }else{
      layer.msg("未开启连接", { offset: 0, shift: 6 });
    }
  }
  /**
   * 检查连接
   */
  function checkConnection(){
    if(ws!=null){
      layer.msg(ws.readyState==0?"连接异常":"连接正常",{offset:0});
    }else{
      layer.msg("连接未开启!",{offset:0,shift:6});
    }
  }

  /**
   * 发送信息给后台
   */
  function sendMessage(){
    if(ws==null){
      layer.msg("连接未开启!",{offset:0,shift:6});
      return null;
    }
    var message=$("#message").val();//获取发送的信息

    var to = sendTarget;//获取要发送给的人，如果为全体成员则to设置为空

    if (to === ""){
      layer.msg("点击右侧聊天按钮，开始和朋友聊天吧")
      return;
    }

    if(message === null | message === ""){
      layer.msg("请输入内容！",{offset:0,shift:6});
    }

    ws.send(JSON.stringify({  //发送信息给后台，发送的格式为JSON:{ message:{cotent:message,from:"userid",to:to,time:Daee()},type:"message" }
      message:{content:message,
        from:'${userName}',
        avatarPath:'${userAvatar}',
        to:to,
        time:getDateFull()
      },
      type:"message"
    }));
  }
  /**
   * 解析后台传来的消息
   * "massage" : {
   *              "from" : "xxx",
   *              "to" : "xxx",
   *              "content" : "xxx",
   *              "time" : "xxxx.xx.xx"
   *          },
   * "type" : {notice|message},
   * "list" : {[xx],[xx],[xx]}
   */
  function analysisMessage(message){
    message=JSON.parse(message);//将后台发来的数据解析出JSON数据
    console.log(message);
    if(message.type === "message"){	//如果格式为message则展示数据到
      showChat(message.message);
    }
    if(message.type === "notice"){	//如果为notice则广播
      showNotice(message.message);
    }
    if(message.list !== null && message.list !== undefined){     //如果列表部位空，显示好友在线列表
      showOnline(message.list);
    }
  }
  function showChat(message){
    var to = message.to == null || message.to === "" ? "全体成员" : message.to;   //获取接收人
    var from;
    var fromtitle;

    var isSef = '${userName}' === message.from ? "am-comment-flip" : "";   //如果是自己则显示在右边,他人信息显示在左边
    var isSefhead ='${userName}'=== message.from? "information":"otherinfo";
    if(message.to==='${userName}'){
      to="你";
    }
    if(message.from === '${userName}')
    {
      messagetitle="你";
    }
    else
    {
      messagetitle=message.from;
    }

    var html = "<li class=\"am-comment "+isSef+" am-comment-primary\"><a href=\"${ctx}/"+isSefhead+"/"+message.from+"\"><img width=\"45\" height=\"45\" class=\"am-comment-avatar\" alt=\"\" src='"+message.avatarPath+"'></a><div class=\"am-comment-main\">\n" +
            "<header class=\"am-comment-hd\"><div class=\"am-comment-meta\">   <a class=\"am-comment-author\" href=\"#link-to-user\">"+messagetitle+"</a> 在<time> "+message.time+"</time> 发送给 "+to+" </div></header><div class=\"am-comment-bd\"> <p>"+message.content+"</p></div></div></li>";
    $("#chat").append(html);

    $("#message").val("");  //清空输入区

    var chat = $("#chat-view");

    chat.scrollTop(chat[0].scrollHeight);   //让聊天区始终滚动到最下面
  }
  function showNotice(notice){
    $("#chat").append("<div><p class=\"am-text-success\" style=\"text-align:center\"><span class=\"am-icon-bell\"></span> "+notice+"</p></div>");
    var chat = $("#chat-view");
    chat.scrollTop(chat[0].scrollHeight);   //让聊天区始终滚动到最下面
  }
  function showOnline(list){
    $("#list").html("");    //清空在线列表
    console.log(list.length);

    $.each(list, function(index, item){     //添加私聊按钮
      var li = "<li>"+item+"[自己]</li>";

      if('${userName}' !== item){    //排除自己
        li = "<li>"+item+" <button type=\"button\" class=\"am-btn am-btn-xs am-btn-primary am-round\" onclick=\"addChat('"+item+"');\"><span class=\"am-icon-phone\"><span>聊天</button></li>";
      }
      $("#list").append(li);
    });
    $("#onlinenum").text($("#list li").length);     //获取在线人数
  }

  function addChat(user){

    if (user !== sendTarget){
      clearConsole();
    }

    sendTarget = user;

  }

  function clearConsole(){
    $("#chat").html("");
  }
  function appendZero(s){return ("00"+ s).substr((s+"").length);}
  function getDateFull(){
    var date=new Date();
    var currentdate = date.getFullYear() + "-" + appendZero(date.getMonth() + 1) + "-" + appendZero(date.getDate()) + " " + appendZero(date.getHours()) + ":" + appendZero(date.getMinutes()) + ":" + appendZero(date.getSeconds());
    return currentdate;
  }
</script>
</body>
</html>