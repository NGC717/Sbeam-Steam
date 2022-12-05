package com.sbeam.service;

import com.sbeam.bean.*;

import java.util.List;

public interface PublisherService {

    void insertPublisher(Publisher publisher);

    Publisher selectPublisherByUserId(Integer id);

    List<Developer> selectDeveloperByPublisherId(Integer pId);

    void deleteDeveloperByDeveloperId(Integer dId);

    void insertLowDeviceConfiguration(LowDeviceConfiguration lowConfig);

    void insertRecommendDeviceConfiguration(RecommendDeviceConfiguration recommendConfig);

    Developer selectDeveloperByDeveloperName(String dName);

    void insertDeveloper(Developer developer);
}
