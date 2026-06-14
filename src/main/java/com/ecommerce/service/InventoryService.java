package com.ecommerce.service;

import com.ecommerce.model.Inventory;
import java.util.List;
import java.util.Optional;

public interface InventoryService {
    Inventory updateStock(Long productId, int quantity, int reorderLevel);
    Optional<Inventory> findByProductId(Long productId);
    List<Inventory> findLowStock();
}
