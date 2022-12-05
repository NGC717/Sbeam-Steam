<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <html>
  <head>
        <meta charset="UTF-8">
        <title>贪吃蛇游戏</title>
        <style>
            *{
                font-family: "微软雅黑";
            }

             #map{
                       width: 600px;
                       height: 600px;
                       background: #54d95a;
                       position: absolute;
                       left: 10px;
                       top: 60px;
                       overflow: hidden;
                   }

              input{
                  padding: 10px;
                  background: black;
                  color: #ffffff;
              }
          </style>
    </head>
  <!--捕获键盘按键-->
  <body onkeydown="control(event);" >
      <div class="top" >
            <input type="button" value="开始游戏" id="start_btn" onclick="start();test(this)"/>

            <span>得分：</span><span id="score"></span>
        </div>
        <div id="map" ></div>


        <script type="text/javascript">
   var snake_left = Math.floor(Math.random() * 26) * 20; //游戏开始时，蛇的位置
   var snake_top = Math.floor(Math.random() * 30) * 20;
   var map = document.getElementById("map");
   var snakes = [];//蛇的关节
   var stepX = 20;
   var stepY = 0;
   var snake_direction="right";
   var timer;

   //开始按钮点击一次后失效
   function test(obj){

         obj.disabled=true;
         obj.value="游戏开始中"
     }

   //点击“开始按钮” 开始游戏
   //document.getElementById("start_btn").onclick = function (){
       function start(){
         //游戏开始，蛇头放到数组的第一项
         for(var i = 2; i>=0;i--){
               drawSnake(i);
           }

         //蛇的移动
         snakeMove();

         //碰到墙壁死掉
         overDiv();

         //产生食物
         food();

         //吃掉食物
         eat();
     }

   //让蛇移动
   function snakeMove(){

         //蛇尾 的位置等于 上一个
         for(var i=snakes.length-1;i>0;i--){
               snakes[i].style.left = snakes[i-1].style.left;
               snakes[i].style.top = snakes[i-1].style.top;
           }

         //snakes数组的第零项是蛇头
         snakes[0].style.left = parseInt(snakes[0].style.left) + stepX +"px";
         snakes[0].style.top = parseInt(snakes[0].style.top) + stepY +"px";

         timer = setTimeout("snakeMove()",400);
     }

   //画出蛇身
   function drawSnake(num){
         var snakeNode = document.createElement("div");
         snakeNode.style.position = "absolute";
         snakeNode.style.top = "0px";
         snakeNode.style.left =  num * 20+"px";
         snakeNode.style.background = "coral";

          //如果设置div边框 20*20   18*18  1
          //snakeNode.style.border = "1px solid #333";
          snakeNode.style.width = "20px";
          snakeNode.style.height = "20px";

          snakes.push(snakeNode);

          map.appendChild(snakeNode);


      }

    function re_move(){
          clearTimeout(timer);
          snakeMove()

      }

    //控制方向
    function control(event){
          var n = event.keyCode;
          switch(n){
                case 37://  左  蛇在向右跑的过程中按左是不起作用的
                      if(snake_direction=="right"){
                            break;
                        }else{
                            stepX = -20;
                            stepY = 0;
                snake_direction="left";
                      }
                    re_move();
                break;

                case 40://下   蛇在向下跑的过程中 按上是不起作用的
                    if(snake_direction=="up"){
                          break;
                      }else{
                          stepX = 0;
                          stepY = 20;
                          snake_direction="down";
                      }
                    re_move();
                break;

                   case 38://  上  蛇在向下跑的过程中按左是不起作用的
                       if(snake_direction=="down"){
                             break;
                         }else{
                             stepX = 0;
                             stepY = -20;
                             snake_direction="up";
                         }
                       re_move();
                   break;

                   case 39://下   蛇在向下跑的过程中 按上是不起作用的
                       if(snake_direction=="left"){
                             break;
                         }else{
                             stepX = 20;
                             stepY = 0;
                             snake_direction="right";
                         }
                       re_move();
                   break;




               }

           }

         //判断是否碰到墙壁
         function overDiv(){

               //计算得分
               var score = document.getElementById("score");
               score.innerHTML = (snakes.length-3)*10;

                   var x = parseInt(snakes[0].style.left); //snakes[0]代表蛇头
                   var y = parseInt(snakes[0].style.top);

                   //判断是否碰到墙壁
                   if(x<0||x>580||y<0||y>580){
                         alert("Game Over");
                         window.location.reload();
                     }

                   //判断是否吃到自己
                   if(snakes.length > 4){
                for(var i=3;i<snakes.length-1;i++){
                          var x1 = parseInt(snakes[i].style.left);
                          var y1 = parseInt(snakes[i].style.top);

                          if(x==x1 && y==y1){
                                alert("Game Over");
                                window.location.reload();
                            }
                      }
                     }

                   setTimeout("overDiv()",30);
           }

         //产生食物
         function food(){

               var food_x = Math.floor(Math.random()*29+1)*20 + "px";
               var food_y = Math.floor(Math.random()*29+1)*20 + "px";
               //画出食物
               var food_div = document.createElement("div");

               food_div.style.position = "absolute";
               food_div.style.top = food_y;
               food_div.style.left = food_x;

               food_div.style.backgroundColor = "orange";
               //food_div.style.border = "1px solid #333";
               food_div.style.width = "20px";
               food_div.style.height = "20px";

               //给食物加id
               food_div.id = "i_food";
               map.appendChild(food_div);

           }

         //吃掉食物
         function eat(){
               //得到蛇头坐标
               var x1 = parseInt(snakes[0].style.left);
               var y1 = parseInt(snakes[0].style.top);

               //得到食物坐标
               var i_food = document.getElementById("i_food");

               var x2 = parseInt(i_food.style.left);
               var y2 = parseInt(i_food.style.top);

               if(Math.abs(x1-x2)<20 && Math.abs(y1-y2)<20){

                     snakes.push(i_food);
                     i_food.id = "";

                     //生成食物
                     food();
                 }

            setTimeout("eat()",30);
        }
  </script>
     </body>
 </html>
