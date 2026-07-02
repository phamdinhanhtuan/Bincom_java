package com.ecommerce.model;

import com.ecommerce.util.ImageUrlHelper;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "product_images")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class ProductImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(name = "image_url", nullable = false)
    private String imageUrl;

    @Column(name = "alt_text", length = 200)
    private String altText;

    @Column(name = "is_primary")
    private boolean primary = false;

    @Column(name = "sort_order")
    private Integer sortOrder = 0;

    /**
     * Returns a ready-to-use image URL, or {@code null} if no image is
     * available. The view layer is responsible for rendering a CSS placeholder
     * when this returns {@code null}.
     *
     * <p>Delegates resolution to {@link ImageUrlHelper} (SRP).
     */
    public String getImageUrl() {
        return ImageUrlHelper.resolve(imageUrl);
    }
}
