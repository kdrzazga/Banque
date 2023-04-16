package org.kd.main.server.model.data.dao;

import org.junit.Assert;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.runner.RunWith;
import org.kd.main.categories.ModuleIntegrationTests;
import org.kd.main.categories.UnitTests;
import org.kd.main.common.entities.Account;
import org.kd.main.server.TraderServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.annotation.Order;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.Objects;
import java.util.function.Predicate;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.*;

@Transactional
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@SpringBootTest(classes = {TraderServer.class})
@RunWith(SpringJUnit4ClassRunner.class)
public class TransferDaoRepoTest {

    @Autowired
    private TransferDaoRepo transferDaoRepo;

    @Autowired
    private AccountDaoRepo accountDaoRepo;

    @Test
    @Order(value = 1)
    @Category(ModuleIntegrationTests.class)
    public void testBookInternalTransfer() {
        var srcAccount = accountDaoRepo.read(2011L);
        var commonBankId = srcAccount.getBankId();

        checkBookingTransfer(srcAccount, account -> Objects.equals(account.getBankId(), commonBankId));
    }

    @Test
    @Category(ModuleIntegrationTests.class)
    public void testBookExternalTransfer() {
        var srcAccount = accountDaoRepo.read(2011L);
        var commonBankId = srcAccount.getBankId();

        checkBookingTransfer(srcAccount, account -> !Objects.equals(account.getBankId(), commonBankId));
    }

    @Test
    @Order(value = 2)
    @Category(UnitTests.class)
    public void testReadByPrimaryKey() {
        assertEquals(Long.valueOf(3002), transferDaoRepo.readByPrimaryKey(3002L).getId());
        assertEquals(Long.valueOf(3003), transferDaoRepo.readByPrimaryKey(3003L).getId());
        assertEquals(Long.valueOf(3005), transferDaoRepo.readByPrimaryKey(3005L).getId());
    }

    @Test
    @Order(value = 3)
    @Category(UnitTests.class)
    public void testReadForParticularFund() {
        var tradeForFund2002 = transferDaoRepo.readByDestAccountId(2002L);
        Assert.assertNotNull(tradeForFund2002);
        assertThat(tradeForFund2002, hasSize(greaterThan(0)));
    }

    @Test
    @Order(value = 4)
    @Category(UnitTests.class)
    public void testReadAll() {
        var transacts = transferDaoRepo.readAll();

        Assert.assertNotNull(transacts);
        assertThat(transacts, hasSize(greaterThan(0)));
        assertThat(transacts, hasSize(greaterThanOrEqualTo(5)));
        assertThat(transacts, hasSize(lessThanOrEqualTo(6)));
    }

    @Test
    @Order(value = 5)
    @Category(UnitTests.class)
    public void testDeleteTransferByPrimaryKey() {
        var id = 3006L;
        transferDaoRepo.deleteByPrimaryKey(id);
        Assert.assertNull(transferDaoRepo.readByPrimaryKey(id));
        //transferDaoRepo.book(2003L, 2004L, 30.02f);//books transact again, but id will change
    }

    private void checkBookingTransfer(Account srcAccount, Predicate<Account> bankIdComparisonPredicate) {

        var destCustomer = accountDaoRepo.readAllCorporate()
                .stream()
                .filter(bankIdComparisonPredicate)
                .findFirst();

        if (destCustomer.isEmpty())
            fail("Wrong test data. Cannot book Transfer. Only one account with appropriate bank id ");

        final int errorCode = -1;
        final long newTransferId =  transferDaoRepo.book(srcAccount, destCustomer.get(), 0.5f);

        assertNotEquals(errorCode, newTransferId);

        removeBookedTransfer(newTransferId);
    }

    private void removeBookedTransfer(long id) {
        transferDaoRepo.deleteByPrimaryKey(id);
    }

}
