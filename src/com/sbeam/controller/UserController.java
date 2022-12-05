package com.sbeam.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.sbeam.bean.*;
import com.sbeam.service.GameService;
import com.sbeam.service.UserService;
import com.sbeam.service.impl.RedisService;
import com.sbeam.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
@MultipartConfig
@RequestMapping("/user")
public class UserController extends ControllerUtil {

    private static Email email = new Email();

    @Autowired
    private RedisService redisService;

    @Autowired
    private UserService userService;

    @Autowired
    private GameService gameService;

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/register")
    public String register(){
        return "register";
    }

    @RequestMapping("/checkCode")
    public String checkCode(User user,Model model){

        //邮箱是否有效
        if (Email.isEmailValid(user.getUEmail())){
            email.setRegisterEmail(user.getUEmail());
        }else {
            model.addAttribute("emailIsValid",true);
            return "registerEmail";
        }

        String uEmail = userService.selectUserByEmail(user.getUEmail());

        //邮箱是否已注册
        if (uEmail != null ){
            model.addAttribute("emailIsRegistered",true);
            return "registerEmail";
        }

        try {
            email.sent();
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("insertUser",user);

        return "checkCode";

    }

    @RequestMapping("codeRight")
    public String doRegister(String checkCode,String e,String c,Model model){

        User user = new User();

        user.setUEmail(e);

        user.setUCountry(c);

        model.addAttribute("insertUser",user);

        if (!checkCode.equals(email.getCheckCode())){
            model.addAttribute("isCheckCodeRight",false);
            return "checkCode";
        }else {
            return "register";
        }
    }

    @RequestMapping("/doIndex")
    public String doIndex(HttpSession session,HttpServletRequest request,Model model) {

        User user = (User) request.getAttribute("loginUser");

        if (user != null){

            User temp = userService.selectUserByName(user.getUName());

            //头像路径
            Resources.setTheAvatarPath(temp);

            session.setAttribute("loginUser",temp);

            Map<String,Object> userMap = new HashMap<>();

            userMap.put(String.valueOf(user.getUId()), user.getUName());

            //设置2小时失效
            redisService.hmset("onlineUserMap",userMap,2*60*60);
        }

        PageBean pageBean = new PageBean();

        pageBean.setCurrentPage(1);

        List<Game> recommendGames = gameService.selectGamesOrderByDownloadNum();

        List<Game> popularGoods = gameService.selectAllGamesPage(pageBean);

        Resources.setTheResourcePath(recommendGames);
        Resources.setTheResourcePath(popularGoods);

        model.addAttribute("recommendGames", recommendGames);

        pageBean.setList(popularGoods);
        pageBean.setOffset(0);
        pageBean.setLimit(8);

        model.addAttribute("pageBean", pageBean);

        List<Game> newGames = gameService.selectGamesOrderByUploadTime();
        model.addAttribute("newGames", newGames);

        //获取当前促销商品
        List<PromotionGame> promotionGames = gameService.selectPromotionGame();

        model.addAttribute("promotionGames",promotionGames);

        return "sbeamIndex";
    }

    @RequestMapping("/registerEmail")
    public String registerEmail(){

        return "registerEmail";
    }

    @RequestMapping("/doRegister")
    public String doRegister(User user,Model model){

        User temp = userService.selectUserByName(user.getUName());

        if (temp != null){
            model.addAttribute("isRegistered",true);
            return "register";
        }

        userService.insertUser(user);
        return "forward:/user/doIndex";
    }

    @RequestMapping("/doLogin")
    public String doLogin(HttpSession session,String name, String password, Model model, HttpServletRequest request, HttpServletResponse response){

        User user = userService.selectUserByNameAndPassword(name, password);

        if (user == null){
            //登陆失败，返回登录页面
            model.addAttribute("isLoginSuccess",false);
            return "login";
        }else {

            session.setAttribute("loginUser",user);

            Resources.setTheAvatarPath(user);

            String token = null;

            try {

                token = JWTUtil.createToken(user.getUId(), user.getUName(),user.getUserData().getAvatarPath(),"JWT");

                response.addCookie(CookieUtil.creatCookie(token));

            } catch (Exception e) {
                e.printStackTrace();
            }

            return "forward:/user/doIndex";
        }

    }

    @RequestMapping("/exit")
    public String exit(HttpServletResponse response,HttpSession session){

        //删除当前登录用户的session中的内容
        session.setAttribute("loginUser",null);
        session.setAttribute("publisher",null);

        Cookie cookie = CookieUtil.deleteCookie();

        response.addCookie(cookie);

        return "forward:/user/doIndex";
    }

    @RequestMapping("/about")
    public String about(){
        return "about";
    }

    @RequestMapping("/userinfo")
    public String userinfo(HttpSession session){

        return "/userinfo";
    }


    @RequestMapping("/uploadAvatar")
    public String uploadAvatar(MultipartFile avatar,HttpSession session) throws IOException {

        Resources.uploadAvatar(avatar, session);

        return "forward:/user/userinfo";
    }


    @RequestMapping("/addGameToCart/{Gid}")
    public String addGameToCart(@PathVariable Integer Gid,HttpSession session){

        User user = (User) session.getAttribute("loginUser");

        if (user == null){
            return "forward:/user/login";
        }

        Cart cart = userService.selectGameByGameIdAndUserIdFromCart(Gid, user.getUId());

        if (cart == null){

            userService.addGameToCart(user.getUId(),Gid);
        }

        return "forward:/user/selectCartByUserId";

    }

    @RequestMapping("/selectCartByUserId")
    public String selectCartByUserId(HttpSession session,Model model){

        Resources.getPayInfo(session,model);

        return "shopCart";
    }

    @RequestMapping("/removeGameFromCart/{gId}")
    public String removeGameFromCart(@PathVariable Integer gId,HttpSession session){

        User user = (User) session.getAttribute("loginUser");

        userService.deleteGameFromCartByGameIdAndUserId(gId,user.getUId());

        return "forward:/user/selectCartByUserId";
    }

    //跳转到用户充值界面
    @RequestMapping("/addCredit/{flag}")
    public String addCredit(@PathVariable Integer flag, Model model, HttpSession session, HttpServletRequest request) throws UnsupportedEncodingException, JsonProcessingException {

//            ObjectMapper mapper = new ObjectMapper();
//
//            Cookie[] cookies = request.getCookies();
//
//            if (cookies != null && cookies.length > 0){
//                for (Cookie cookie : cookies) {
//                    if ("loginUser".equals(cookie.getName())){
//
//                        String userJson = cookie.getValue();
//
//                        userJson = URLDecoder.decode(userJson,"GBK");
//
//                        user = mapper.readValue(userJson,User.class);
//
//                        session.setAttribute("loginUser",user);
//
//                    }
//
//                }
//            }
        if (flag == 1){
            model.addAttribute("balanceNotEnough",true);
        }
        return "addCredit";
    }

    //使用账户余额付款
    @RequestMapping("/pay")
    public String pay(HttpSession session,Model model){

        User loginUser = (User) session.getAttribute("loginUser");

        List<Cart> carts = userService.selectCartByUserId(loginUser.getUId());

        Integer totalPay = 0;

        for (Cart cart : carts) {

            Resources.setTheResourcePath(cart.getGame());
            totalPay += cart.getGame().getGPrice();
        }

        Integer uBalance = loginUser.getUBalance();

        if (uBalance > totalPay){

            model.addAttribute("carts",carts);
            model.addAttribute("totalPay",totalPay);
            return "pay";

        }else {

            return "forward:/user/addCredit/1";
        }

    }

    @RequestMapping("/doPay")
    public String doPay(HttpSession session){

        HashMap payInfo = Resources.getPayInfo(session);

        Integer totalPay = (Integer) payInfo.get("totalPay");

        List<Cart> carts = (List<Cart>) payInfo.get("carts");

        User user = (User) payInfo.get("user");

        Integer balance = user.getUBalance();
        Integer temp = balance - totalPay;

        userService.updateUserBalanceWithBalanceAndUserId(user.getUId(), temp);

        for (Cart cart : carts) {

            userService.insertGameToInventoryWithUserIdAndGameId(user.getUId(),cart.getGame().getGId());
            userService.deleteGameFromCartByGameIdAndUserId(cart.getGame().getGId(),user.getUId());
        }

        return "paySuccess";

    }

    @RequestMapping("/inventory")
    public String inventory(HttpSession session,Model model){

        User loginUser = (User) session.getAttribute("loginUser");
        List<Game> games = userService.selectInventoryByUserId(loginUser.getUId());
        model.addAttribute("games",games);
        return "inventory";
    }

    @RequestMapping("/comment/{gId}")
    public String comment(@PathVariable Integer gId, Model model){

        model.addAttribute("gId",gId);

        return "gameComment";
    }

    @RequestMapping("/doComment")
    public String doComment(Comment comment,HttpSession session){

        User loginUser = (User) session.getAttribute("loginUser");

        comment.setUId(loginUser.getUId());

        userService.insertGameCommentWithComment(comment);

        return "forward:/user/inventory";
    }

    @RequestMapping("/friend")
    public String friend(HttpSession session,Model model){

        User user = (User) session.getAttribute("loginUser");

        List<User> friends = userService.selectAllFriends(user.getUId());

        if (friends != null){
            Resources.setTheAvatarPath(friends);
        }
        Resources.setTheAvatarPath(friends);

        Map<Object, Object> onlineUserMap = redisService.hmget("onlineUserMap");

        for (User friend : friends) {

            for (Object o : onlineUserMap.keySet()) {

                if (Integer.parseInt((String) o) == friend.getUId()){
                    friend.setIsOnline(1);
                }
            }
        }

        model.addAttribute("friends",friends);

        List<User> waitForPassing = userService.selectWaitForPassingByUserId(user.getUId());

        if (waitForPassing != null){
            Resources.setTheAvatarPath(waitForPassing);
        }
        model.addAttribute("waitForPassing",waitForPassing);

        return "friend";
    }

    @RequestMapping("/selectAllFriends")
    public String selectAllFriends(HttpSession session,Model model){

        User user = (User) session.getAttribute("loginUser");

        List<User> friends = userService.selectAllFriends(user.getUId());
        model.addAttribute("friends",friends);

        List<User> waitForPassing = userService.selectWaitForPassingByUserId(user.getUId());
        model.addAttribute("waitForPassing",waitForPassing);

        return "friend";
    }

    @RequestMapping("/selectFriendByName")
    public String selectFriendByName(HttpSession session,String friendName,Model model){

        User user = (User) session.getAttribute("loginUser");

        User friend = userService.selectUserByName(friendName);

        Integer fid = null;

        if (friend == null){
            model.addAttribute("isExists",false);

        }else {

            Resources.setTheAvatarPath(friend);
            fid = userService.selectFriendIdByFId(user.getUId(),friend.getUId());
        }

        if (fid != null){
            model.addAttribute("wasFriend",true);
        }

        List<User> friends = userService.selectAllFriends(user.getUId());

        Resources.setTheAvatarPath(friends);

        model.addAttribute("friend",friend);
        model.addAttribute("friends",friends);

        return "forward:/user/friend";
    }

    @RequestMapping("/addFriend/{fId}")
    public String addFriend(@PathVariable Integer fId,HttpSession session){

        User user = (User) session.getAttribute("loginUser");

        //用户添加对方为好友,相当于在对方好友表中添加当前用户为好友

        userService.insertFriend(fId, user.getUId());

        return "forward://user/friend";
    }

    @RequestMapping("/friendReqPass/{fId}")
    public String friendReqPass(@PathVariable Integer fId,HttpSession session){

        User user = (User) session.getAttribute("loginUser");

        userService.updateFriendIsPass(user.getUId(),fId);
        userService.insertFriendWithIsPass(fId,user.getUId(),1);

        return "forward://user/friend";
    }

    @RequestMapping("/friendReqRefuse/{fId}")
    public String friendReqRefuse(@PathVariable Integer fId,HttpSession session){

        User user = (User) session.getAttribute("loginUser");

        userService.deleteFriendReq(user.getUId(),fId);

        return "forward://user/friend";
    }

    @RequestMapping("/chatWithFriend/{uId}")
    public String chatWithFriend(@PathVariable Integer uId,HttpSession session,Model model){

        User user = (User) session.getAttribute("loginUser");
        //取出用户登录时的名称，存入model，用于前端分别是用户自己还是其他
        Resources.setTheAvatarPath(user);

        model.addAttribute("userName",user.getUName());
        model.addAttribute("userAvatar",user.getUserData().getAvatarPath());

        return "chat";
    }

}
