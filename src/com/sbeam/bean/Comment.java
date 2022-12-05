package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Comment {

    private Integer gcId;
    private String gcContent;
    private Integer gcIsGood;
    private Integer uId;
    private Integer gId;
    private Timestamp gcTime;
}
