<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="kumo-footer">
  <div class="kumo-container">
    <div class="footer-grid">
      <!-- Cột 1: Thương hiệu & Hotline -->
      <div>
        <a href="${pageContext.request.contextPath}/home" style="display:inline-block; margin-bottom:16px;">
          <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom Logo" style="height:36px; width:auto; object-fit:contain; filter:brightness(0) invert(1);">
        </a>
        <p class="footer-desc">Hệ thống mua sắm trực tuyến hàng đầu. Cung cấp sản phẩm công nghệ, thời trang và gia dụng chính hãng với trải nghiệm mua sắm tuyệt vời.</p>
        
        <div class="footer-hotline">
          <div class="footer-hotline-label">Tổng đài hỗ trợ (Miễn phí)</div>
          <div class="footer-hotline-number">1800 1234</div>
        </div>

        <div class="footer-social">
          <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
          <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
          <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
          <a href="#" class="social-icon"><i class="bi bi-tiktok"></i></a>
        </div>
      </div>

      <!-- Cột 2: Mua sắm -->
      <div>
        <div class="footer-col-title">Danh mục mua sắm</div>
        <ul class="footer-links">
          <li><a href="${pageContext.request.contextPath}/shop">Tất cả sản phẩm</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=1">Điện thoại & Thiết bị</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=2">Thời trang & Phụ kiện</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=3">Đồ dùng gia đình</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=4">Sách & Văn phòng phẩm</a></li>
        </ul>
      </div>

      <!-- Cột 3: Hỗ trợ khách hàng -->
      <div>
        <div class="footer-col-title">Dịch vụ & Hỗ trợ</div>
        <ul class="footer-links">
          <li><a href="#">Hướng dẫn mua hàng online</a></li>
          <li><a href="#">Chính sách giao hàng nhanh</a></li>
          <li><a href="#">Chính sách đổi trả 30 ngày</a></li>
          <li><a href="#">Chính sách bảo mật thông tin</a></li>
          <li><a href="${pageContext.request.contextPath}/orders">Tra cứu trạng thái đơn hàng</a></li>
        </ul>
      </div>

      <!-- Cột 4: Thanh toán & Chứng nhận -->
      <div>
        <div class="footer-col-title">Thanh toán an toàn</div>
        <div class="footer-payment">
          <span class="footer-payment-badge"><i class="bi bi-credit-card-2-front"></i> Visa/Master</span>
          <span class="footer-payment-badge"><i class="bi bi-bank"></i> Internet Banking</span>
          <span class="footer-payment-badge"><i class="bi bi-qr-code-scan"></i> VNPAY QR</span>
          <span class="footer-payment-badge"><i class="bi bi-wallet2"></i> Ví điện tử</span>
        </div>
        
        <div style="margin-top:24px;">
          <div class="footer-col-title" style="margin-bottom:10px;">Chứng nhận dịch vụ</div>
          <div style="display:flex; gap:10px; align-items:center; opacity:0.8;">
            <div style="width:70px; height:26px; background:rgba(255,255,255,0.1); border-radius:4px; display:flex; align-items:center; justify-content:center; font-size:9px; font-weight:800; color:#fff; border:1px solid rgba(255,255,255,0.2);">ĐÃ ĐĂNG KÝ</div>
            <div style="width:70px; height:26px; background:rgba(255,255,255,0.1); border-radius:4px; display:flex; align-items:center; justify-content:center; font-size:9px; font-weight:800; color:#4ade80; border:1px solid rgba(74,222,128,0.3);"><i class="bi bi-shield-check me-1"></i>SSL SECURE</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bản quyền -->
    <div class="footer-bottom">
      <span>© 2026 Bincom E-Commerce. Tất cả quyền được bảo lưu. Thiết kế và phát triển bởi Nhóm 3 — Java Web Spring MVC.</span>
    </div>
  </div>
</footer>

</body>
</html>
