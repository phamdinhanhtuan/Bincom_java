package com.ecommerce.service.impl;

import com.ecommerce.model.Category;
import com.ecommerce.repository.CategoryRepository;
import com.ecommerce.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CategoryServiceImpl implements CategoryService {

    @Autowired private CategoryRepository categoryRepository;

    @Override
    public Category save(Category category) {
        if (category.getParent() != null && category.getParent().getId() == null) {
            category.setParent(null);
        }
        return categoryRepository.save(category);
    }

    @Override
    public Category update(Category category) {
        Category existing = categoryRepository.findById(category.getId())
            .orElseThrow(() -> new RuntimeException("Danh mục không tồn tại"));
        existing.setName(category.getName());
        existing.setDescription(category.getDescription());
        existing.setActive(category.isActive());
        
        if (category.getParent() != null && category.getParent().getId() != null) {
            Category parent = categoryRepository.findById(category.getParent().getId()).orElse(null);
            existing.setParent(parent);
        } else {
            existing.setParent(null);
        }
        
        if (category.getImageUrl() != null) {
            existing.setImageUrl(category.getImageUrl());
        }
        if (category.getSortOrder() != null) {
            existing.setSortOrder(category.getSortOrder());
        }
        return categoryRepository.update(existing);
    }

    @Autowired private org.hibernate.SessionFactory sessionFactory;

    @Override
    public void delete(Long id) {
        org.hibernate.Session session = sessionFactory.getCurrentSession();
        Category category = categoryRepository.findById(id).orElse(null);
        if (category == null) {
            throw new RuntimeException("Danh mục không tồn tại.");
        }

        // Check for subcategories
        Long childCount = (Long) session.createQuery("SELECT COUNT(c) FROM Category c WHERE c.parent.id = :categoryId")
            .setParameter("categoryId", id)
            .uniqueResult();
        if (childCount > 0) {
            throw new RuntimeException("Không thể xóa danh mục này vì đang có " + childCount + " danh mục con trực thuộc. Vui lòng di chuyển hoặc xóa các danh mục con trước.");
        }

        // Check for products
        Long productCount = (Long) session.createQuery("SELECT COUNT(p) FROM Product p WHERE p.category.id = :categoryId")
            .setParameter("categoryId", id)
            .uniqueResult();
        if (productCount > 0) {
            throw new RuntimeException("Không thể xóa danh mục này vì đang có " + productCount + " sản phẩm đang liên kết. Vui lòng di chuyển các sản phẩm sang danh mục khác trước.");
        }

        categoryRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Category> findById(Long id) {
        return categoryRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Category> findActiveCategories() {
        return categoryRepository.findActiveCategories();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Category> findRootCategories() {
        return categoryRepository.findRootCategories();
    }
}
