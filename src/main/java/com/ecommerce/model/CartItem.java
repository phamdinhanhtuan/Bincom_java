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

    public BigDecimal getTotalPrice() {
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    public void incrementQuantity(int qty) {
        this.quantity += qty;
    }
}
