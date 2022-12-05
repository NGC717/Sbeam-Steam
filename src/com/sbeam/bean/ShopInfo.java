package com.sbeam.bean;

import lombok.Data;

import java.io.Serializable;

@Data
public class ShopInfo implements Serializable {

    private int shopId;
    private int userId;

    public ShopInfo(Integer shopId, Integer userId) {
        this.shopId = shopId;
        this.userId = userId;
    }
}
