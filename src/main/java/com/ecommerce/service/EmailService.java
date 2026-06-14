package com.ecommerce.service;

import com.ecommerce.model.Order;

public interface EmailService {
    void sendOrderConfirmationEmail(String to, Order order);
    void sendPasswordResetEmail(String to, String resetToken);
    void sendWelcomeEmail(String to, String fullName);
    void sendOrderStatusUpdateEmail(String to, Order order);
}
