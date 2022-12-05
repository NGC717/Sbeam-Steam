package com.sbeam.controller;

import com.sbeam.bean.Game;
import com.sbeam.bean.PromotionGame;
import com.sbeam.bean.Publisher;
import com.sbeam.service.GameService;
import com.sbeam.service.OfficialService;
import com.sbeam.service.UserService;
import com.sbeam.service.impl.RedisService;
import com.sbeam.util.Email;
import com.sbeam.util.Notification;
import com.sbeam.util.Resources;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 该controller用于sbeam管理后台，只能通过地址栏输入http:127.0.0.1:8080/root/login访问
 * 没有页面跳转到该后台的方式，跳转后需使用t_root中的密码登录,进入后对游戏发行商的各种请求进行处理
 * 处理结果将通过邮件告知
 */
@Controller
@RequestMapping("/root")
public class SbeamOfficialController {

    private Email email = new Email();
    @Autowired
    OfficialService officialService;

    @Autowired
    UserService userService;

    @Autowired
    RedisService redisService;

    @Autowired
    GameService gameService;

    @RequestMapping("/login")
    public String rootLogin(){
        return "doRootLogin";
    }

    @RequestMapping("/doRootLogin")
    public String rootLogin(String rootPwd,Model  model){

        Integer id = officialService.selectRootByPwd(rootPwd);

        if (id > 0){
            return "forward://root/selectGamesAndPublishers";
        }else {

            return "doRootLogin";
        }
    }

    @RequestMapping("/selectGamesAndPublishers")
    private String selectGamesAndPublishers(Model model){
        List<Game> games = officialService.selectAllGamesWaitForCheck();

        List<Publisher> publisherList = officialService.selectAllPublishersWaitForPass();

        model.addAttribute("games",games);
        model.addAttribute("publisherList",publisherList);

        return "SbeamOfficialIndex";
    }



    @RequestMapping("/gameInfo/{gId}")
    public String gameInfo(@PathVariable Integer gId, Model model){
        Game game = officialService.selectGameAllInfoByGId(gId);
        Resources.setTheResourcePath(game);
        model.addAttribute("game",game);
        return "AllInfoOfGame";
    }

    //发行商申请通过
    @RequestMapping("/publisherPass/{pId}")
    public String publisherPass(@PathVariable Integer pId,Model model){

        String em = userService.selectUserByPId(pId);

        officialService.updatePublisherIsPass(pId);

        email.setRegisterEmail(em);
        try {
            email.sent(Notification.PUBLISH_PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "forward://root/selectGamesAndPublishers";
    }

    //发行商申请未通过
    @RequestMapping("/publisherNotPass/{pId}")
    public String publisherNotPass(HttpSession session,@PathVariable Integer pId){

        String em = userService.selectUserByPId(pId);

        officialService.deletePublisherNotPass(pId);



        email.setRegisterEmail(em);
        try {
            email.sent(Notification.PUBLISH_NOT_PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "forward://root/selectGamesAndPublishers";
    }

    //游戏审核通过
    @RequestMapping("/updateGameIsCheck/{gId}")
    public String updateGameIsCheck(@PathVariable Integer gId){
        String em = userService.selectUserByGId(gId);

        officialService.updateGameIsCheck(gId);

        email.setRegisterEmail(em);
        try {
            email.sent(Notification.GAME_PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "forward://root/selectGamesAndPublishers";
    }

    //游戏审核未通过
    @RequestMapping("/deleteGame/{gId}")
    public String deleteGame(HttpSession session,@PathVariable Integer gId){

        String em = userService.selectUserByGId(gId);

        officialService.deleteGame(gId);

        email.setRegisterEmail(em);
        try {
            email.sent(Notification.GAME_NOT_PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "forward://root/selectGamesAndPublishers";
    }

    //设置促销游戏
    @RequestMapping("/setPromotionGame")
    public String setPromotionGame(){
        return "promotion";
    }

    //添加游戏到优惠名单
    @RequestMapping("/addRoll")
    public String addRoll(Integer gId,Integer gTotal,Integer gPrice,String gBeginTime) {

        String temp = gBeginTime.replace("T", " ") + ":00";

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("UTC"));

        String date = null;
        try {
            date = String.valueOf(sdf.parse(temp).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Map<String, Object> map = new HashMap<>();
        map.put(gId.toString(), gTotal.toString());

        PromotionGame game = new PromotionGame();
        game.setGId(gId);
        game.setGTotal(gTotal);
        game.setGPrice(gPrice);
        game.setGBeginTime(date);

        //保存游戏信息到redis，gId，gPrice
        Map<String, Object> gameInfo = new HashMap<>();
        gameInfo.put(gId.toString(),gPrice.toString());

        gameService.insertPromotion(game);

        redisService.hmset("game",gameInfo);

        redisService.hmset("promotion", map);

        return "forward:/root/getPromotion";
    }

    //获取当前优惠游戏信息
    @RequestMapping("/getPromotion")
    public String getPromotion(Model model){

        List<PromotionGame> games = gameService.selectPromotionGame();

        for (PromotionGame game : games) {

            Map<Object, Object> map = redisService.hmget("promotion");

            Integer gid = game.getGId();

            String sGId = String.valueOf(gid);

            game.setGName(gameService.selectNameByGId(gid));

            Integer leave = Integer.parseInt(map.get(sGId).toString());

            game.setGResidue(leave);

        }

        model.addAttribute("games",games);

        return "promotion";
    }

}
