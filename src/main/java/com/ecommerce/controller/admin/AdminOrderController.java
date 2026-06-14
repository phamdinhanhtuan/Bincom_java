package com.ecommerce.controller.admin;

import com.ecommerce.model.Order;
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
@RequestMapping("/admin/orders")
public class AdminOrderController {

    @Autowired private OrderService orderService;
    @Autowired private UserService userService;

    @GetMapping
    public String list(Model model,
                       @RequestParam(required = false) String status,
                       @RequestParam(required = false) String orderCode) {

        List<Order> orders;
        if (orderCode != null && !orderCode.isEmpty()) {
            orders = orderService.findByOrderCode(orderCode)
                .map(List::of).orElse(List.of());
        } else if (status != null && !status.isEmpty()) {
            orders = orderService.findByStatus(Order.Status.valueOf(status));
        } else {
            orders = orderService.findAll();
        }

        model.addAttribute("orders",     orders);
        model.addAttribute("statuses",   Order.Status.values());
        model.addAttribute("filterStatus", status);
        return "admin/order/list";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Order order = orderService.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
        model.addAttribute("order",    order);
        model.addAttribute("statuses", Order.Status.values());
        return "admin/order/detail";
    }

    @PostMapping("/{id}/update-status")
    public String updateStatus(@PathVariable Long id,
                               @RequestParam String status,
                               Authentication auth,
                               RedirectAttributes redirectAttrs) {
        try {
            Order.Status newStatus = Order.Status.valueOf(status);
            String username = auth.getName();
            Long staffId = userService.findByUsername(username).map(u -> u.getId()).orElse(null);
            orderService.updateOrderStatus(id, newStatus, staffId);
            redirectAttrs.addFlashAttribute("success",
                "Cập nhật trạng thái đơn hàng thành công!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/orders/" + id;
    }

    @GetMapping("/reports")
    public String reports(Model model,
                          @RequestParam(defaultValue = "0") int year,
                          @RequestParam(defaultValue = "0") int month) {
        int currentYear = year == 0 ? java.time.LocalDateTime.now().getYear() : year;
        model.addAttribute("revenueByMonth", orderService.getRevenueByMonth(currentYear));
        model.addAttribute("currentYear",    currentYear);
        model.addAttribute("month",          month);
        if (month > 0) {
            model.addAttribute("revenueByDay", orderService.getRevenueByDay(currentYear, month));
        }
        return "admin/order/reports";
    }
}
