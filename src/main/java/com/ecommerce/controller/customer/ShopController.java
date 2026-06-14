package com.ecommerce.controller.customer;

import com.ecommerce.model.Product;
import com.ecommerce.service.CategoryService;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @Autowired private ProductService productService;
    @Autowired private CategoryService categoryService;

    @GetMapping({"", "/"})
    public String shop(Model model,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(required = false) Long categoryId,
                       @RequestParam(required = false) BigDecimal minPrice,
                       @RequestParam(required = false) BigDecimal maxPrice,
                       @RequestParam(defaultValue = "newest") String sort) {

        List<Product> products = productService.searchByCategoryAndKeyword(
            categoryId, keyword, minPrice, maxPrice);

        // Sorting
        if ("price-asc".equals(sort)) {
            products.sort((a, b) -> a.getEffectivePrice().compareTo(b.getEffectivePrice()));
        } else if ("price-desc".equals(sort)) {
            products.sort((a, b) -> b.getEffectivePrice().compareTo(a.getEffectivePrice()));
        }

        model.addAttribute("products",   products);
        model.addAttribute("categories", categoryService.findActiveCategories());
        model.addAttribute("keyword",    keyword);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("minPrice",   minPrice);
        model.addAttribute("maxPrice",   maxPrice);
        model.addAttribute("sort",       sort);
        model.addAttribute("totalCount", products.size());
        return "customer/shop";
    }

    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        Product product = productService.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));
        List<Product> related = productService.findByCategory(product.getCategory().getId());
        related.removeIf(p -> p.getId().equals(id));
        if (related.size() > 4) related = related.subList(0, 4);

        model.addAttribute("product",          product);
        model.addAttribute("relatedProducts",  related);
        model.addAttribute("categories",       categoryService.findActiveCategories());
        return "customer/product-detail";
    }
}
