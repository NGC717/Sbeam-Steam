package com.sbeam.util;

import com.sun.mail.util.MailSSLSocketFactory;
import org.apache.commons.net.smtp.SMTPClient;
import org.apache.commons.net.smtp.SMTPReply;
import org.xbill.DNS.Lookup;
import org.xbill.DNS.Record;
import org.xbill.DNS.Type;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Properties;

public class Email {

//    public static final String SENDER_EMAIL = "no-reply@domain.com";//"no-reply@domain.com";
//    public static final String SENDER_EMAIL_SERVER = SENDER_EMAIL.split("@")[1];//"domain.com";

    private static String registerEmail = "";

    private static String checkCode = "";

    private Session session;
    private Transport ts;

    public void setRegisterEmail(String registerEmail) {
        Email.registerEmail = registerEmail;
    }

    public String getCheckCode() {
        return checkCode;
    }

    private void setEmailConfig() throws MessagingException, GeneralSecurityException {
        Properties prop = new Properties();
        // 开启debug调试，以便在控制台查看
        prop.setProperty("mail.debug", "true");
        // 设置邮件服务器主机名
        prop.setProperty("mail.host", "smtp.qq.com");
        // 发送服务器需要身份验证
        prop.setProperty("mail.smtp.auth", "true");
        // 发送邮件协议名称
        prop.setProperty("mail.transport.protocol", "smtp");
        // 开启SSL加密，否则会失败
        MailSSLSocketFactory sf = new MailSSLSocketFactory();
        sf.setTrustAllHosts(true);
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.socketFactory", sf);
        // 创建session
        session = Session.getInstance(prop);
        // 通过session得到transport对象
        ts = session.getTransport();
        // 连接邮件服务器：邮箱类型，帐号，POP3/SMTP协议授权码 163使用：smtp.163.com
        ts.connect("smtp.qq.com", Resources.getQQAccount(), Resources.getAuthorizationCode());
    }

    public void sent() throws Exception {

        setEmailConfig();

        // 创建邮件
        MimeMessage message = createSimpleMail(session);
        // 发送邮件
        ts.sendMessage(message, message.getAllRecipients());
        ts.close();
    }

    public void sent(String content) throws Exception {

        setEmailConfig();

        // 创建邮件
        MimeMessage message = createSimpleMail(session, content);
        // 发送邮件
        ts.sendMessage(message, message.getAllRecipients());
        ts.close();
    }

    /**
     * @Method: createSimpleMail
     * @Description: 创建邮件内容
     */
    public static MimeMessage createSimpleMail(Session session) throws Exception {
        //  获取5位随机验证码
        String[] letters = new String[]{
                "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m",
                "A", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M",
                "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};

        for (int i = 0; i < 5; i++) {
            checkCode = checkCode + letters[(int) Math.floor(Math.random() * letters.length)];
        }

        checkCode = checkCode.substring(checkCode.length() - 5);
        // 创建邮件对象
        MimeMessage message = new MimeMessage(session);
        // 指明邮件的发件人
        message.setFrom(new InternetAddress(Resources.getEmailAccount()));
        // 指明邮件的收件人，发件人和收件人如果是一样的，那就是自己给自己发
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(registerEmail));
        // 邮件的标题
        message.setSubject("验证您的邮箱");
        // 邮件的文本内容
        // message.setContent("欢迎您注册Sbeam"+"\r"+"账号注册验证码为:"+checkCode+"\r"+"请勿回复此邮箱", "text/html;charset=UTF-8");
        message.setContent("" +
                "<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "</head>\n" +
                "<body>\n" +
                "<h1>欢迎注册Sbeam</h1>\n" +
                "<h1>您的邮箱验证码为：" + checkCode + "</h1>\n" +
                "<h1>请勿回复此邮件</h1>\n" +
                "</body>\n" +
                "</html>", "text/html;charset=UTF-8");

        // 返回创建好的邮件对象
        return message;
    }

