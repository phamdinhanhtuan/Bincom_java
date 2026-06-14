package com.ecommerce.controller.admin;

import com.ecommerce.model.Category;
import com.ecommerce.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping("/admin/categories")
public class AdminCategoryController {

    @Autowired private CategoryService categoryService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("categories", categoryService.findAll());
        return "admin/category/list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("category", new Category());
        model.addAttribute("parents",  categoryService.findRootCategories());
        return "admin/category/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute Category category,
                       BindingResult result,
                       Model model,
                       RedirectAttributes redirectAttrs) {
        if (result.hasErrors()) {
            model.addAttribute("parents", categoryService.findRootCategories());
            return "admin/category/form";
        }
        try {
            categoryService.save(category);
            redirectAttrs.addFlashAttribute("success", "Thêm danh mục thành công!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/categories";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Category cat = categoryService.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục"));
        model.addAttribute("category", cat);
        model.addAttribute("parents",  categoryService.findRootCategories());
        return "admin/category/form";
    }

    @PostMapping("/{id}/update")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute Category category,
                         BindingResult result,
                         Model model,
                         RedirectAttributes redirectAttrs) {
        category.setId(id);
        if (result.hasErrors()) {
            model.addAttribute("parents", categoryService.findRootCategories());
            return "admin/category/form";
        }
        categoryService.update(category);
        redirectAttrs.addFlashAttribute("success", "Cập nhật danh mục thành công!");
        return "redirect:/admin/categories";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        try {
            categoryService.delete(id);
            redirectAttrs.addFlashAttribute("success", "Đã xóa danh mục!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Không thể xóa: " + e.getMessage());
        }
        return "redirect:/admin/categories";
    }
}
