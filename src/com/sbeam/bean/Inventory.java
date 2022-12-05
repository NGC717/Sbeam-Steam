package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Inventory {

    private Integer iId;
    private String uId;
    private String gId;
    private Timestamp buyTime;

    private List<Game> gameList;
}
