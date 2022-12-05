package com.sbeam.util;

import com.sbeam.bean.*;
import com.sbeam.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

@Component
public class Resources {

    private static GameData gameData;//为game类注入游戏宣传图路径
    private static UserData userData;//为user类注入头像路径

    private static final String DATA_PATH = "/data";

    private static String FILE_PATH;//保存用户头像文件夹路径
    private static String GAME_PATH;//保存游戏文件（游戏宣传图）的文件夹路径
    private static String DATA_DIR_PATH;//保存发行商上传文件的文件夹的路径
    private static String EMAIL_ACCOUNT;//向用户发送验证码的邮箱地址
    private static String QQ_ACCOUNT;//向用户发送验证码的QQ
    private static String AUTHORIZATION_CODE;//OP3/SMTP协议授权码


    @Autowired
    private UserService UserService;

    private static UserService userService;

    public @PostConstruct void init(){
        userService = UserService;
    }

    static {

        Properties properties = new Properties();

        try {

            FileInputStream fis = new FileInputStream(new File("F:\\Q\\sbeam\\src\\data.properties"));

            properties.load(fis);

            DATA_DIR_PATH = properties.getProperty("PROJECT_PATH");

            FILE_PATH = properties.getProperty("PROJECT_PATH") + "/sbeam/web/data/avatar";
            GAME_PATH = properties.getProperty("PROJECT_PATH") + "/sbeam/web/data/gameFile";

            EMAIL_ACCOUNT = properties.getProperty("EMAIL_ACCOUNT");
            QQ_ACCOUNT = properties.getProperty("QQ_ACCOUNT");
            AUTHORIZATION_CODE = properties.getProperty("AUTHORIZATION_CODE");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getDataPath(){
        return DATA_DIR_PATH + "/sbeam/web/data";
    }

    public static String getEmailAccount(){
        return EMAIL_ACCOUNT;
    }

    public static String getQQAccount(){
        return QQ_ACCOUNT;
    }

    public static String getAuthorizationCode(){
        return AUTHORIZATION_CODE;
    }
    public static void setTheResourcePath(Game game){

        gameData = new GameData();

        gameData.setFilePath(GAME_PATH+"/"+game.getGId()+".exe");
        gameData.setHeadImg(DATA_PATH +"/gameImg/"+game.getGId()+"/headImg.png");
        gameData.setAnoImg1(DATA_PATH +"/gameImg/"+game.getGId()+"/anoImg1.png");
        gameData.setAnoImg2(DATA_PATH +"/gameImg/"+game.getGId()+"/anoImg2.png");
        gameData.setAnoImg3(DATA_PATH +"/gameImg/"+game.getGId()+"/anoImg3.png");
        gameData.setAnoImg4(DATA_PATH +"/gameImg/"+game.getGId()+"/anoImg4.png");

        game.setGameData(gameData);

    }

    public static void setTheResourcePath(List<Game> gameList){

        for (Game game : gameList) {

            setTheResourcePath(game);

        }

    }

    private static void setTheResourcePath(User user){

        userData = new UserData();

        userData.setAvatarPath(DATA_PATH +"/avatar/"+user.getUId()+".png");

        user.setUserData(userData);

    }

    private static void setDefaultAvatarPath(User user){
        userData = new UserData();
        userData.setAvatarPath(DATA_PATH +"/avatar/default.png");
        user.setUserData(userData);
    }

    public static void setTheAvatarPath(User user){

        setTheResourcePath(user);

        String avatarPath = FILE_PATH + "/"+user.getUId()+".png";

        File file = new File(avatarPath);

        if (!file.exists()){

            setDefaultAvatarPath(user);
        }
    }

    public static void setTheAvatarPath(List<User> user){

        for (User temp : user) {
            setTheAvatarPath(temp);
        }
    }

    public static User setTheAvatarPath(String userName){
        User user = userService.selectUserByName(userName);
        setTheAvatarPath(user);
        return user;
    }



    public static void uploadAvatar(MultipartFile avatar, HttpSession session) throws IOException {

        File file = new File(FILE_PATH+"/" + ((User) session.getAttribute("loginUser")).getUId()+".png");

        avatar.transferTo(file);
    }

    public static void getPayInfo(HttpSession session,Model model){

        HashMap map = getPayInfo(session);

        List<Cart> carts = (List<Cart>) map.get("carts");
        Integer totalPay = (Integer) map.get("totalPay");

        model.addAttribute("carts",carts);
        model.addAttribute("totalPay",totalPay);

    }

    public static HashMap getPayInfo(HttpSession session) {

        User user = (User) session.getAttribute("loginUser");

        List<Cart> carts = userService.selectCartByUserId(user.getUId());

        Integer totalPay = 0;

        for (Cart cart : carts) {
            setTheResourcePath(cart.getGame());
            totalPay += cart.getGame().getGPrice();
        }

        HashMap map = new HashMap();
        map.put("carts",carts);
        map.put("totalPay",totalPay);
        map.put("user",user);

        return map;
    }

    public static void setFilePath(Game game){
        gameData = new GameData();
        gameData.setFilePath(FILE_PATH+"/"+game.getGId()+".exe");

        game.setGameData(gameData);
    }

    public static String getCategory(Integer c){
        String category = "";
        switch (c){
            case 1:
                category = "免费游戏";
                break;
            case 2:
                category = "休闲";
                break;
            case 3:
                category = "体育";
                break;
            case 4:
                category = "冒险";
                break;
            case 5:
                category = "动作";
                break;
            case 6:
                category = "大型多人在线";
                break;
            case 7:
                category = "模拟";
                break;
            case 8:
                category = "独立";
                break;
            case 9:
                category = "竞速";
                break;

            case 10:
                category = "策略";
                break;
            case 11:
                category = "角色扮演";
                break;
        }

        return category;
    }
}

