package com.sbeam.controller;

import com.sbeam.bean.*;
import com.sbeam.service.GameService;
import com.sbeam.service.UserService;
import com.sbeam.util.Resources;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/game")
@MultipartConfig
public class GameController {

    @Autowired
    private GameService gameService;

    @Autowired
    UserService userService;

    @RequestMapping("/doUploadFile/{gId}")
    public String doUploadFile(@PathVariable Integer gId,HttpServletRequest request, Model model) {

        //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        //检查form中是否有enctype="multipart/form-data"
        if(multipartResolver.isMultipart(request))
        {
            //将request变成多部分request
            MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
            //获取multiRequest 中所有的文件名
            Iterator iter=multiRequest.getFileNames();

            while(iter.hasNext())
            {
                //一次遍历所有文件
                MultipartFile file = multiRequest.getFile(iter.next().toString());
                if(file!=null)
                {
                    String uploadPath = "";

                    //获取保存上传文件的文件夹的路径
                    String path = Resources.getDataPath();

                    switch (file.getName()){
                        case "uploadFile":
                            path = path+"/gameFile";

                            int index = file.getOriginalFilename().lastIndexOf(".");
                            uploadPath = path+"/"+gId+file.getOriginalFilename().substring(index);

                            break;

                        default:
                            path = path+"/gameImg/"+gId;
                            uploadPath = path+"/"+file.getName()+".png";
                    }

                    new File(path).mkdir();
                    //上传
                    try {
                        file.transferTo(new File(uploadPath));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

            }

        }

        //游戏文件上传成功后将game表中的字段g_is_complete值改为1
        gameService.updateGameIsCompleteByGameId(gId);

        return "forward:/publish/cooperation";
    }

    @RequestMapping("/uploadFile/{gId}")
    public String uploadfILE(@PathVariable Integer gId,Model model){
        model.addAttribute("gId",gId);
        return "uploadFile";
    }

    //游戏详情页
    @RequestMapping("/{gId}")
    public String gamePage(@PathVariable Integer gId, Model model, HttpSession session){

        Game game = gameService.selectGameByGameId(gId);

        User loginUser = (User) session.getAttribute("loginUser");

        Resources.setTheResourcePath(game);//将该游戏对应的图片资源路径赋值给game对象中的gameData对象

        IntroduceGame introduceGame = gameService.selectGameIntroduceByGameId(gId);
        LowDeviceConfiguration ldc = gameService.selectLowDeviceConfigrationByGameId(gId);
        RecommendDeviceConfiguration rdc = gameService.selectRecommendDeviceConfigurationByGameId(gId);
        List<User> users = userService.selectCommentByGameId(gId);

        if (loginUser != null){

            Cart cart = userService.selectGameByGameIdAndUserIdFromCart(gId, loginUser.getUId());
            Game inventory = gameService.selectGameByGameIdFromInventory(gId, loginUser.getUId());

            if (cart != null){//如果购物车已存在该游戏，则标记
                model.addAttribute("isInCartFlag",true);
            }

            if (inventory != null){//若用户库存中已有该游戏，则标记
                model.addAttribute("isInInventory",true);
            }
        }

        //注入游戏简介
        game.setIntroduceGame(introduceGame);

        //注入游戏最低配置信息
        game.setLowDeviceConfiguration(ldc);

        //注入推荐配置信息
        game.setRecommendDeviceConfiguration(rdc);

        model.addAttribute("game",game);
        model.addAttribute("users",users);

        return "gameInfo";


    }

    @RequestMapping("/editIntroduce/{Gid}/{Gname}")
    public String editIntroduce(@PathVariable Integer Gid,@PathVariable String Gname, Model model){

        IntroduceGame introduceGame = gameService.selectGameIntroduceByGameId(Gid);

        if (introduceGame != null){
            model.addAttribute("introduceGame",introduceGame);
        }

        return "introduceGame";

    }


    @RequestMapping("/uploadGameIntroduce")
    public String uploadIntroduce(IntroduceGame introduceGame,Model model){

        gameService.insertIntroduceGame(introduceGame);

        return "forward:/publish/cooperation";

    }

    @RequestMapping("/updateGameIntroduce")
    public String updateIntroduce(IntroduceGame introduceGame,Model model){

        gameService.updateIntroduceGame(introduceGame);

        return "forward:/publish/cooperation";

    }

    @RequestMapping("/doDownload/{gId}")
    public String downloadFile(@PathVariable Integer gId, HttpServletResponse resp){

        Game game = gameService.selectGameByGameId(gId);

        Resources.setTheResourcePath(game);

        try {
            //获取页面输出流
            ServletOutputStream outputStream = resp.getOutputStream();
            //读取文件
            byte[] bytes = FileUtils.readFileToByteArray(new File(game.getGameData().getFilePath()));
            //向输出流写文件
            //写之前设置响应流以附件的形式打开返回值,这样可以保证前边打开文件出错时异常可以返回给前台
            resp.setHeader("Content-Disposition","attachment;filename="+game.getGName());
            outputStream.write(bytes);
            outputStream.flush();
            outputStream.close();

        } catch (IOException e) {
            System.out.println("出错");
        }

        return "forward:/user/inventory";
    }

    @RequestMapping("/selectAllGamesPage/{currentPage}")
    public String selectAllNotesPage(PageBean<Game> pageBean, @PathVariable Integer currentPage, Model model) {
        if (currentPage == null) {
            currentPage = 1;
        }

        pageBean.setCurrentPage(currentPage);


        List<Game> list = gameService.selectAllGamesPage(pageBean);

        Resources.setTheResourcePath(list);

        pageBean.setList(list);

        model.addAttribute("pageBean", pageBean);

        return "sbeamIndex";
    }

    @RequestMapping("/search")
    public String search(String search,Model model) {

        List<Game> games = gameService.selectGameByName(search);

        Resources.setTheResourcePath(games);

        model.addAttribute("games",games);

        return "search";
    }

    @RequestMapping("/selectGamesByCategory/{c}")
    public String selectGamesByCategory(@PathVariable Integer c,Model model){

        List<Game> games = gameService.selectGamesByCategory(new PageBean<Game>(),c);

        Resources.setTheResourcePath(games);
        model.addAttribute("games",games);

        model.addAttribute("category",Resources.getCategory(c));

        return "browserCategory";

    }

    @RequestMapping("/deleteGameByGId/{gId}")
    public String deleteGameByGId(@PathVariable Integer gId){
        gameService.deleteGameByGId(gId);
        return "forward:/publish/cooperation";
    }

    @RequestMapping("/canPlay")
    public String canPlay(){
        return "canPlay";
    }

    @RequestMapping("/snake")
    public String snake(){
        return "snake";
    }

    @RequestMapping("/tetris")
    public String tetris(){
        return "tetris";
    }
}
