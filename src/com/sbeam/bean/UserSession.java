package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserSession {

    private Integer sId;
    private Integer uId;
    private String uName;
    private Integer uBalance;
    private String uPassword;

}
