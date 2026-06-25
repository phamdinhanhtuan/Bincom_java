package com.ecommerce.service.impl;

import com.ecommerce.model.Role;
import com.ecommerce.model.User;
import com.ecommerce.repository.UserRepository;
import com.ecommerce.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private org.hibernate.SessionFactory sessionFactory;

    @Override
    public User registerCustomer(User user) {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("Tên đăng nhập đã tồn tại: " + user.getUsername());
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email đã được sử dụng: " + user.getEmail());
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setEnabled(true);
        // Assign ROLE_CUSTOMER by default
        Role customerRole = new Role();
        customerRole.setId(5); // ROLE_CUSTOMER id in DB
        user.getRoles().add(customerRole);
        return userRepository.save(user);
    }

    @Override
    public User createStaffUser(User user, String roleName) {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("Tên đăng nhập đã tồn tại: " + user.getUsername());
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email đã được sử dụng: " + user.getEmail());
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setEnabled(true);
        
        Role role = sessionFactory.getCurrentSession()
            .createQuery("FROM Role r WHERE r.name = :roleName", Role.class)
            .setParameter("roleName", roleName)
            .uniqueResult();
        if (role != null) {
            user.getRoles().add(role);
        } else {
            Role customerRole = new Role();
            customerRole.setId(5);
            user.getRoles().add(customerRole);
        }
        return userRepository.save(user);
    }

    @Override
    public User updateUser(User user) {
        User existing = userRepository.findById(user.getId())
            .orElseThrow(() -> new RuntimeException("Người dùng không tồn tại"));
        if (!existing.getEmail().equals(user.getEmail()) && userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email đã được sử dụng: " + user.getEmail());
        }
        existing.setFullName(user.getFullName());
        existing.setEmail(user.getEmail());
        existing.setPhoneNumber(user.getPhoneNumber());
        existing.setAddress(user.getAddress());
        existing.setEnabled(user.isEnabled());
        return userRepository.update(existing);
    }

    @Override
    public User updateUser(User user, String roleName) {
        User existing = userRepository.findById(user.getId())
            .orElseThrow(() -> new RuntimeException("Người dùng không tồn tại"));
        if (!existing.getEmail().equals(user.getEmail()) && userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email đã được sử dụng: " + user.getEmail());
        }
        existing.setFullName(user.getFullName());
        existing.setEmail(user.getEmail());
        existing.setPhoneNumber(user.getPhoneNumber());
        existing.setAddress(user.getAddress());
        existing.setEnabled(user.isEnabled());

        if (roleName != null && !roleName.isEmpty()) {
            Role role = sessionFactory.getCurrentSession()
                .createQuery("FROM Role r WHERE r.name = :roleName", Role.class)
                .setParameter("roleName", roleName)
                .uniqueResult();
            if (role != null) {
                existing.getRoles().clear();
                existing.getRoles().add(role);
            }
        }
        return userRepository.update(existing);
    }

    @Override
    public void deleteUser(Long userId) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            throw new RuntimeException("Tài khoản không tồn tại.");
        }

        org.hibernate.Session session = sessionFactory.getCurrentSession();
        
        // Check for orders
        Long orderCount = (Long) session.createQuery("SELECT COUNT(o) FROM Order o WHERE o.customer.id = :userId")
            .setParameter("userId", userId)
            .uniqueResult();
        if (orderCount > 0) {
            throw new RuntimeException("Không thể xóa tài khoản này vì đang có " + orderCount + " đơn hàng liên quan. Vui lòng chuyển trạng thái tài khoản sang 'Bị khóa' thay vì xóa.");
        }

        // Check for reviews
        Long reviewCount = (Long) session.createQuery("SELECT COUNT(r) FROM Review r WHERE r.user.id = :userId")
            .setParameter("userId", userId)
            .uniqueResult();
        if (reviewCount > 0) {
            throw new RuntimeException("Không thể xóa tài khoản này vì đang có " + reviewCount + " đánh giá sản phẩm. Vui lòng chuyển trạng thái tài khoản sang 'Bị khóa' thay vì xóa.");
        }

        userRepository.deleteById(userId);
    }

    @Override
    public void changePassword(Long userId, String oldPassword, String newPassword) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new RuntimeException("Mật khẩu cũ không đúng");
        }
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.update(user);
    }

    @Override
    public void resetPassword(Long userId, String newPassword) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.update(user);
    }

    @Override
    public void toggleUserStatus(Long userId) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        user.setEnabled(!user.isEnabled());
        userRepository.update(user);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> findAllCustomers() {
        return userRepository.findByRole("ROLE_CUSTOMER");
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> findAllStaff() {
        List<User> staff = new ArrayList<>();
        staff.addAll(userRepository.findByRole("ROLE_ADMIN"));
        staff.addAll(userRepository.findByRole("ROLE_STORE_MANAGER"));
        staff.addAll(userRepository.findByRole("ROLE_SALES_STAFF"));
        staff.addAll(userRepository.findByRole("ROLE_WAREHOUSE_STAFF"));
        return staff;
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> searchUsers(String keyword) {
        return userRepository.searchUsers(keyword);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isUsernameAvailable(String username) {
        return !userRepository.existsByUsername(username);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isEmailAvailable(String email) {
        return !userRepository.existsByEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public long countCustomers() {
        return userRepository.countByRole("ROLE_CUSTOMER");
    }

    @Override
    @Transactional(readOnly = true)
    public long countStaff() {
        return userRepository.countByRole("ROLE_ADMIN")
             + userRepository.countByRole("ROLE_STORE_MANAGER")
             + userRepository.countByRole("ROLE_SALES_STAFF")
             + userRepository.countByRole("ROLE_WAREHOUSE_STAFF");
    }
}
