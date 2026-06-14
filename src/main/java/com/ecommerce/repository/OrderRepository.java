package com.ecommerce.repository;

import com.ecommerce.model.Order;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface OrderRepository extends BaseRepository<Order, Long> {
    Optional<Order> findByOrderCode(String orderCode);
    List<Order> findByCustomerId(Long customerId);
    List<Order> findByStatus(Order.Status status);
    List<Order> findByDateRange(LocalDateTime from, LocalDateTime to);
    BigDecimal sumRevenueByDateRange(LocalDateTime from, LocalDateTime to);
    List<Object[]> revenueByMonth(int year);
    List<Object[]> revenueByDay(int year, int month);
    long countByStatus(Order.Status status);
    long countToday();
}
