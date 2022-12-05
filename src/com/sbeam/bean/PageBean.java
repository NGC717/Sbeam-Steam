package com.sbeam.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PageBean<T> {

    private int currentPage = 1;
    private int pageCount = 8;
    private int totalCount;
    private int totalPage;
    private List<T> list;

    private int offset;
    private int limit;

    public int getTotalPage() {
        if (totalCount % pageCount == 0) {
            totalPage = totalCount / pageCount;
        } else {
            totalPage = totalCount / pageCount + 1;
        }
        return totalPage;
    }

}
