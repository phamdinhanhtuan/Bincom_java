<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đăng ký — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<div class="lp-wrap">

  <%-- LEFT: BRANDING PANEL --%>
  <div class="lp-left">
    <div class="lp-left-inner">
      <a href="${pageContext.request.contextPath}/home" class="lp-logo-link">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom Logo"
             style="height:44px;width:auto;filter:brightness(0) invert(1);"
             onerror="this.style.display='none'">
      </a>

      <div class="lp-brand-content">
        <h2 class="lp-brand-title">Tham gia<br>Bincom! 🚀</h2>
        <p class="lp-brand-sub">Tạo tài khoản ngay để nhận hàng ngàn ưu đãi hấp dẫn, miễn phí vận chuyển và đổi trả tiện lợi.</p>

        <div class="lp-stats">
          <div class="lp-stat"><span>500+</span><small>Sản phẩm</small></div>
          <div class="lp-stat-sep"></div>
          <div class="lp-stat"><span>10K+</span><small>Khách hàng</small></div>
          <div class="lp-stat-sep"></div>
          <div class="lp-stat"><span>4.9★</span><small>Đánh giá</small></div>
        </div>

        <div class="lp-trust-list">
          <div class="lp-trust-row"><i class="bi bi-shield-check-fill"></i> Bảo mật SSL 256-bit</div>
          <div class="lp-trust-row"><i class="bi bi-truck"></i> Giao hàng nhanh 2h</div>
          <div class="lp-trust-row"><i class="bi bi-arrow-left-right"></i> Đổi trả miễn phí 30 ngày</div>
          <div class="lp-trust-row"><i class="bi bi-headphones"></i> Hỗ trợ 24/7 — 1800 1234</div>
        </div>
      </div>

      <div class="lp-deco-circle lp-c1"></div>
      <div class="lp-deco-circle lp-c2"></div>
      <div class="lp-deco-circle lp-c3"></div>
    </div>
  </div>

  <%-- RIGHT: FORM PANEL --%>
  <div class="lp-right">
    <div class="lp-form-box" style="max-width: 500px;">

      <%-- Header --%>
      <div class="lp-form-head">
        <div class="lp-form-icon"><i class="bi bi-person-plus-fill"></i></div>
        <h1 class="lp-form-title">Đăng ký tài khoản</h1>
        <p class="lp-form-sub">Nhập thông tin cá nhân của bạn</p>
      </div>

      <%-- Alerts --%>
      <c:if test="${not empty error}">
        <div class="lp-alert lp-alert-error">
          <i class="bi bi-exclamation-circle-fill"></i> ${error}
        </div>
      </c:if>

      <%-- Register Form --%>
      <form action="${pageContext.request.contextPath}/register" method="post" class="lp-form" id="registerForm" onsubmit="return validatePwd()">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        
        <!-- Honeypot Spam Control (hidden from users, bot trap) -->
        <div style="display: none;">
          <input type="text" name="honeypot" value="" autocomplete="off" />
        </div>

        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
          <div class="lp-field">
            <label for="fullName">Họ và tên *</label>
            <input type="text" id="fullName" name="fullName" required placeholder="Nguyễn Văn A">
          </div>
          <div class="lp-field">
            <label for="phoneNumber">Số điện thoại</label>
            <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="0901234567">
          </div>
        </div>

        <div class="lp-field">
          <label for="username">Tên đăng nhập *</label>
          <input type="text" id="username" name="username" required placeholder="username123" autocomplete="username">
        </div>

        <div class="lp-field">
          <label for="email">Email *</label>
          <input type="email" id="email" name="email" required placeholder="email@example.com">
        </div>

        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
          <div class="lp-field">
            <label for="pwd">Mật khẩu *</label>
            <input type="password" id="pwd" name="password" required placeholder="••••••••" minlength="6" autocomplete="new-password">
          </div>
          <div class="lp-field">
            <label for="confirmPwd">Xác nhận mật khẩu *</label>
            <input type="password" id="confirmPwd" name="confirmPassword" required placeholder="••••••••" autocomplete="new-password">
          </div>
        </div>

        <div style="font-size:12px;color:#64748b;margin-bottom:20px;line-height:1.5;">
          Bằng cách đăng ký, bạn đồng ý với <a href="#" style="color:var(--accent);text-decoration:none;font-weight:600;">Điều khoản dịch vụ</a> và <a href="#" style="color:var(--accent);text-decoration:none;font-weight:600;">Chính sách bảo mật</a>.
        </div>

        <button type="submit" class="lp-btn-submit" id="submitBtn">
          <i class="bi bi-person-plus-fill"></i> Tạo tài khoản
        </button>
      </form>

      <%-- Divider --%>
      <div class="lp-divider"><span>Đã có tài khoản?</span></div>

      <%-- Login --%>
      <a href="${pageContext.request.contextPath}/login" class="lp-btn-register">
        <i class="bi bi-box-arrow-in-right"></i> Đăng nhập ngay
      </a>

      <%-- Bottom links --%>
      <div class="lp-bottom-links">
        <a href="${pageContext.request.contextPath}/home"><i class="bi bi-house"></i> Về trang chủ</a>
        <span>•</span>
        <a href="${pageContext.request.contextPath}/shop"><i class="bi bi-bag"></i> Cửa hàng</a>
        <span>•</span>
        <a href="mailto:support@bincom.vn"><i class="bi bi-envelope"></i> Liên hệ</a>
      </div>

    </div><%-- /lp-form-box --%>
  </div><%-- /lp-right --%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auth.css">

<style>
  /* Simplified header/footer for clean authorization pages */
  .cps-topbar, .cps-catnav, .cps-searchbar, .cps-header-actions, .cps-bottomnav, .cps-footer, .cps-footer-usps {
    display: none !important;
  }
  .cps-header {
    background: #fff !important;
    border-bottom: 1px solid #e2e8f0 !important;
    box-shadow: none !important;
  }
  .cps-header-inner {
    grid-template-columns: 1fr !important;
    justify-content: center;
    text-align: center;
  }
  .cps-logo {
    margin: 0 auto;
  }
  .cps-logo img {
    filter: none !important;
  }
</style>

<script>
function validatePwd() {
  var p = document.getElementById('pwd').value;
  var c = document.getElementById('confirmPwd').value;
  if (p !== c) { 
    alert('Mật khẩu xác nhận không khớp!'); 
    return false; 
  }
  var btn = document.getElementById('submitBtn');
  btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Đang tạo tài khoản...';
  btn.disabled = true;
  return true;
}
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
