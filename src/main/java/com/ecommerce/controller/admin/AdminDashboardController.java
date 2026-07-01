package com.ecommerce.controller.admin;

import com.ecommerce.model.Order;
import com.ecommerce.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

    @Autowired private OrderService orderService;
    @Autowired private ProductService productService;
    @Autowired private UserService userService;
    @Autowired private DatabaseBackupService databaseBackupService;

    @GetMapping({"", "/", "/dashboard"})
    public String dashboard(Model model) {
        // Stats cards
        model.addAttribute("totalRevenue",     orderService.getTotalRevenue());
        model.addAttribute("todayRevenue",     orderService.getTodayRevenue());
        model.addAttribute("monthRevenue",     orderService.getMonthRevenue());
        model.addAttribute("pendingOrders",    orderService.countPendingOrders());
        model.addAttribute("todayOrders",      orderService.countTodayOrders());
        model.addAttribute("totalCustomers",   userService.countCustomers());
        model.addAttribute("totalProducts",    productService.countActiveProducts());

        // Chart: Revenue by month (current year)
        int currentYear = LocalDateTime.now().getYear();
        List<Object[]> revenueByMonth = orderService.getRevenueByMonth(currentYear);
        model.addAttribute("revenueByMonth",   revenueByMonth);
        model.addAttribute("currentYear",      currentYear);

        // Best selling products
        model.addAttribute("bestSelling",      productService.findBestSelling(10));

        // Low stock products
        model.addAttribute("lowStockProducts", productService.findLowStockProducts());

        // Recent orders
        model.addAttribute("recentOrders",     orderService.findByStatus(Order.Status.PENDING));

        return "admin/dashboard";
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(required = false) String error,
                            @RequestParam(required = false) String logout,
                            Model model) {
        if (error != null) model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
        if (logout != null) model.addAttribute("message", "Bạn đã đăng xuất thành công.");
        return "admin/login";
    }

    @GetMapping("/api/revenue-data")
    @ResponseBody
    public Map<String, Object> getRevenueData(
            @RequestParam(defaultValue = "0") int year,
            @RequestParam(defaultValue = "0") int month) {
        Map<String, Object> response = new HashMap<>();
        int currentYear = year == 0 ? LocalDateTime.now().getYear() : year;
        List<Object[]> data = month > 0
            ? orderService.getRevenueByDay(currentYear, month)
            : orderService.getRevenueByMonth(currentYear);
        response.put("data", data);
        response.put("year", currentYear);
        return response;
    }

    @GetMapping("/backup")
    public String backupDatabase(org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttrs) {
        try {
            databaseBackupService.exportDatabase();
            redirectAttrs.addFlashAttribute("success", "Đã sao lưu toàn bộ dữ liệu và hình ảnh (Base64) vào file database_setup.sql thành công!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Lỗi sao lưu: " + e.getMessage());
        }
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/download-backup")
    public void downloadBackup(javax.servlet.http.HttpServletResponse response) {
        try {
            // First, trigger a fresh export to make sure database_setup.sql is up to date
            databaseBackupService.exportDatabase();
            
            String userDir = System.getProperty("user.dir");
            java.io.File file = new java.io.File(userDir, "database_setup.sql");
            if (userDir.contains("/target") || userDir.contains("/src")) {
                file = new java.io.File(userDir.substring(0, userDir.indexOf("/target")), "database_setup.sql");
            }
            
            if (file.exists()) {
                response.setContentType("application/sql");
                response.setHeader("Content-Disposition", "attachment; filename=\"database_setup.sql\"");
                try (java.io.InputStream is = new java.io.FileInputStream(file);
                     java.io.OutputStream os = response.getOutputStream()) {
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        os.write(buffer, 0, bytesRead);
                    }
                    os.flush();
                }
            } else {
                response.sendError(javax.servlet.http.HttpServletResponse.SC_NOT_FOUND, "Backup file not found.");
            }
        } catch (Exception e) {
            try {
                response.sendError(javax.servlet.http.HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            } catch (Exception ignored) {}
        }
    }
}
