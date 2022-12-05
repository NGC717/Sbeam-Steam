package com.sbeam.mapper;

import com.sbeam.bean.*;

import java.util.List;

public interface UserMapper {

    void insertUser(User user);

    User selectUserByNameAndPassword(String name, String password);

    void addGameToCart(Integer uId,Integer gid);

    List<Cart> selectCartByUserId(Integer uId);

    void deleteGameFromCartByGameIdAndUserId(Integer gId, Integer uId);

    Cart selectGameByGameIdAndUserIdFromCart(Integer gid, int uId);

    void updateUserBalanceWithBalance(Integer uId,Integer balance);

    void insertGameToInventoryWithUserIdAndGameId(Integer uId, Integer gId);

    List<Game> selectInventoryByUserId(Integer uId);

    void insertGameCommentWithComment(Comment comment);

    List<User> selectCommentByGameId(Integer gId);

    Integer selectBalanceByUserId(Integer uId);

    void updateUserSessionWithUser(User user);

    UserSession selectUserSession();

    List<User> selectAllFriends(Integer uId);

    User selectUserByName(String friendName);

    void insertFriend(Integer uId,Integer fId);

    List<User> selectWaitForPassingByUserId(Integer uId);

    void updateFriendIsPass(Integer uId, Integer fId);

    void deleteFriendReq(Integer uId, Integer fId);

    void insertFriendWithIsPass(Integer fId, Integer uId, Integer isPass);

    String selectUserEmailByPId(Integer pId);

    String selectUserEmailByGId(Integer gId);

    Integer selectFriendIdByFId(Integer uId,Integer fId);

    String selectUserByEmail(String uEmail);
}
