package com.ecommerce.repository.impl;

import com.ecommerce.model.Inventory;
import com.ecommerce.repository.InventoryRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class InventoryRepositoryImpl extends BaseRepositoryImpl<Inventory, Long>
        implements InventoryRepository {

    @Override
    public Optional<Inventory> findByProductId(Long productId) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Inventory i WHERE i.product.id = :pid", Inventory.class)
            .setParameter("pid", productId)
            .uniqueResultOptional();
    }

    @Override
    public void updateStock(Long productId, int quantity) {
        sessionFactory.getCurrentSession()
            .createQuery("UPDATE Inventory i SET i.quantityInStock = :qty WHERE i.product.id = :pid")
            .setParameter("qty", quantity)
            .setParameter("pid", productId)
            .executeUpdate();
    }
}
