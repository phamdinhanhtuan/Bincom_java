package com.ecommerce.repository;

import com.ecommerce.model.Coupon;
import java.util.Optional;

public interface CouponRepository extends BaseRepository<Coupon, Long> {
    Optional<Coupon> findByCode(String code);
}
