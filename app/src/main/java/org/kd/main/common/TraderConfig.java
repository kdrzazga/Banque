package org.kd.main.common;

import org.kd.main.client.presenter.PresenterHandler;
import org.kd.main.client.presenter.TraderPresenter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
@EntityScan(basePackages = "org.kd.main.common.entities")
public class TraderConfig {

    @Value("${server.port}")
    private String port;

    @Bean//necessary for JavaFx CLIENT APP, Sever will autoconfigure the component.
    public RestUtility restUtility() {
        return new RestUtility();
    }

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    @Bean(name = "server_port")
    public String port() {
        return port;
    }

    @Bean
    PresenterHandler presenterHandler() {
        return new TraderPresenter();
    }
}
