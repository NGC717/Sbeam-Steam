package com.sbeam.bean;

import lombok.Data;

@Data
public class PromotionGame {

    private Integer id;
    private Integer gTotal;
    private Integer gPrice;
    private String gBeginTime;
    private String gName;
    private Integer gResidue;

    private Integer gId;

    private Boolean already;
    private Boolean isTime;

    private Integer state;

}
