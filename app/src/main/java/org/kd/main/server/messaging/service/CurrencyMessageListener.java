package org.kd.main.server.messaging.service;

import org.kd.main.common.messaging.SpringJmsConsumer;
import org.kd.main.server.messaging.config.JmsConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Import;

import javax.jms.JMSException;

@Import(JmsConfig.class)
public class CurrencyMessageListener implements Runnable {

    @Value("currencyPolling.time")
    private String currencyPollingTime;

    @Autowired
    private SpringJmsConsumer springJmsConsumer;

    private static boolean running = false;

    @Override
    public void run() {
        while (true) {
            try {
                Thread.sleep(determineDelay());
                if (running) {
                    System.out.println(springJmsConsumer.receiveMessage());
                }
            } catch (InterruptedException | JMSException e) {
                e.printStackTrace();
            }
        }
    }

    private int determineDelay() {
        int delay;
        try {
            delay = Integer.decode(currencyPollingTime);
        } catch (NumberFormatException e) {
            delay = 300;//default
        }
        return delay;
    }

    public void start() {
        running = true;
    }

    public void stop() {
        running = false;
    }

}
