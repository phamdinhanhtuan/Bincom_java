package com.ecommerce.model;

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

    public String getImageUrl() {
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            return "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200' viewBox='0 0 200 200'><rect width='100%' height='100%' fill='%23f4f6f9'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='14' fill='%23999'>No Image</text></svg>";
        }
        if (imageUrl.startsWith("data:")) {
            return imageUrl;
        }
        if (imageUrl.startsWith("/uploads/")) {
            String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
            if (fileName.equals("books.jpg") || fileName.equals("headphone.jpg") || 
                fileName.equals("iphone15.jpg") || fileName.equals("iphone15_alt.jpg") || 
                fileName.equals("jacket.jpg") || fileName.equals("nike.jpg") || 
                fileName.equals("samsung_s24.jpg") || fileName.equals("watch.jpg") ||
                fileName.equals(".gitkeep")) {
                return imageUrl;
            }
            try {
                String userDir = System.getProperty("user.dir");
                java.io.File[] possiblePaths = {
                    new java.io.File(userDir, "src/main/webapp" + imageUrl),
                    new java.io.File(userDir, "target/ECommerceSystem" + imageUrl),
                    new java.io.File(userDir, "webapps/ROOT" + imageUrl),
                    new java.io.File(userDir, "webapps/ECommerceSystem" + imageUrl),
                    new java.io.File(userDir, "work/Catalina/localhost/ECommerceSystem" + imageUrl)
                };
                for (java.io.File file : possiblePaths) {
                    if (file.exists() && file.isFile()) {
                        return imageUrl;
                    }
                }
            } catch (Exception ignored) {}
            return "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200' viewBox='0 0 200 200'><rect width='100%' height='100%' fill='%23f4f6f9'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='12' fill='%23999'>No Image</text></svg>";
        }
        return imageUrl;
    }
}
