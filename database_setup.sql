-- ============================================================
-- E-Commerce Shopping Management System
-- Database Schema + Sample Data
-- MySQL 8.x | UTF-8
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;

SET FOREIGN_KEY_CHECKS = 0;

-- ===== ROLES =====
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50)  NOT NULL UNIQUE COMMENT 'ROLE_ADMIN, ROLE_CUSTOMER, ...',
    description VARCHAR(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO roles (name, description) VALUES
('ROLE_ADMIN',           'Quản trị viên hệ thống'),
('ROLE_STORE_MANAGER',   'Quản lý cửa hàng'),
('ROLE_SALES_STAFF',     'Nhân viên bán hàng'),
('ROLE_WAREHOUSE_STAFF', 'Nhân viên kho hàng'),
('ROLE_CUSTOMER',        'Khách hàng');

-- ===== USERS =====
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id           BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    username     VARCHAR(50)  NOT NULL UNIQUE,
    password     VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    address      TEXT,
    avatar_url   VARCHAR(500),
    enabled      TINYINT(1) NOT NULL DEFAULT 1,
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Passwords are BCrypt encoded (cost=10): password = admin123
INSERT INTO users (full_name, email, username, password, phone_number, address, enabled) VALUES
('Quản Trị Viên',   'admin@bincom.vn',    'admin',    '$2a$10$QdJjHZCWvPxvuOc.S6rxGuZQwqBO9HARzhMw.VvuZOAc7d1G2DEDe', '0901234567', 'TP. Hồ Chí Minh', 1),
('Nguyễn Quản Lý',  'manager@bincom.vn',  'manager',  '$2a$10$uk7BFD39rqe3xeKyHUIUOO5ijHBHNJeDECBkDuDfRv8YzjrglXpQ2', '0902345678', 'TP. Hồ Chí Minh', 1),
('Trần Bán Hàng',   'sales@bincom.vn',    'sales',    '$2a$10$k.kOnft8DhmOGfaDajm2rO5FzxUSesB.OMwu2kyYjFl8p1lQIM6oK', '0903456789', 'TP. Hồ Chí Minh', 1),
('Lê Kho Hàng',     'warehouse@bincom.vn','warehouse', '$2a$10$tlpKz6y5JpgC8jwGOou2g.WigU8si/QHDXqRHvdZE0fohZVTX1INK', '0904567890', 'TP. Hồ Chí Minh', 1),
('Nguyễn Văn An',   'an@gmail.com',      'customer1','$2a$10$RB/jbDnNZSufbC6PMZgD7uNVw/8HrxkyciTpILLJ5w5Fj6iVAYecO', '0905678901', '123 Lê Lợi, Q1, HCM', 1),
('Phạm Thị Bình',   'binh@gmail.com',    'customer2','$2a$10$CACE1UJ8i3RuXnje8ZCf2e8Pl6fNyZ201wlDfZxdsIQYuHhrjJ5CO', '0906789012', '456 Nguyễn Huệ, Q1, HCM', 1);
-- All passwords = admin123


-- ===== USER_ROLES =====
CREATE TABLE user_roles (
    user_id BIGINT  NOT NULL,
    role_id INT     NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO user_roles (user_id, role_id) VALUES
(1, 1), -- admin → ROLE_ADMIN
(2, 2), -- manager → ROLE_STORE_MANAGER
(3, 3), -- sales → ROLE_SALES_STAFF
(4, 4), -- warehouse → ROLE_WAREHOUSE_STAFF
(5, 5), -- customer1 → ROLE_CUSTOMER
(6, 5); -- customer2 → ROLE_CUSTOMER

-- ===== CATEGORIES =====
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    image_url   VARCHAR(500),
    active      TINYINT(1) DEFAULT 1,
    sort_order  INT DEFAULT 0,
    parent_id   BIGINT,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO categories (name, description, active, sort_order) VALUES
('Điện tử',         'Sản phẩm điện tử, công nghệ',    1, 1),
('Thời trang',      'Quần áo, giày dép, phụ kiện',    1, 2),
('Gia dụng',        'Đồ dùng gia đình, nội thất',     1, 3),
('Sách & Văn phòng','Sách, dụng cụ học tập',          1, 4),
('Thể thao',        'Dụng cụ thể thao, fitness',      1, 5),
('Mỹ phẩm',         'Chăm sóc da, trang điểm',        1, 6);

-- ===== PRODUCTS =====
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id                BIGINT AUTO_INCREMENT PRIMARY KEY,
    name              VARCHAR(200) NOT NULL,
    product_code      VARCHAR(50)  UNIQUE,
    description       TEXT,
    short_description VARCHAR(500),
    price             DECIMAL(15,2) NOT NULL,
    sale_price        DECIMAL(15,2),
    thumbnail_url     VARCHAR(500),
    active            TINYINT(1) DEFAULT 1,
    is_featured       TINYINT(1) DEFAULT 0,
    category_id       BIGINT,
    created_at        DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at        DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO products (name, product_code, description, short_description, price, sale_price, active, is_featured, category_id) VALUES
('iPhone 15 Pro Max 256GB', 'PRD-001', 'iPhone 15 Pro Max với chip A17 Pro, camera 48MP, Dynamic Island và Action Button.', 'Smartphone cao cấp với chip A17 Pro', 34990000, 32990000, 1, 1, 1),
('Samsung Galaxy S24 Ultra', 'PRD-002', 'Samsung Galaxy S24 Ultra với S Pen, camera 200MP, màn hình 6.8 inch Dynamic AMOLED.', 'Flagship Android với S Pen tích hợp', 28990000, 26990000, 1, 1, 1),
('MacBook Air M3 13 inch', 'PRD-003', 'MacBook Air M3 với chip M3, màn hình Liquid Retina 13.6 inch, thời lượng pin 18 giờ.', 'Laptop siêu mỏng nhẹ với chip M3', 28990000, NULL, 1, 1, 1),
('Tai nghe AirPods Pro (2nd Gen)', 'PRD-004', 'AirPods Pro thế hệ 2 với Active Noise Cancellation, Transparency Mode và âm thanh không gian.', 'Tai nghe True Wireless cao cấp của Apple', 6290000, 5490000, 1, 0, 1),
('Apple Watch Series 9 45mm', 'PRD-005', 'Apple Watch Series 9 với chip S9, màn hình Always-On Retina, theo dõi sức khỏe toàn diện.', 'Đồng hồ thông minh cao cấp', 11990000, NULL, 1, 1, 1),

('Áo Thun Uniqlo Basic', 'PRD-006', 'Áo thun cotton 100% Supima, mềm mịn, thoáng khí, phù hợp mặc hàng ngày.', 'Áo thun cotton cao cấp cơ bản', 299000, 249000, 1, 0, 2),
('Giày Nike Air Max 270', 'PRD-007', 'Giày thể thao Nike Air Max 270 với đế Air Max lớn nhất từ trước đến nay, thoải mái và phong cách.', 'Giày thể thao iconic với đế Air Max', 3490000, 2990000, 1, 1, 2),
('Áo Khoác Levi\'s Denim', 'PRD-008', 'Áo khoác denim Levi\'s classic, thiết kế timeless, chất liệu denim bền chắc.', 'Áo khoác denim cổ điển Levi\'s', 1990000, NULL, 1, 0, 2),

('Nồi Cơm Điện Sharp 1.5L', 'PRD-009', 'Nồi cơm điện Sharp 1.5L với công nghệ hơi nước, giữ ấm 24 giờ, dễ vệ sinh.', 'Nồi cơm điện tiết kiệm điện', 590000, 490000, 1, 0, 3),
('Robot Hút Bụi Xiaomi S10', 'PRD-010', 'Robot hút bụi Xiaomi S10 với lực hút 4000Pa, lập bản đồ LiDAR, điều khiển qua app.', 'Robot hút bụi thông minh LiDAR', 4990000, 3990000, 1, 1, 3),

('Sách "Đắc Nhân Tâm"', 'PRD-011', 'Cuốn sách kinh điển về kỹ năng giao tiếp và ảnh hưởng con người của Dale Carnegie.', 'Sách kỹ năng giao tiếp bán chạy nhất mọi thời đại', 79000, 69000, 1, 0, 4),
('Bộ Dụng Cụ Vẽ Chuyên Nghiệp', 'PRD-012', 'Bộ 48 màu chì chuyên nghiệp, bút vẽ các loại, giấy vẽ A3, thích hợp họa sĩ.', 'Bộ vẽ chuyên nghiệp 48 màu', 459000, NULL, 1, 0, 4),

('Xe Đạp Địa Hình Giant Talon', 'PRD-013', 'Xe đạp địa hình Giant Talon 2 với khung nhôm ALUXX, phuộc SR Suntour, 21 tốc độ.', 'Xe đạp địa hình chuyên nghiệp', 8990000, 7990000, 1, 1, 5),
('Bộ Tạ Tay 20kg Adjustable', 'PRD-014', 'Bộ tạ tay điều chỉnh được từ 2-20kg, tiết kiệm không gian, thích hợp tập tại nhà.', 'Tạ tay điều chỉnh 2-20kg', 1290000, NULL, 1, 0, 5),

('Serum Vitamin C Klairs', 'PRD-015', 'Serum Vitamin C dạng thuần túy 5% từ Klairs, làm sáng da, mờ thâm, chống oxy hóa.', 'Serum Vitamin C thuần túy dưỡng sáng da', 390000, 330000, 1, 0, 6),
('Kem Chống Nắng Anessa SPF50+', 'PRD-016', 'Kem chống nắng Anessa Perfect UV Sunscreen SPF50+ PA++++, chống nắng tốt nhất Nhật Bản.', 'Kem chống nắng số 1 Nhật Bản', 420000, NULL, 1, 1, 6);

-- ===== INVENTORY =====
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (
    id                 BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id         BIGINT NOT NULL UNIQUE,
    quantity_in_stock  INT NOT NULL DEFAULT 0,
    quantity_reserved  INT DEFAULT 0,
    reorder_level      INT DEFAULT 10,
    warehouse_location VARCHAR(100),
    last_updated       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO inventory (product_id, quantity_in_stock, quantity_reserved, reorder_level) VALUES
(1, 50, 2, 5), (2, 35, 1, 5), (3, 20, 0, 5), (4, 100, 5, 10), (5, 30, 1, 5),
(6, 200, 10, 20), (7, 80, 3, 10), (8, 60, 2, 10),
(9, 150, 5, 15), (10, 25, 1, 5),
(11, 300, 20, 30), (12, 120, 5, 15),
(13, 15, 0, 3), (14, 80, 4, 10),
(15, 200, 8, 20), (16, 180, 10, 20);

-- ===== PRODUCT IMAGES =====
DROP TABLE IF EXISTS product_images;
CREATE TABLE product_images (
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    image_url  VARCHAR(500) NOT NULL,
    alt_text   VARCHAR(200),
    is_primary TINYINT(1) DEFAULT 0,
    sort_order INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===== ORDERS =====
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id               BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_code       VARCHAR(20)   NOT NULL UNIQUE,
    customer_id      BIGINT        NOT NULL,
    recipient_name   VARCHAR(100)  NOT NULL,
    recipient_phone  VARCHAR(15)   NOT NULL,
    shipping_address TEXT          NOT NULL,
    subtotal         DECIMAL(15,2) DEFAULT 0,
    shipping_fee     DECIMAL(15,2) DEFAULT 0,
    discount_amount  DECIMAL(15,2) DEFAULT 0,
    total_amount     DECIMAL(15,2) NOT NULL,
    status           ENUM('PENDING','CONFIRMED','SHIPPING','COMPLETED','CANCELLED','RETURNED') DEFAULT 'PENDING',
    payment_method   VARCHAR(50)   DEFAULT 'COD',
    note             TEXT,
    coupon_code      VARCHAR(20),
    processed_by     BIGINT,
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (processed_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===== ORDER ITEMS =====
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    id               BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id         BIGINT        NOT NULL,
    product_id       BIGINT        NOT NULL,
    product_name     VARCHAR(200)  NOT NULL,
    product_thumbnail VARCHAR(500),
    quantity         INT           NOT NULL,
    unit_price       DECIMAL(15,2) NOT NULL,
    total_price      DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample Orders
INSERT INTO orders (order_code, customer_id, recipient_name, recipient_phone, shipping_address, subtotal, shipping_fee, discount_amount, total_amount, status, payment_method) VALUES
('ORD20240001', 5, 'Nguyễn Văn An', '0905678901', '123 Lê Lợi, Q1, HCM', 34990000, 0, 0, 34990000, 'COMPLETED', 'COD'),
('ORD20240002', 6, 'Phạm Thị Bình', '0906789012', '456 Nguyễn Huệ, Q1, HCM', 7780000, 0, 0, 7780000, 'SHIPPING', 'VNPAY'),
('ORD20240003', 5, 'Nguyễn Văn An', '0905678901', '123 Lê Lợi, Q1, HCM', 378000, 30000, 0, 408000, 'PENDING', 'COD');

INSERT INTO order_items (order_id, product_id, product_name, quantity, unit_price, total_price) VALUES
(1, 1, 'iPhone 15 Pro Max 256GB', 1, 32990000, 32990000),
(1, 4, 'Tai nghe AirPods Pro (2nd Gen)', 1, 5490000, 5490000),
(2, 7, 'Giày Nike Air Max 270', 1, 2990000, 2990000),
(2, 15, 'Serum Vitamin C Klairs', 2, 330000, 660000),
(3, 11, 'Sách "Đắc Nhân Tâm"', 2, 69000, 138000),
(3, 6, 'Áo Thun Uniqlo Basic', 1, 249000, 249000);

-- ===== PAYMENTS =====
DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
    id                       BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id                 BIGINT NOT NULL UNIQUE,
    method                   ENUM('COD','BANK_TRANSFER','VNPAY','MOMO') DEFAULT 'COD',
    status                   ENUM('PENDING','COMPLETED','FAILED','REFUNDED') DEFAULT 'PENDING',
    amount                   DECIMAL(15,2) NOT NULL,
    transaction_id           VARCHAR(100),
    payment_gateway_response TEXT,
    paid_at                  DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO payments (order_id, method, status, amount) VALUES
(1, 'COD',   'COMPLETED', 34990000),
(2, 'VNPAY', 'COMPLETED', 7780000),
(3, 'COD',   'PENDING',   408000);

-- ===== COUPONS =====
DROP TABLE IF EXISTS coupons;
CREATE TABLE coupons (
    id                   BIGINT AUTO_INCREMENT PRIMARY KEY,
    code                 VARCHAR(20)   NOT NULL UNIQUE,
    description          VARCHAR(200),
    discount_type        ENUM('PERCENTAGE','FIXED_AMOUNT') DEFAULT 'PERCENTAGE',
    discount_value       DECIMAL(10,2) NOT NULL,
    minimum_order_amount DECIMAL(15,2) DEFAULT 0,
    max_uses             INT,
    used_count           INT DEFAULT 0,
    active               TINYINT(1) DEFAULT 1,
    valid_from           DATETIME,
    valid_to             DATETIME,
    created_at           DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO coupons (code, description, discount_type, discount_value, minimum_order_amount, max_uses, active, valid_to) VALUES
('GIAM10',   'Giảm 10% cho đơn hàng bất kỳ',       'PERCENTAGE',    10,  0,       100, 1, DATE_ADD(NOW(), INTERVAL 30 DAY)),
('GIAM50K',  'Giảm 50,000₫ cho đơn từ 300K',        'FIXED_AMOUNT',  50000, 300000, 50, 1, DATE_ADD(NOW(), INTERVAL 30 DAY)),
('SALE20',   'Khuyến mãi 20% tháng này',            'PERCENTAGE',    20,  500000,  30, 1, DATE_ADD(NOW(), INTERVAL 15 DAY)),
('NEWUSER',  'Chào mừng khách hàng mới - giảm 5%', 'PERCENTAGE',     5,  0,       200, 1, DATE_ADD(NOW(), INTERVAL 60 DAY));

-- ===== REVIEWS =====
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    user_id    BIGINT NOT NULL,
    rating     TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment    TEXT,
    approved   TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO reviews (product_id, user_id, rating, comment, approved) VALUES
(1, 5, 5, 'Sản phẩm tuyệt vời, giao hàng nhanh, đóng gói cẩn thận. Rất hài lòng!', 1),
(1, 6, 4, 'Điện thoại rất đẹp, hiệu năng mạnh mẽ. Chỉ tiếc là giá hơi cao.', 1),
(7, 5, 5, 'Giày đẹp, đi êm chân, đúng size. Sẽ mua lại!', 1);

SET FOREIGN_KEY_CHECKS = 1;

-- ===== INDEXES FOR PERFORMANCE =====
CREATE INDEX idx_products_category   ON products(category_id);
CREATE INDEX idx_products_active      ON products(active);
CREATE INDEX idx_orders_customer      ON orders(customer_id);
CREATE INDEX idx_orders_status        ON orders(status);
CREATE INDEX idx_orders_created_at    ON orders(created_at);
CREATE INDEX idx_order_items_order    ON order_items(order_id);
CREATE INDEX idx_order_items_product  ON order_items(product_id);
CREATE INDEX idx_inventory_product    ON inventory(product_id);
-- ============================================
-- Update product thumbnail URLs với ảnh đã download
-- Chạy: mysql -u root ecommerce_db < update_product_images.sql
-- ============================================

USE ecommerce_db;

-- Map ảnh theo category (category_id) và thứ tự sản phẩm
-- Category 1 = Điện tử, 2 = Thời trang, 3 = Gia dụng, 4 = Sách, 5 = Thể thao, 6 = Mỹ phẩm

UPDATE products SET thumbnail_url = '/uploads/products/iphone15.jpg'
WHERE id = 1;

UPDATE products SET thumbnail_url = '/uploads/products/samsung_s24.jpg'
WHERE id = 2;

UPDATE products SET thumbnail_url = '/uploads/products/macbook_air.jpg'
WHERE id = 3;

UPDATE products SET thumbnail_url = '/uploads/products/laptop.jpg'
WHERE id = 4;

UPDATE products SET thumbnail_url = '/uploads/products/headphone.jpg'
WHERE id = 5;

UPDATE products SET thumbnail_url = '/uploads/products/watch.jpg'
WHERE id = 6;

-- Thời trang
UPDATE products SET thumbnail_url = '/uploads/products/tshirt.jpg'
WHERE id = 7;

UPDATE products SET thumbnail_url = '/uploads/products/jacket.jpg'
WHERE id = 8;

UPDATE products SET thumbnail_url = '/uploads/products/nike.jpg'
WHERE id = 9;

-- Gia dụng
UPDATE products SET thumbnail_url = '/uploads/products/vacuum.jpg'
WHERE id = 10;

-- Sách
UPDATE products SET thumbnail_url = '/uploads/products/books.jpg'
WHERE id = 11;

-- Thể thao
UPDATE products SET thumbnail_url = '/uploads/products/soccer.jpg'
WHERE id = 12;

-- Mỹ phẩm
UPDATE products SET thumbnail_url = '/uploads/products/cosmetics.jpg'
WHERE id = 13;

-- Update all remaining products by category fallback
UPDATE products SET thumbnail_url = '/uploads/products/iphone15_alt.jpg'
WHERE thumbnail_url IS NULL AND category_id = 1;

UPDATE products SET thumbnail_url = '/uploads/products/tshirt.jpg'
WHERE thumbnail_url IS NULL AND category_id = 2;

UPDATE products SET thumbnail_url = '/uploads/products/vacuum.jpg'
WHERE thumbnail_url IS NULL AND category_id = 3;

UPDATE products SET thumbnail_url = '/uploads/products/books.jpg'
WHERE thumbnail_url IS NULL AND category_id = 4;

UPDATE products SET thumbnail_url = '/uploads/products/soccer.jpg'
WHERE thumbnail_url IS NULL AND category_id = 5;

UPDATE products SET thumbnail_url = '/uploads/products/cosmetics.jpg'
WHERE thumbnail_url IS NULL AND category_id = 6;

-- Verify
SELECT id, name, thumbnail_url, active, is_featured FROM products ORDER BY id;
