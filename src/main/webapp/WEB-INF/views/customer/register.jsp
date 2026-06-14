<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đăng ký — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<div class="auth-page">
  <div class="auth-banner">
    <a href="${pageContext.request.contextPath}/home" style="display:inline-block; margin-bottom:24px; z-index:1; position:relative;">
      <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom Logo" style="height:42px; width:auto; object-fit:contain; filter:brightness(0) invert(1);">
    </a>
    <h2 style="font-family:'Playfair Display',serif;font-size:28px;margin-bottom:16px;color:white;">Tham gia cộng đồng<br>mua sắm thông minh</h2>
    <p class="auth-banner-tagline">Hàng nghìn sản phẩm chất lượng. Ưu đãi độc quyền cho thành viên mới. Giao hàng nhanh toàn quốc.</p>
    <div style="margin-top:40px;display:flex;flex-direction:column;gap:12px;max-width:280px;">
      <div style="display:flex;align-items:center;gap:12px;color:rgba(255,255,255,.8);font-size:14px;">
        <div style="width:32px;height:32px;background:var(--accent);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">✓</div>
        Miễn phí vận chuyển đơn từ 500K
      </div>
      <div style="display:flex;align-items:center;gap:12px;color:rgba(255,255,255,.8);font-size:14px;">
        <div style="width:32px;height:32px;background:var(--accent);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">✓</div>
        Đổi trả miễn phí trong 30 ngày
      </div>
      <div style="display:flex;align-items:center;gap:12px;color:rgba(255,255,255,.8);font-size:14px;">
        <div style="width:32px;height:32px;background:var(--accent);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">✓</div>
        Ưu đãi giảm 5% cho đơn đầu tiên
      </div>
    </div>
  </div>

  <div class="auth-form-side" style="width:520px;">
    <div class="auth-form-box">
      <h1 class="auth-title">Tạo tài khoản</h1>
      <p class="auth-subtitle">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" style="color:var(--accent);font-weight:600;">Đăng nhập</a></p>

      <c:if test="${not empty error}">
        <div style="background:#fef2f2;border:1px solid #fecaca;border-radius:4px;padding:12px 16px;font-size:13px;color:var(--danger);margin-bottom:20px;">
          <i class="bi bi-exclamation-circle-fill"></i> ${error}
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/register" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        
        <!-- Honeypot Spam Control (hidden from users, bot trap) -->
        <div style="display: none;">
          <input type="text" name="honeypot" value="" autocomplete="off" />
        </div>

        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
          <div class="form-group">
            <label>Họ và tên *</label>
            <input type="text" name="fullName" required placeholder="Nguyễn Văn A">
          </div>
          <div class="form-group">
            <label>Số điện thoại</label>
            <input type="tel" name="phoneNumber" placeholder="0901234567">
          </div>
        </div>
        <div class="form-group">
          <label>Tên đăng nhập *</label>
          <input type="text" name="username" required placeholder="username123" autocomplete="username">
        </div>
        <div class="form-group">
          <label>Email *</label>
          <input type="email" name="email" required placeholder="email@example.com">
        </div>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
          <div class="form-group">
            <label>Mật khẩu *</label>
            <input type="password" name="password" id="pwd" required placeholder="••••••••" minlength="6">
          </div>
          <div class="form-group">
            <label>Xác nhận mật khẩu *</label>
            <input type="password" name="confirmPassword" id="confirmPwd" required placeholder="••••••••">
          </div>
        </div>
        <div style="font-size:12px;color:var(--text-muted);margin-bottom:20px;">
          Bằng cách đăng ký, bạn đồng ý với <a href="#" style="color:var(--accent);">Điều khoản dịch vụ</a> và <a href="#" style="color:var(--accent);">Chính sách bảo mật</a>.
        </div>
        <button type="submit" class="btn-primary" style="width:100%;justify-content:center;padding:16px;" onclick="return validatePwd()">
          Tạo tài khoản <i class="bi bi-arrow-right"></i>
        </button>
      </form>

      <div class="auth-divider" style="margin:24px 0; position:relative; text-align:center;">
        <span style="background:white;padding:0 16px;color:#94a3b8;font-size:12px;position:relative;z-index:1;">Đã có tài khoản?</span>
        <div style="position:absolute;top:50%;left:0;right:0;height:1px;background:#e2e8f0;z-index:0;"></div>
      </div>
      <a href="${pageContext.request.contextPath}/login" class="btn-outline" style="width:100%;justify-content:center;padding:14px;">
        Đăng nhập ngay
      </a>
    </div>
  </div>
</div>

<script>
function validatePwd() {
  var p = document.getElementById('pwd').value;
  var c = document.getElementById('confirmPwd').value;
  if (p !== c) { alert('Mật khẩu xác nhận không khớp!'); return false; }
  return true;
}
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
