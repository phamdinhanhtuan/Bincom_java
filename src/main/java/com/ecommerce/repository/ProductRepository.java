package com.ecommerce.repository;

import com.ecommerce.model.Product;
import java.math.BigDecimal;
import java.util.List;

public interface ProductRepository extends BaseRepository<Product, Long> {
    List<Product> findByCategory(Long categoryId);
    List<Product> searchByKeyword(String keyword);
    List<Product> findFeaturedProducts(int limit);
    List<Product> findLatestProducts(int limit);
    List<Product> findByPriceRange(BigDecimal minPrice, BigDecimal maxPrice);
    List<Product> findLowStockProducts(int threshold);
    List<Object[]> findBestSelling(int limit);
    long countActive();
}
