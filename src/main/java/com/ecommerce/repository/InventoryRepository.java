package com.ecommerce.repository;

import com.ecommerce.model.Inventory;
import java.util.Optional;

public interface InventoryRepository extends BaseRepository<Inventory, Long> {
    Optional<Inventory> findByProductId(Long productId);
    void updateStock(Long productId, int quantity);
}
