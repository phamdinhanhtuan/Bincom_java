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

    @Override
    public void delete(Long id) {
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
