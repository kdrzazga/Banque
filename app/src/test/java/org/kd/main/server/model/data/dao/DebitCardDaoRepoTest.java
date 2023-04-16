package org.kd.main.server.model.data.dao;

import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.runner.RunWith;
import org.kd.main.categories.UnitTests;
import org.kd.main.server.TraderServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.hasSize;

@Transactional
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@SpringBootTest(classes = {TraderServer.class})
@RunWith(SpringJUnit4ClassRunner.class)
public class DebitCardDaoRepoTest {

    @Autowired
    private DebitCardDaoRepo debitCardDao;

    @Test
    @Category(UnitTests.class)
    public void testReadAccountCards(){
        var accountId = 2001L;
        var cards = debitCardDao.readAccountCards(accountId);

        assertThat(cards, hasSize(greaterThan(0)));
    }
}
