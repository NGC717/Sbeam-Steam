package com.sbeam.mapper;

import com.sbeam.bean.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GameMapper {

    void insertGame(Game game);

    List<Game> selectAllGamesByPublisherId(Integer pId);

    void updateGameIsCompleteByGameId(Integer gId);

    List<Game> selectGamesOrderByDownloadNum();

    List<Game> selectGamesOrderByUploadTime();

    IntroduceGame selectGameIntroduceByGameId(Integer gid);

    void insertIntroduceGame(IntroduceGame introduceGame);

    void updateIntroduceGame(IntroduceGame introduceGame);

    Game selectGameByGameId(Integer id);

    LowDeviceConfiguration selectLowDeviceConfigurationByGameId(Integer gId);

    RecommendDeviceConfiguration selectRecommendDeviceConfigurationByGameId(Integer gId);

    List<Game> selectAllGamesIsPublish();

    Game selectGameByGameIdFromInventory(Integer gId,Integer uId);

    List<Game> selectAllGamesPage(PageBean<Game> pageBean);

    int getTotalCountIsPublish();

    List<Game> selectGameByName(String search);

    List<Game> selectGameByCategoryId(Integer i);

    List<Game> selectGamesByCategory(@Param("pageBean") PageBean<Game> pageBean, Integer c);

    void deleteGameByGId(Integer gId);

    void updateGameIsNotPublishByGId(Integer gId);

    List<Game> selectAllGamesWaitForCheck();

    void updateGameIsPublishByGId(Integer gId);

    void insertPromotion(PromotionGame game);

    List<PromotionGame> selectPromotionGame();

    String selectNameByGId(Integer gId);

    Integer selectGameByUserIdWithGameId(int uId, Integer gId);
}
