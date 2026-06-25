package com.ecommerce.controller.customer;

import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import com.ecommerce.service.OrderService;
import com.ecommerce.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderController {

    @Autowired private OrderService orderService;
    @Autowired private UserService userService;

    @GetMapping
    public String myOrders(Authentication auth, Model model, javax.servlet.http.HttpServletRequest request) {
        User user = userService.findByUsername(auth.getName()).orElseThrow();
        List<Order> orders = orderService.findByCustomerId(user.getId());
        model.addAttribute("orders", orders);

        model.addAttribute("pageTitle", "Đơn hàng của tôi — Bincom");
        model.addAttribute("metaDescription", "Xem danh sách và theo dõi lịch sử các đơn hàng đã đặt mua của bạn tại Bincom.");

        List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc1 = new java.util.LinkedHashMap<>();
        bc1.put("name", "Tài khoản");
        bc1.put("url", request.getContextPath() + "/account");
        breadcrumbs.add(bc1);

        java.util.Map<String, String> bc2 = new java.util.LinkedHashMap<>();
        bc2.put("name", "Đơn hàng của tôi");
        bc2.put("url", request.getContextPath() + "/orders");
        breadcrumbs.add(bc2);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/orders";
    }

    @GetMapping("/{orderCode}")
    public String orderDetail(@PathVariable String orderCode,
                              Authentication auth,
                              Model model,
                              javax.servlet.http.HttpServletRequest request) {
        Order order = orderService.findByOrderCode(orderCode)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
        User user = userService.findByUsername(auth.getName()).orElseThrow();

        // Security check: customer can only see their own orders
        if (!order.getCustomer().getId().equals(user.getId())) {
            return "redirect:/orders";
        }

        model.addAttribute("order", order);

        model.addAttribute("pageTitle", "Chi tiết đơn hàng " + orderCode + " — Bincom");
        model.addAttribute("metaDescription", "Chi tiết sản phẩm, tổng tiền thanh toán và trạng thái vận chuyển của đơn hàng " + orderCode + " tại Bincom.");

        List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc1 = new java.util.LinkedHashMap<>();
        bc1.put("name", "Tài khoản");
        bc1.put("url", request.getContextPath() + "/account");
        breadcrumbs.add(bc1);

        java.util.Map<String, String> bc2 = new java.util.LinkedHashMap<>();
        bc2.put("name", "Đơn hàng của tôi");
        bc2.put("url", request.getContextPath() + "/orders");
        breadcrumbs.add(bc2);

        java.util.Map<String, String> bc3 = new java.util.LinkedHashMap<>();
        bc3.put("name", "Chi tiết đơn hàng");
        bc3.put("url", request.getContextPath() + "/orders/" + orderCode);
        breadcrumbs.add(bc3);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/order-detail";
    }

    @PostMapping("/{orderCode}/cancel")
    public String cancelOrder(@PathVariable String orderCode,
                              Authentication auth,
                              RedirectAttributes redirectAttrs) {
        try {
            Order order = orderService.findByOrderCode(orderCode).orElseThrow();
            User user = userService.findByUsername(auth.getName()).orElseThrow();
            orderService.cancelOrder(order.getId(), user.getId());
            redirectAttrs.addFlashAttribute("success", "Đã hủy đơn hàng thành công.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/orders/" + orderCode;
    }

    @GetMapping("/track")
    public String trackOrder(@RequestParam(name = "orderCode", required = false) String orderCode, Model model, javax.servlet.http.HttpServletRequest request) {
        if (orderCode != null && !orderCode.isEmpty()) {
            orderService.findByOrderCode(orderCode)
                .ifPresentOrElse(
                    order -> model.addAttribute("order", order),
                    () -> model.addAttribute("notFound", true)
                );
        }
        model.addAttribute("orderCode", orderCode);

        model.addAttribute("pageTitle", "Tra cứu đơn hàng — Bincom");
        model.addAttribute("metaDescription", "Tra cứu trạng thái vận chuyển và thông tin đơn hàng nhanh chóng, chính xác tại Bincom.");

        List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc = new java.util.LinkedHashMap<>();
        bc.put("name", "Tra cứu đơn hàng");
        bc.put("url", request.getContextPath() + "/orders/track");
        breadcrumbs.add(bc);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/order-tracking";
    }
}
