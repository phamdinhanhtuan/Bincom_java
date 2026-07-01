<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Admin'} — Bincom Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png?v=1.0.2">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <script>window.CTX = '${pageContext.request.contextPath}';</script>
</head>
<body class="admin-body">

<!-- ===== SIDEBAR ===== -->
<aside class="admin-sidebar" id="adminSidebar">
    <div class="sidebar-brand" style="display:flex; align-items:center; gap:10px; padding:20px 24px;">
        <img src="${pageContext.request.contextPath}/resources/images/favicon.png" alt="Bincom Logo" style="height:32px; width:auto; object-fit:contain;">
        <div class="brand-text">
            <span class="brand-name" style="font-family:'Plus Jakarta Sans',sans-serif; font-weight:800; letter-spacing:-0.5px; font-size:20px; color:#fff; display:block; line-height:1.2;">Bincom</span>
            <span class="brand-role" style="font-size:10px; color:rgba(255,255,255,0.5); text-transform:uppercase; letter-spacing:0.5px; display:block;">Admin Panel</span>
        </div>
    </div>

    <nav class="sidebar-nav">
        <!-- Tổng quan -->
        <div class="nav-group">
            <span class="nav-label">Tổng quan</span>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="nav-item ${currentPage == 'dashboard' ? 'active' : ''}">
                <i class="bi bi-grid-1x2-fill"></i>
                <span>Dashboard</span>
            </a>
        </div>

        <!-- Sản phẩm -->
        <div class="nav-group">
            <span class="nav-label">Sản phẩm</span>
            <a href="${pageContext.request.contextPath}/admin/categories"
               class="nav-item ${currentPage == 'categories' ? 'active' : ''}">
                <i class="bi bi-tags-fill"></i>
                <span>Danh mục</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/products"
               class="nav-item ${currentPage == 'products' ? 'active' : ''}">
                <i class="bi bi-box-seam-fill"></i>
                <span>Sản phẩm</span>
            </a>
            <sec:authorize access="hasAnyRole('ADMIN','STORE_MANAGER','WAREHOUSE_STAFF')">
            <a href="${pageContext.request.contextPath}/admin/inventory"
               class="nav-item ${currentPage == 'inventory' ? 'active' : ''}">
                <i class="bi bi-archive-fill"></i>
                <span>Kho hàng</span>
            </a>
            </sec:authorize>
        </div>

        <!-- Đơn hàng -->
        <div class="nav-group">
            <span class="nav-label">Đơn hàng</span>
            <a href="${pageContext.request.contextPath}/admin/orders"
               class="nav-item ${currentPage == 'orders' ? 'active' : ''}">
                <i class="bi bi-bag-check-fill"></i>
                <span>Đơn hàng</span>
                <c:if test="${pendingOrders > 0}">
                    <span class="badge bg-warning text-dark">${pendingOrders}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders/reports"
               class="nav-item ${currentPage == 'reports' ? 'active' : ''}">
                <i class="bi bi-bar-chart-line-fill"></i>
                <span>Báo cáo</span>
            </a>
        </div>

        <!-- Người dùng -->
        <sec:authorize access="hasAnyRole('ADMIN','STORE_MANAGER')">
        <div class="nav-group">
            <span class="nav-label">Người dùng</span>
            <a href="${pageContext.request.contextPath}/admin/users"
               class="nav-item ${currentPage == 'users' ? 'active' : ''}">
                <i class="bi bi-people-fill"></i>
                <span>Tất cả</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users/customers"
               class="nav-item">
                <i class="bi bi-person-fill"></i>
                <span>Khách hàng</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users/staff"
               class="nav-item">
                <i class="bi bi-person-badge-fill"></i>
                <span>Nhân viên</span>
            </a>
        </div>
        </sec:authorize>
    </nav>

    <!-- Footer -->
    <div class="sidebar-footer">
        <div class="user-info">
            <div class="user-avatar">
                <sec:authentication property="principal.username" var="username"/>
                <span>${username.substring(0,1).toUpperCase()}</span>
            </div>
            <div class="user-details">
                <span class="user-name">${username}</span>
                <span class="user-role">
                    <sec:authorize access="hasRole('ADMIN')">Administrator</sec:authorize>
                    <sec:authorize access="hasRole('STORE_MANAGER')">Store Manager</sec:authorize>
                    <sec:authorize access="hasRole('SALES_STAFF')">Sales Staff</sec:authorize>
                    <sec:authorize access="hasRole('WAREHOUSE_STAFF')">Warehouse Staff</sec:authorize>
                </span>
            </div>
        </div>
        <form action="${pageContext.request.contextPath}/admin/logout" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn-logout" title="Đăng xuất">
                <i class="bi bi-box-arrow-right"></i>
            </button>
        </form>
    </div>
</aside>

<!-- ===== MAIN ===== -->
<main class="admin-main" id="adminMain">
    <!-- Topbar -->
    <header class="admin-topbar">
        <button class="sidebar-toggle" onclick="toggleSidebar()">
            <i class="bi bi-list"></i>
        </button>
        <div class="topbar-title">
            <h4 class="mb-0">${pageTitle != null ? pageTitle : 'Dashboard'}</h4>
        </div>
        <div class="topbar-actions">
            <a href="${pageContext.request.contextPath}/" target="_blank"
               class="btn btn-sm btn-outline-secondary">
                <i class="bi bi-eye"></i> Xem cửa hàng
            </a>
        </div>
    </header>

    <!-- Flash Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show mx-3 mt-3" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show mx-3 mt-3" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Page Content -->
    <div class="admin-content">
