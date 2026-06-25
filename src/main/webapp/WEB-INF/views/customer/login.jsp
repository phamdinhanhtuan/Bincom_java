<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đăng nhập — Bincom" scope="request"/>
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
        <h2 class="lp-brand-title">Chào mừng<br>trở lại! 👋</h2>
        <p class="lp-brand-sub">Đăng nhập để mua sắm thông minh, theo dõi đơn hàng và nhận ưu đãi độc quyền.</p>

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
    <div class="lp-form-box">

      <%-- Header --%>
      <div class="lp-form-head">
        <div class="lp-form-icon"><i class="bi bi-person-circle"></i></div>
        <h1 class="lp-form-title">Đăng nhập</h1>
        <p class="lp-form-sub">Nhập thông tin tài khoản của bạn</p>
      </div>

      <%-- Alerts --%>
      <c:if test="${not empty error}">
        <div class="lp-alert lp-alert-error">
          <i class="bi bi-exclamation-circle-fill"></i> ${error}
        </div>
      </c:if>
      <c:if test="${param.registered != null}">
        <div class="lp-alert lp-alert-success">
          <i class="bi bi-check-circle-fill"></i> Đăng ký thành công! Hãy đăng nhập.
        </div>
      </c:if>
      <c:if test="${param.logout != null}">
        <div class="lp-alert lp-alert-info">
          <i class="bi bi-info-circle-fill"></i> Bạn đã đăng xuất thành công.
        </div>
      </c:if>

      <%-- Login Form --%>
      <form action="${pageContext.request.contextPath}/login" method="post" class="lp-form" id="loginForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <div class="lp-field">
          <label for="username"><i class="bi bi-person"></i> Tên đăng nhập hoặc Email</label>
          <input type="text" id="username" name="username" required
                 placeholder="Nhập username hoặc email"
                 value="${param.username}" autocomplete="username">
        </div>

        <div class="lp-field">
          <div class="lp-label-row">
            <label for="password"><i class="bi bi-lock"></i> Mật khẩu</label>
            <a href="javascript:void(0)" onclick="alert('Tính năng khôi phục mật khẩu tự động đang được bảo trì. Vui lòng liên hệ bộ phận hỗ trợ qua email support@bincom.vn để được cấp lại mật khẩu.')" class="lp-forgot">Quên mật khẩu?</a>
          </div>
          <div class="lp-pass-wrap">
            <input type="password" id="password" name="password" required
                   placeholder="Nhập mật khẩu" autocomplete="current-password">
            <button type="button" class="lp-eye" onclick="togglePass()">
              <i class="bi bi-eye" id="eyeIcon"></i>
            </button>
          </div>
        </div>

        <div class="lp-remember">
          <label class="lp-check-label">
            <input type="checkbox" name="remember-me">
            <span class="lp-checkmark"></span>
            Nhớ đăng nhập
          </label>
        </div>

        <button type="submit" class="lp-btn-submit" id="submitBtn">
          <i class="bi bi-arrow-right-circle-fill"></i> Đăng nhập
        </button>
      </form>

      <%-- Divider --%>
      <div class="lp-divider"><span>Hoặc</span></div>

      <%-- Register --%>
      <a href="${pageContext.request.contextPath}/register" class="lp-btn-register">
        <i class="bi bi-person-plus-fill"></i> Tạo tài khoản mới
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
function togglePass(){
  var inp = document.getElementById('password');
  var ico = document.getElementById('eyeIcon');
  if(inp.type === 'password'){
    inp.type = 'text';
    ico.className = 'bi bi-eye-slash';
  } else {
    inp.type = 'password';
    ico.className = 'bi bi-eye';
  }
}
document.getElementById('loginForm').addEventListener('submit', function(){
  var btn = document.getElementById('submitBtn');
  btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Đang xử lý...';
  btn.disabled = true;
});
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
