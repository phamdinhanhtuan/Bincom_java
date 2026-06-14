package com.ecommerce.service;

import com.ecommerce.model.Order;
import com.ecommerce.model.CartItem;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface OrderService {
    Order createOrder(Long customerId, List<CartItem> cartItems, String recipientName,
                      String recipientPhone, String shippingAddress, String paymentMethod,
                      String note, String couponCode);
    Order updateOrderStatus(Long orderId, Order.Status newStatus, Long processedBy);
    Order cancelOrder(Long orderId, Long userId);
    Optional<Order> findById(Long id);
    Optional<Order> findByOrderCode(String orderCode);
    List<Order> findByCustomerId(Long customerId);
    List<Order> findAll();
    List<Order> findByStatus(Order.Status status);
    List<Order> findByDateRange(LocalDateTime from, LocalDateTime to);
    BigDecimal getTodayRevenue();
    BigDecimal getMonthRevenue();
    BigDecimal getTotalRevenue();
    List<Object[]> getRevenueByMonth(int year);
    List<Object[]> getRevenueByDay(int year, int month);
    long countPendingOrders();
    long countTodayOrders();
}
