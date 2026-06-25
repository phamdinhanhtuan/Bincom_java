package com.ecommerce.service;

import com.ecommerce.model.User;
import com.ecommerce.model.Role;
import java.util.List;
import java.util.Optional;

public interface UserService {
    User registerCustomer(User user);
    User createStaffUser(User user, String roleName);
    User updateUser(User user);
    User updateUser(User user, String roleName);
    void deleteUser(Long userId);
    void changePassword(Long userId, String oldPassword, String newPassword);
    void resetPassword(Long userId, String newPassword);
    void toggleUserStatus(Long userId);
    Optional<User> findById(Long id);
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    List<User> findAllCustomers();
    List<User> findAllStaff();
    List<User> findAll();
    List<User> searchUsers(String keyword);
    boolean isUsernameAvailable(String username);
    boolean isEmailAvailable(String email);
    long countCustomers();
    long countStaff();
}
