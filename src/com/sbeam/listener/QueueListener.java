package com.sbeam.listener;

import org.springframework.stereotype.Component;

import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

@Component
public class QueueListener implements MessageListener {

    @Override
    public void onMessage(Message message) {

        if (message instanceof TextMessage){

            TextMessage text = (TextMessage) message;

            
        }
    }
}
