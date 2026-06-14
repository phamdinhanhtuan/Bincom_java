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
    public String myOrders(Authentication auth, Model model) {
        User user = userService.findByUsername(auth.getName()).orElseThrow();
        List<Order> orders = orderService.findByCustomerId(user.getId());
        model.addAttribute("orders", orders);
        return "customer/orders";
    }

    @GetMapping("/{orderCode}")
    public String orderDetail(@PathVariable String orderCode,
                              Authentication auth,
                              Model model) {
        Order order = orderService.findByOrderCode(orderCode)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
        User user = userService.findByUsername(auth.getName()).orElseThrow();

        // Security check: customer can only see their own orders
        if (!order.getCustomer().getId().equals(user.getId())) {
            return "redirect:/orders";
        }

        model.addAttribute("order", order);
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
    public String trackOrder(@RequestParam(required = false) String orderCode, Model model) {
        if (orderCode != null && !orderCode.isEmpty()) {
            orderService.findByOrderCode(orderCode)
                .ifPresentOrElse(
                    order -> model.addAttribute("order", order),
                    () -> model.addAttribute("notFound", true)
                );
        }
        model.addAttribute("orderCode", orderCode);
        return "customer/order-tracking";
    }
}
