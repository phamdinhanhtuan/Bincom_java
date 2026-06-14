package com.ecommerce.repository.impl;

import com.ecommerce.model.Order;
import com.ecommerce.repository.OrderRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public class OrderRepositoryImpl extends BaseRepositoryImpl<Order, Long>
        implements OrderRepository {

    @Override
    public Optional<Order> findByOrderCode(String orderCode) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Order o WHERE o.orderCode = :code", Order.class)
            .setParameter("code", orderCode)
            .uniqueResultOptional();
    }

    @Override
    public List<Order> findByCustomerId(Long customerId) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Order o WHERE o.customer.id = :id ORDER BY o.createdAt DESC",
                Order.class)
            .setParameter("id", customerId)
            .getResultList();
    }

    @Override
    public List<Order> findByStatus(Order.Status status) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Order o WHERE o.status = :status ORDER BY o.createdAt DESC",
                Order.class)
            .setParameter("status", status)
            .getResultList();
    }

    @Override
    public List<Order> findByDateRange(LocalDateTime from, LocalDateTime to) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Order o WHERE o.createdAt BETWEEN :from AND :to ORDER BY o.createdAt DESC",
                Order.class)
            .setParameter("from", from)
            .setParameter("to", to)
            .getResultList();
    }

    @Override
    public BigDecimal sumRevenueByDateRange(LocalDateTime from, LocalDateTime to) {
        BigDecimal result = sessionFactory.getCurrentSession()
            .createQuery(
                "SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.status = 'COMPLETED' AND o.createdAt BETWEEN :from AND :to",
                BigDecimal.class)
            .setParameter("from", from)
            .setParameter("to", to)
            .getSingleResult();
        return result != null ? result : BigDecimal.ZERO;
    }

    @Override
    public List<Object[]> revenueByMonth(int year) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "SELECT MONTH(o.createdAt), SUM(o.totalAmount), COUNT(o) FROM Order o " +
                "WHERE o.status = 'COMPLETED' AND YEAR(o.createdAt) = :year " +
                "GROUP BY MONTH(o.createdAt) ORDER BY MONTH(o.createdAt)",
                Object[].class)
            .setParameter("year", year)
            .getResultList();
    }

    @Override
    public List<Object[]> revenueByDay(int year, int month) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "SELECT DAY(o.createdAt), SUM(o.totalAmount), COUNT(o) FROM Order o " +
                "WHERE o.status = 'COMPLETED' AND YEAR(o.createdAt) = :year AND MONTH(o.createdAt) = :month " +
                "GROUP BY DAY(o.createdAt) ORDER BY DAY(o.createdAt)",
                Object[].class)
            .setParameter("year", year)
            .setParameter("month", month)
            .getResultList();
    }

    @Override
    public long countByStatus(Order.Status status) {
        return sessionFactory.getCurrentSession()
            .createQuery("SELECT COUNT(o) FROM Order o WHERE o.status = :status", Long.class)
            .setParameter("status", status)
            .getSingleResult();
    }

    @Override
    public long countToday() {
        LocalDateTime startOfDay = LocalDateTime.now().toLocalDate().atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1);
        return sessionFactory.getCurrentSession()
            .createQuery(
                "SELECT COUNT(o) FROM Order o WHERE o.createdAt BETWEEN :start AND :end",
                Long.class)
            .setParameter("start", startOfDay)
            .setParameter("end", endOfDay)
            .getSingleResult();
    }
}
