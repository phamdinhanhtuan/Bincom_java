<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Tài khoản của tôi — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<style>
/* Grid layout compatibility */
.account-grid {
    display: grid;
    grid-template-columns: 1.4fr 1fr;
    gap: 32px;
    margin-top: 24px;
}

@media (max-width: 992px) {
    .account-grid {
        grid-template-columns: 1fr;
    }
}

/* Custom grid for form items */
.form-grid-2 {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

@media (max-width: 576px) {
    .form-grid-2 {
        grid-template-columns: 1fr;
    }
}

/* Card Container */
.profile-card {
    background: #ffffff;
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-sm);
    border: 1px solid var(--border);
    margin-bottom: 24px;
    overflow: hidden;
    transition: var(--transition);
}

.profile-card:hover {
    box-shadow: var(--shadow);
}

/* Card Header */
.profile-card-header {
    background: var(--light);
    padding: 20px 24px;
    border-bottom: 1px solid var(--border);
    font-size: 16px;
    font-weight: 700;
    color: var(--primary);
    display: flex;
    align-items: center;
    gap: 10px;
}

/* Card Body */
.profile-card-body {
    padding: 24px;
}

/* Form inputs & controls */
.form-group-custom {
    margin-bottom: 20px;
}

.form-label-custom {
    font-size: 13px;
    font-weight: 600;
    color: var(--text-muted);
    margin-bottom: 8px;
    display: block;
    letter-spacing: 0.5px;
}

.form-input-custom {
    width: 100%;
    padding: 12px 16px;
    font-family: inherit;
    font-size: 14px;
    color: var(--primary);
    background: var(--white);
    border: 1.5px solid var(--border);
    border-radius: var(--radius);
    outline: none;
    transition: var(--transition);
}

.form-input-custom:focus {
    border-color: var(--accent);
    box-shadow: 0 0 0 3px rgba(13,148,136,0.15);
}

.form-input-custom[readonly] {
    background: var(--light2);
    border-color: var(--border);
    color: var(--text-muted);
    cursor: not-allowed;
}

