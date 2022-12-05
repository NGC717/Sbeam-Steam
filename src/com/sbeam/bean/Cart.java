package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Cart {

    private Integer carId;
    private Integer uId;
    private Integer gId;
    private Timestamp creatTime;

    private Game game;
}
