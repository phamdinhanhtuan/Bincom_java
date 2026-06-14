package com.ecommerce.service.impl;

import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import com.ecommerce.service.EmailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.text.NumberFormat;
import java.util.Locale;

@Service
public class EmailServiceImpl implements EmailService {

    private static final Logger log = LoggerFactory.getLogger(EmailServiceImpl.class);

    @Autowired
    private JavaMailSender mailSender;

    @Override
    @Async
    public void sendOrderConfirmationEmail(String to, Order order) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject("Xác nhận đơn hàng #" + order.getOrderCode());
            helper.setText(buildOrderConfirmationHtml(order), true);
            mailSender.send(message);
            log.info("Order confirmation email sent to {}", to);
        } catch (MessagingException e) {
            log.error("Failed to send order confirmation email to {}: {}", to, e.getMessage());
        }
    }

    @Override
    @Async
    public void sendPasswordResetEmail(String to, String resetToken) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject("Đặt lại mật khẩu - ECommerce Shop");
            helper.setText(buildPasswordResetHtml(resetToken), true);
            mailSender.send(message);
        } catch (MessagingException e) {
            log.error("Failed to send password reset email: {}", e.getMessage());
        }
    }

    @Override
    @Async
    public void sendWelcomeEmail(String to, String fullName) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject("Chào mừng bạn đến với ECommerce Shop!");
            helper.setText(buildWelcomeHtml(fullName), true);
            mailSender.send(message);
        } catch (MessagingException e) {
            log.error("Failed to send welcome email: {}", e.getMessage());
        }
    }

    @Override
    @Async
    public void sendOrderStatusUpdateEmail(String to, Order order) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject("Cập nhật đơn hàng #" + order.getOrderCode());
            helper.setText(buildStatusUpdateHtml(order), true);
            mailSender.send(message);
        } catch (MessagingException e) {
            log.error("Failed to send status update email: {}", e.getMessage());
        }
    }

    private String buildOrderConfirmationHtml(Order order) {
        NumberFormat fmt = NumberFormat.getInstance(new Locale("vi", "VN"));
        StringBuilder sb = new StringBuilder();
        sb.append("<!DOCTYPE html><html><head><meta charset='UTF-8'></head><body>");
        sb.append("<div style='font-family:Arial,sans-serif;max-width:600px;margin:0 auto;background:#f9f9f9;padding:20px;border-radius:8px;'>");
        sb.append("<div style='background:#6c63ff;padding:20px;border-radius:8px 8px 0 0;text-align:center;'>");
        sb.append("<h1 style='color:#fff;margin:0;font-size:24px;'>🛍️ ECommerce Shop</h1></div>");
        sb.append("<div style='background:#fff;padding:30px;border-radius:0 0 8px 8px;'>");
        sb.append("<h2 style='color:#333;'>Xác nhận đơn hàng thành công!</h2>");
        sb.append("<p>Cảm ơn bạn đã đặt hàng. Đơn hàng của bạn đã được tiếp nhận.</p>");
        sb.append("<div style='background:#f5f5f5;padding:15px;border-radius:8px;margin:20px 0;'>");
        sb.append("<strong>Mã đơn hàng:</strong> ").append(order.getOrderCode()).append("<br>");
        sb.append("<strong>Địa chỉ giao hàng:</strong> ").append(order.getShippingAddress()).append("<br>");
        sb.append("<strong>Phương thức thanh toán:</strong> ").append(order.getPaymentMethod()).append("</div>");
        sb.append("<h3>Chi tiết đơn hàng:</h3>");
        sb.append("<table style='width:100%;border-collapse:collapse;'>");
        sb.append("<tr style='background:#6c63ff;color:#fff;'><th style='padding:10px;text-align:left;'>Sản phẩm</th><th>SL</th><th>Đơn giá</th><th>Thành tiền</th></tr>");
        for (OrderItem item : order.getOrderItems()) {
            sb.append("<tr style='border-bottom:1px solid #eee;'>");
            sb.append("<td style='padding:10px;'>").append(item.getProductName()).append("</td>");
            sb.append("<td style='text-align:center;'>").append(item.getQuantity()).append("</td>");
            sb.append("<td style='text-align:right;'>").append(fmt.format(item.getUnitPrice())).append("₫</td>");
            sb.append("<td style='text-align:right;'>").append(fmt.format(item.getTotalPrice())).append("₫</td>");
            sb.append("</tr>");
        }
        sb.append("</table>");
        sb.append("<div style='text-align:right;margin-top:15px;'>");
        sb.append("<p>Phí vận chuyển: <strong>").append(fmt.format(order.getShippingFee())).append("₫</strong></p>");
        sb.append("<p>Giảm giá: <strong>-").append(fmt.format(order.getDiscountAmount())).append("₫</strong></p>");
        sb.append("<p style='font-size:18px;color:#6c63ff;'>Tổng cộng: <strong>").append(fmt.format(order.getTotalAmount())).append("₫</strong></p>");
        sb.append("</div>");
        sb.append("<p style='color:#777;font-size:12px;margin-top:30px;'>Cảm ơn bạn đã tin tưởng mua sắm tại ECommerce Shop!</p>");
        sb.append("</div></div></body></html>");
        return sb.toString();
    }

    private String buildPasswordResetHtml(String resetToken) {
        return "<h2>Đặt lại mật khẩu</h2><p>Token của bạn: <strong>" + resetToken + "</strong></p>";
    }

    private String buildWelcomeHtml(String fullName) {
        return "<h2>Chào mừng " + fullName + "!</h2><p>Tài khoản của bạn đã được tạo thành công.</p>";
    }

    private String buildStatusUpdateHtml(Order order) {
        return "<h2>Cập nhật đơn hàng #" + order.getOrderCode() + "</h2><p>Trạng thái mới: <strong>"
            + order.getStatus().getDisplayName() + "</strong></p>";
    }
}
