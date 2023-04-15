package org.kd.main.server.model.data.dao;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.kd.main.common.entities.Credit;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

@Repository
public class CreditDaoRepo {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public Credit read(long id) {
        return readCredit(id);
    }

    private Credit readCredit(long id) {
        var session = getSession();
        var crBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Credit> query = crBuilder.createQuery(Credit.class);
        Root<Credit> root = query.from(Credit.class);
        query.select(root).where(crBuilder.equal(root.get("id"), id));
        Query<Credit> q = session.createQuery(query);
        return q.getSingleResult();
    }

    @Transactional
    public List<Credit> readAll() {
        var session = getSession();
        var builder = session.getCriteriaBuilder();
        var criteria = builder.createQuery(Credit.class);
        criteria.from(Credit.class);

        return session.createQuery(criteria).getResultList();
    }

    public List<Credit> readAccountCredits(long accountId){
        var session = getSession();
        var crBuilder = session.getCriteriaBuilder();
        var query = crBuilder.createQuery(Credit.class);
        var root = query.from(Credit.class);
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
