package com.ecommerce.model;

import lombok.*;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "inventory")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Inventory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false, unique = true)
    private Product product;

    @Column(name = "quantity_in_stock", nullable = false)
    private Integer quantityInStock = 0;

    @Column(name = "quantity_reserved")
    private Integer quantityReserved = 0;

    @Column(name = "reorder_level")
    private Integer reorderLevel = 10;

    @Column(name = "warehouse_location", length = 100)
    private String warehouseLocation;

    @UpdateTimestamp
    @Column(name = "last_updated")
    private LocalDateTime lastUpdated;

    public Integer getAvailableQuantity() {
        return quantityInStock - (quantityReserved != null ? quantityReserved : 0);
    }

    public boolean isLowStock() {
        return getAvailableQuantity() <= reorderLevel;
    }

    public boolean isOutOfStock() {
        return getAvailableQuantity() <= 0;
    }
}
