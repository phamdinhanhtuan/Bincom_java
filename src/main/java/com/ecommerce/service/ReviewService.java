package com.ecommerce.service;

import com.ecommerce.model.Review;
import java.util.List;
import java.util.Optional;

public interface ReviewService {
    Review save(Review review);
    Review update(Review review);
    void delete(Long id);
    Optional<Review> findById(Long id);
    List<Review> findByProductId(Long productId);
    List<Review> findByProductIdAndApproved(Long productId, boolean approved);
}
