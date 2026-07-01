package com.ecommerce.controller.customer;

import com.ecommerce.model.Product;
import com.ecommerce.model.Review;
import com.ecommerce.model.User;
import com.ecommerce.service.CategoryService;
import com.ecommerce.service.ProductService;
import com.ecommerce.service.ReviewService;
import com.ecommerce.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @Autowired private ProductService productService;
    @Autowired private CategoryService categoryService;
    @Autowired private ReviewService reviewService;
    @Autowired private UserService userService;

    @GetMapping(value = "", params = "ajax=suggest")
    @ResponseBody
    public List<String> suggest(@RequestParam(name = "keyword") String keyword) {
        List<Product> products = productService.searchByKeyword(keyword);
        List<String> suggestions = new java.util.ArrayList<>();
        for (Product p : products) {
            suggestions.add(p.getName());
            if (suggestions.size() >= 6) {
                break;
            }
        }
        return suggestions;
    }

    @GetMapping({"", "/"})
    public String shop(Model model,
                       @RequestParam(name = "keyword", required = false) String keyword,
                       @RequestParam(name = "categoryId", required = false) Long categoryId,
                       @RequestParam(name = "minPrice", required = false) BigDecimal minPrice,
                       @RequestParam(name = "maxPrice", required = false) BigDecimal maxPrice,
                       @RequestParam(name = "sort", defaultValue = "newest") String sort,
                       javax.servlet.http.HttpServletRequest request) {

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

        // SEO attributes & Breadcrumbs
        String pageTitle = "Cửa hàng — Bincom";
        String metaDescription = "Danh sách sản phẩm công nghệ điện thoại di động, laptop, phụ kiện giá rẻ chính hãng tại Bincom.";
        List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        
        java.util.Map<String, String> bc1 = new java.util.LinkedHashMap<>();
        bc1.put("name", "Cửa hàng");
        bc1.put("url", request.getContextPath() + "/shop");
        breadcrumbs.add(bc1);

        if (categoryId != null) {
            com.ecommerce.model.Category category = categoryService.findById(categoryId).orElse(null);
            if (category != null) {
                pageTitle = category.getName() + " chính hãng, giá tốt nhất — Bincom";
                metaDescription = "Mua sắm các sản phẩm " + category.getName() + " chính hãng, chất lượng cao, bảo hành đầy đủ tại Bincom.";
                
                java.util.Map<String, String> bc2 = new java.util.LinkedHashMap<>();
                bc2.put("name", category.getName());
                bc2.put("url", request.getContextPath() + "/shop?categoryId=" + categoryId);
                breadcrumbs.add(bc2);
            }
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            pageTitle = "Kết quả tìm kiếm cho \"" + keyword + "\" — Bincom";
            metaDescription = "Kết quả tìm kiếm sản phẩm \"" + keyword + "\" tại Bincom.";
        }

        model.addAttribute("pageTitle", pageTitle);
        model.addAttribute("metaDescription", metaDescription);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/shop";
    }

    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable Long id, Model model, javax.servlet.http.HttpServletRequest request) {
        Product product = productService.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));
        List<Product> related = new java.util.ArrayList<>();
        if (product.getCategory() != null) {
            related = productService.findByCategory(product.getCategory().getId());
            related.removeIf(p -> p.getId().equals(id));
            if (related.size() > 4) related = related.subList(0, 4);
        }

        List<Review> reviews = reviewService.findByProductIdAndApproved(id, true);
        double avgRating = 5.0;
        if (!reviews.isEmpty()) {
            avgRating = reviews.stream().mapToInt(Review::getRating).average().orElse(5.0);
        }

        model.addAttribute("product",          product);
        model.addAttribute("relatedProducts",  related);
        model.addAttribute("categories",       categoryService.findActiveCategories());
        model.addAttribute("reviews",          reviews);
        model.addAttribute("avgRating",        avgRating);
        model.addAttribute("reviewsCount",     reviews.size());

        // SEO attributes
        model.addAttribute("pageTitle", product.getName() + " — Giá tốt tại Bincom");
        model.addAttribute("metaDescription", "Mua " + product.getName() + " chính hãng, giá " + product.getEffectivePrice() + "đ, bảo hành 12 tháng tại Bincom.");

        // Breadcrumbs: Home -> Cửa hàng -> Category -> Product Name
        List<java.util.Map<String, String>> breadcrumbs = new java.util.ArrayList<>();
        java.util.Map<String, String> bc1 = new java.util.LinkedHashMap<>();
        bc1.put("name", "Cửa hàng");
        bc1.put("url", request.getContextPath() + "/shop");
        breadcrumbs.add(bc1);

        if (product.getCategory() != null) {
            java.util.Map<String, String> bc2 = new java.util.LinkedHashMap<>();
            bc2.put("name", product.getCategory().getName());
            bc2.put("url", request.getContextPath() + "/shop?categoryId=" + product.getCategory().getId());
            breadcrumbs.add(bc2);
        }

        java.util.Map<String, String> bc3 = new java.util.LinkedHashMap<>();
        bc3.put("name", product.getName());
        bc3.put("url", request.getContextPath() + "/shop/product/" + product.getId());
        breadcrumbs.add(bc3);

        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/product-detail";
    }

    @PostMapping("/product/{id}/review")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addReview(
            @PathVariable Long id,
            @RequestParam Integer rating,
            @RequestParam String comment,
            Authentication auth) {

        Map<String, Object> response = new HashMap<>();
        try {
            if (auth == null || !auth.isAuthenticated()) {
                response.put("success", false);
                response.put("message", "Vui lòng đăng nhập để gửi đánh giá.");
                return ResponseEntity.ok(response);
            }

            Product product = productService.findById(id)
                .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));

            User user = userService.findByUsername(auth.getName())
                .orElseThrow(() -> new RuntimeException("Tài khoản không tồn tại"));

            Review review = new Review();
            review.setProduct(product);
            review.setUser(user);
            review.setRating(rating);
            review.setComment(comment);
            review.setApproved(true); // Automatically approve for instant feedback in demo

            reviewService.save(review);

            response.put("success", true);
            response.put("message", "✓ Đã gửi đánh giá thành công!");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/api/wishlist")
    @ResponseBody
    public java.util.List<java.util.Map<String, Object>> getWishlistProducts(@RequestParam(value = "ids", required = false) java.util.List<Long> ids) {
        java.util.List<java.util.Map<String, Object>> result = new java.util.ArrayList<>();
        if (ids == null || ids.isEmpty()) return result;
        for (Long id : ids) {
            productService.findById(id).ifPresent(p -> {
                java.util.Map<String, Object> map = new java.util.HashMap<>();
                map.put("id", p.getId());
                map.put("name", p.getName());
                map.put("price", p.getPrice());
                map.put("effectivePrice", p.getEffectivePrice());
                map.put("thumbnailUrl", p.getThumbnailUrl());
                map.put("onSale", p.isOnSale());
                result.add(map);
            });
        }
        return result;
    }
}
