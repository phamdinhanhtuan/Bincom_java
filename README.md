# 🛍️ Bincom — Enterprise E-Commerce Storefront

[![Java](https://img.shields.io/badge/Java-11%20%7C%2021%20%7C%2026-orange.svg?style=for-the-badge&logo=java)](https://www.oracle.com/java/technologies/downloads/)
[![Spring Framework](https://img.shields.io/badge/Spring-5.3.27-green.svg?style=for-the-badge&logo=spring)](https://spring.io/)
[![Hibernate](https://img.shields.io/badge/Hibernate-5.6.15-red.svg?style=for-the-badge&logo=hibernate)](https://hibernate.org/)
[![Spring Security](https://img.shields.io/badge/Spring--Security-5.5.x-blue.svg?style=for-the-badge&logo=springsecurity)](https://spring.io/projects/spring-security)
[![Tomcat](https://img.shields.io/badge/Tomcat-9.0.x-yellow.svg?style=for-the-badge&logo=apachetomcat)](https://tomcat.apache.org/)

**Bincom** is a high-performance Spring MVC e-commerce platform built with Hibernate ORM, Spring Security, and custom CSS grid architecture. Focused on high-fidelity SEO compliance and optimized client-server performance, it integrates automated local developer tooling (embedded Tomcat/Maven wrappers) for zero-configuration deployment across Windows, macOS, and Linux.

---

## 🌟 Key Features

*   🎨 **Premium Aesthetic**: Modern UI with a cohesive Emerald-Violet color scheme, typography powered by *Plus Jakarta Sans*, subtle glassmorphism effects, and micro-interactions.
*   📐 **Responsive & Redundancy-Free Layout**: Clean and custom-built grid structure optimized dynamically for mobile, tablet, and high-resolution desktops. Elements are streamlined to avoid visual redundancy (such as hiding main navigation duplicates on Desktop UI while keeping them in HTML for search engines).
*   🔍 **Advanced SEO On-Page Suite**:
    *   **Meta Tags**: Pre-configured meta descriptions, search keywords, robots index commands, and Open Graph parameters (`og:title`, `og:description`, `og:image`) for high-fidelity social sharing.
    *   **Semantic Headings**: Structural hierarchy containing hidden keyword-rich `<h1>` and `<h2>` elements to communicate store branches (Bincom Tech, Bincom Style, Bincom Home) to crawlers.
    *   **Off-Screen SEO Anchors**: Custom off-screen container wrapping anchor links directly under the main header to maintain maximum PageRank distribution to category landing pages without cluttering the UI.
*   🛒 **Real-Time Cart Calculations**: Instant calculations of totals, subtotals, tax thresholds, and promotional coupons with automated rules (e.g. Free Shipping on orders over 500,000 VND).
*   🛡️ **Role-Based Access Control (RBAC)**: Fine-grained security filter chain with BCrypt password hashing for various staff groups: Administrators, Store Managers, Sales, Warehouse Staff, and Customers.
*   🔄 **Auto-Rotating Brand Slides (No-AI Photos)**:
    *   The home page features dynamic category-linked banner sliders and a brand showcase banner (Slide 1).
    *   Slide 1 integrates an inner auto-rotating photo slideshow featuring realistic, high-resolution product photography (real smartphone/earbuds, model photoshoot, smart home devices) rather than glowing AI art.
    *   Transitions are handled via smooth CSS opacity fades, auto-advancing every 4 seconds and pausing on mouse-hover, clean from redundant dot indicators.

---

## 🛠️ Technology Stack

| Layer | Component |
| :--- | :--- |
| **Backend Core** | Spring MVC 5.3.27 (IoC, Core Context, Bean Management) |
| **Security** | Spring Security 5.5.x (Custom authentication, BCrypt password hashing) |
| **ORM / Database** | Hibernate 5.6.15.Final + HikariCP Connection Pool |
| **Database** | MySQL 8.0+ / 10.x MariaDB |
| **Build System** | Apache Maven 3.9.9 |
| **Web Server** | Apache Tomcat 9.0.100 |
| **Frontend UI** | JSP / JSTL, Custom Vanilla CSS Grid, Bootstrap Icons |

---

## 🚀 Setup & Installation

### 1. Database Setup
Bincom comes with a database structure and seed data.
1. Connect to your local MySQL instance.
2. Execute the setup SQL script located in the repository:
   ```bash
   mysql -u root -p < database_setup.sql
   ```
   *This creates the database `ecommerce_db`, configures the tables, and seeds the tables with default products, categories, and test accounts.*

### 2. Configure Database Connections
Edit the Spring context properties file to match your local environment:
`src/main/webapp/WEB-INF/spring/db.properties`

```properties
# Database Configuration
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/ecommerce_db?useSSL=false&serverTimezone=Asia/Ho_Chi_Minh&useUnicode=true&characterEncoding=UTF-8&allowPublicKeyRetrieval=true
db.username=your_mysql_username
db.password=your_mysql_password
```

### 3. Local Deployment (Recommended)
You can build and start the server with the automated runner script. Run:
```bash
./run.sh
```
This script will:
1. Automatically scan and release ports `8080` and `8005` (using the helper utility `kill_ports.sh`).
2. Run Maven packaging to create the WAR archive.
3. Start the local Tomcat server.
4. Open the application directly in your default browser at `http://localhost:8080/ECommerceSystem/`.

### 4. Stopping the Server
To stop the background Tomcat server, run:
```bash
./apache-tomcat-9.0.100/bin/shutdown.sh
```

---

## 🔑 Default Accounts (For Testing)

All accounts are pre-seeded with the password **`admin123`** (BCrypt Encrypted).

| Role | Username | Privileges |
| :--- | :--- | :--- |
| **Administrator** | `admin` | Full control over the Admin Dashboard, product entries, and users. |
| **Store Manager** | `manager` | Tracking orders, processing deliveries, and managing categories. |
| **Sales Staff** | `sales` | Catalog maintenance, reviewing order feedback, and editing items. |
| **Warehouse Staff**| `warehouse` | Inventory levels monitoring, updating stock, and warehouse status. |
| **Customer** | `customer1` | Purchasing workflow, order status checks, and account profiling. |

---

## 📂 Codebase Directory Layout

```
├── apache-maven-3.9.9/            # Local Maven installation
├── apache-tomcat-9.0.100/         # Local Tomcat application server
├── database_setup.sql             # SQL database script (schema & seed data)
├── kill_ports.sh                  # Utility to release Tomcat port bindings
├── run.sh                         # Master runner script for local startup
├── pom.xml                        # Maven dependencies & build rules
├── src/
│   └── main/
│       ├── java/                  # Java backend architecture
│       │   └── com/ecommerce/
│       │       ├── controller/    # MVC Request handlers (Storefront / Admin)
│       │       ├── model/         # Hibernate Entities
│       │       ├── repository/    # DAO Layer (Data access objects)
│       │       └── service/       # Service Layer (Business logic interface & impl)
│       ├── resources/
│       │   └── schema.sql         # Base database schema
│       └── webapp/
│           ├── resources/         # Static assets (CSS styles, JS modules, images)
│           └── WEB-INF/
│               ├── spring/        # Context, persistence, and security settings
│               ├── views/         # Dynamic JSP templates (Storefront / Admin UI)
│               └── web.xml        # Deployment descriptor
```
