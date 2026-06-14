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
        model.addAttribute("featuredProducts", productService.findFeaturedProducts(15));
        model.addAttribute("latestProducts",   productService.findLatestProducts(15));
        model.addAttribute("categories",       categoryService.findActiveCategories());
        return "customer/home";
    }

    @GetMapping("/about")
    public String about() {
        return "customer/about";
    }

    @GetMapping("/contact")
    public String contact() {
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
