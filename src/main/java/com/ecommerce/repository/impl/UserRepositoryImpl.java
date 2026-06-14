package com.ecommerce.repository.impl;

import com.ecommerce.model.User;
import com.ecommerce.repository.UserRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class UserRepositoryImpl extends BaseRepositoryImpl<User, Long> implements UserRepository {

    @Override
    public Optional<User> findByUsername(String username) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM User u WHERE u.username = :username", User.class)
            .setParameter("username", username)
            .uniqueResultOptional();
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM User u WHERE u.email = :email", User.class)
            .setParameter("email", email)
            .uniqueResultOptional();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> findByRole(String roleName) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "SELECT DISTINCT u FROM User u JOIN u.roles r WHERE r.name = :roleName ORDER BY u.fullName",
                User.class)
            .setParameter("roleName", roleName)
            .getResultList();
    }

    @Override
    public List<User> searchUsers(String keyword) {
        String likeKeyword = "%" + keyword.toLowerCase() + "%";
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM User u WHERE LOWER(u.fullName) LIKE :kw OR LOWER(u.email) LIKE :kw OR LOWER(u.username) LIKE :kw ORDER BY u.createdAt DESC",
                User.class)
            .setParameter("kw", likeKeyword)
            .getResultList();
    }

    @Override
    public boolean existsByUsername(String username) {
        Long count = sessionFactory.getCurrentSession()
            .createQuery("SELECT COUNT(u) FROM User u WHERE u.username = :username", Long.class)
            .setParameter("username", username)
            .getSingleResult();
        return count > 0;
    }

    @Override
    public boolean existsByEmail(String email) {
        Long count = sessionFactory.getCurrentSession()
            .createQuery("SELECT COUNT(u) FROM User u WHERE u.email = :email", Long.class)
            .setParameter("email", email)
            .getSingleResult();
        return count > 0;
    }

    @Override
    public long countByRole(String roleName) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "SELECT COUNT(DISTINCT u) FROM User u JOIN u.roles r WHERE r.name = :roleName",
                Long.class)
            .setParameter("roleName", roleName)
            .getSingleResult();
    }
}
