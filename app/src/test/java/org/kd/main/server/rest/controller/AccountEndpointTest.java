package org.kd.main.server.rest.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;
import org.kd.main.categories.SystemIntegrationTests;
import org.kd.main.common.RestUtility;
import org.kd.main.common.TraderConfig;
import org.kd.main.common.entities.CorporateAccount;
import org.kd.main.server.TraderServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpMethod;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;
import static org.junit.Assert.assertEquals;

@SpringBootTest(classes = {TraderServer.class})
@RunWith(SpringJUnit4ClassRunner.class)
@Import(TraderConfig.class)
@Ignore
public class AccountEndpointTest {

    @Autowired
    private RestUtility restUtility;

    @Test
    @Category(SystemIntegrationTests.class)
    public void testUpdateAccount() {
        TraderServer.getInstance().start();
        var contentType = "application/json";
        var requestUrl = "http://localhost:8080/account";
        var testCustomer = new CorporateAccount("TST", "Test", 0.0, 1002L);

        try {
            String customerJson = new ObjectMapper().writeValueAsString(testCustomer);
            var response = restUtility.processHttpRequest(HttpMethod.PUT, customerJson, requestUrl, contentType);

            restUtility.retrieveResponseBodyAndStatusCode(response);

            assertEquals("Have you started TraderServer? ", "200", restUtility.getResponseStatusCode());
            assertThat("Wrong response:" + restUtility.getResponseBody(), restUtility.getResponseBody(), containsString(customerJson));
        } catch (JsonProcessingException e) {
            Assert.fail(e.getMessage());
        }
    }

}