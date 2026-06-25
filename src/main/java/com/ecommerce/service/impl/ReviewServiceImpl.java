package com.ecommerce.service.impl;

import com.ecommerce.model.Review;
import com.ecommerce.repository.ReviewRepository;
import com.ecommerce.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Override
    public Review save(Review review) {
        return reviewRepository.save(review);
    }

    @Override
    public Review update(Review review) {
        return reviewRepository.update(review);
    }

    @Override
    public void delete(Long id) {
        reviewRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Review> findById(Long id) {
        return reviewRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Review> findByProductId(Long productId) {
        return reviewRepository.findByProductId(productId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Review> findByProductIdAndApproved(Long productId, boolean approved) {
        return reviewRepository.findByProductIdAndApproved(productId, approved);
    }
}
