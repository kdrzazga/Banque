package org.kd.main.server.model.data.dao;

import org.hibernate.Session;
import org.kd.main.common.entities.Account;
import org.kd.main.common.entities.ExternalTransfer;
import org.kd.main.common.entities.InternalTransfer;
import org.kd.main.common.entities.Transfer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.Objects;

@Repository
public class TransferDaoRepo {

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private BankDaoRepo bankDaoRepo;

    @Autowired
    private AccountDaoRepo accountDaoRepo;

    @Autowired
    private InternalTransferDaoRepo internalTransferDaoRepo;

    @Autowired
    private ExternalTransferDaoRepo externalTransferDaoRepo;

    @Transactional
    public long book(Account srcAccount, Account destAccount, double units) {

        if (destAccount == null || srcAccount == null) return -1;

        return (Objects.equals(destAccount.getBankId(), srcAccount.getBankId()))
                ? bookInternalTransfer(srcAccount, destAccount, units)
                : bookExternalTransfer(srcAccount, destAccount, units);
    }

    @Transactional
    public Transfer readByPrimaryKey(long id) {
        return readTransferByPrimaryKey(id);
    }

    @Transactional
    public List<Transfer> readAll() {
        var allTransfers = internalTransferDaoRepo.readAllNoTransact();
        allTransfers.addAll(externalTransferDaoRepo.readAllNoTransact());
        entityManager.unwrap(Session.class).close();
        return allTransfers;
    }

    @Transactional
    public List<Transfer> readByDestAccountId(long accountId) {
        var session = entityManager.unwrap(Session.class);
        var builder = session.getCriteriaBuilder();
        var criteria = builder.createQuery(Transfer.class);

        var root = criteria.from(Transfer.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("destAccount"), accountId));

        var transacts = session.createQuery(criteria).getResultList();
        session.close();
        return transacts;
    }

    @Transactional
    public void update(Transfer transfer) {
        var session = getSession();
        session.update(transfer);
    }

    @Transactional
    public Transfer deleteByPrimaryKey(long id) {
        var entity = entityManager.find(Transfer.class, id);
        //entityManager.getTradeion().begin();// this is handled by Spring @Transactional
        entityManager.remove(entity);
        return entity;
        //entityManager.getTradeion().commit();// this is handled by Spring @Transactional too
    }
    
    private long bookInternalTransfer(Account sourceAccount, Account destAccount, double units) {
        if (sourceAccount.getBalance() < units) return -1;

        sourceAccount.setBalance(sourceAccount.getBalance() - units);
        destAccount.setBalance(destAccount.getBalance() + units);

        /*TODO: possible error - if program unexpectedly quits after withdrawing money form source account
        *  and before adding them to destination account, sourceAccount will LOSE money
        *  Solution is to put both updates in a single Hibernate transaction*/
        accountDaoRepo.update(sourceAccount);
        accountDaoRepo.update(destAccount);
        return createInternalTransfer(sourceAccount, destAccount, units);
    }

    private long bookExternalTransfer(Account sourceAccount, Account destAccount, double units) {
        if (sourceAccount.getBalance() < units) return -1;

        sourceAccount.setBalance(sourceAccount.getBalance() - units);
        destAccount.setBalance(destAccount.getBalance() + units);

        accountDaoRepo.update(sourceAccount);
        accountDaoRepo.update(destAccount);
        return createExternalTransfer(sourceAccount, destAccount, units);
    }

    private long createInternalTransfer(Account sourceFundId, Account destFundId, double units) {
        var transfer = new InternalTransfer(sourceFundId, destFundId, units);

        getSession().saveOrUpdate(transfer);
        return transfer.getId();
    }

    private long createExternalTransfer(Account sourceFundId, Account destFundId, double units) {
        var newTrade = new ExternalTransfer(sourceFundId, destFundId, units);

        getSession().saveOrUpdate(newTrade);
        return newTrade.getId();
    }

    private Transfer readTransferByPrimaryKey(long id) {
        return entityManager.find(Transfer.class, id);
    }

    private Session getSession() {
        /*
        Container like Spring is not resposible for maintaing the life cycle for the EntityManager created from it. But you can @Autowire EntityManagerFactory directly as the bean is already configured in the applicationContext. Hence this could be simple like this emf.createEntityManager().unwrap(Session.class)' to get Session`
         */

        Session session;
        if (entityManager == null
                || (session = entityManager.unwrap(Session.class)) == null) {

            throw new RuntimeException("No entityManager available");

        }
        return session;
    }
}
