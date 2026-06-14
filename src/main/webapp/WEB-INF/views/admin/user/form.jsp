<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"   value="Thêm người dùng" scope="request"/>
<c:set var="currentPage" value="users"           scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="d-flex align-items-center justify-content-between mb-4">
    <div>
        <h5 class="fw-bold mb-1">${not empty user.id ? 'Chỉnh sửa tài khoản' : 'Thêm người dùng mới'}</h5>
        <p class="text-muted small mb-0">Quản lý tài khoản người dùng trong hệ thống</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary rounded-3">
        <i class="bi bi-arrow-left me-1"></i> Quay lại
    </a>
</div>

<div class="row">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-header">
                <span><i class="bi bi-person-fill me-2 text-primary"></i>Thông tin tài khoản</span>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/users/save" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <c:if test="${not empty user.id}">
                        <input type="hidden" name="id" value="${user.id}">
                    </c:if>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-medium">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" name="fullName" class="form-control rounded-3"
                                   value="${user.fullName}" required placeholder="Nguyễn Văn A">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium">Username <span class="text-danger">*</span></label>
                            <input type="text" name="username" class="form-control rounded-3"
                                   value="${user.username}" required placeholder="username123"
                                   ${not empty user.id ? 'readonly' : ''}>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium">Email <span class="text-danger">*</span></label>
                            <input type="email" name="email" class="form-control rounded-3"
                                   value="${user.email}" required placeholder="email@example.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium">Số điện thoại</label>
                            <input type="tel" name="phoneNumber" class="form-control rounded-3"
                                   value="${user.phoneNumber}" placeholder="0901234567">
                        </div>
                        <c:if test="${empty user.id}">
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" name="password" id="pwd" class="form-control rounded-3"
                                       required placeholder="Tối thiểu 6 ký tự" minlength="6">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" id="confirmPwd" class="form-control rounded-3"
                                       required placeholder="Nhập lại mật khẩu">
                            </div>
                        </c:if>
                        <div class="col-md-6">
                            <label class="form-label fw-medium">Vai trò <span class="text-danger">*</span></label>
                            <select name="roleName" class="form-select rounded-3">
                                <option value="ROLE_CUSTOMER">Khách hàng</option>
                                <option value="ROLE_SALES_STAFF">Nhân viên bán hàng</option>
                                <option value="ROLE_WAREHOUSE_STAFF">Nhân viên kho</option>
                                <option value="ROLE_STORE_MANAGER">Quản lý cửa hàng</option>
                                <option value="ROLE_ADMIN">Quản trị viên</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium">Trạng thái</label>
                            <select name="enabled" class="form-select rounded-3">
                                <option value="true" ${user.enabled ? 'selected' : ''}>Hoạt động</option>
                                <option value="false" ${!user.enabled ? 'selected' : ''}>Bị khóa</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-medium">Địa chỉ</label>
                            <textarea name="address" class="form-control rounded-3" rows="2"
                                      placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố">${user.address}</textarea>
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-4">
                        <button type="submit" class="btn-primary-custom" onclick="return validateForm()">
                            <i class="bi bi-check-lg me-1"></i>
                            ${not empty user.id ? 'Cập nhật' : 'Tạo tài khoản'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary rounded-3">
                            Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="card">
            <div class="card-header">
                <span><i class="bi bi-info-circle me-2 text-info"></i>Hướng dẫn</span>
            </div>
            <div class="card-body">
                <ul class="list-unstyled small text-muted">
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Username không thể thay đổi sau khi tạo</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Mật khẩu tối thiểu 6 ký tự</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Email phải là địa chỉ hợp lệ</li>
                    <li class="mb-2"><i class="bi bi-info-circle-fill text-primary me-2"></i>Tài khoản bị khóa không thể đăng nhập</li>
                </ul>
                <hr>
                <div class="small">
                    <strong>Phân quyền:</strong>
                    <ul class="mt-2 text-muted">
                        <li>Admin — Toàn quyền</li>
                        <li>Store Manager — Quản lý cửa hàng</li>
                        <li>Sales Staff — Xử lý đơn hàng</li>
                        <li>Warehouse — Quản lý kho</li>
                        <li>Customer — Mua hàng</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function validateForm() {
    var pwd = document.getElementById('pwd');
    var confirm = document.getElementById('confirmPwd');
    if (pwd && confirm && pwd.value !== confirm.value) {
        alert('Mật khẩu xác nhận không khớp!');
        return false;
    }
    return true;
}
</script>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
