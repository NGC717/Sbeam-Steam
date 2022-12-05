package com.sbeam.controller;

import com.sbeam.bean.Game;
import com.sbeam.bean.PromotionGame;
import com.sbeam.bean.User;
import com.sbeam.service.GameService;
import com.sbeam.service.impl.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/promotion")
public class PromotionController {

    @Autowired
    private RedisService redisService;

    @Autowired
    private GameService gameService;

    @RequestMapping("/game")
    public String getPromotionGames(HttpSession session,Model model){

        User user = (User) session.getAttribute("loginUser");

        List<PromotionGame> games = gameService.selectPromotionGame();
        Map<Object, Object> promotion = redisService.hmget("promotion");

        for (PromotionGame game : games) {

            String gId = String.valueOf(game.getGId());

            Integer leaveNum = Integer.parseInt(promotion.get(gId).toString());

            game.setGResidue(leaveNum);

            //查询该游戏是否在玩家库中
            Integer temp = gameService.selectGameByUserIdWithGameId(user.getUId(),game.getGId());

            if (temp != null){
                //已获得游戏
                game.setState(1);
            }
        }

        model.addAttribute("games",games);

        return "seckill";
    }

    @ResponseBody
    @RequestMapping("/getNum/{gId}")
    public String getNum(@PathVariable Integer gId){
        Map<Object, Object> promotion = redisService.hmget("promotion");

        String id = String.valueOf(gId);

        String num = (String) promotion.get(id);

        return num;
    }
}
