package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Game {

    private Integer gId;
    private Integer gPrice;

    private String gName;
    private String gUploadTime;
    private String gDownloadNum;
    
    private Integer gIsPublish;
    private Integer gIsRemove;
    private Integer gIsComplete;
    private Integer gIsCheck;

    private Integer pId;
    private Integer dId;
    private Integer cId;

    private GameData gameData;

    private Developer developer;
    private Publisher publisher;
    private Category category;
    private IntroduceGame introduceGame;

    private List<Comment> comments;

    private LowDeviceConfiguration lowDeviceConfiguration;
    private RecommendDeviceConfiguration recommendDeviceConfiguration;

    public Game(String gName, Integer dId) {
        this.gName = gName;
        this.dId = dId;
    }


}

