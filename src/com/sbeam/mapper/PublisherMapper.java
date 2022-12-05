package com.sbeam.mapper;

import com.sbeam.bean.Developer;
import com.sbeam.bean.LowDeviceConfiguration;
import com.sbeam.bean.Publisher;
import com.sbeam.bean.RecommendDeviceConfiguration;

import java.util.List;

public interface PublisherMapper {

    void insertPublisher(Publisher publisher);

    Publisher selectPublisherByUserId(Integer id);

    List<Developer> selectDeveloperByPublisherId(Integer pId);

    void deleteDeveloperByDeveloperId(Integer dId);

    void insertLowDeviceConfiguration(LowDeviceConfiguration lowConfig);

    void insertRecommendDeviceConfiguration(RecommendDeviceConfiguration recommendConfig);

    Developer selectDeveloperByDeveloperName(String dName);

    void insertDeveloper(Developer developer);

    List<Publisher> selectAllPublishersWaitForPass();
}
