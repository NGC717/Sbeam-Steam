package com.sbeam.util;

import org.junit.Test;

public class EmailTest {

    @Test
    public void smtpVerify() {

        Boolean aBoolean = Email.isEmailValid("391877174@qq.com");

        System.out.println(aBoolean);
    }
}