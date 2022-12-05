package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Publisher {

    private Integer pId;            //publisher表主键
    private String pName;           //发行商名称
    private String pBank;           //发行商收款账户

    private String pOfficeName;     //发行商公司或工作室名称
    private String pOfficeLocation; //发行商公司或工作室位置
    private String pOfficeCountry;  //发行商公司或工作室所属国家
    private String pTele;           //发行商公司或工作室联系电话
    private Integer pIncome;        //该发行商总收入
    private Integer pIsPass;        //该发行商是否经过sbeam官方审核 1：通过 0：等待审核
    private Integer uId;            //sbeam账户主键

    private List<Developer> developers;
    private List<Game> games;
}
