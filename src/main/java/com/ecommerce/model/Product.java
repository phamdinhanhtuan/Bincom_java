package com.ecommerce.model;

import com.ecommerce.util.ImageUrlHelper;
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

    // -------------------------------------------------------------------------
    // Business logic helpers
    // -------------------------------------------------------------------------

    /**
     * Returns the effective selling price.
     * Uses {@code salePrice} when it is set, positive, and less than {@code price};
     * otherwise falls back to the regular {@code price}.
     */
    public BigDecimal getEffectivePrice() {
        return isOnSale() ? salePrice : price;
    }

    /**
     * Returns {@code true} when a valid sale price is present and lower than
     * the regular price.
     */
    public boolean isOnSale() {
        return salePrice != null
                && salePrice.compareTo(BigDecimal.ZERO) > 0
                && salePrice.compareTo(price) < 0;
    }

    /**
     * Returns a ready-to-use thumbnail URL, or {@code null} if no image is
     * available. The view layer is responsible for rendering a CSS placeholder
     * when this returns {@code null}.
     *
     * <p>Delegates file-existence resolution to {@link ImageUrlHelper} so that
     * this model stays free of filesystem and UI concerns (SRP).
     */
    public String getThumbnailUrl() {
        return ImageUrlHelper.resolve(thumbnailUrl);
    }
}
