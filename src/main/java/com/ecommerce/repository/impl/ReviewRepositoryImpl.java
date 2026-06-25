package com.ecommerce.repository.impl;

import com.ecommerce.model.Review;
import com.ecommerce.repository.ReviewRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewRepositoryImpl extends BaseRepositoryImpl<Review, Long>
        implements ReviewRepository {

    @Override
    public List<Review> findByProductId(Long productId) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Review r WHERE r.product.id = :prodId ORDER BY r.createdAt DESC", Review.class)
            .setParameter("prodId", productId)
            .getResultList();
    }

    @Override
    public List<Review> findByProductIdAndApproved(Long productId, boolean approved) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Review r WHERE r.product.id = :prodId AND r.approved = :appr ORDER BY r.createdAt DESC", Review.class)
            .setParameter("prodId", productId)
            .setParameter("appr", approved)
            .getResultList();
    }
}
