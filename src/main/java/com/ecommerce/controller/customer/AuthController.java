package com.ecommerce.controller.customer;

import com.ecommerce.model.User;
import com.ecommerce.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
public class AuthController {

    @Autowired private UserService userService;

    @GetMapping("/login")
    public String loginPage(@RequestParam(name = "error", required = false) String error,
                            @RequestParam(name = "logout", required = false) String logout,
                            Model model,
                            javax.servlet.http.HttpServletRequest request) {
        if (error != null)  model.addAttribute("error",   "Tên đăng nhập hoặc mật khẩu không đúng!");
        if (logout != null) model.addAttribute("message", "Đăng xuất thành công.");

        model.addAttribute("pageTitle", "Đăng nhập tài khoản — Bincom");
        model.addAttribute("metaDescription", "Đăng nhập tài khoản Bincom để mua sắm điện thoại, laptop chính hãng và hưởng nhiều ưu đãi.");
        
        java.util.List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc = new java.util.LinkedHashMap<>();
        bc.put("name", "Đăng nhập");
        bc.put("url", request.getContextPath() + "/login");
        breadcrumbs.add(bc);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model, javax.servlet.http.HttpServletRequest request) {
        model.addAttribute("user", new User());

        model.addAttribute("pageTitle", "Đăng ký tài khoản mới — Bincom");
        model.addAttribute("metaDescription", "Đăng ký tài khoản Bincom để tích lũy điểm thưởng và nhận ngay ưu đãi giảm 5% cho đơn hàng đầu tiên.");

        java.util.List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc = new java.util.LinkedHashMap<>();
        bc.put("name", "Đăng ký");
        bc.put("url", request.getContextPath() + "/register");
        breadcrumbs.add(bc);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/register";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute User user,
                           BindingResult result,
                           @RequestParam String confirmPassword,
                           @RequestParam(value = "honeypot", required = false) String honeypot,
                           Model model,
                           RedirectAttributes redirectAttrs) {

        // Spam control: honeypot check
        if (honeypot != null && !honeypot.trim().isEmpty()) {
            // Silently redirect to login to make spam bots think it succeeded
            return "redirect:/login";
        }

        if (result.hasErrors()) {
            return "customer/register";
        }

        if (!user.getPassword().equals(confirmPassword)) {
            model.addAttribute("passwordError", "Mật khẩu xác nhận không khớp!");
            return "customer/register";
        }

        if (!userService.isUsernameAvailable(user.getUsername())) {
            model.addAttribute("usernameError", "Tên đăng nhập đã được sử dụng!");
            return "customer/register";
        }

        if (!userService.isEmailAvailable(user.getEmail())) {
            model.addAttribute("emailError", "Email đã được sử dụng!");
            return "customer/register";
        }

        try {
            userService.registerCustomer(user);
            redirectAttrs.addFlashAttribute("success",
                "Đăng ký thành công! Vui lòng đăng nhập.");
            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "customer/register";
        }
    }

    @GetMapping("/account")
    public String accountPage(Authentication auth, Model model, javax.servlet.http.HttpServletRequest request) {
        User user = userService.findByUsername(auth.getName()).orElseThrow();
        model.addAttribute("user", user);

        model.addAttribute("pageTitle", "Tài khoản của tôi — Bincom");
        model.addAttribute("metaDescription", "Quản lý thông tin cá nhân, địa chỉ giao hàng và đổi mật khẩu tài khoản của bạn tại Bincom.");

        java.util.List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc = new java.util.LinkedHashMap<>();
        bc.put("name", "Tài khoản của tôi");
        bc.put("url", request.getContextPath() + "/account");
        breadcrumbs.add(bc);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/account";
    }

    @PostMapping("/account/update")
    public String updateProfile(@ModelAttribute User user,
                                Authentication auth,
                                RedirectAttributes redirectAttrs) {
        User existing = userService.findByUsername(auth.getName()).orElseThrow();
        existing.setFullName(user.getFullName());
        existing.setPhoneNumber(user.getPhoneNumber());
        existing.setAddress(user.getAddress());
        userService.updateUser(existing);
        redirectAttrs.addFlashAttribute("success", "Cập nhật thông tin thành công!");
        return "redirect:/account";
    }

    @PostMapping("/account/change-password")
    public String changePassword(@RequestParam String oldPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmNewPassword,
                                 Authentication auth,
                                 RedirectAttributes redirectAttrs) {
        if (!newPassword.equals(confirmNewPassword)) {
            redirectAttrs.addFlashAttribute("error", "Mật khẩu mới không khớp!");
            return "redirect:/account";
        }
        try {
            User user = userService.findByUsername(auth.getName()).orElseThrow();
            userService.changePassword(user.getId(), oldPassword, newPassword);
            redirectAttrs.addFlashAttribute("success", "Đổi mật khẩu thành công!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/account";
    }
}
