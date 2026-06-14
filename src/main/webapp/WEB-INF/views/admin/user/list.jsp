<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle"   value="Quản lý người dùng" scope="request"/>
<c:set var="currentPage" value="users"             scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="page-header">
    <div>
        <h5>${not empty pageTitle ? pageTitle : 'Quản lý người dùng'}</h5>
        <p>Tất cả tài khoản trong hệ thống</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/users/new" class="btn-primary-custom">
        <i class="bi bi-person-plus-fill"></i> Thêm người dùng
    </a>
</div>

<!-- Search -->
<div class="card mb-4">
    <div class="card-body p-3">
        <form action="${pageContext.request.contextPath}/admin/users" method="get" class="row g-2">
            <div class="col-md-6">
                <div class="search-box">
                    <i class="bi bi-search"></i>
                    <input type="text" name="keyword" class="form-control" placeholder="Tìm theo tên, email, username..." value="${keyword}">
                </div>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary rounded-3 w-100">Tìm kiếm</button>
            </div>
        </form>
    </div>
</div>

<!-- Tab Navigation -->
<div class="d-flex gap-2 mb-3">
    <a href="${pageContext.request.contextPath}/admin/users" class="chip ${empty request.servletPath.contains('customers') && empty request.servletPath.contains('staff') ? 'active' : ''}">Tất cả</a>
    <a href="${pageContext.request.contextPath}/admin/users/customers" class="chip">Khách hàng</a>
    <a href="${pageContext.request.contextPath}/admin/users/staff" class="chip">Nhân viên</a>
</div>

<!-- Users Table -->
<div class="card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr>
                    <th>Người dùng</th>
                    <th>Username</th>
                    <th>SĐT</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width:38px;height:38px;background:linear-gradient(135deg,#6c63ff,#ff6584);border-radius:50%;display:flex;align-items:center;justify-content:center;color:white;font-weight:700;font-size:14px;flex-shrink:0;">
                                    ${user.fullName.substring(0,1).toUpperCase()}
                                </div>
                                <div>
                                    <div class="fw-medium">${user.fullName}</div>
                                    <div class="text-muted small">${user.email}</div>
                                </div>
                            </div>
                        </td>
                        <td><code>${user.username}</code></td>
                        <td>${user.phoneNumber}</td>
                        <td>
                            <c:forEach var="role" items="${user.roles}">
                                <span class="badge bg-light text-dark border small">
                                    ${role.name.replace('ROLE_', '')}
                                </span>
                            </c:forEach>
                        </td>
                        <td>
                            <span class="status-badge ${user.enabled ? 'active' : 'inactive'}">
                                ${user.enabled ? 'Hoạt động' : 'Bị khóa'}
                            </span>
                        </td>
                        <td class="text-muted small">${user.createdAt}</td>
                        <td>
                            <div class="d-flex gap-1">
                                <a href="${pageContext.request.contextPath}/admin/users/${user.id}"
                                   class="btn btn-sm btn-outline-primary rounded-2" title="Chi tiết">
                                    <i class="bi bi-eye-fill"></i>
                                </a>
                                <form action="${pageContext.request.contextPath}/admin/users/${user.id}/toggle-status" method="post" class="d-inline">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-sm ${user.enabled ? 'btn-outline-warning' : 'btn-outline-success'} rounded-2"
                                            title="${user.enabled ? 'Khóa tài khoản' : 'Kích hoạt'}">
                                        <i class="bi bi-${user.enabled ? 'lock' : 'unlock'}-fill"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr><td colspan="7" class="text-center py-5 text-muted">Không có người dùng nào</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
