package com.ecommerce.repository;

import com.ecommerce.model.User;
import java.util.List;
import java.util.Optional;

public interface UserRepository extends BaseRepository<User, Long> {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    List<User> findByRole(String roleName);
    List<User> searchUsers(String keyword);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
    long countByRole(String roleName);
}
