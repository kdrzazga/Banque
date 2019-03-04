package org.kd.main.server.model.data.dao;

import org.hibernate.Session;
import org.kd.main.server.model.data.entities.Fund;
import org.kd.main.server.model.data.entities.Trade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class TradeDaoRepo{

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private PartyDaoRepo partyDaoRepo;

    @Autowired
    private FundDaoRepo fundDaoRepo;

    @Transactional
    public Trade getTradeByPrimaryKey(int id) {
        return entityManager.find(Trade.class, id);
    }

    @Transactional
    public void removeTradeByPrimaryKey(int id) {
        var entity = entityManager.find(Trade.class, id);
        //entityManager.getTradeion().begin();// this is handled by Spring @Transactional
        entityManager.remove(entity);
        //entityManager.getTradeion().commit();// this is handled by Spring @Transactional too
    }

    @Transactional
    public List<Trade> getAllTrades() {
        var session = entityManager.unwrap(Session.class);
        var builder = session.getCriteriaBuilder();
        var criteria = builder.createQuery(Trade.class);
        criteria.from(Trade.class);

        var transacts = session.createQuery(criteria).getResultList();
        session.close();
        return transacts;
    }

    @Transactional
    public List<Trade> getTradeByFundId(int fundId) {
        var session = entityManager.unwrap(Session.class);
        var builder = session.getCriteriaBuilder();
        var criteria = builder.createQuery(Trade.class);

        var root = criteria.from(Trade.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("dest_fund_id"), fundId));

        var transacts = session.createQuery(criteria).getResultList();
        session.close();
        return transacts;
    }

    @Transactional
    public int book(long sourceFundIs, long destFundId, float units) {

        var destFund = fundDaoRepo.get(destFundId);
        var sourceFund = fundDaoRepo.get(sourceFundIs);

        if (destFund == null || sourceFund == null) return -1;

        return (destFund.getParty_id() == sourceFund.getParty_id())
                ? bookInternalTrade(sourceFund, destFund, units)
                : bookExternalTrade();
    }

    private int bookInternalTrade(Fund sourceFund, Fund destFund, float units) {
        if (sourceFund.getUnits() < units) return -1;

        sourceFund.setUnits(sourceFund.getUnits() - units);
        destFund.setUnits(destFund.getUnits() + units);

        fundDaoRepo.update(sourceFund);
        fundDaoRepo.update(destFund);
        return addNewTrade(sourceFund.getId(), destFund.getId(), units, true);
    }

    private int bookExternalTrade() {
        throw new RuntimeException("Not implemented yet");
        //TODO implement
    }

    private int addNewTrade(int sourceFundId, int destFundId, float units, boolean internal){
        var newTrade = new Trade(sourceFundId, destFundId, units, internal);

        entityManager.persist(newTrade);
        entityManager.flush();

        return newTrade.getId();
    }

}
