package com.sbeam.aspect;

import com.auth0.jwt.interfaces.Claim;
import com.sbeam.bean.User;
import com.sbeam.bean.UserData;
import com.sbeam.util.JWTUtil;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Aspect
@Component
public class AopAspect {

    @Pointcut("execution (* com.sbeam.controller.UserController.doIndex(..))")
    private void doIndex(){
    }

    private static HttpServletRequest getRequest(){

        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        return attributes.getRequest();
    }

    @Before(value = "doIndex()")
    private void getUserCookie(JoinPoint joinPoint) throws Exception {

        HttpServletRequest request = getRequest();

        Cookie[] cookies = request.getCookies();

        for (Cookie c : cookies) {

            if ("UCookie".equals(c.getName())){

                Map<String, Claim> claimMap = JWTUtil.verifyToken(c.getValue());

                User user = new User();

                user.setUId(claimMap.get("id").asInt());
                user.setUName(claimMap.get("username").asString());
                user.setUserData(new UserData(claimMap.get("avatar").asString()));

                request.setAttribute("loginUser",user);

            }
        }
    }
}
