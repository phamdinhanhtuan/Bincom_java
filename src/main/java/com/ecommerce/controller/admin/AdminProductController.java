package com.ecommerce.controller.admin;

import com.ecommerce.model.Category;
import com.ecommerce.model.Inventory;
import com.ecommerce.model.Product;
import com.ecommerce.service.CategoryService;
import com.ecommerce.service.ProductService;
import com.ecommerce.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/admin/products")
public class AdminProductController {

    @Autowired private ProductService productService;
    @Autowired private CategoryService categoryService;
    @Autowired private InventoryService inventoryService;

    @GetMapping
    public String list(Model model,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(required = false) Long categoryId) {
        List<Product> products;
        if (keyword != null && !keyword.isEmpty()) {
            products = productService.searchByKeyword(keyword);
        } else if (categoryId != null) {
            products = productService.findByCategory(categoryId);
        } else {
            products = productService.findAll();
        }
        model.addAttribute("products",   products);
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("keyword",    keyword);
        model.addAttribute("categoryId", categoryId);
        return "admin/product/list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("product",    new Product());
        model.addAttribute("categories", categoryService.findActiveCategories());
        return "admin/product/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute Product product,
                       BindingResult result,
                       @RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnail,
                       @RequestParam(value = "imageFiles",    required = false) MultipartFile[] images,
                       @RequestParam(value = "stockQty",      defaultValue = "0") int stockQty,
                       @RequestParam(value = "reorderLevel",  defaultValue = "10") int reorderLevel,
                       Model model,
                       RedirectAttributes redirectAttrs) {

        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.findActiveCategories());
            return "admin/product/form";
        }

        try {
            Product saved = productService.createProduct(product, thumbnail, images);
            // Update inventory
            inventoryService.updateStock(saved.getId(), stockQty, reorderLevel);
            redirectAttrs.addFlashAttribute("success", "Thêm sản phẩm thành công!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Product product = productService.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));
        model.addAttribute("product",    product);
        model.addAttribute("categories", categoryService.findActiveCategories());
        return "admin/product/form";
    }

    @PostMapping("/{id}/update")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute Product product,
                         BindingResult result,
                         @RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnail,
                         @RequestParam(value = "imageFiles",    required = false) MultipartFile[] images,
                         @RequestParam(value = "stockQty",      required = false) Integer stockQty,
                         @RequestParam(value = "reorderLevel",  required = false) Integer reorderLevel,
                         Model model,
                         RedirectAttributes redirectAttrs) {

        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.findActiveCategories());
            return "admin/product/form";
        }

        product.setId(id);
        try {
            productService.updateProduct(product, thumbnail, images);
            if (stockQty != null) {
                inventoryService.updateStock(id, stockQty, reorderLevel != null ? reorderLevel : 10);
            }
            redirectAttrs.addFlashAttribute("success", "Cập nhật sản phẩm thành công!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/products";
    }

    @PostMapping("/{id}/toggle-status")
    public String toggleStatus(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        productService.toggleProductStatus(id);
        redirectAttrs.addFlashAttribute("success", "Đã thay đổi trạng thái sản phẩm.");
        return "redirect:/admin/products";
    }

    @PostMapping("/{id}/toggle-featured")
    public String toggleFeatured(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        productService.toggleFeatured(id);
        redirectAttrs.addFlashAttribute("success", "Đã thay đổi nổi bật sản phẩm.");
        return "redirect:/admin/products";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        try {
            productService.deleteProduct(id);
            redirectAttrs.addFlashAttribute("success", "Đã xóa sản phẩm!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "Không thể xóa sản phẩm: " + e.getMessage());
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/{id}/detail")
    public String detail(@PathVariable Long id, Model model) {
        Product product = productService.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));
        model.addAttribute("product", product);
        return "admin/product/detail";
    }

    @PostMapping("/images/{imageId}/delete")
    @ResponseBody
    public org.springframework.http.ResponseEntity<String> deleteImage(@PathVariable Long imageId) {
        try {
            productService.deleteProductImage(imageId);
            return new org.springframework.http.ResponseEntity<>("OK", org.springframework.http.HttpStatus.OK);
        } catch (Exception e) {
            return new org.springframework.http.ResponseEntity<>(e.getMessage(), org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
