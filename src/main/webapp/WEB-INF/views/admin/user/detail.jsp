<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"   value="Chi tiết người dùng" scope="request"/>
<c:set var="currentPage" value="users"               scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="d-flex align-items-center justify-content-between mb-4">
    <div>
        <h5 class="fw-bold mb-1">Chi tiết tài khoản</h5>
        <p class="text-muted small mb-0">${user.fullName} — @${user.username}</p>
    </div>
    <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary rounded-3">
            <i class="bi bi-arrow-left me-1"></i> Quay lại
        </a>
        <a href="${pageContext.request.contextPath}/admin/users/${user.id}/edit" class="btn btn-primary rounded-3">
            <i class="bi bi-pencil-square me-1"></i> Chỉnh sửa
        </a>
        <form action="${pageContext.request.contextPath}/admin/users/${user.id}/toggle-status" method="post" class="d-inline">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn ${user.enabled ? 'btn-outline-warning' : 'btn-outline-success'} rounded-3">
                <i class="bi bi-${user.enabled ? 'lock' : 'unlock'}-fill me-1"></i>
                ${user.enabled ? 'Khóa tài khoản' : 'Kích hoạt'}
            </button>
        </form>
        <form action="${pageContext.request.contextPath}/admin/users/${user.id}/delete" method="post" class="d-inline"
              onsubmit="return confirm('Bạn có chắc chắn muốn xóa tài khoản \'${user.username}\'?');">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-outline-danger rounded-3" title="Xóa">
                <i class="bi bi-trash3-fill me-1"></i> Xóa
            </button>
        </form>
    </div>
</div>

<div class="row g-4">
    <!-- User Info -->
    <div class="col-lg-4">
        <div class="card">
            <div class="card-body text-center pt-4">
                <div style="width:80px;height:80px;background:linear-gradient(135deg,#6366f1,#8b5cf6);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:32px;color:white;font-weight:700;">
                    ${user.fullName.substring(0,1).toUpperCase()}
                </div>
                <h5 class="fw-bold mb-1">${user.fullName}</h5>
                <p class="text-muted small mb-3">@${user.username}</p>
                <span class="badge ${user.enabled ? 'bg-success' : 'bg-danger'} rounded-pill px-3 py-2">
                    <i class="bi bi-circle-fill me-1" style="font-size:8px;"></i>
                    ${user.enabled ? 'Đang hoạt động' : 'Bị khóa'}
                </span>
                <hr>
                <div class="text-start">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="bi bi-envelope-fill text-primary"></i>
                        <span class="small">${user.email}</span>
                    </div>
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="bi bi-telephone-fill text-success"></i>
                        <span class="small">${not empty user.phoneNumber ? user.phoneNumber : 'Chưa cập nhật'}</span>
                    </div>
                    <div class="d-flex align-items-start gap-2 mb-2">
                        <i class="bi bi-geo-alt-fill text-danger mt-1"></i>
                        <span class="small">${not empty user.address ? user.address : 'Chưa cập nhật'}</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-calendar-fill text-warning"></i>
                        <span class="small">
                                <c:choose>
                                    <c:when test="${not empty user.createdAt}">
                                        ${user.createdAt.toString().substring(0,10)}
                                    </c:when>
                                    <c:otherwise>Không rõ</c:otherwise>
                                </c:choose>
                        </span>
                    </div>
                </div>
                <hr>
                <div class="text-start">
                    <p class="small fw-bold mb-2">Vai trò:</p>
                    <c:forEach var="role" items="${user.roles}">
                        <span class="badge bg-primary me-1 mb-1">
                            ${role.name.replace('ROLE_', '')}
                        </span>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <!-- Orders & Reset Password -->
    <div class="col-lg-8">
        <!-- Reset Password -->
        <div class="card mb-4">
            <div class="card-header">
                <span><i class="bi bi-key-fill me-2 text-warning"></i>Đặt lại mật khẩu</span>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/users/${user.id}/reset-password" method="post"
                      class="row g-3 align-items-end">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="col-md-6">
                        <label class="form-label fw-medium">Mật khẩu mới</label>
                        <input type="password" name="newPassword" class="form-control rounded-3"
                               required minlength="6" placeholder="Tối thiểu 6 ký tự">
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-warning rounded-3 w-100">
                            <i class="bi bi-key-fill me-1"></i> Đặt lại
                        </button>
                    </div>
                </form>
                <div class="alert alert-info mt-3 mb-0 small">
                    <i class="bi bi-info-circle-fill me-2"></i>
                    Mật khẩu mới sẽ được mã hoá BCrypt trước khi lưu vào database.
                </div>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="card">
            <div class="card-header">
                <span><i class="bi bi-bag-check-fill me-2 text-success"></i>Đơn hàng gần đây</span>
            </div>
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Ngày đặt</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty user.orders}">
                                <c:forEach var="order" items="${user.orders}" begin="0" end="4">
                                    <tr>
                                        <td><code class="text-primary fw-bold">${order.orderCode}</code></td>
                                        <td class="fw-bold">
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                                        </td>
                                        <td>
                                            <span class="status-badge ${order.status == 'COMPLETED' ? 'active' : order.status == 'CANCELLED' ? 'inactive' : 'pending'}">
                                                <c:choose>
                                                    <c:when test="${order.status == 'PENDING'}">Chờ xác nhận</c:when>
                                                    <c:when test="${order.status == 'CONFIRMED'}">Đã xác nhận</c:when>
                                                    <c:when test="${order.status == 'SHIPPING'}">Đang giao</c:when>
                                                    <c:when test="${order.status == 'COMPLETED'}">Hoàn thành</c:when>
                                                    <c:when test="${order.status == 'CANCELLED'}">Đã huỷ</c:when>
                                                    <c:otherwise>${order.status}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td class="text-muted small">
                                        ${order.createdAt.toString().substring(0,10)}
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/orders/${order.id}"
                                               class="btn btn-sm btn-outline-primary rounded-2">
                                                <i class="bi bi-eye-fill"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="bi bi-bag-x fs-1 d-block mb-2 opacity-25"></i>
                                        Chưa có đơn hàng nào
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
