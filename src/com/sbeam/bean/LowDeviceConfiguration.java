package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class LowDeviceConfiguration {

    private Integer lId;

    private String lOperationSystem;
    private String lCpu;
    private String lRam;

    private String lGpu;
    private String lDirectx;
    private String lRom;

    private Integer gId;

}
