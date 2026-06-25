package com.ecommerce.service.impl;

import com.ecommerce.model.*;
import com.ecommerce.repository.*;
import com.ecommerce.service.ProductService;
import com.ecommerce.util.FileUploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    @Autowired private ProductRepository productRepository;
    @Autowired private InventoryRepository inventoryRepository;
    @Autowired private CategoryRepository categoryRepository;
    @Autowired private FileUploadUtil fileUploadUtil;
    @Autowired private org.hibernate.SessionFactory sessionFactory;

    private boolean isProductCodeExists(String productCode, Long excludeId) {
        if (productCode == null || productCode.trim().isEmpty()) {
            return false;
        }
        org.hibernate.Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(p) FROM Product p WHERE LOWER(p.productCode) = :code";
        if (excludeId != null) {
            hql += " AND p.id <> :excludeId";
        }
        org.hibernate.query.Query<Long> query = session.createQuery(hql, Long.class)
            .setParameter("code", productCode.trim().toLowerCase());
        if (excludeId != null) {
            query.setParameter("excludeId", excludeId);
        }
        return query.uniqueResult() > 0;
    }

    @Override
    public Product createProduct(Product product, MultipartFile thumbnail, MultipartFile[] images) {
        // Fetch managed Category
        if (product.getCategory() != null && product.getCategory().getId() != null) {
            Category cat = categoryRepository.findById(product.getCategory().getId()).orElse(null);
            product.setCategory(cat);
        } else {
            product.setCategory(null);
        }

        // Generate product code if not provided
        if (product.getProductCode() == null || product.getProductCode().trim().isEmpty()) {
            product.setProductCode("PRD-" + java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        } else {
            product.setProductCode(product.getProductCode().trim());
        }

        // Validate uniqueness of product code
        if (isProductCodeExists(product.getProductCode(), null)) {
            throw new RuntimeException("Mã sản phẩm (SKU) '" + product.getProductCode() + "' đã tồn tại trong hệ thống! Vui lòng chọn mã khác.");
        }

        // Handle thumbnail upload
        if (thumbnail != null && !thumbnail.isEmpty()) {
            String thumbnailUrl = fileUploadUtil.uploadFile(thumbnail, "products");
            product.setThumbnailUrl(thumbnailUrl);
        }

        Product savedProduct = productRepository.save(product);

        // Handle additional images
        if (images != null) {
            for (int i = 0; i < images.length; i++) {
                if (!images[i].isEmpty()) {
                    String imageUrl = fileUploadUtil.uploadFile(images[i], "products");
                    ProductImage img = new ProductImage();
                    img.setProduct(savedProduct);
                    img.setImageUrl(imageUrl);
                    img.setSortOrder(i);
                    img.setPrimary(i == 0);
                    savedProduct.getImages().add(img);
                }
            }
        }

        // Initialize inventory
        Inventory inventory = new Inventory();
        inventory.setProduct(savedProduct);
        inventory.setQuantityInStock(0);
        inventoryRepository.save(inventory);

        return savedProduct;
    }

    @Override
    public Product updateProduct(Product product, MultipartFile thumbnail, MultipartFile[] images) {
        Product existing = productRepository.findById(product.getId())
            .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));

        String newCode = product.getProductCode();
        if (newCode != null) {
            newCode = newCode.trim();
        }
        if (newCode == null || newCode.isEmpty()) {
            newCode = "PRD-" + java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        }

        // Validate uniqueness of product code
        if (isProductCodeExists(newCode, product.getId())) {
            throw new RuntimeException("Mã sản phẩm (SKU) '" + newCode + "' đã tồn tại trong hệ thống! Vui lòng chọn mã khác.");
        }

        existing.setName(product.getName());
        existing.setProductCode(newCode);
        
        // Fetch managed Category
        if (product.getCategory() != null && product.getCategory().getId() != null) {
            Category cat = categoryRepository.findById(product.getCategory().getId()).orElse(null);
            existing.setCategory(cat);
        } else {
            existing.setCategory(null);
        }

        existing.setPrice(product.getPrice());
        existing.setSalePrice(product.getSalePrice());
        existing.setShortDescription(product.getShortDescription());
        existing.setDescription(product.getDescription());
        existing.setActive(product.isActive());
        existing.setFeatured(product.isFeatured());

        // Handle thumbnail upload
        if (thumbnail != null && !thumbnail.isEmpty()) {
            if (existing.getThumbnailUrl() != null && !existing.getThumbnailUrl().isEmpty()) {
                fileUploadUtil.deleteFile(existing.getThumbnailUrl());
            }
            String thumbnailUrl = fileUploadUtil.uploadFile(thumbnail, "products");
            existing.setThumbnailUrl(thumbnailUrl);
        }

        // Handle additional images
        if (images != null) {
            for (int i = 0; i < images.length; i++) {
                if (!images[i].isEmpty()) {
                    String imageUrl = fileUploadUtil.uploadFile(images[i], "products");
                    ProductImage img = new ProductImage();
                    img.setProduct(existing);
                    img.setImageUrl(imageUrl);
                    img.setSortOrder(existing.getImages().size() + i);
                    existing.getImages().add(img);
                }
            }
        }

        return productRepository.update(existing);
    }

    @Override
    public void deleteProduct(Long id) {
        Product product = productRepository.findById(id).orElse(null);
        if (product != null) {
            org.hibernate.Session session = sessionFactory.getCurrentSession();
            Long orderCount = (Long) session.createQuery("select count(oi) from OrderItem oi where oi.product.id = :productId")
                .setParameter("productId", id)
                .uniqueResult();
            
            if (orderCount > 0) {
                product.setActive(false);
                productRepository.update(product);
                throw new RuntimeException("Sản phẩm đã tồn tại trong lịch sử mua hàng. Hệ thống đã tự động chuyển trạng thái của sản phẩm sang 'Ngừng kinh doanh' để bảo toàn dữ liệu hóa đơn.");
            }

            if (product.getThumbnailUrl() != null && !product.getThumbnailUrl().isEmpty()) {
                fileUploadUtil.deleteFile(product.getThumbnailUrl());
            }
            if (product.getImages() != null) {
                for (ProductImage img : product.getImages()) {
                    fileUploadUtil.deleteFile(img.getImageUrl());
                }
            }
            productRepository.delete(product);
        }
    }

    @Override
    public void toggleProductStatus(Long id) {
        Product product = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));
        product.setActive(!product.isActive());
        productRepository.update(product);
    }

    @Override
    public void toggleFeatured(Long id) {
        Product product = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));
        product.setFeatured(!product.isFeatured());
        productRepository.update(product);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Product> findById(Long id) {
        Optional<Product> productOpt = productRepository.findById(id);
        productOpt.ifPresent(p -> {
            if (p.getImages() != null) {
                p.getImages().size(); // Force load
            }
        });
        return productOpt;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> findByCategory(Long categoryId) {
        return productRepository.findByCategory(categoryId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> searchByKeyword(String keyword) {
        return productRepository.searchByKeyword(keyword);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> searchByCategoryAndKeyword(Long categoryId, String keyword,
            BigDecimal minPrice, BigDecimal maxPrice) {
        List<Product> products;
        if (categoryId != null && keyword != null && !keyword.trim().isEmpty()) {
            products = productRepository.findByCategory(categoryId).stream()
                .filter(p -> p.getName().toLowerCase().contains(keyword.toLowerCase()))
                .collect(java.util.stream.Collectors.toList());
        } else if (categoryId != null) {
            products = productRepository.findByCategory(categoryId);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            products = productRepository.searchByKeyword(keyword);
        } else {
            products = productRepository.findAll();
        }

        if (minPrice != null) {
            products = products.stream()
                .filter(p -> p.getEffectivePrice().compareTo(minPrice) >= 0)
                .collect(java.util.stream.Collectors.toList());
        }
        if (maxPrice != null) {
            products = products.stream()
                .filter(p -> p.getEffectivePrice().compareTo(maxPrice) <= 0)
                .collect(java.util.stream.Collectors.toList());
        }
        return products;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> findFeaturedProducts(int limit) {
        return productRepository.findFeaturedProducts(limit);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> findLatestProducts(int limit) {
        return productRepository.findLatestProducts(limit);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> findLowStockProducts() {
        return productRepository.findLowStockProducts(10);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Object[]> findBestSelling(int limit) {
        return productRepository.findBestSelling(limit);
    }

    @Override
    @Transactional(readOnly = true)
    public long countActiveProducts() {
        return productRepository.countActive();
    }

    @Override
    public void deleteProductImage(Long imageId) {
        org.hibernate.Session session = sessionFactory.getCurrentSession();
        ProductImage img = session.get(ProductImage.class, imageId);
        if (img != null) {
            fileUploadUtil.deleteFile(img.getImageUrl());
            if (img.getProduct() != null && img.getProduct().getImages() != null) {
                img.getProduct().getImages().remove(img);
            }
            session.delete(img);
        }
    }

    @Override
    public void deleteProductThumbnail(Long id) {
        Product product = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));
        if (product.getThumbnailUrl() != null && !product.getThumbnailUrl().isEmpty()) {
            fileUploadUtil.deleteFile(product.getThumbnailUrl());
            product.setThumbnailUrl(null);
            productRepository.update(product);
        }
    }
}
