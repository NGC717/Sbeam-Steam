package com.sbeam.mapper;

public interface RootMapper {
    Integer selectRootByPwd(String rootPwd);

    void updatePublisherIsPass(Integer pId);

    void deletePublisherNotPass(Integer pId);

    void updateGameIsCheck(Integer gId);

    void deleteGame(Integer gId);
}
