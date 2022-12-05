package com.sbeam.util;

import javax.servlet.http.Cookie;

public class CookieUtil extends Cookie{

    private static final String NAME = "UCookie";

    public CookieUtil(String name, String value) {
        super(name, value);
    }

    public static Cookie creatCookie(String token){

        Cookie cookie = new Cookie(NAME,token);
        cookie.setMaxAge(7*24*60*60);

        cookie.setPath("/");

        return cookie;
    }

    public static Cookie deleteCookie(){

        Cookie cookie = new Cookie(NAME,null);

        cookie.setMaxAge(0);

        cookie.setPath("/");

        return cookie;
    }
}
