package com.ecommerce.service.impl;

import com.ecommerce.model.*;
import com.ecommerce.repository.*;
import com.ecommerce.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired private OrderRepository orderRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private ProductRepository productRepository;
    @Autowired private InventoryRepository inventoryRepository;
    @Autowired private CouponRepository couponRepository;
    @Autowired private EmailService emailService;

    @Override
    public Order createOrder(Long customerId, List<CartItem> cartItems, String recipientName,
                             String recipientPhone, String shippingAddress, String paymentMethod,
                             String note, String couponCode) {

        User customer = userRepository.findById(customerId)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy khách hàng"));

        // Build order
        Order order = new Order();
        order.setOrderCode(generateOrderCode());
        order.setCustomer(customer);
        order.setRecipientName(recipientName);
        order.setRecipientPhone(recipientPhone);
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setNote(note);
        order.setStatus(Order.Status.PENDING);

        // Build order items + calculate subtotal
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem cartItem : cartItems) {
            Product product = productRepository.findById(cartItem.getProductId())
                .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại: " + cartItem.getProductId()));

            // Check stock
            Inventory inventory = product.getInventory();
            if (inventory == null || inventory.getAvailableQuantity() < cartItem.getQuantity()) {
                throw new RuntimeException("Sản phẩm '" + product.getName() + "' không đủ hàng");
            }

            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setProduct(product);
            item.setProductName(product.getName());
            item.setProductThumbnail(product.getThumbnailUrl());
            item.setQuantity(cartItem.getQuantity());
            item.setUnitPrice(product.getEffectivePrice());
            item.calculateTotal();

            order.getOrderItems().add(item);
            subtotal = subtotal.add(item.getTotalPrice());

            // Reserve stock
            inventory.setQuantityReserved(inventory.getQuantityReserved() + cartItem.getQuantity());
            inventoryRepository.update(inventory);
        }

        order.setSubtotal(subtotal);

        // Shipping fee logic
        BigDecimal shippingFee = subtotal.compareTo(new BigDecimal("500000")) >= 0
            ? BigDecimal.ZERO : new BigDecimal("30000");
        order.setShippingFee(shippingFee);

        // Apply coupon
        BigDecimal discountAmount = BigDecimal.ZERO;
        if (couponCode != null && !couponCode.isEmpty()) {
            Optional<Coupon> couponOpt = couponRepository.findByCode(couponCode);
            if (couponOpt.isPresent() && couponOpt.get().isValid()) {
                Coupon coupon = couponOpt.get();
                discountAmount = coupon.calculateDiscount(subtotal);
                order.setCouponCode(couponCode);
                coupon.setUsedCount(coupon.getUsedCount() + 1);
                couponRepository.update(coupon);
            }
        }
        order.setDiscountAmount(discountAmount);
        order.setTotalAmount(subtotal.add(shippingFee).subtract(discountAmount));

        // Save order
        Order savedOrder = orderRepository.save(order);

        // Create payment record
        Payment payment = new Payment();
        payment.setOrder(savedOrder);
        payment.setAmount(savedOrder.getTotalAmount());
        payment.setStatus("COD".equals(paymentMethod) ? Payment.Status.PENDING : Payment.Status.PENDING);
        try {
            payment.setMethod(Payment.Method.valueOf(paymentMethod));
        } catch (IllegalArgumentException e) {
            payment.setMethod(Payment.Method.COD);
        }

        // Send confirmation email (async)
        try {
            emailService.sendOrderConfirmationEmail(customer.getEmail(), savedOrder);
        } catch (Exception e) {
            // Log but don't fail the order
        }

        return savedOrder;
    }

    @Override
    public Order updateOrderStatus(Long orderId, Order.Status newStatus, Long processedBy) {
        Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));

        Order.Status oldStatus = order.getStatus();
        order.setStatus(newStatus);

        if (processedBy != null) {
            userRepository.findById(processedBy).ifPresent(order::setProcessedBy);
        }

        // If completed: deduct stock reservation
        if (newStatus == Order.Status.COMPLETED && oldStatus != Order.Status.COMPLETED) {
            for (OrderItem item : order.getOrderItems()) {
                Inventory inventory = item.getProduct().getInventory();
                if (inventory != null) {
                    inventory.setQuantityInStock(inventory.getQuantityInStock() - item.getQuantity());
                    inventory.setQuantityReserved(
                        Math.max(0, inventory.getQuantityReserved() - item.getQuantity()));
                    inventoryRepository.update(inventory);
                }
            }
        }

        // If cancelled: release reservation
        if (newStatus == Order.Status.CANCELLED && 
            (oldStatus == Order.Status.PENDING || oldStatus == Order.Status.CONFIRMED || oldStatus == Order.Status.SHIPPING)) {
            for (OrderItem item : order.getOrderItems()) {
                Inventory inventory = item.getProduct().getInventory();
                if (inventory != null) {
                    inventory.setQuantityReserved(
                        Math.max(0, inventory.getQuantityReserved() - item.getQuantity()));
                    inventoryRepository.update(inventory);
                }
            }
        }

        return orderRepository.update(order);
    }

    @Override
    public Order cancelOrder(Long orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
        if (order.getStatus() != Order.Status.PENDING) {
            throw new RuntimeException("Chỉ có thể hủy đơn hàng đang chờ xác nhận");
        }
        return updateOrderStatus(orderId, Order.Status.CANCELLED, userId);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Order> findById(Long id) {
        return orderRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Order> findByOrderCode(String orderCode) {
        return orderRepository.findByOrderCode(orderCode);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order> findByCustomerId(Long customerId) {
        return orderRepository.findByCustomerId(customerId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order> findByStatus(Order.Status status) {
        return orderRepository.findByStatus(status);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order> findByDateRange(LocalDateTime from, LocalDateTime to) {
        return orderRepository.findByDateRange(from, to);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getTodayRevenue() {
        LocalDateTime start = LocalDateTime.now().toLocalDate().atStartOfDay();
        LocalDateTime end = start.plusDays(1);
        return orderRepository.sumRevenueByDateRange(start, end);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getMonthRevenue() {
        YearMonth ym = YearMonth.now();
        LocalDateTime start = ym.atDay(1).atStartOfDay();
        LocalDateTime end = ym.atEndOfMonth().atTime(23, 59, 59);
        return orderRepository.sumRevenueByDateRange(start, end);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getTotalRevenue() {
        return orderRepository.sumRevenueByDateRange(
            LocalDateTime.of(2000, 1, 1, 0, 0),
            LocalDateTime.now().plusDays(1));
    }

    @Override
    @Transactional(readOnly = true)
    public List<Object[]> getRevenueByMonth(int year) {
        return orderRepository.revenueByMonth(year);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Object[]> getRevenueByDay(int year, int month) {
        return orderRepository.revenueByDay(year, month);
    }

    @Override
    @Transactional(readOnly = true)
    public long countPendingOrders() {
        return orderRepository.countByStatus(Order.Status.PENDING);
    }

    @Override
    @Transactional(readOnly = true)
    public long countTodayOrders() {
        return orderRepository.countToday();
    }

    private String generateOrderCode() {
        return "ORD" + System.currentTimeMillis();
    }
}
