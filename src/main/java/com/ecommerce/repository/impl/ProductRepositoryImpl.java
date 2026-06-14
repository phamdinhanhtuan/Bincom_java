package com.ecommerce.repository.impl;

import com.ecommerce.model.Product;
import com.ecommerce.repository.ProductRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public class ProductRepositoryImpl extends BaseRepositoryImpl<Product, Long>
        implements ProductRepository {

    @Override
    public List<Product> findByCategory(Long categoryId) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Product p WHERE p.category.id = :catId AND p.active = true ORDER BY p.createdAt DESC",
                Product.class)
            .setParameter("catId", categoryId)
            .getResultList();
    }

    @Override
    public List<Product> searchByKeyword(String keyword) {
        String kw = "%" + keyword.toLowerCase() + "%";
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Product p WHERE p.active = true AND (LOWER(p.name) LIKE :kw OR LOWER(p.description) LIKE :kw OR LOWER(p.productCode) LIKE :kw) ORDER BY p.name",
                Product.class)
            .setParameter("kw", kw)
            .getResultList();
    }

    @Override
    public List<Product> findFeaturedProducts(int limit) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Product p WHERE p.featured = true AND p.active = true ORDER BY p.createdAt DESC",
                Product.class)
            .setMaxResults(limit)
            .getResultList();
    }

    @Override
    public List<Product> findLatestProducts(int limit) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Product p WHERE p.active = true ORDER BY p.createdAt DESC",
                Product.class)
            .setMaxResults(limit)
            .getResultList();
    }

    @Override
    public List<Product> findByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Product p WHERE p.active = true AND p.price BETWEEN :min AND :max ORDER BY p.price ASC",
                Product.class)
            .setParameter("min", minPrice)
            .setParameter("max", maxPrice)
            .getResultList();
    }

    @Override
    public List<Product> findLowStockProducts(int threshold) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM Product p WHERE p.active = true AND p.inventory.quantityInStock <= :threshold ORDER BY p.inventory.quantityInStock ASC",
                Product.class)
            .setParameter("threshold", threshold)
            .getResultList();
    }

    @Override
    public List<Object[]> findBestSelling(int limit) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "SELECT oi.product, SUM(oi.quantity) as totalSold FROM OrderItem oi GROUP BY oi.product ORDER BY totalSold DESC",
                Object[].class)
            .setMaxResults(limit)
            .getResultList();
    }

    @Override
    public long countActive() {
        return sessionFactory.getCurrentSession()
            .createQuery("SELECT COUNT(p) FROM Product p WHERE p.active = true", Long.class)
            .getSingleResult();
    }
}
