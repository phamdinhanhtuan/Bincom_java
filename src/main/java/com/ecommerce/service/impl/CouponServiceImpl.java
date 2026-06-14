package com.ecommerce.service.impl;

import com.ecommerce.model.Coupon;
import com.ecommerce.repository.CouponRepository;
import com.ecommerce.service.CouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Service
@Transactional(readOnly = true)
public class CouponServiceImpl implements CouponService {

    @Autowired private CouponRepository couponRepository;

    @Override
    public BigDecimal calculateDiscount(String couponCode, BigDecimal orderAmount) {
        Coupon coupon = couponRepository.findByCode(couponCode)
            .orElseThrow(() -> new RuntimeException("Mã giảm giá không hợp lệ: " + couponCode));
        if (!coupon.isValid()) {
            throw new RuntimeException("Mã giảm giá đã hết hạn hoặc đã dùng hết");
        }
        return coupon.calculateDiscount(orderAmount);
    }

    @Override
    public boolean isValid(String couponCode) {
        return couponRepository.findByCode(couponCode)
            .map(Coupon::isValid)
            .orElse(false);
    }
}
