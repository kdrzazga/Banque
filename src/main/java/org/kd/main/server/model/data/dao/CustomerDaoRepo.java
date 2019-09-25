package org.kd.main.server.model.data.dao;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.kd.main.common.entities.Customer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

@Repository
public class CustomerDaoRepo {

    @PersistenceContext
    private EntityManager entityManager;

    private Logger log = LoggerFactory.getLogger(CustomerDaoRepo.class);

    @Transactional
    public long insert(Customer customer) {

        entityManager.persist(customer);
        return customer.getId();
    }

    public boolean isPersisted(Customer customer) {
        return entityManager.contains(customer);
    }

    @Transactional
    public void detach(Customer customer) {
        entityManager.detach(customer);
    }

    @Transactional
    public List<Customer> getAllCustomers() {
        //javax.persistence.Query query = entityManager.createQuery("SELECT id, name, shortname, units, party_id FROM Customer");//doesn't work

        var session = getSession();
        var crBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Customer> query = crBuilder.createQuery(Customer.class);
        Root<Customer> root = query.from(Customer.class);
        query.select(root);
        Query<Customer> q = session.createQuery(query);

        return q.getResultList();
    }

    @Transactional
    public Customer get(long id) {
        return read(id);
    }

    public Customer read(long id) {
        var session = getSession();
        var crBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Customer> query = crBuilder.createQuery(Customer.class);
        Root<Customer> root = query.from(Customer.class);
        query.select(root).where(crBuilder.equal(root.get("id"), id));//SELECT from Customer WHERE id=id
        Query<Customer> q = session.createQuery(query);
        return q.getSingleResult();
    }

    @Transactional
    public Customer get(String shortname) {
        var session = getSession();
        var crBuilder = session.getCriteriaBuilder();
        var query = crBuilder.createQuery(Customer.class);
        var root = query.from(Customer.class);
        query.select(root).where(crBuilder.equal(root.get("shortname"), shortname));//SELECT from Customer WHERE id=id
        var q = session.createQuery(query);
        return q.getSingleResult();
    }

    @Transactional
    public void update(Customer customer) {
        var session = getSession();
        log.info("Logging session: " + session + " updating customer " + customer);
        session.update(customer);
    }

    Session getSession() {
        Session session;
        if (entityManager == null
                || (session = entityManager.unwrap(Session.class)) == null) {

            throw new NullPointerException();
        }
        return session;
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }
}