    public static MimeMessage createSimpleMail(Session session, String content) throws Exception {

        // 创建邮件对象
        MimeMessage message = new MimeMessage(session);
        // 指明邮件的发件人
        message.setFrom(new InternetAddress(Resources.getEmailAccount()));
        // 指明邮件的收件人，发件人和收件人如果是一样的，那就是自己给自己发
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(registerEmail));
        // 邮件的标题
        message.setSubject("验证您的邮箱");
        // 邮件的文本内容
        // message.setContent("欢迎您注册Sbeam"+"\r"+"账号注册验证码为:"+checkCode+"\r"+"请勿回复此邮箱", "text/html;charset=UTF-8");
        message.setContent("" +
                "<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "</head>\n" +
                "<body>\n" +
                "<h1>" + content + "</h1>\n" +
                "<h1>请勿回复此邮件</h1>\n" +
                "</body>\n" +
                "</html>", "text/html;charset=UTF-8");

        // 返回创建好的邮件对象
        return message;
    }


    /**
     * @param email 待校验的邮箱地址
     * @return
     */
    public static boolean isEmailValid(String email) {
        if (!email.matches("[\\w\\.\\-]+@([\\w\\-]+\\.)+[\\w\\-]+")) {
            return false;
        }
        String host = "";
        String hostName = email.split("@")[1];
        //Record: A generic DNS resource record. The specific record types
        //extend this class. A record contains a name, type, class, ttl, and rdata.
        Record[] result = null;
        SMTPClient client = new SMTPClient();
        try {
            // 查找DNS缓存服务器上为MX类型的缓存域名信息
            Lookup lookup = new Lookup(hostName, Type.MX);
            lookup.run();
            if (lookup.getResult() != Lookup.SUCCESSFUL) {//查找失败
                return false;
            } else {//查找成功
                result = lookup.getAnswers();
            }
            //尝试和SMTP邮箱服务器建立Socket连接
            for (int i = 0; i < result.length; i++) {
                host = result[i].getAdditionalName().toString();

                //此connect()方法来自SMTPClient的父类:org.apache.commons.net.SocketClient
                //继承关系结构：org.apache.commons.net.smtp.SMTPClient-->org.apache.commons.net.smtp.SMTP-->org.apache.commons.net.SocketClient
                //Opens a Socket connected to a remote host at the current default port and
                //originating from the current host at a system assigned port. Before returning,
                //_connectAction_() is called to perform connection initialization actions.
                //尝试Socket连接到SMTP服务器
                client.connect(host);
                //Determine if a reply code is a positive completion response（查看响应码是否正常）.
                //All codes beginning with a 2 are positive completion responses（所有以2开头的响应码都是正常的响应）.
                //The SMTP server will send a positive completion response on the final successful completion of a command.
                if (!SMTPReply.isPositiveCompletion(client.getReplyCode())) {
                    //断开socket连接
                    client.disconnect();
                    continue;
                } else {
                    break;
                }
            }

            String emailSuffix="163.com";

            String emailPrefix="ranguisheng";

            String fromEmail = emailPrefix+"@"+emailSuffix;
            //Login to the SMTP server by sending the HELO command with the given hostname as an argument.
            //Before performing any mail commands, you must first login.
            //尝试和SMTP服务器建立连接,发送一条消息给SMTP服务器
            client.login(emailPrefix);


            //Set the sender of a message using the SMTP MAIL command,
            //specifying a reverse relay path.
            //The sender must be set first before any recipients may be specified,
            //otherwise the mail server will reject your commands.
            //设置发送者，在设置接受者之前必须要先设置发送者
            client.setSender(fromEmail);

            //Add a recipient for a message using the SMTP RCPT command,
            //specifying a forward relay path. The sender must be set first before any recipients may be specified,
            //otherwise the mail server will reject your commands.
            //设置接收者,在设置接受者必须先设置发送者，否则SMTP服务器会拒绝你的命令
            client.addRecipient(email);

            if (250 == client.getReplyCode()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                client.disconnect();
            } catch (IOException e) {
            }
        }
        return false;
    }

}
