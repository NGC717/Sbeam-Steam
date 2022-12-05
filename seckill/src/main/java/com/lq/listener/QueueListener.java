package com.lq.listener;

import com.lq.redis.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import javax.jms.JMSException;
import javax.jms.TextMessage;
import javax.xml.crypto.Data;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Component
public class QueueListener {

    @Autowired
    private RedisUtil redisUtil;

    @JmsListener(destination = "order")
    public void recOrder(TextMessage message) throws JMSException {

        String s = message.getText();

        /**
         * split[0]:gameId
         * split[1]:userId
         */
        String[] split = s.split(":");

        /**
         * 订单状态
         * value为1则已付款
         * 为0则为未支付，超时
         */

        Map<Object, Object> order = redisUtil.hmget("order");

        if (order != null){

            Integer state = (Integer) order.get(split[1]);

            //付款失败，库存+1
            if (state != 1) {

                //指定时间之内未付款
                //超时，删除订单,库存加1
                redisUtil.del(split[0]);
                redisUtil.hincr("promotion", split[0], 1.0);

            } else {
                //订单完成，删除原有的订单信息
                redisUtil.hdel("shop", split[1]);
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();

            String format = sdf.format(date);

            System.out.println("[游戏ID：" + split[0] + "，用户ID：" + split[1] + "]"+format);
        }
    }
}
