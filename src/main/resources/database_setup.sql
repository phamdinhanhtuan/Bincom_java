-- MySQL dump 10.13  Distrib 9.2.0, for macos15 (arm64)
--
-- Host: localhost    Database: ecommerce_db
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `image_url` longtext,
  `active` tinyint(1) DEFAULT '1',
  `sort_order` int DEFAULT '0',
  `parent_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Điện tử','Sản phẩm điện tử, công nghệ',NULL,1,1,NULL,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(2,'Thời trang','Quần áo, giày dép, phụ kiện',NULL,1,2,NULL,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(3,'Gia dụng','Đồ dùng gia đình, nội thất',NULL,1,3,NULL,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(4,'Sách & Văn phòng','Sách, dụng cụ học tập',NULL,1,4,NULL,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(5,'Thể thao','Dụng cụ thể thao, fitness',NULL,1,5,NULL,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(6,'Mỹ phẩm','Chăm sóc da, trang điểm',NULL,1,6,NULL,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(7,'Điện thoại','Điện thoại di động, smartphone',NULL,1,1,1,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(8,'Laptop','Máy tính xách tay, Laptop',NULL,1,2,1,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(9,'Màn hình','Màn hình máy tính, Monitors',NULL,1,3,1,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(10,'Tai nghe & Phụ kiện','Tai nghe, Apple Watch, Phụ kiện công nghệ',NULL,1,4,1,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(11,'Quần áo','Quần áo thời trang nam nữ',NULL,1,1,2,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(12,'Giày dép','Giày thể thao, giày lười, dép các loại',NULL,1,2,2,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(13,'Phụ kiện thời trang','Ví, dây nịt, thắt lưng',NULL,1,3,2,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(14,'Đồ dùng gia đình','Đồ gia dụng thông dụng',NULL,1,1,3,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(15,'Thiết bị gia dụng','Thiết bị thông minh, nồi cơm điện, robot hút bụi',NULL,1,2,3,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(16,'MÁY TÍNH BẢNG','',NULL,1,0,1,'2026-06-25 13:20:55','2026-06-25 13:20:55');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `discount_type` enum('PERCENTAGE','FIXED_AMOUNT') DEFAULT 'PERCENTAGE',
  `discount_value` decimal(10,2) NOT NULL,
  `minimum_order_amount` decimal(15,2) DEFAULT '0.00',
  `max_uses` int DEFAULT NULL,
  `used_count` int DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'GIAM10','Giảm 10% cho đơn hàng bất kỳ','PERCENTAGE',10.00,0.00,100,0,1,NULL,'2026-07-25 00:55:02','2026-06-25 00:55:02'),(2,'GIAM50K','Giảm 50,000₫ cho đơn từ 300K','FIXED_AMOUNT',50000.00,300000.00,50,0,1,NULL,'2026-07-25 00:55:02','2026-06-25 00:55:02'),(3,'SALE20','Khuyến mãi 20% tháng này','PERCENTAGE',20.00,500000.00,30,1,1,NULL,'2026-07-10 00:55:02','2026-06-25 00:55:02'),(4,'NEWUSER','Chào mừng khách hàng mới - giảm 5%','PERCENTAGE',5.00,0.00,200,0,1,NULL,'2026-08-24 00:55:02','2026-06-25 00:55:02');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `quantity_in_stock` int NOT NULL DEFAULT '0',
  `quantity_reserved` int DEFAULT '0',
  `reorder_level` int DEFAULT '10',
  `warehouse_location` varchar(100) DEFAULT NULL,
  `last_updated` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  KEY `idx_inventory_product` (`product_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,50,3,5,NULL,'2026-06-25 09:36:42'),(2,2,35,1,5,NULL,'2026-06-25 00:55:02'),(3,3,20,0,5,NULL,'2026-06-25 00:55:02'),(4,4,100,5,10,NULL,'2026-06-25 00:55:02'),(5,5,30,1,5,NULL,'2026-06-25 00:55:02'),(6,6,200,10,20,NULL,'2026-06-25 00:55:02'),(7,7,80,3,10,NULL,'2026-06-25 00:55:02'),(8,8,60,2,10,NULL,'2026-06-25 00:55:02'),(9,9,100,0,10,NULL,'2026-06-25 00:55:02'),(10,10,80,0,10,NULL,'2026-06-25 00:55:02'),(11,11,150,5,15,NULL,'2026-06-25 00:55:02'),(12,12,25,1,5,NULL,'2026-06-25 00:55:02'),(13,13,29,0,5,NULL,'2026-06-25 12:47:06'),(14,14,49,0,10,NULL,'2026-06-25 12:47:06'),(15,15,300,20,30,NULL,'2026-06-25 00:55:02'),(16,16,120,5,15,NULL,'2026-06-25 00:55:02'),(17,17,15,0,3,NULL,'2026-06-25 00:55:02'),(18,18,80,4,10,NULL,'2026-06-25 00:55:02'),(19,19,200,8,20,NULL,'2026-06-25 00:55:02'),(20,20,180,10,20,NULL,'2026-06-25 00:55:02'),(21,28,50,0,10,NULL,'2026-06-25 12:51:16'),(22,25,40,0,11,NULL,'2026-06-25 13:04:19'),(23,26,35,0,10,NULL,'2026-06-25 13:15:38'),(24,21,69,0,10,NULL,'2026-06-25 13:18:47'),(25,29,89,0,10,NULL,'2026-06-25 13:23:09'),(29,24,10,0,5,NULL,'2026-06-25 14:14:30'),(30,35,40,0,10,NULL,'2026-06-25 14:17:51');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `product_name` varchar(200) NOT NULL,
  `product_thumbnail` varchar(500) DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `size` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_items_order` (`order_id`),
  KEY `idx_order_items_product` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,'iPhone 15 Pro Max 256GB',NULL,1,32990000.00,32990000.00,NULL),(2,1,4,'Tai nghe AirPods Pro (2nd Gen)',NULL,1,5490000.00,5490000.00,NULL),(3,2,7,'Giày Nike Air Max 270',NULL,1,2990000.00,2990000.00,NULL),(4,2,15,'Serum Vitamin C Klairs',NULL,2,330000.00,660000.00,NULL),(5,3,11,'Sách \"Đắc Nhân Tâm\"',NULL,2,69000.00,138000.00,NULL),(6,3,6,'Áo Thun Uniqlo Basic',NULL,1,249000.00,249000.00,NULL),(7,4,1,'iPhone 15 Pro Max 256GB','/uploads/products/iphone15.jpg',1,32990000.00,32990000.00,NULL),(8,5,14,'Giày Nike Air Max 270','/uploads/products/nike.jpg',1,2990000.00,2990000.00,'40'),(9,5,13,'Áo Thun Uniqlo Basic','/uploads/products/tshirt.jpg',1,249000.00,249000.00,'M');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_code` varchar(20) NOT NULL,
  `customer_id` bigint NOT NULL,
  `recipient_name` varchar(100) NOT NULL,
  `recipient_phone` varchar(15) NOT NULL,
  `shipping_address` text NOT NULL,
  `subtotal` decimal(15,2) DEFAULT '0.00',
  `shipping_fee` decimal(15,2) DEFAULT '0.00',
  `discount_amount` decimal(15,2) DEFAULT '0.00',
  `total_amount` decimal(15,2) NOT NULL,
  `status` enum('PENDING','CONFIRMED','SHIPPING','COMPLETED','CANCELLED','RETURNED') DEFAULT 'PENDING',
  `payment_method` varchar(50) DEFAULT 'COD',
  `note` text,
  `coupon_code` varchar(20) DEFAULT NULL,
  `processed_by` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_code` (`order_code`),
  KEY `processed_by` (`processed_by`),
  KEY `idx_orders_customer` (`customer_id`),
  KEY `idx_orders_status` (`status`),
  KEY `idx_orders_created_at` (`created_at`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'ORD20240001',5,'Nguyễn Văn An','0905678901','123 Lê Lợi, Q1, HCM',34990000.00,0.00,0.00,34990000.00,'COMPLETED','COD',NULL,NULL,NULL,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(2,'ORD20240002',6,'Phạm Thị Bình','0906789012','456 Nguyễn Huệ, Q1, HCM',7780000.00,0.00,0.00,7780000.00,'SHIPPING','VNPAY',NULL,NULL,NULL,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(3,'ORD20240003',5,'Nguyễn Văn An','0905678901','123 Lê Lợi, Q1, HCM',378000.00,30000.00,0.00,408000.00,'RETURNED','COD',NULL,NULL,1,'2026-06-25 00:55:02','2026-06-25 14:26:00'),(4,'ORD1782354995919',5,'Nguyễn Văn An','0905678901','123 Lê Lợi, Q1, HCM',32990000.00,0.00,6598000.00,26392000.00,'PENDING','COD','','SALE20',NULL,'2026-06-25 09:36:37','2026-06-25 09:36:37'),(5,'ORD1782366351649',5,'Nguyễn Văn An','0905678901','123 Lê Lợi, Q1, HCM',3239000.00,0.00,0.00,3239000.00,'COMPLETED','COD','',NULL,1,'2026-06-25 12:45:52','2026-06-25 12:47:06');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `method` enum('COD','BANK_TRANSFER','VNPAY','MOMO') DEFAULT 'COD',
  `status` enum('PENDING','COMPLETED','FAILED','REFUNDED') DEFAULT 'PENDING',
  `amount` decimal(15,2) NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `payment_gateway_response` text,
  `paid_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,'COD','COMPLETED',34990000.00,NULL,NULL,'2026-06-25 00:55:02'),(2,2,'VNPAY','COMPLETED',7780000.00,NULL,NULL,'2026-06-25 00:55:02'),(3,3,'COD','PENDING',408000.00,NULL,NULL,'2026-06-25 00:55:02');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `image_url` longtext NOT NULL,
  `alt_text` varchar(200) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `sort_order` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (1,27,'/uploads/products/3481f67a-a14a-48d1-aa94-f0281042e938.webp',NULL,0,0),(2,27,'/uploads/products/e7bc49de-0738-47e2-bc8a-0526d8f2fccb.webp',NULL,0,2),(3,18,'/uploads/products/e8260870-2397-4bba-a2b7-342aa5149851.webp',NULL,0,0),(4,11,'/uploads/products/f3a395b9-da61-4af8-8120-05f15a3ee73c.png',NULL,0,0),(5,16,'/uploads/products/3ff691ae-e976-4c1e-8f8b-47b87978ada5.png',NULL,0,0),(6,16,'/uploads/products/9675523b-2cf3-4c71-bb67-b615faa2b8cd.png',NULL,0,2);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `description` text,
  `short_description` varchar(500) DEFAULT NULL,
  `price` decimal(15,2) NOT NULL,
  `sale_price` decimal(15,2) DEFAULT NULL,
  `thumbnail_url` longtext,
  `active` tinyint(1) DEFAULT '1',
  `is_featured` tinyint(1) DEFAULT '0',
  `category_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_code` (`product_code`),
  KEY `idx_products_category` (`category_id`),
  KEY `idx_products_active` (`active`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'iPhone 15 Pro Max 256GB','PRD-001','iPhone 15 Pro Max với chip A17 Pro, camera 48MP, Dynamic Island và Action Button.','Smartphone cao cấp với chip A17 Pro',34990000.00,32990000.00,'/uploads/products/iphone15.jpg',1,1,7,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(2,'Samsung Galaxy S24 Ultra','PRD-002','Samsung Galaxy S24 Ultra với S Pen, camera 200MP, màn hình 6.8 inch Dynamic AMOLED.','Flagship Android với S Pen tích hợp',28990000.00,26990000.00,'/uploads/products/samsung_s24.jpg',1,1,7,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(3,'MacBook Air M3 13 inch','PRD-003','MacBook Air M3 với chip M3, màn hình Liquid Retina 13.6 inch, thời lượng pin 18 giờ.','Laptop siêu mỏng nhẹ với chip M3',28990000.00,NULL,'/uploads/products/ae0de161-6fd6-4b0e-82fa-0e7a89e5bbd8.png',1,1,8,'2026-06-25 00:55:02','2026-06-25 20:45:46'),(4,'Tai nghe AirPods Pro (2nd Gen)','PRD-004','AirPods Pro thế hệ 2 với Active Noise Cancellation, Transparency Mode và âm thanh không gian.','Tai nghe True Wireless cao cấp của Apple',6290000.00,5490000.00,'/uploads/products/headphone.jpg',1,0,10,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(5,'Apple Watch Series 9 45mm','PRD-005','Apple Watch Series 9 với chip S9, màn hình Always-On Retina, theo dõi sức khỏe toàn diện.','Đồng hồ thông minh cao cấp',11990000.00,NULL,'/uploads/products/watch.jpg',1,1,10,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(6,'Laptop ASUS TUF Gaming A15','PRD-021','Laptop ASUS TUF Gaming A15 với chip Ryzen 5, card đồ họa GTX 1650, RAM 8GB, SSD 512GB.','Laptop gaming phân khúc tầm trung',18990000.00,16990000.00,'/uploads/products/1b212b22-016f-43ba-b45b-eb849afe4d78.png',1,0,8,'2026-06-25 00:55:02','2026-06-25 20:46:03'),(7,'Laptop Dell Inspiron 15 3520','PRD-022','Laptop Dell Inspiron 15 3520 với chip Core i5, RAM 8GB, SSD 512GB, màn hình 15.6 inch 120Hz.','Laptop văn phòng mỏng nhẹ hiệu năng ổn định',14990000.00,13490000.00,'/uploads/products/e671af02-da95-4d68-b57b-1a4fc2d4c84b.png',1,0,8,'2026-06-25 00:55:02','2026-06-25 20:46:15'),(8,'Laptop HP Pavilion 15-eg2035TX','PRD-023','Laptop HP Pavilion 15 với chip Core i5, RAM 8GB, SSD 512GB, card đồ họa rời MX550.','Laptop văn phòng sang trọng cấu hình tốt',16990000.00,15490000.00,'/uploads/products/eb3ce9a0-76cf-4e3e-ae60-ea250f942979.png',1,0,8,'2026-06-25 00:55:02','2026-06-25 20:46:32'),(9,'Màn hình ASUS VY249HE 24 inch','PRD-024','Màn hình ASUS VY249HE 24 inch FHD IPS 75Hz bảo vệ mắt kháng khuẩn.','Màn hình văn phòng bảo vệ mắt IPS',3290000.00,2790000.00,'/uploads/products/3ae6c89c-be00-44b1-ae57-0a8a3352a0a4.png',1,0,9,'2026-06-25 00:55:02','2026-06-25 20:48:02'),(10,'Màn hình Samsung Essential S3 S31C 24 inch','PRD-025','Màn hình Samsung Essential S3 S31C 24 inch FHD IPS 75Hz tràn viền.','Màn hình tràn viền giá rẻ Samsung IPS',2990000.00,2490000.00,'/uploads/products/4d408c1a-88c1-4e3e-9b34-2b5702c2b59e.png',1,0,9,'2026-06-25 00:55:02','2026-06-25 20:46:50'),(11,'Màn hình Dell P2422H 23.8 inch','PRD-026','Màn hình Dell Professional P2422H 23.8 inch FHD IPS thiết kế công thái học.','Màn hình văn phòng công thái học Dell IPS',4890000.00,4290000.00,'/uploads/products/91e6afe6-5a90-4fb7-b0fe-6645c12d2a8f.png',1,1,9,'2026-06-25 00:55:02','2026-06-25 13:30:34'),(12,'Màn hình LG UltraGear 24GQ50F 24 inch','PRD-027','Màn hình LG UltraGear Gaming 24GQ50F 24 inch FHD 165Hz chuyên game.','Màn hình gaming tần số quét cao LG 165Hz',3690000.00,3190000.00,'/uploads/products/25007267-ca34-49d9-8337-2941bc0eb7eb.png',1,1,9,'2026-06-25 00:55:02','2026-06-25 13:30:09'),(13,'Áo Thun Uniqlo Basic','PRD-006','Áo thun cotton 100% Supima, mềm mịn, thoáng khí, phù hợp mặc hàng ngày.','Áo thun cotton cao cấp cơ bản',299000.00,249000.00,'/uploads/products/23d6973c-38fa-406e-b56b-eb3dbd2a2cf7.png',1,0,11,'2026-06-25 00:55:02','2026-06-25 13:31:32'),(14,'Giày Nike Air Max 270','PRD-007','Giày thể thao Nike Air Max 270 với đế Air Max lớn nhất từ trước đến nay, thoải mái và phong cách.','Giày thể thao iconic với đế Air Max',3490000.00,2990000.00,'/uploads/products/nike.jpg',1,1,12,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(15,'Áo Khoác Levi\'s Denim','PRD-008','Áo khoác denim Levi\'s classic, thiết kế timeless, chất liệu denim bền chắc.','Áo khoác denim cổ điển Levi\'s',1990000.00,NULL,'/uploads/products/jacket.jpg',1,0,11,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(16,'Áo Polo Nam Uniqlo','PRD-017','Áo polo nam cổ bẻ Uniqlo chất liệu gai mịn, thấm hút mồ hôi tốt, kiểu dáng lịch sự.','Áo polo nam Uniqlo gai mịn',399000.00,349000.00,'/uploads/products/5539c04a-2741-4892-8b4d-21d07a5030be.png',1,1,11,'2026-06-25 00:55:02','2026-06-25 13:32:29'),(17,'Váy Hoa Nhí Vintage','PRD-018','Váy hoa nhí dáng dài phong cách vintage Hàn Quốc, chất liệu voan nhẹ nhàng bay bổng.','Váy voan hoa nhí dáng dài',450000.00,390000.00,'/uploads/products/5d6dc0d0-1042-43f1-9615-4be5f4319ddd.png',1,1,11,'2026-06-25 00:55:02','2026-06-25 13:33:17'),(18,'Nồi Cơm Điện Sharp 1.5L','PRD-009','Nồi cơm điện Sharp 1.5L với công nghệ hơi nước, giữ ấm 24 giờ, dễ vệ sinh.','Nồi cơm điện tiết kiệm điện',590000.00,490000.00,'/uploads/products/f8803f0c-7f4e-4586-b6f3-2384729bfd41.webp',1,0,15,'2026-06-25 00:55:02','2026-06-25 13:16:39'),(19,'Robot Hút Bụi Xiaomi S10','PRD-010','Robot hút bụi Xiaomi S10 với lực hút 4000Pa, lập bản đồ LiDAR, điều khiển qua app.','Robot hút bụi thông minh LiDAR',4990000.00,3990000.00,'/uploads/products/43398e77-0f76-40e3-99c7-3eb3a5b40a68.png',1,1,15,'2026-06-25 00:55:02','2026-06-25 13:18:01'),(20,'Lò Vi Sóng Panasonic 20L','PRD-019','Lò vi sóng Panasonic dung tích 20L công suất 800W, có chức năng rã đông nhanh.','Lò vi sóng 20L công suất 800W',2490000.00,1990000.00,'/uploads/products/f7e89637-f5ed-4390-87d1-adbf68caa347.png',1,1,15,'2026-06-25 00:55:02','2026-06-25 13:19:30'),(21,'Quạt Đứng Xiaomi Smart Fan','PRD-020','Quạt đứng thông minh Xiaomi Smart Fan 2 Lite, kết nối app Mi Home, chạy cực êm.','Quạt đứng thông minh Xiaomi',1690000.00,1390000.00,'/uploads/products/c602bcd6-c868-4f3c-99d4-4b2384010d76.png',1,1,15,'2026-06-25 00:55:02','2026-06-25 13:18:47'),(22,'Sách \"Đắc Nhân Tâm\"','PRD-011','Cuốn sách kinh điển về kỹ năng giao tiếp và ảnh hưởng con người của Dale Carnegie.','Sách kỹ năng giao tiếp bán chạy nhất mọi thời đại',79000.00,69000.00,'/uploads/products/books.jpg',1,0,4,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(23,'Bộ Dụng Cụ Vẽ Chuyên Nghiệp','PRD-012','Bộ 48 màu chì chuyên nghiệp, bút vẽ các loại, giấy vẽ A3, thích hợp họa sĩ.','Bộ vẽ chuyên nghiệp 48 màu',459000.00,NULL,'/uploads/products/books.jpg',1,0,4,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(24,'Xe Đạp Địa Hình Giant Talon','PRD-013','Xe đạp địa hình Giant Talon 2 với khung nhôm ALUXX, phuộc SR Suntour, 21 tốc độ.','Xe đạp địa hình chuyên nghiệp',8990000.00,7990000.00,'/uploads/products/2714b9ee-bae8-42ca-9a54-8dc972f5e71f.jpg',1,0,5,'2026-06-25 00:55:02','2026-06-25 20:47:26'),(25,'Bộ Tạ Tay 20kg Adjustable','PRD-014','Bộ tạ tay điều chỉnh được từ 2-20kg, tiết kiệm không gian, thích hợp tập tại nhà.','Tạ tay điều chỉnh 2-20kg',1290000.00,NULL,'/uploads/products/76c9c205-560c-45a5-adf7-490e97ad749a.png',1,0,5,'2026-06-25 00:55:02','2026-06-25 13:04:19'),(26,'Serum Vitamin C Klairs','PRD-015','Serum Vitamin C dạng thuần túy 5% từ Klairs, làm sáng da, mờ thâm, chống oxy hóa.','Serum Vitamin C thuần túy dưỡng sáng da',390000.00,330000.00,'/uploads/products/dd51c482-752c-4383-8dfd-ee106a666434.webp',1,0,6,'2026-06-25 00:55:02','2026-06-25 13:15:37'),(27,'Kem Chống Nắng Anessa SPF50+','PRD-016','Kem chống nắng Anessa Perfect UV Sunscreen SPF50+ PA++++, chống nắng tốt nhất Nhật Bản.','Kem chống nắng số 1 Nhật Bản',420000.00,NULL,'/uploads/products/d1dafea3-854f-4132-9e7f-0f4269d91124.webp',1,1,6,'2026-06-25 00:55:02','2026-06-25 12:48:17'),(28,'Bộ Tạ Tay 40kg Adjustable','PRD-TEST-TA','Bộ tạ tay đa năng điều chỉnh được 40kg','Bộ tạ tay đa năng',1200000.00,NULL,'/uploads/products/2b32e5bd-1f5a-4c6a-8aa3-560c86023f49.png',1,0,5,'2026-06-25 12:51:16','2026-06-25 13:04:01'),(29,'iPad Air M4 2026 11 inch Wifi 128GB','PRD-1FDA4136','iPad Air M4 2026 11-inch Wifi 128GB chính hãng là phiên bản nâng cấp đáng chú ý trong dòng iPad Air, mang đến sự cân bằng giữa hiệu năng mạnh mẽ và thiết kế mỏng nhẹ quen thuộc. Với chip M4 thế hệ mới, màn hình Liquid Retina sắc nét cùng dung lượng 128GB đáp ứng tốt nhu cầu học tập, làm việc và giải trí, sản phẩm phù hợp với nhiều đối tượng người dùng đang tìm kiếm một chiếc iPad hiệu năng cao trong tầm giá hợp lý.\r\n\r\nKhông chỉ dừng lại ở hiệu năng, iPad Air M4 11-inch còn được tối ưu trải nghiệm với hệ sinh thái Apple, hỗ trợ Apple Pencil và Magic Keyboard, giúp nâng cao khả năng sáng tạo và đa nhiệm linh hoạt. Nếu bạn đang cân nhắc một chiếc tablet chính hãng tại Việt Nam, đây là lựa chọn đáng chú ý nhờ cấu hình mạnh, thiết kế gọn gàng và mức giá khởi điểm dễ tiếp cận khách hàng.','iPad Air M4 2026 11 inch Wifi 128GB',12000000.00,11009000.00,'/uploads/products/abb150b2-edc7-42de-8dc4-057db1d2d239.png',1,0,16,'2026-06-25 13:23:09','2026-06-25 13:23:09'),(35,'Bộ nồi Elmich','PRD-92','Bền - Đẹp','Bộ nồi Elmich  cao cấp',1120000.00,NULL,'/uploads/products/21f6e462-a4d8-41fc-a17b-2e395eac3e17.png',1,0,14,'2026-06-25 14:17:51','2026-06-25 14:17:51');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `rating` tinyint NOT NULL,
  `comment` text,
  `approved` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,5,5,'Sản phẩm tuyệt vời, giao hàng nhanh, đóng gói cẩn thận. Rất hài lòng!',1,'2026-06-25 00:55:02'),(2,1,6,4,'Điện thoại rất đẹp, hiệu năng mạnh mẽ. Chỉ tiếc là giá hơi cao.',1,'2026-06-25 00:55:02'),(3,7,5,5,'Giày đẹp, đi êm chân, đúng size. Sẽ mua lại!',1,'2026-06-25 00:55:02');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT 'ROLE_ADMIN, ROLE_CUSTOMER, ...',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ROLE_ADMIN','Quản trị viên hệ thống'),(2,'ROLE_STORE_MANAGER','Quản lý cửa hàng'),(3,'ROLE_SALES_STAFF','Nhân viên bán hàng'),(4,'ROLE_WAREHOUSE_STAFF','Nhân viên kho hàng'),(5,'ROLE_CUSTOMER','Khách hàng');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,5);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `address` text,
  `avatar_url` longtext,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Quản Trị Viên','admin@bincom.vn','admin','$2a$10$QdJjHZCWvPxvuOc.S6rxGuZQwqBO9HARzhMw.VvuZOAc7d1G2DEDe','0901234567','TP. Hồ Chí Minh',NULL,1,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(2,'Nguyễn Hương Ly','manager@bincom.vn','manager','$2a$10$uk7BFD39rqe3xeKyHUIUOO5ijHBHNJeDECBkDuDfRv8YzjrglXpQ2','0902345678','TP. Hồ Chí Minh',NULL,1,'2026-06-25 00:55:02','2026-06-25 10:05:38'),(3,'Trần Văn Hoàng','sales@bincom.vn','sales','$2a$10$k.kOnft8DhmOGfaDajm2rO5FzxUSesB.OMwu2kyYjFl8p1lQIM6oK','0903456789','TP. Hồ Chí Minh',NULL,1,'2026-06-25 00:55:02','2026-06-25 10:05:54'),(4,'Lê Quang Hoàng','warehouse@bincom.vn','warehouse','$2a$10$tlpKz6y5JpgC8jwGOou2g.WigU8si/QHDXqRHvdZE0fohZVTX1INK','0904567890','TP. Hồ Chí Minh',NULL,1,'2026-06-25 00:55:02','2026-06-25 10:06:21'),(5,'Nguyễn Văn An','an@gmail.com','customer1','$2a$10$RB/jbDnNZSufbC6PMZgD7uNVw/8HrxkyciTpILLJ5w5Fj6iVAYecO','0905678901','123 Lê Lợi, Q1, HCM',NULL,1,'2026-06-25 00:55:02','2026-06-25 00:55:02'),(6,'Phạm Thị Bình','binh@gmail.com','customer2','$2a$10$CACE1UJ8i3RuXnje8ZCf2e8Pl6fNyZ201wlDfZxdsIQYuHhrjJ5CO','0906789012','456 Nguyễn Huệ, Q1, HCM',NULL,1,'2026-06-25 00:55:02','2026-06-25 00:55:02');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-30 14:02:06
