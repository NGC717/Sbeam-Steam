package com.sbeam.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.sbeam.bean.User;
import com.sbeam.bean.UserSession;
import com.sbeam.service.UserService;
import com.sbeam.util.AlipayConfig;
import com.sbeam.util.ControllerUtil;
import com.sbeam.util.Resources;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RequestMapping("/pay")
@Controller
public class PayController extends ControllerUtil {

    @Autowired
    UserService userService;

    @RequestMapping("/addCredit/{grade}")
    @ResponseBody
    public String addCredit(@PathVariable Integer grade, HttpSession session, HttpServletResponse response, Model model) throws AlipayApiException, IOException {

        User user = (User) session.getAttribute("loginUser");

        /**
         * 在tomcat中设置的访问地址是127.0.0.1
         * 但是需要进行支付宝沙箱支付，必须提供外界可访问的地址
         * 所以使用了花生壳的内网穿透，但是由于这两次域名不同
         * 之前保存在session中的用户信息丢失，则采取保存在数据库中的保存方法
         * 当支付完成完成回调时，再从数据库读取用户信息，并重新注入到session当中
         */
        userService.updateUserSessionWithUser(user);

        //充值金额
        int money = 0;

        switch (grade) {
            case 1:
                money = 30;
                break;
            case 2:
                money = 60;
                break;
            case 3:
                money = 150;
                break;
            case 4:
                money = 300;
                break;
            case 5:
                money = 600;
                break;
        }

        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);

        //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        //	request.getParameter("WIDout_trade_no").getBytes("ISO-8859-1"),"UTF-8"
        long out_trade_no = System.currentTimeMillis();
        //付款金额，必填
        //	request.getParameter("WIDtotal_amount").getBytes("ISO-8859-1"),"UTF-8"
        String total_amount = new String("" + money);
        //订单名称，必填
        //	request.getParameter("WIDsubject").getBytes("ISO-8859-1"),"UTF-8"
        String subject = new String("sbeam账户余额充值");
        //商品描述，可空
        //	request.getParameter("WIDbody").getBytes("ISO-8859-1"),"UTF-8"
        String body = new String("为您的账户充值");

        alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\","
                + "\"total_amount\":\"" + total_amount + "\","
                + "\"subject\":\"" + subject + "\","
                + "\"body\":\"" + body + "\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        //若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
        //alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
        //		+ "\"total_amount\":\""+ total_amount +"\","
        //		+ "\"subject\":\""+ subject +"\","
        //		+ "\"body\":\""+ body +"\","
        //		+ "\"timeout_express\":\"10m\","
        //		+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
        //请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节

        response.setContentType("text/html;charset=UTF-8");

        String head = "<html><head><meta http-equiv='Content-Type' content='text/html;charset=UTF-8'></head>";

        String result = alipayClient.pageExecute(alipayRequest).getBody();

        String bottom = "<body></body></html>";

        //输出
        response.getWriter().println(head + result + bottom);

        return null;
    }

    @RequestMapping("/return_url")
    public String returnUrl(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, AlipayApiException {

        Map<String, String> params = new HashMap<String, String>();

        Map<String, String[]> requestParams = request.getParameterMap();

        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext(); ) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用
            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            params.put(name, valueStr);
        }

        boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type);
        //调用SDK验证签名

        //——请在这里编写您的程序（以下代码仅作参考）——
        if (signVerified) {//验证成功
            //验证成功

            User user = new User();

            //从数据库取出用户信息，重新保存到session中
            UserSession userSession = userService.selectUserSession();

            //充值成功，在数据库中更新用户余额

            user.setUId(userSession.getUId());
            user.setUName(userSession.getUName());
            user.setUBalance(userSession.getUBalance());
            user.setUPassword(userSession.getUPassword());

            String total_amount = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"), "UTF-8");

            float num = Float.parseFloat(total_amount);
            int money = (int) num;

            int balance = userService.selectBalanceByUserId(user.getUId());

            userService.updateUserBalanceWithBalanceAndUserId(user.getUId(), (balance + money));

            User temp = userService.selectUserByNameAndPassword(userSession.getUName(), userSession.getUPassword());
            Resources.setTheAvatarPath(temp);
            session.setAttribute("loginUser", temp);

            return "forward:/user/addCredit/2";

        } else {
            //验证失败

            //调试用，写文本函数记录程序运行情况是否正常

        }

        return "return_url";
    }

    @RequestMapping("/notify_url")
    public String notifyUrl(HttpServletRequest request) throws UnsupportedEncodingException, AlipayApiException {

        return null;
    }

}
