package org.kd.main.client.presenter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.tomakehurst.wiremock.WireMockServer;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;
import org.kd.main.categories.ModuleIntegrationTests;
import org.kd.main.client.presenter.config.TestClientConfig;
import org.kd.main.common.TraderConfig;
import org.kd.main.common.entities.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static com.github.tomakehurst.wiremock.client.WireMock.*;
import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.hasSize;
import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {TraderConfig.class, TestClientConfig.class})
@PropertySource("classpath:application.properties")
//@Ignore
public class PresenterTest {

    //don't start Tests when Server is running -> port is busy

    @Value("${port:8080}")
    private String port;

    private final Bank bank = new Bank(1L, "Test Bank", "TST");
    private final Account account = new CorporateAccount("IK", "Ian Kovalsky", 1.0, 1L);
    private final Transfer transfer = new InternalTransfer(account, account, 2d);

    @Autowired
    private WireMockServer wireMockServer;

    @Autowired
    private PresenterHandler presenterHandler;

    @Before
    public void setup() {
        wireMockServer.start();
        configureFor("localhost", Integer.parseInt(port));

        try {
            var objectMapper = new ObjectMapper();
            String banksAsJson = objectMapper.writeValueAsString(List.of(bank));
            String accountsAsJson = objectMapper.writeValueAsString(List.of(account));
            String transfersAsJson = objectMapper.writeValueAsString(List.of(transfer));

            createStubForGet(banksAsJson, "/banks");
            createStubForGet(accountsAsJson, "/corporate-accounts");
            createStubForGet(transfersAsJson, "/transfers");
        } catch (
                JsonProcessingException e) {
            Assert.fail(e.getMessage());
        }
    }

    public void createStubForGet(String banksAsJson, String endpoint) {
        var response = aResponse()
                .withStatus(HttpStatus.OK.value())
                .withHeader("Content-Type", "application/json")
                .withBody(banksAsJson);

        stubFor(get(urlEqualTo(endpoint))
                .willReturn(response));
    }

    @Test
    @Category(ModuleIntegrationTests.class)
    public void testLoadBanks() {
        var banks = presenterHandler.readBanks();
        assertNotNull(banks);
        assertThat(banks, hasSize(greaterThan(0)));
    }

    @Test
    @Category(ModuleIntegrationTests.class)
    public void testLoadAccounts() {
        var accounts = presenterHandler.readAccounts();
        assertNotNull(accounts);
        assertThat(accounts, hasSize(greaterThan(0)));
    }

    @Test
    @Category(ModuleIntegrationTests.class)
    public void testLoadTransfers() {
        var transfers = presenterHandler.readTransfers();
        assertNotNull(transfers);
        assertThat(transfers, hasSize(greaterThan(0)));
        assertEquals(transfer, transfers.get(0));
    }
}
