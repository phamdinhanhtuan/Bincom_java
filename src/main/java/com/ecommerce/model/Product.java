package com.ecommerce.model;

import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "products")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Tên sản phẩm không được để trống")
    @Size(max = 200)
    @Column(nullable = false, length = 200)
    private String name;

    @Column(name = "product_code", unique = true, length = 50)
    private String productCode;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "short_description", length = 500)
    private String shortDescription;

    @NotNull(message = "Giá không được để trống")
    @DecimalMin(value = "0.0", inclusive = false, message = "Giá phải lớn hơn 0")
    @Column(nullable = false, precision = 15, scale = 2)
    private BigDecimal price;

    @Column(name = "sale_price", precision = 15, scale = 2)
    private BigDecimal salePrice;

    @Column(name = "thumbnail_url")
    private String thumbnailUrl;

    @Column(nullable = false)
    private boolean active = true;

    @Column(name = "is_featured")
    private boolean featured = false;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @OneToOne(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Inventory inventory;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ProductImage> images = new ArrayList<>();

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Review> reviews = new ArrayList<>();

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Helper: get effective price
    public BigDecimal getEffectivePrice() {
        return (salePrice != null && salePrice.compareTo(BigDecimal.ZERO) > 0
                && salePrice.compareTo(price) < 0)
                ? salePrice : price;
    }

    public boolean isOnSale() {
        return salePrice != null && salePrice.compareTo(BigDecimal.ZERO) > 0
                && salePrice.compareTo(price) < 0;
    }

    public String getThumbnailUrl() {
        if (thumbnailUrl == null || thumbnailUrl.trim().isEmpty()) {
            return "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200' viewBox='0 0 200 200'><rect width='100%' height='100%' fill='%23f4f6f9'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='14' fill='%23999'>No Image</text></svg>";
        }
        if (thumbnailUrl.startsWith("data:")) {
            return thumbnailUrl;
        }
        if (thumbnailUrl.startsWith("/uploads/")) {
            String fileName = thumbnailUrl.substring(thumbnailUrl.lastIndexOf("/") + 1);
            if (fileName.equals("books.jpg") || fileName.equals("headphone.jpg") || 
                fileName.equals("iphone15.jpg") || fileName.equals("iphone15_alt.jpg") || 
                fileName.equals("jacket.jpg") || fileName.equals("nike.jpg") || 
                fileName.equals("samsung_s24.jpg") || fileName.equals("watch.jpg") ||
                fileName.equals(".gitkeep")) {
                return thumbnailUrl;
            }
            try {
                String userDir = System.getProperty("user.dir");
                java.io.File[] possiblePaths = {
                    new java.io.File(userDir, "src/main/webapp" + thumbnailUrl),
                    new java.io.File(userDir, "target/ECommerceSystem" + thumbnailUrl),
                    new java.io.File(userDir, "webapps/ROOT" + thumbnailUrl),
                    new java.io.File(userDir, "webapps/ECommerceSystem" + thumbnailUrl),
                    new java.io.File(userDir, "work/Catalina/localhost/ECommerceSystem" + thumbnailUrl)
                };
                for (java.io.File file : possiblePaths) {
                    if (file.exists() && file.isFile()) {
                        return thumbnailUrl;
                    }
                }
            } catch (Exception ignored) {}
            return "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200' viewBox='0 0 200 200'><rect width='100%' height='100%' fill='%23f4f6f9'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='12' fill='%23999'>No Image</text></svg>";
        }
        return thumbnailUrl;
    }
}
