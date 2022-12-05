package com.sbeam.service.impl;

import com.sbeam.bean.Game;
import com.sbeam.bean.Publisher;
import com.sbeam.mapper.GameMapper;
import com.sbeam.mapper.PublisherMapper;
import com.sbeam.mapper.RootMapper;
import com.sbeam.service.OfficialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Create with IntelliJ IDEA.
 * User: LQ
 */

@Service
public class OfficialServiceImpl implements OfficialService {

    @Autowired
    private GameMapper gameMapper;

    @Autowired
    private PublisherMapper publisherMapper;

    @Autowired
    private RootMapper rootMapper;

    @Override
    public List<Game> selectAllGamesWaitForCheck() {

        return gameMapper.selectAllGamesWaitForCheck();
    }

    @Override
    public List<Publisher> selectAllPublishersWaitForPass() {
        return publisherMapper.selectAllPublishersWaitForPass();
    }

    @Override
    public Game selectGameAllInfoByGId(Integer gId) {
        return gameMapper.selectGameByGameId(gId);
    }

    @Override
    public Integer selectRootByPwd(String rootPwd) {
        return rootMapper.selectRootByPwd(rootPwd);
    }

    @Override
    public void updatePublisherIsPass(Integer pId) {
        rootMapper.updatePublisherIsPass(pId);
    }

    @Override
    public void deletePublisherNotPass(Integer pId) {
        rootMapper.deletePublisherNotPass(pId);
    }

    @Override
    public void updateGameIsCheck(Integer gId) {
        rootMapper.updateGameIsCheck(gId);
    }

    @Override
    public void deleteGame(Integer gId) {
        rootMapper.deleteGame(gId);
    }
}
