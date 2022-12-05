package com.sbeam.service.impl;

import com.sbeam.bean.Developer;
import com.sbeam.bean.LowDeviceConfiguration;
import com.sbeam.bean.Publisher;
import com.sbeam.bean.RecommendDeviceConfiguration;
import com.sbeam.mapper.PublisherMapper;
import com.sbeam.service.PublisherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Create with IntelliJ IDEA.
 * User: LQ
 */

@Service
public class PublisherServiceImpl  implements PublisherService{

    @Autowired
    PublisherMapper publisherMapper;

    @Override
    public void insertPublisher(Publisher publisher) {
        publisherMapper.insertPublisher(publisher);
    }

    @Override
    public Publisher selectPublisherByUserId(Integer id) {
        return publisherMapper.selectPublisherByUserId(id);
    }

    @Override
    public List<Developer> selectDeveloperByPublisherId(Integer pId) {
        return publisherMapper.selectDeveloperByPublisherId(pId);
    }

    @Override
    public void deleteDeveloperByDeveloperId(Integer dId) {

        publisherMapper.deleteDeveloperByDeveloperId(dId);

    }

    @Override
    public void insertLowDeviceConfiguration(LowDeviceConfiguration lowConfig) {
        publisherMapper.insertLowDeviceConfiguration(lowConfig);
    }

    @Override
    public void insertRecommendDeviceConfiguration(RecommendDeviceConfiguration recommendConfig) {
        publisherMapper.insertRecommendDeviceConfiguration(recommendConfig);
    }

    @Override
    public Developer selectDeveloperByDeveloperName(String dName) {
        return publisherMapper.selectDeveloperByDeveloperName(dName);
    }

    @Override
    public void insertDeveloper(Developer developer) {
        publisherMapper.insertDeveloper(developer);
    }
}
