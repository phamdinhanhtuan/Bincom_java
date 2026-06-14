<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đăng nhập — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<div class="auth-page">
  <!-- Banner -->
  <div class="auth-banner">
    <a href="${pageContext.request.contextPath}/home" style="display:inline-block; margin-bottom:24px; z-index:1; position:relative;">
      <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom Logo" style="height:42px; width:auto; object-fit:contain; filter:brightness(0) invert(1);">
    </a>
    <h2 style="font-size:28px;font-weight:700;margin-bottom:16px;position:relative;z-index:1;">Chào mừng trở lại!</h2>
    <p class="auth-banner-tagline">Đăng nhập để trải nghiệm mua sắm thông minh, theo dõi đơn hàng và nhận ưu đãi độc quyền.</p>
    <div style="margin-top:40px;display:flex;gap:32px;position:relative;z-index:1;">
      <div style="text-align:center;">
        <div style="font-size:28px;font-weight:800;">500+</div>
        <div style="font-size:11px;opacity:.7;letter-spacing:1px;text-transform:uppercase;">Sản phẩm</div>
      </div>
      <div style="width:1px;background:rgba(255,255,255,.2);"></div>
      <div style="text-align:center;">
        <div style="font-size:28px;font-weight:800;">10K+</div>
        <div style="font-size:11px;opacity:.7;letter-spacing:1px;text-transform:uppercase;">Khách hàng</div>
      </div>
      <div style="width:1px;background:rgba(255,255,255,.2);"></div>
      <div style="text-align:center;">
        <div style="font-size:28px;font-weight:800;">4.9★</div>
        <div style="font-size:11px;opacity:.7;letter-spacing:1px;text-transform:uppercase;">Đánh giá</div>
      </div>
    </div>
  </div>

  <!-- Form -->
  <div class="auth-form-side">
    <div class="auth-form-box">
      <h1 class="auth-title">Đăng nhập</h1>
      <p class="auth-subtitle">Nhập thông tin tài khoản của bạn</p>

      <c:if test="${not empty error}">
        <div style="background:#fef2f2;border:1px solid #fecaca;border-radius:10px;padding:12px 16px;color:#991b1b;font-size:13px;margin-bottom:20px;display:flex;align-items:center;gap:8px;">
          <i class="bi bi-exclamation-circle-fill"></i> ${error}
        </div>
      </c:if>
      <c:if test="${param.registered != null}">
        <div style="background:#ecfdf5;border:1px solid #a7f3d0;border-radius:10px;padding:12px 16px;color:#065f46;font-size:13px;margin-bottom:20px;display:flex;align-items:center;gap:8px;">
          <i class="bi bi-check-circle-fill"></i> Đăng ký thành công! Hãy đăng nhập.
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/login" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <div class="auth-input-group">
          <label>Tên đăng nhập hoặc Email</label>
          <input type="text" name="username" required placeholder="Nhập username hoặc email"
                 value="${param.username}" autocomplete="username">
        </div>

        <div class="auth-input-group">
          <label>Mật khẩu</label>
          <input type="password" name="password" required placeholder="Nhập mật khẩu"
                 autocomplete="current-password">
        </div>

        <button type="submit" class="btn-primary" style="width:100%;justify-content:center;padding:14px;font-size:14px;margin-top:8px;">
          <i class="bi bi-arrow-right-circle"></i> Đăng nhập
        </button>
      </form>

      <div class="auth-divider" style="margin:24px 0; position:relative; text-align:center;">
        <span style="background:white;padding:0 16px;color:#94a3b8;font-size:12px;position:relative;z-index:1;">Chưa có tài khoản?</span>
        <div style="position:absolute;top:50%;left:0;right:0;height:1px;background:#e2e8f0;z-index:0;"></div>
      </div>

      <a href="${pageContext.request.contextPath}/register" class="btn-outline" style="width:100%;justify-content:center;">
        <i class="bi bi-person-plus"></i> Tạo tài khoản mới
      </a>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
