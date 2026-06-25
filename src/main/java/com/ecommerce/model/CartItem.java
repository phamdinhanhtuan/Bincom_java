package com.ecommerce.model;

import lombok.*;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Cart item stored in HTTP Session (not DB)
 */
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class CartItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long productId;
    private String productName;
    private String thumbnailUrl;
    private BigDecimal unitPrice;
    private Integer quantity;
    private String size; // Selected product size (e.g. S, M, L, 39, 40...)

    public CartItem(Long productId, String productName, String thumbnailUrl, BigDecimal unitPrice, Integer quantity) {
        this.productId = productId;
        this.productName = productName;
        this.thumbnailUrl = thumbnailUrl;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.size = null;
    }

    public BigDecimal getTotalPrice() {
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    public void incrementQuantity(int qty) {
        this.quantity += qty;
    }
}
