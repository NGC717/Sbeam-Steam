package com.sbeam.service;

import com.sbeam.bean.*;

import java.util.List;

public interface GameService {

    void insertGame(Game game);

    List<Game> selectAllGamesIsPublish();

    Game selectGameByGameId(Integer id);

    List<Game> selectAllGamesByPublisherId(Integer pId);

    void updateGameIsCompleteByGameId(Integer gId);

    List<Game> selectGamesOrderByDownloadNum();

    List<Game> selectGamesOrderByUploadTime();

    IntroduceGame selectGameIntroduceByGameId(Integer gid);

    void insertIntroduceGame(IntroduceGame introduceGame);

    void updateIntroduceGame(IntroduceGame introduceGame);

    LowDeviceConfiguration selectLowDeviceConfigrationByGameId(Integer gId);

    RecommendDeviceConfiguration selectRecommendDeviceConfigurationByGameId(Integer gId);

    Game selectGameByGameIdFromInventory(Integer gId,Integer uId);

    List<Game> selectAllGamesPage(PageBean<Game> pageBean);

    List<Game> selectGameByName(String search);

    List<Game> selectGamesByCategory(PageBean<Game> pageBean,Integer c);

    void deleteGameByGId(Integer gId);

    void updateGameIsNotPublishByGId(Integer gId);

    void updateGameIsPublishByGId(Integer gId);

    void insertPromotion(PromotionGame game);

    List<PromotionGame> selectPromotionGame();

    String selectNameByGId(Integer gId);

    Integer selectGameByUserIdWithGameId(int uId, Integer gId);
}
