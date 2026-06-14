package com.ecommerce.controller.admin;

import com.ecommerce.model.Product;
import com.ecommerce.service.InventoryService;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/inventory")
public class AdminInventoryController {

    @Autowired private ProductService productService;
    @Autowired private InventoryService inventoryService;

    @GetMapping
    public String list(Model model,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(required = false) String stockStatus) {

        List<Product> allProducts = productService.findAll();

        // Filter by stock status
        List<Product> products = allProducts;
        if ("low".equals(stockStatus)) {
            products = allProducts.stream()
                .filter(p -> p.getInventory() != null && p.getInventory().isLowStock()
                             && p.getInventory().getQuantityInStock() > 0)
                .collect(Collectors.toList());
        } else if ("out".equals(stockStatus)) {
            products = allProducts.stream()
                .filter(p -> p.getInventory() != null && p.getInventory().getQuantityInStock() == 0)
                .collect(Collectors.toList());
        } else if ("ok".equals(stockStatus)) {
            products = allProducts.stream()
                .filter(p -> p.getInventory() != null && !p.getInventory().isLowStock())
                .collect(Collectors.toList());
        }

        // Filter by keyword
        if (keyword != null && !keyword.isEmpty()) {
            String kw = keyword.toLowerCase();
            products = products.stream()
                .filter(p -> p.getName().toLowerCase().contains(kw)
                          || (p.getProductCode() != null && p.getProductCode().toLowerCase().contains(kw)))
                .collect(Collectors.toList());
        }

        // Statistics
        long totalProducts  = allProducts.size();
        long outOfStockCount = allProducts.stream()
            .filter(p -> p.getInventory() != null && p.getInventory().getQuantityInStock() == 0)
            .count();
        long lowStockCount = allProducts.stream()
            .filter(p -> p.getInventory() != null && p.getInventory().isLowStock()
                         && p.getInventory().getQuantityInStock() > 0)
            .count();
        long inStockCount = totalProducts - outOfStockCount - lowStockCount;

        model.addAttribute("products",        products);
        model.addAttribute("keyword",         keyword);
        model.addAttribute("stockStatus",     stockStatus);
        model.addAttribute("totalProducts",   totalProducts);
        model.addAttribute("inStockCount",    inStockCount);
        model.addAttribute("lowStockCount",   lowStockCount);
        model.addAttribute("outOfStockCount", outOfStockCount);

        return "admin/inventory/list";
    }
}
