package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class RecommendDeviceConfiguration {

    private Integer rId;

    private String rOperationSystem;
    private String rCpu;
    private String rRam;

    private String rGpu;
    private String rDirectx;
    private String rRom;

    private Integer gId;

}
