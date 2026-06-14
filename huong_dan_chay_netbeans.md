# 🚀 Hướng Dẫn Chạy Dự Án Trên NetBeans

Tài liệu này hướng dẫn chi tiết cách cấu hình cơ sở dữ liệu, import dự án và khởi chạy ứng dụng **Bincom E-Commerce** bằng IDE NetBeans.

---

### ⚠️ Yêu Cầu Hệ Thống
*   **Java Development Kit (JDK):** JDK 11 hoặc JDK 17 (Cấu hình Maven hiện tại sử dụng Java 11).
*   **Apache Tomcat:** Phiên bản **Tomcat 9.0.x** (Bắt buộc phải dùng bản 9.x do dự án sử dụng thư viện `javax.servlet` từ đặc tả Servlet 4.0; phiên bản Tomcat 10+ sử dụng `jakarta.servlet` sẽ gây lỗi xung đột thư viện).
*   **MySQL Server:** Phiên bản 8.0 hoặc mới hơn.
*   **NetBeans IDE:** Phiên bản 12.0 trở lên (khuyến nghị dùng NetBeans 17+ để hỗ trợ tốt nhất cho Maven).

---

## 🛠️ Quy Trình Triển Khai (5 Bước)

### 1️⃣ Bước 1: Thiết lập Cơ sở dữ liệu (MySQL)
1. Khởi động MySQL Server của bạn (qua XAMPP, Laragon, MySQL Installer, hoặc Docker).
2. Sử dụng một công cụ quản trị dữ liệu (như phpMyAdmin, DBeaver, MySQL Workbench, Navicat) và mở kết nối.
3. Import/chạy toàn bộ nội dung file SQL dưới đây để tạo cơ sở dữ liệu và nạp dữ liệu mẫu:
   * **Đường dẫn file:** `database_setup.sql` (ở thư mục gốc của dự án).
   * **Kết quả:** Cơ sở dữ liệu tên là `ecommerce_db` sẽ được tạo, đi kèm đầy đủ cấu trúc bảng và các bản ghi mẫu (sản phẩm, danh mục, vai trò người dùng, tài khoản kiểm thử).

---

### 2️⃣ Bước 2: Cấu hình tài khoản Database trong code
1. Tìm và mở file chứa cấu hình kết nối database trong mã nguồn tại:
   `src/main/webapp/WEB-INF/spring/db.properties`
2. Cập nhật thông tin `db.username` và `db.password` để trùng khớp với tài khoản MySQL trên máy cá nhân của bạn:
   ```properties
   # Database Configuration
   db.driver=com.mysql.cj.jdbc.Driver
   db.url=jdbc:mysql://localhost:3306/ecommerce_db?useSSL=false&serverTimezone=Asia/Ho_Chi_Minh&useUnicode=true&characterEncoding=UTF-8&allowPublicKeyRetrieval=true
   db.username=root        # Thay đổi nếu dùng user khác (mặc định: root)
   db.password=yourpassword # Điền mật khẩu MySQL của bạn (nếu không cài mật khẩu thì để trống)
   ```

---

### 3️⃣ Bước 3: Thêm Máy chủ Tomcat 9.0 vào NetBeans
*(Nếu bạn đã thêm Tomcat 9 vào NetBeans trước đó, bạn có thể bỏ qua bước này)*
1. Mở NetBeans IDE.
2. Trên thanh menu chính, chọn **Tools** -> **Servers**.
3. Nhấp chọn nút **Add Server**.
4. Chọn **Apache Tomcat or TomEE**, sau đó nhấn **Next**.
5. Nhấp nút **Browse** tại mục *Server Location* và tìm chọn thư mục cài đặt/giải nén của **Apache Tomcat 9.0.x** trên máy của bạn.
6. Đặt Username và Password tùy ý cho quản trị viên Tomcat (hoặc để trống), sau đó bấm **Finish**.

---

### 4️⃣ Bước 4: Mở Dự án trong NetBeans
1. Trên thanh công cụ NetBeans, chọn **File** -> **Open Project** (hoặc dùng tổ hợp phím `Ctrl + Shift + O` / `Cmd + Shift + O`).
2. Tìm đến thư mục **`JAVA_Nhom2`** trên máy tính của bạn và chọn nó. 
3. NetBeans sẽ tự động quét file `pom.xml` và nhận diện đây là một **Maven Web Project** (có biểu tượng quả địa cầu màu cam vàng trên thư mục dự án). Nhấp **Open Project**.
4. Để tránh các lỗi hiển thị cảnh báo đỏ liên quan đến thư viện Lombok trong trình soạn thảo, hãy chắc chắn rằng bạn đã cài đặt plugin **Lombok** cho NetBeans (vào **Tools** -> **Plugins** -> **Available Plugins** -> tìm kiếm `Lombok` và chọn **Install**).

---

### 5️⃣ Bước 5: Build và Chạy dự án
1. Click chuột phải vào tên dự án `ECommerceSystem` (trong cửa sổ *Projects* bên trái) -> Chọn **Clean and Build**.
   * *NetBeans sẽ tiến hành tải toàn bộ các thư viện dependency khai báo trong file `pom.xml` từ internet và tiến hành biên dịch code. Quá trình này sẽ mất 1-2 phút trong lần chạy đầu tiên.*
2. Sau khi build thành công (thông báo `BUILD SUCCESS`), click chuột phải vào dự án -> chọn **Run** (hoặc nhấn phím `F6`).
3. NetBeans sẽ tự khởi chạy máy chủ Tomcat 9, deploy file ứng dụng `ECommerceSystem.war` lên server và tự động mở trình duyệt web hiển thị trang chủ tại địa chỉ:
   `http://localhost:8080/ECommerceSystem/`

---

## 🔑 Danh sách Tài khoản Kiểm thử (Mật khẩu chung: `admin123`)

Hệ thống đã phân quyền chi tiết cho nhiều vai trò thành viên khác nhau. Bạn có thể sử dụng các tài khoản pre-seed sau để đăng nhập thử nghiệm:

| Vai trò (Role) | Tài khoản (Username) | Quyền hạn chính |
| :--- | :--- | :--- |
| **Administrator** | `admin` | Toàn quyền quản trị hệ thống, danh mục, sản phẩm, tài khoản và xem dashboard. |
| **Store Manager** | `manager` | Xem danh sách đơn hàng, cập nhật trạng thái giao hàng, quản lý danh mục sản phẩm. |
| **Sales Staff** | `sales` | Quản lý danh mục sản phẩm, phản hồi đánh giá của khách hàng. |
| **Warehouse Staff**| `warehouse` | Quản lý số lượng tồn kho sản phẩm, vị trí kệ hàng trong kho. |
| **Customer** | `customer1` | Mua sắm sản phẩm, quản lý giỏ hàng, đặt hàng và xem lịch sử đơn hàng. |

---

### 💡 Khắc Phục Sự Cố Nhanh
*   **Lỗi Port 8080 đã bị chiếm dụng:** Nếu Tomcat báo lỗi không khởi động được do cổng 8080 đang chạy ứng dụng khác, bạn có thể đổi port của Tomcat trong cấu hình server của NetBeans hoặc tắt ứng dụng đang chiếm cổng đó.
*   **Lỗi Database Connection:** Hãy kiểm tra lại dịch vụ MySQL của bạn đã được bật chưa, và chắc chắn rằng bạn đã chỉnh sửa đúng mật khẩu kết nối tại file `db.properties`.
