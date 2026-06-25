package com.ecommerce.repository;

import com.ecommerce.model.Review;
import java.util.List;

public interface ReviewRepository extends BaseRepository<Review, Long> {
    List<Review> findByProductId(Long productId);
    List<Review> findByProductIdAndApproved(Long productId, boolean approved);
}
