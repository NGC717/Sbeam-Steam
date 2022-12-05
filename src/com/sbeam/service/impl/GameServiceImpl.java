package com.sbeam.service.impl;

import com.sbeam.bean.*;
import com.sbeam.mapper.GameMapper;
import com.sbeam.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Create with IntelliJ IDEA.
 * User: LQ
 */

@Service
public class GameServiceImpl implements GameService {

    @Autowired
    private GameMapper gameMapper;

    @Override
    public void insertGame(Game game) {
        gameMapper.insertGame(game);
    }

    @Override
    public List<Game> selectAllGamesIsPublish() {
        return gameMapper.selectAllGamesIsPublish();
    }

    @Override
    public Game selectGameByGameId(Integer id) {
        return gameMapper.selectGameByGameId(id);
    }

    @Override
    public List<Game> selectAllGamesByPublisherId(Integer pId) {
        return gameMapper.selectAllGamesByPublisherId(pId);
    }

    @Override
    public void updateGameIsCompleteByGameId(Integer gId) {
        gameMapper.updateGameIsCompleteByGameId(gId);
    }

    @Override
    public List<Game> selectGamesOrderByDownloadNum() {
        return gameMapper.selectGamesOrderByDownloadNum();
    }

    @Override
    public List<Game> selectGamesOrderByUploadTime() {
        return gameMapper.selectGamesOrderByUploadTime();
    }

    @Override
    public IntroduceGame selectGameIntroduceByGameId(Integer gid) {
        return gameMapper.selectGameIntroduceByGameId(gid);
    }

    @Override
    public void insertIntroduceGame(IntroduceGame introduceGame) {
        gameMapper.insertIntroduceGame(introduceGame);
    }

    @Override
    public void updateIntroduceGame(IntroduceGame introduceGame) {
        gameMapper.updateIntroduceGame(introduceGame);
    }

    @Override
    public LowDeviceConfiguration selectLowDeviceConfigrationByGameId(Integer gId) {
        return gameMapper.selectLowDeviceConfigurationByGameId(gId);
    }

    @Override
    public RecommendDeviceConfiguration selectRecommendDeviceConfigurationByGameId(Integer gId) {
        return gameMapper.selectRecommendDeviceConfigurationByGameId(gId);
    }

    @Override
    public Game selectGameByGameIdFromInventory(Integer gId,Integer uId) {
        return gameMapper.selectGameByGameIdFromInventory(gId,uId);
    }

    @Override
    public List<Game> selectAllGamesPage(PageBean<Game> pageBean) {
        int totalCount = gameMapper.getTotalCountIsPublish();
        pageBean.setTotalCount(totalCount);

        if (pageBean.getCurrentPage() <= 0) {
            pageBean.setCurrentPage(1);
        } else if (pageBean.getCurrentPage() > pageBean.getTotalPage()) {
            pageBean.setCurrentPage(pageBean.getTotalPage());
        }

        int offset = (pageBean.getCurrentPage() - 1) * pageBean.getPageCount();
        int limit = pageBean.getPageCount();

        pageBean.setOffset(offset);
        pageBean.setLimit(limit);

        return gameMapper.selectAllGamesPage(pageBean);
    }

    @Override
    public List<Game> selectGameByName(String search) {
        return gameMapper.selectGameByName(search);
    }

    @Override
    public List<Game> selectGamesByCategory(PageBean<Game> pageBean,Integer c) {

        return gameMapper.selectGamesByCategory(pageBean,c);
    }

    @Override
    public void deleteGameByGId(Integer gId) {
        gameMapper.deleteGameByGId(gId);
    }

    @Override
    public void updateGameIsNotPublishByGId(Integer gId) {
        gameMapper.updateGameIsNotPublishByGId(gId);
    }

    @Override
    public void updateGameIsPublishByGId(Integer gId) {
        gameMapper.updateGameIsPublishByGId(gId);
    }

    @Override
    public void insertPromotion(PromotionGame game) {
        gameMapper.insertPromotion(game);
    }

    @Override
    public List<PromotionGame> selectPromotionGame() {
        return gameMapper.selectPromotionGame();
    }

    @Override
    public String selectNameByGId(Integer gId) {
        return gameMapper.selectNameByGId(gId);
    }

    @Override
    public Integer selectGameByUserIdWithGameId(int uId, Integer gId) {
        return gameMapper.selectGameByUserIdWithGameId(uId,gId);
    }

}
