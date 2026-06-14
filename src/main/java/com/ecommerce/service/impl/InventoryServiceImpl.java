package com.ecommerce.service.impl;

import com.ecommerce.model.Inventory;
import com.ecommerce.repository.InventoryRepository;
import com.ecommerce.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class InventoryServiceImpl implements InventoryService {

    @Autowired private InventoryRepository inventoryRepository;

    @Override
    public Inventory updateStock(Long productId, int quantity, int reorderLevel) {
        Optional<Inventory> opt = inventoryRepository.findByProductId(productId);
        Inventory inventory = opt.orElseGet(Inventory::new);
        inventory.setQuantityInStock(quantity);
        inventory.setReorderLevel(reorderLevel);
        if (opt.isEmpty()) {
            return inventoryRepository.save(inventory);
        }
        return inventoryRepository.update(inventory);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Inventory> findByProductId(Long productId) {
        return inventoryRepository.findByProductId(productId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Inventory> findLowStock() {
        return inventoryRepository.findAll().stream()
            .filter(Inventory::isLowStock)
            .collect(Collectors.toList());
    }
}
