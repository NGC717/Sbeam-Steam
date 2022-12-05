package com.sbeam.service.impl;

import com.sbeam.bean.*;
import com.sbeam.mapper.UserMapper;
import com.sbeam.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Create with IntelliJ IDEA.
 * User: LQ
 */

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public List<Game> selectAllGames() {
        return null;
    }

    @Override
    public Game selectGameById(Integer id) {
        return null;
    }

    @Override
    public void insertUser(User user) {
        userMapper.insertUser(user);
    }

    @Override
    public User selectUserByNameAndPassword(String name, String password) {
        return userMapper.selectUserByNameAndPassword(name,password);
    }

    @Override
    public void selectByUserId(User loginUser) {

    }

    @Override
    public void addGameToCart(Integer uId,Integer gid) {
        userMapper.addGameToCart(uId, gid);
    }

    @Override
    public List<Cart> selectCartByUserId(int uId) {
        return userMapper.selectCartByUserId(uId);
    }

    @Override
    public void deleteGameFromCartByGameIdAndUserId(Integer gId, Integer uId) {
        userMapper.deleteGameFromCartByGameIdAndUserId(gId, uId);
    }

    @Override
    public Cart selectGameByGameIdAndUserIdFromCart(Integer gid, int uId) {
        return userMapper.selectGameByGameIdAndUserIdFromCart(gid,uId);
    }

    @Override
    public void updateUserBalanceWithBalanceAndUserId(Integer uId, Integer balance) {
        userMapper.updateUserBalanceWithBalance(uId,balance);
    }

    @Override
    public void insertGameToInventoryWithUserIdAndGameId(Integer uId, Integer gId) {
        userMapper.insertGameToInventoryWithUserIdAndGameId(uId,gId);
    }

    @Override
    public List<Game> selectInventoryByUserId(Integer uId) {
        return userMapper.selectInventoryByUserId(uId);
    }

    @Override
    public void insertGameCommentWithComment(Comment comment) {
        userMapper.insertGameCommentWithComment(comment);
    }

    @Override
    public List<User> selectCommentByGameId(Integer gId) {
        return userMapper.selectCommentByGameId(gId);
    }

    @Override
    public Integer selectBalanceByUserId(Integer uId) {
        return userMapper.selectBalanceByUserId(uId);
    }

    @Override
    public void updateUserSessionWithUser(User user) {
        userMapper.updateUserSessionWithUser(user);
    }

    @Override
    public UserSession selectUserSession() {
        return userMapper.selectUserSession();
    }

    @Override
    public List<User> selectAllFriends(Integer uId) {
        return userMapper.selectAllFriends(uId);
    }

    @Override
    public User selectUserByName(String friendName) {
        return userMapper.selectUserByName(friendName);
    }

    @Override
    public void insertFriend(Integer uId,Integer fId) {
        userMapper.insertFriend(uId,fId);
    }

    @Override
    public List<User> selectWaitForPassingByUserId(Integer uId) {

        return userMapper.selectWaitForPassingByUserId(uId);
    }

    @Override
    public void updateFriendIsPass(Integer uId, Integer fId) {
        userMapper.updateFriendIsPass(uId,fId);
    }

    @Override
    public void deleteFriendReq(Integer uId, Integer fId) {
        userMapper.deleteFriendReq(uId,fId);
    }

    @Override
    public void insertFriendWithIsPass(Integer fId, Integer uId,Integer isPass) {
        userMapper.insertFriendWithIsPass(fId,uId,isPass);
    }

    @Override
    public String selectUserByPId(Integer pId) {
        return userMapper.selectUserEmailByPId(pId);
    }

    @Override
    public String selectUserByGId(Integer gId) {
        return userMapper.selectUserEmailByGId(gId);
    }

    @Override
    public Integer selectFriendIdByFId(Integer uId,Integer fId) {
        return userMapper.selectFriendIdByFId(uId,fId);
    }

    @Override
    public String selectUserByEmail(String uEmail) {
        return userMapper.selectUserByEmail(uEmail);
    }

}
