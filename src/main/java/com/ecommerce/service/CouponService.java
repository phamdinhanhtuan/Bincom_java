package com.ecommerce.service;

import java.math.BigDecimal;

public interface CouponService {
    BigDecimal calculateDiscount(String couponCode, BigDecimal orderAmount);
    boolean isValid(String couponCode);
}