/* Account Banner summary */
.account-summary-banner {
    background: linear-gradient(135deg, #f0fdfa 0%, #ccfbf1 100%);
    border: 1px solid rgba(13,148,136,0.15);
    border-radius: var(--radius-lg);
    padding: 32px 24px;
    text-align: center;
    box-shadow: var(--shadow-sm);
    margin-bottom: 24px;
}

.avatar-circle {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, var(--accent) 0%, #0f766e 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32px;
    font-weight: 800;
    color: white;
    margin: 0 auto 16px;
    box-shadow: 0 8px 20px rgba(13,148,136,0.25);
}

.account-name {
    font-size: 20px;
    font-weight: 800;
    color: var(--primary);
    margin-bottom: 4px;
}

.account-username {
    font-size: 13px;
    color: var(--text-muted);
    font-weight: 600;
    margin-bottom: 2px;
}

.account-email {
    font-size: 13px;
    color: var(--text-muted);
    margin-bottom: 20px;
}
</style>

<div class="container-shop" style="padding:40px 24px; min-height: 70vh;">
    <h1 class="fw-bold" style="font-size:28px; color: var(--primary);">
        <i class="bi bi-person-circle me-2 text-accent"></i>Tài khoản của tôi
    </h1>
    <p style="color: var(--text-muted); font-size: 14px; margin-top: 4px; margin-bottom: 24px;">Quản lý thông tin hồ sơ và bảo mật tài khoản cá nhân của bạn.</p>

    <c:if test="${not empty success}">
        <div style="background:#ecfdf5; border:1px solid #a7f3d0; border-radius:12px; padding:16px 20px; color:#065f46; font-size:14px; margin-bottom:24px; display:flex; align-items:center; gap:10px;">
            <i class="bi bi-check-circle-fill" style="font-size: 18px; color:#10b981;"></i>
            <span>${success}</span>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div style="background:#fef2f2; border:1px solid #fecaca; border-radius:12px; padding:16px 20px; color:#991b1b; font-size:14px; margin-bottom:24px; display:flex; align-items:center; gap:10px;">
            <i class="bi bi-exclamation-triangle-fill" style="font-size: 18px; color:#ef4444;"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <div class="account-grid">
        <!-- Profile Info -->
        <div>
            <div class="profile-card">
                <div class="profile-card-header">
                    <i class="bi bi-person-fill text-accent" style="font-size: 18px;"></i>
                    <span>Thông tin cá nhân</span>
                </div>
                <div class="profile-card-body">
                    <form action="${pageContext.request.contextPath}/account/update" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="form-grid-2">
                            <div class="form-group-custom">
                                <label class="form-label-custom">Họ và tên</label>
                                <input type="text" name="fullName" class="form-input-custom"
                                       value="${user.fullName}" required placeholder="Nhập họ và tên">
                            </div>
                            <div class="form-group-custom">
                                <label class="form-label-custom">Số điện thoại</label>
                                <input type="tel" name="phoneNumber" class="form-input-custom"
                                       value="${user.phoneNumber}" placeholder="0901234567">
                            </div>
                        </div>

                        <div class="form-group-custom">
                            <label class="form-label-custom">Email</label>
                            <input type="email" class="form-input-custom"
                                   value="${user.email}" readonly>
                            <div style="font-size:12px; color:var(--text-muted); margin-top:6px; display: flex; align-items: center; gap: 4px;">
                                <i class="bi bi-info-circle"></i> Email đăng ký tài khoản không thể thay đổi
                            </div>
                        </div>

                        <div class="form-group-custom" style="margin-bottom: 24px;">
                            <label class="form-label-custom">Địa chỉ giao hàng</label>
                            <textarea name="address" class="form-input-custom" rows="3" style="resize:vertical;"
                                      placeholder="Nhập số nhà, tên đường, quận/huyện, thành phố...">${user.address}</textarea>
                        </div>

                        <button type="submit" class="btn-add-cart" style="width:auto; padding:12px 32px; font-size:13px;">
                            <i class="bi bi-floppy-fill me-2"></i>Lưu thay đổi
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Change Password + Account Info -->
        <div>
            <!-- Account Summary -->
            <div class="account-summary-banner">
                <div class="avatar-circle">
                    ${user.fullName.substring(0,1).toUpperCase()}
                </div>
                <div class="account-name">${user.fullName}</div>
                <div class="account-username">@${user.username}</div>
                <div class="account-email">${user.email}</div>
                
                <div style="height:1px; background:rgba(13,148,136,0.15); margin:20px 0;"></div>
                
                <a href="${pageContext.request.contextPath}/orders" class="btn-outline" style="width:100%; justify-content:center; gap:8px;">
                    <i class="bi bi-bag-check-fill"></i> Xem đơn hàng của tôi
                </a>
            </div>

            <!-- Change Password -->
            <div class="profile-card">
                <div class="profile-card-header">
                    <i class="bi bi-shield-lock-fill text-warning" style="font-size: 18px;"></i>
                    <span>Đổi mật khẩu</span>
                </div>
                <div class="profile-card-body">
                    <form action="${pageContext.request.contextPath}/account/change-password" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="form-group-custom">
                            <label class="form-label-custom">Mật khẩu hiện tại</label>
                            <input type="password" name="oldPassword" class="form-input-custom" required placeholder="Nhập mật khẩu hiện tại">
                        </div>
                        
                        <div class="form-group-custom">
                            <label class="form-label-custom">Mật khẩu mới</label>
                            <input type="password" name="newPassword" class="form-input-custom"
                                   required minlength="6" placeholder="Tối thiểu 6 ký tự">
                        </div>
                        
                        <div class="form-group-custom" style="margin-bottom: 24px;">
                            <label class="form-label-custom">Xác nhận mật khẩu mới</label>
                            <input type="password" name="confirmNewPassword" class="form-input-custom" required placeholder="Xác nhận mật khẩu mới">
                        </div>
                        
                        <button type="submit" class="btn-primary" style="width:100%; justify-content:center; padding:12px; font-size:13px; background:var(--grad-warm); box-shadow:0 4px 16px rgba(245,158,11,0.25);">
                            <i class="bi bi-key-fill me-2"></i>Đổi mật khẩu
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
