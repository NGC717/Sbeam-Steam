package com.lq.bean;

import java.io.Serializable;

public class ShopInfo implements Serializable {

    private int shopId;
    private int userId;

    public ShopInfo(Integer shopId, Integer userId) {
        this.shopId = shopId;
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "ShopInfo{" +
                "shopId=" + shopId +
                ", userId=" + userId +
                '}';
    }
}
