package com.ecommerce.repository;

import com.ecommerce.model.Category;
import java.util.List;
import java.util.Optional;

public interface CategoryRepository extends BaseRepository<Category, Long> {
    List<Category> findRootCategories();
    List<Category> findActiveCategories();
    Optional<Category> findByName(String name);
}
