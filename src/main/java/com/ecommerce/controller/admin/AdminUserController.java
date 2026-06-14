package com.ecommerce.controller.admin;

import com.ecommerce.model.User;
import com.ecommerce.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/admin/users")
public class AdminUserController {

    @Autowired private UserService userService;

    @GetMapping
    public String list(Model model, @RequestParam(required = false) String keyword) {
        List<User> users = (keyword != null && !keyword.isEmpty())
            ? userService.searchUsers(keyword)
            : userService.findAll();
        model.addAttribute("users",   users);
        model.addAttribute("keyword", keyword);
        return "admin/user/list";
    }

    @GetMapping("/customers")
    public String customers(Model model) {
        model.addAttribute("users",    userService.findAllCustomers());
        model.addAttribute("pageTitle", "Danh sách khách hàng");
        return "admin/user/list";
    }

    @GetMapping("/staff")
    public String staff(Model model) {
        model.addAttribute("users",    userService.findAllStaff());
        model.addAttribute("pageTitle", "Danh sách nhân viên");
        return "admin/user/list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("user", new User());
        return "admin/user/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute User user,
                       BindingResult result,
                       @RequestParam(defaultValue = "ROLE_CUSTOMER") String roleName,
                       Model model,
                       RedirectAttributes redirectAttrs) {
        if (result.hasErrors()) {
            return "admin/user/form";
        }
        try {
            userService.createStaffUser(user, roleName);
            redirectAttrs.addFlashAttribute("success", "Tạo tài khoản thành công!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        User user = userService.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    @PostMapping("/{id}/toggle-status")
    public String toggleStatus(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        userService.toggleUserStatus(id);
        redirectAttrs.addFlashAttribute("success", "Đã thay đổi trạng thái tài khoản.");
        return "redirect:/admin/users";
    }

    @PostMapping("/{id}/reset-password")
    public String resetPassword(@PathVariable Long id,
                                @RequestParam String newPassword,
                                RedirectAttributes redirectAttrs) {
        userService.resetPassword(id, newPassword);
        redirectAttrs.addFlashAttribute("success", "Đã đặt lại mật khẩu thành công.");
        return "redirect:/admin/users/" + id;
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        try {
            userService.deleteUser(id);
            redirectAttrs.addFlashAttribute("success", "Đã xóa tài khoản!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Không thể xóa: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }
}
