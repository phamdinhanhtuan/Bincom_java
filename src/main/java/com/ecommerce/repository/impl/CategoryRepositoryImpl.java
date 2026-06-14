package com.ecommerce.repository.impl;

import com.ecommerce.model.Category;
import com.ecommerce.repository.CategoryRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class CategoryRepositoryImpl extends BaseRepositoryImpl<Category, Long>
        implements CategoryRepository {

    @Override
    public List<Category> findRootCategories() {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Category c WHERE c.parent IS NULL ORDER BY c.sortOrder ASC, c.name ASC", Category.class)
            .getResultList();
    }

    @Override
    public List<Category> findActiveCategories() {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Category c WHERE c.active = true ORDER BY c.sortOrder ASC, c.name ASC", Category.class)
            .getResultList();
    }

    @Override
    public Optional<Category> findByName(String name) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Category c WHERE c.name = :name", Category.class)
            .setParameter("name", name)
            .uniqueResultOptional();
    }
}
