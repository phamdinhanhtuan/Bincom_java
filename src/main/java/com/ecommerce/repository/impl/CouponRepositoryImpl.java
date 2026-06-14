package com.ecommerce.repository.impl;

import com.ecommerce.model.Coupon;
import com.ecommerce.repository.CouponRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class CouponRepositoryImpl extends BaseRepositoryImpl<Coupon, Long>
        implements CouponRepository {

    @Override
    public Optional<Coupon> findByCode(String code) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Coupon c WHERE c.code = :code", Coupon.class)
            .setParameter("code", code)
            .uniqueResultOptional();
    }
}
