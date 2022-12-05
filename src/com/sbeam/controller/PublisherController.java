package com.sbeam.controller;

import com.sbeam.bean.*;
import com.sbeam.service.GameService;
import com.sbeam.service.PublisherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/publish")
public class PublisherController {

    @Autowired
    PublisherService publisherService;

    @Autowired
    GameService gameService;
    
    @RequestMapping("/register")
    public String register(Publisher publisher){

        publisherService.insertPublisher(publisher);

        return "waitPass";
    }

    @RequestMapping("/cooperation")
    public String isLogin(HttpSession session, Model model){
        //查询用户是否登录
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser != null){

            //用户已经登录，查询是否已经注册发行商
            Publisher publisher = publisherService.selectPublisherByUserId(loginUser.getUId());

            if (publisher != null){
                switch (publisher.getPIsPass()){
                    case 1:
                        //若已申请成为发行商且通过审核，跳转到上传游戏界面
                        session.setAttribute("publisher",publisher);
                        return "forward:/publish/publisherIndex";
                    case 0:
                        //已申请成为发行商但尚未审核，跳转到等待审核界面
                        return "waitPass";
                }
            }

            //未申请成为发行商或未通过审核，跳转到申请界面
            return "applyNeedKnow";

        }else {
            //提醒用户登录标志
            model.addAttribute("isLogFlag",false);
            return "login";
        }
    }

    @RequestMapping("/publishGame")
    public String publishGame(){
        return "uploadGameInfo";
    }

    @RequestMapping("/publisherIndex")
    public String publisherIndex(HttpSession session,Model model){

        Publisher publisher = (Publisher) session.getAttribute("publisher");

        List<Game> games = gameService.selectAllGamesByPublisherId(publisher.getPId());

        model.addAttribute("games",games);

        return "publisherIndex";

    }

    @RequestMapping("/stopCooperation/{DId}")
    public String stopCooperation(@PathVariable("DId") Integer DId){

        publisherService.deleteDeveloperByDeveloperId(DId);

        return "forward:/publish/publisherIndex";
    }

    //游戏发行商上传游戏信息及配置要求信息
    @RequestMapping("/uploadGameConfiguration")
    public String uploadGameConfiguration(
            LowDeviceConfiguration lowConfig,
            RecommendDeviceConfiguration recommendConfig,
            String gName,String dName,Integer gPrice,
            Model model,HttpSession session){

        Publisher publisher = (Publisher) session.getAttribute("publisher");

        Developer developer = publisherService.selectDeveloperByDeveloperName(dName.trim());
        if (developer == null){

            developer = new Developer(null,dName,publisher.getPId());
            publisherService.insertDeveloper(developer);
        }

        Game game = new Game(gName,developer.getDId());
        game.setPId(publisher.getPId());
        game.setGPrice(gPrice);

        gameService.insertGame(game);

        LowDeviceConfiguration ldc = lowConfig;
        ldc.setGId(game.getGId());

        RecommendDeviceConfiguration rdc = recommendConfig;
        rdc.setGId(game.getGId());

        publisherService.insertLowDeviceConfiguration(ldc);
        publisherService.insertRecommendDeviceConfiguration(rdc);

        model.addAttribute("gId",game.getGId());

        return "uploadFile";
    }

    @RequestMapping("/applyNeedKnow")
    public String applyNeedkonw(){

        return "applyNeedKnow";
    }


    @RequestMapping("/joinSbeam")
    public String joinSbeam(){
        return "joinSbeam";
    }

    @RequestMapping("/banGame/{gId}")
    public String banGame(@PathVariable Integer gId){

        gameService.updateGameIsNotPublishByGId(gId);

        return "forward:/publish/cooperation";
    }

    @RequestMapping("/uploadGameIsPublish/{gId}")
    public String uploadGameIsPublish(@PathVariable Integer gId){

        gameService.updateGameIsPublishByGId(gId);

        return "forward:/publish/cooperation";
    }
}
