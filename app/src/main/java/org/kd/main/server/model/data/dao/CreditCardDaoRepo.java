package org.kd.main.server.model.data.dao;

import org.hibernate.Session;
import org.kd.main.common.entities.CreditCard;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class CreditCardDaoRepo {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public CreditCard read(long id) {
        return readCreditCard(id);
    }

    private CreditCard readCreditCard(long id) {
        return entityManager.find(CreditCard.class, id);
    }

    @Transactional
    public List<CreditCard> readAll() {
        var session = getSession();
        var builder = session.getCriteriaBuilder();
        var criteria = builder.createQuery(CreditCard.class);
        criteria.from(CreditCard.class);

        return session.createQuery(criteria).getResultList();
    }

    public List<CreditCard> readAccountCards(long accountId){
        var session = getSession();
        var crBuilder = session.getCriteriaBuilder();
        var query = crBuilder.createQuery(CreditCard.class);
        var root = query.from(CreditCard.class);
        query.select(root).where(crBuilder.equal(root.get("account"), accountId));
        var q = session.createQuery(query);
        return q.getResultList();
    }

    private Session getSession() {
        Session session;
        if (entityManager == null
                || (session = entityManager.unwrap(Session.class)) == null) {

            throw new NullPointerException();
        }
        return session;
    }
}
