package com.sbeam.util;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {

//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "2021000117694820";

    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCUpUwoM8ZdB0oqNJEehlmmQ8yo77hViIcrj/5dcnFyDsxJOktWTRK6j5sJczr+TDRZhAEeziW6C/bHrYeblvgnTYq9USyBDVZh0WQg/Z7OCTR6FTT/oB+HaqQMySyg5B0almyjWcn229K5n0L8JQQyffIcPLz0zkn4D/ppl3cWFpjzehkEYlXf8TLT3K6LwflBxW5ssMMjcFzC+JkahqfMzjD0Mo8mVBGuHZtJFDI893WCs+jQhpIs2Ni4vWSFiQ2WnShQ/lpXLBpGgzthbdkmE+d/El5f3uAOddAkE5cxuUiJD9XZhgan7TCu+fgwnIwhkM6t1zE4Spko+FhoLiSfAgMBAAECggEAYareiEfEnVlt1J9nfqv9+a3wqkugTasATZI2KsZIXg31EmRYHeNUW/qBfssUxwPhHbQLXGdNCJpV0stlH8kpUgG0GEJewIi36lu/s6GRF4Wa0mBey1s1fC+IjNIeHbTknpSZ2xbjCe1T3x0S0UOtJ1PzobQS37MvjOtKuNiJqZu3LbYRtH64w7tCWP4wE+3wnS3WhiUZuBRgCpOjk8SefYARlquRrxnRElrDJsrsIGZ512KTCwvK94Hx5Smuk3WSF0fbKGIX9U0xiHToDxuXc4M/r5ATT5IKHFn4X2C7l34N2m/wK1QUhsKPHyTAd980y6AKKhOVyyD4W/ThPMCtqQKBgQDxuzHnEkpqYCaiUs9KKPUT0xfqajltB+dHzHIb+nz2ML2iFSEkYZM0BYCwofVec5uiAptqN16gwz6kQcbIKp3WfQGpZgzDCPjC63+tMBD/a7CGmov4OU7dUiGwW0tc+OlJ+3M8H+JSKcgDDwDEV+exoor8Uozc8XmwcRnHVeoecwKBgQCda3w8UogVbtLtvq53jtvsDe5lU8pxbhHyvliy9IfhyaLafPGoDt+TtQPsbtshpaMhNYGthlvWWtLPtQ/a4mfeLL6uk+ypGkUEUSwV9DnQHsi8CxqXl4Et/tjrpOQmysoZyl2PvGJ1fO6S11o11ZrmPRlYtUzKjiDd/OPbTCvKJQKBgQDEJizxHqNpvAm9b8qql59+ba0bVwSwF1ixpxD06QYbUyOdcN3Kwq6K6Ogq69DJyq9///OSdcmAU83xxToC1KntENSXW6qBXDdXG3cn1jgEuqKsJp3rVr1K08lobDwz/fp3QOWZ5RllqGeXK8ZojBgCyS1UX7vT0NH4vV24pVtrRwKBgB8TuyEFggwJJub8f+DmeRAu5+NlGVAvVKfBYC1kDPdMITRU+jgdR5IXaEDi2avY0U2bDJC/N54nq/qJWinyDGNWHgbE+TGhGAL0K2niHw+xJBvLbWKD7GKyLwzGLqxh2GgjBTl9DUr4cPjYPtzl4ICXi0tx70kFqgNpC2qdrP9pAoGBAKahmUoa10zqsOKL3yA3a3fR2UkqZH+DGZFRP+5yB2FmfX9ebUDv3zvpBqg+bchfLxI8pfqbPONIJLJ5NNTWA8xbxqq8BYXTWUS7jSJFmNrVAIySURNB4NQdfXvK9mnK+Q5BhsUlvT1nYRNOgKyU3wN7w1viqnD9Evcf77/X63rb";

    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAn0TtL9d/6eccDNJ9+XjV8xu42J0vEBdJidCOJLSTnYsc4lgmRo1NMEaFoz2IDN+P0Sn+3qXS2OoZhJgFZ/MZdWIUwqN7vasZPT/EtoI4CL962MmB0FJ7rxnMtg+lyMDiWKxlr9RSYWKulRokPQY2wVJ8hc2h4Zh3E86OIzb5jBz2/OmvBACpQcyGZSPqI1MmSJv9R4QssD6D3r9SUjeyKXXvNaxHk5Xu6tXXXWHyb0AETnnt11Y36O85TvCnKkH4dFooH/zIjKUIYeat/PEgXTlbWAVDeHwxjsoWSKH2j9JbEfloy/q/cAUT+tacmVb8qyrPJU1USQqA0FqWbfS4yQIDAQAB";

    // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String notify_url = "http://3935f12124.imdo.co:80/pay/notify_url";

    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String return_url = "http://3935f12124.imdo.co:80/pay/return_url";

    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

    // 支付宝网关
    public static String log_path = "D:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /**
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

