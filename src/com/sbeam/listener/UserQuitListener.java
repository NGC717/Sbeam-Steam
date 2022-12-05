package com.sbeam.listener;

import com.sbeam.bean.User;
import com.sbeam.service.impl.RedisService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class UserQuitListener implements HttpSessionListener {

    private HttpSession session;

    @Autowired
    private RedisService redisService;

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSessionListener.super.sessionCreated(se);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        session = se.getSession();

        User user = (User) session.getAttribute("loginUser");

        redisService.hdel("onlineUserMap",user.getUId());

        HttpSessionListener.super.sessionDestroyed(se);
    }
}
