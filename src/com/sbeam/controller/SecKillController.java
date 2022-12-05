package com.sbeam.controller;

import com.sbeam.bean.User;
import com.sbeam.service.UserService;
import com.sbeam.service.impl.RedisService;
import org.apache.activemq.ScheduledMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.jms.JMSException;

import javax.jms.Session;
import javax.jms.TextMessage;
import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class SecKillController {

    @Autowired
    private UserService userService;

    @Autowired
    @Qualifier("jmsQueueTemplate")
    private JmsTemplate jmsTemplate;

    @Autowired
    private RedisService redisService;

    @RequestMapping("/{shopId}")
    public String order(HttpSession session, @PathVariable Integer shopId, Model model) {

        User loginUser = (User) session.getAttribute("loginUser");

        Integer userId = loginUser.getUId();

        Map<Object, Object> promotion = redisService.hmget("promotion");

        String gId = String.valueOf(shopId);

        if (promotion != null && Integer.parseInt(promotion.get(gId).toString()) > 0) {

            /**
             * 支付的三个状态-1，0，1
             * -1：超时
             * 0：未付款
             * 1：已付款
             * 2:订单完成
             * 用户抢到商品后将用户id作为key，value为0
             */

            //保存订单信息
            Map<String, Object> order = new HashMap<>();
            order.put(String.valueOf(userId),"0");
            redisService.hmset("order",order);

            //保存用户的购买信息，userId，gameId
            Map<String, Object> info = new HashMap<>();
            info.put(userId.toString(),shopId.toString());

            boolean shop = redisService.hmset("shop", info);

            //商品库存减1
            redisService.hdecr("promotion",gId,1.0);

            //将用户id，游戏id信息发送到消息队列中
            jmsTemplate.send("order", new MessageCreator() {
                @Override
                public TextMessage createMessage(Session session) throws JMSException {

                    TextMessage message = session.createTextMessage((shopId + ":" + userId));

                    //延迟60s发送
                    message.setLongProperty(ScheduledMessage.AMQ_SCHEDULED_DELAY,60000L);
                    return message;
                }
            });

            //确认付款界面
            return "payPromotion";
        }

        //提示用户商品已售空
        model.addAttribute("isNone",true);
        return "order";
    }

    @RequestMapping("/doOrder")
    public String doOrder(String message) {

        String[] split = message.split(":");

        redisService.hdecr("promotion", split[0], 1);

        return "order";

    }

    @RequestMapping("/verify")
    public String verify(String pwd,HttpSession session,Model model) {

        User user = (User) session.getAttribute("loginUser");

        if (!user.getUPassword().equals(pwd)){
            model.addAttribute("pwdError",true);
            return "payPromotion";
        }

        String uId = String.valueOf(user.getUId());

        //完成订单
        redisService.hincr("order",uId,1.0);

        Map<Object, Object> shop = redisService.hmget("shop");

        Integer gId =Integer.parseInt(shop.get(uId).toString());

        userService.insertGameToInventoryWithUserIdAndGameId(Integer.parseInt(uId),gId);

        Integer balance = userService.selectBalanceByUserId(Integer.parseInt(uId));

        Map<Object, Object> game = redisService.hmget("game");

        Integer price = Integer.parseInt(game.get(gId.toString()).toString());

        userService.updateUserBalanceWithBalanceAndUserId(Integer.valueOf(uId),balance-price);

        model.addAttribute("success",true);

        return "forward://promotion/game";

    }

}
