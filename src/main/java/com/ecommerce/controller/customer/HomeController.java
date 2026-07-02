package com.ecommerce.controller.customer;

import com.ecommerce.service.CategoryService;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

    @Autowired private ProductService productService;
    @Autowired private CategoryService categoryService;

    @GetMapping({"/", "/home", "/index.jsp"})
    public String home(Model model) {
        try {
            model.addAttribute("featuredProducts", productService.findFeaturedProducts(30));
            model.addAttribute("latestProducts",   productService.findLatestProducts(30));
            model.addAttribute("categories",       categoryService.findActiveCategories());
        } catch (Exception e) {
            System.err.println("Bincom Home: Database connectivity issue. Falling back to empty model. Error: " + e.getMessage());
            model.addAttribute("featuredProducts", new java.util.ArrayList<>());
            model.addAttribute("latestProducts",   new java.util.ArrayList<>());
            model.addAttribute("categories",       new java.util.ArrayList<>());
            model.addAttribute("dbError", "Hệ thống đang bảo trì kết nối cơ sở dữ liệu. Vui lòng quay lại sau.");
        }

        // SEO attributes (required by customer-header.jsp)
        model.addAttribute("pageTitle",
            "Bincom — Điện thoại, Laptop, Thời trang & Gia dụng chính hãng");
        model.addAttribute("metaDescription",
            "Mua điện thoại, laptop, thời trang, đồ gia dụng chính hãng tại Bincom. " +
            "Giá tốt nhất, bảo hành 12 tháng, giao hàng nhanh 2h toàn quốc.");
        model.addAttribute("metaKeywords",
            "bincom, điện thoại chính hãng, mua iphone giá tốt, samsung galaxy, " +
            "laptop giá rẻ, thời trang online, đồ gia dụng thông minh");
        return "customer/home";
    }

    @Autowired private javax.sql.DataSource dataSource;

    @GetMapping("/health")
    @org.springframework.web.bind.annotation.ResponseBody
    public String health() {
        return "UP";
    }

    @GetMapping(value = "/db-status", produces = "text/plain;charset=UTF-8")
    @org.springframework.web.bind.annotation.ResponseBody
    public String dbStatus() {
        StringBuilder sb = new StringBuilder();
        sb.append("--- Database Connection Status Diagnostics ---\n");
        sb.append("Current Time: ").append(new java.util.Date()).append("\n\n");
        
        try (java.sql.Connection conn = dataSource.getConnection()) {
            sb.append("Connection: SUCCESS\n");
            sb.append("Database Product Name: ").append(conn.getMetaData().getDatabaseProductName()).append("\n");
            sb.append("Database Product Version: ").append(conn.getMetaData().getDatabaseProductVersion()).append("\n");
            sb.append("Driver Name: ").append(conn.getMetaData().getDriverName()).append("\n");
            
            // Check tables
            String[] tables = {"roles", "users", "categories", "products"};
            for (String table : tables) {
                try (java.sql.Statement stmt = conn.createStatement();
                     java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM `" + table + "`")) {
                    if (rs.next()) {
                        sb.append("Table `").append(table).append("` count: ").append(rs.getInt(1)).append("\n");
                    }
                } catch (Exception ex) {
                    sb.append("Table `").append(table).append("` error: ").append(ex.getMessage()).append("\n");
                }
            }
        } catch (Exception ex) {
            sb.append("Connection: FAILED\n");
            sb.append("Error Message: ").append(ex.getMessage()).append("\n");
            sb.append("Error Class: ").append(ex.getClass().getName()).append("\n");
            java.io.StringWriter sw = new java.io.StringWriter();
            ex.printStackTrace(new java.io.PrintWriter(sw));
            sb.append("Stack Trace:\n").append(sw.toString()).append("\n");
        }
        return sb.toString();
    }

    @GetMapping("/about")
    public String about(Model model, javax.servlet.http.HttpServletRequest request) {
        model.addAttribute("pageTitle", "Về chúng tôi — Bincom");
        model.addAttribute("metaDescription", "Tìm hiểu về Bincom, hệ thống bán lẻ điện thoại, laptop, phụ kiện chính hãng hàng đầu.");
        model.addAttribute("metaKeywords", "về Bincom, giới thiệu Bincom, cửa hàng công nghệ");

        java.util.List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc = new java.util.LinkedHashMap<>();
        bc.put("name", "Về Bincom");
        bc.put("url", request.getContextPath() + "/about");
        breadcrumbs.add(bc);
        model.addAttribute("breadcrumbs", breadcrumbs);
        return "customer/about";
    }

    @GetMapping("/contact")
    public String contact(Model model, javax.servlet.http.HttpServletRequest request) {
        model.addAttribute("pageTitle", "Liên hệ hỗ trợ — Bincom");
        model.addAttribute("metaDescription", "Liên hệ với Bincom để được hỗ trợ mua hàng, bảo hành thiết bị di động, laptop nhanh chóng.");
        model.addAttribute("metaKeywords", "liên hệ Bincom, hotline Bincom, tổng đài hỗ trợ");

        java.util.List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc = new java.util.LinkedHashMap<>();
        bc.put("name", "Hỗ trợ khách hàng");
        bc.put("url", request.getContextPath() + "/contact");
        breadcrumbs.add(bc);
        model.addAttribute("breadcrumbs", breadcrumbs);
        return "customer/contact";
    }

    @PostMapping("/contact")
    public String submitContact(@RequestParam String name,
                                 @RequestParam String email,
                                 @RequestParam String message,
                                 @RequestParam(value = "honeypot", required = false) String honeypot,
                                 HttpSession session,
                                 RedirectAttributes redirectAttrs) {
        // 1. Spam control: Honeypot check
        if (honeypot != null && !honeypot.trim().isEmpty()) {
            // Silently redirect to look successful to spam bots
            return "redirect:/contact";
        }

        // 2. Spam control: Session cooldown (Rate limiting - 30 seconds)
        Long lastSubmitTime = (Long) session.getAttribute("lastContactSubmitTime");
        long currentTime = System.currentTimeMillis();
        if (lastSubmitTime != null && (currentTime - lastSubmitTime) < 30000) {
            redirectAttrs.addFlashAttribute("errorMessage", "Bạn gửi tin nhắn quá nhanh! Vui lòng thử lại sau 30 giây.");
            return "redirect:/contact";
        }

        // Save submission timestamp
        session.setAttribute("lastContactSubmitTime", currentTime);

        // Store success message
        redirectAttrs.addFlashAttribute("successMessage", "Gửi thông tin liên hệ thành công! Chúng tôi sẽ phản hồi sớm nhất.");
        return "redirect:/contact";
    }
}
