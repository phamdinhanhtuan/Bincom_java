package com.ecommerce.service;

import com.ecommerce.model.Product;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import org.springframework.web.multipart.MultipartFile;

public interface ProductService {
    Product createProduct(Product product, MultipartFile thumbnail, MultipartFile[] images);
    Product updateProduct(Product product, MultipartFile thumbnail, MultipartFile[] images);
    void deleteProduct(Long id);
    void toggleProductStatus(Long id);
    void toggleFeatured(Long id);
    Optional<Product> findById(Long id);
    List<Product> findAll();
    List<Product> findByCategory(Long categoryId);
    List<Product> searchByKeyword(String keyword);
    List<Product> searchByCategoryAndKeyword(Long categoryId, String keyword, BigDecimal minPrice, BigDecimal maxPrice);
    List<Product> findFeaturedProducts(int limit);
    List<Product> findLatestProducts(int limit);
    List<Product> findLowStockProducts();
    List<Object[]> findBestSelling(int limit);
    long countActiveProducts();
    void deleteProductImage(Long imageId);
    void deleteProductThumbnail(Long id);
}
