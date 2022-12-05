package com.sbeam.service;

import com.sbeam.bean.Game;
import com.sbeam.bean.Publisher;

import java.util.List;

public interface OfficialService {
    List<Game> selectAllGamesWaitForCheck();

    List<Publisher> selectAllPublishersWaitForPass();

    Game selectGameAllInfoByGId(Integer gId);

    Integer selectRootByPwd(String rootPwd);

    void updatePublisherIsPass(Integer pId);

    void deletePublisherNotPass(Integer pId);

    void updateGameIsCheck(Integer gId);

    void deleteGame(Integer gId);
}
