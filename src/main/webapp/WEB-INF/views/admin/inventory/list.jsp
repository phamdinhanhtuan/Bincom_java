<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"   value="Quản lý kho hàng" scope="request"/>
<c:set var="currentPage" value="inventory"       scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="page-header">
    <div>
        <h5>Quản lý kho hàng</h5>
        <p>Theo dõi tồn kho và cảnh báo sắp hết hàng</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/products/new" class="btn-primary-custom">
        <i class="bi bi-plus-lg"></i> Nhập hàng mới
    </a>
</div>

<!-- Stats -->
<div class="quick-stats mb-4">
    <div class="stat-card blue">
        <div class="stat-info">
            <p class="stat-label">Tổng sản phẩm</p>
            <h3 class="stat-value">${totalProducts != null ? totalProducts : 0}</h3>
            <p class="stat-sub">Đang quản lý</p>
        </div>
        <div class="stat-icon blue"><i class="bi bi-box-seam-fill"></i></div>
    </div>
    <div class="stat-card green">
        <div class="stat-info">
            <p class="stat-label">Còn hàng</p>
            <h3 class="stat-value">${inStockCount != null ? inStockCount : 0}</h3>
            <p class="stat-sub">Sản phẩm</p>
        </div>
        <div class="stat-icon green"><i class="bi bi-check-circle-fill"></i></div>
    </div>
    <div class="stat-card orange">
        <div class="stat-info">
            <p class="stat-label">Sắp hết hàng</p>
            <h3 class="stat-value">${lowStockCount != null ? lowStockCount : 0}</h3>
            <p class="stat-sub">Cần nhập thêm</p>
        </div>
        <div class="stat-icon orange"><i class="bi bi-exclamation-triangle-fill"></i></div>
    </div>
    <div class="stat-card red">
        <div class="stat-info">
            <p class="stat-label">Hết hàng</p>
            <h3 class="stat-value">${outOfStockCount != null ? outOfStockCount : 0}</h3>
            <p class="stat-sub">Cần nhập gấp</p>
        </div>
        <div class="stat-icon red"><i class="bi bi-x-circle-fill"></i></div>
    </div>
</div>

<!-- Filter -->
<div class="card mb-4">
    <div class="card-body p-3">
        <form action="" method="get" class="row g-2 align-items-end">
            <div class="col-md-5">
                <div class="search-box">
                    <i class="bi bi-search"></i>
                    <input type="text" name="keyword" class="form-control"
                           placeholder="Tìm sản phẩm..." value="${keyword}">
                </div>
            </div>
            <div class="col-md-3">
                <select name="stockStatus" class="form-select">
                    <option value="">Tất cả trạng thái</option>
                    <option value="low" ${stockStatus == 'low' ? 'selected' : ''}>Sắp hết (≤ mức tối thiểu)</option>
                    <option value="out" ${stockStatus == 'out' ? 'selected' : ''}>Hết hàng</option>
                    <option value="ok"  ${stockStatus == 'ok'  ? 'selected' : ''}>Còn đủ hàng</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">Lọc</button>
            </div>
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/admin/inventory"
                   class="btn btn-outline-secondary w-100">Đặt lại</a>
            </div>
        </form>
    </div>
</div>

<!-- Inventory Table -->
<div class="card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Danh mục</th>
                    <th class="text-center">Tồn kho</th>
                    <th class="text-center">Đang giao</th>
                    <th class="text-center">Khả dụng</th>
                    <th class="text-center">Mức tối thiểu</th>
                    <th class="text-center">Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>
                            <div class="d-flex align-items-center gap-3">
                                <c:choose>
                                    <c:when test="${not empty product.thumbnailUrl && product.thumbnailUrl.startsWith('data:')}">
                                        <img src="${product.thumbnailUrl}"
                                             class="product-thumb" alt="${product.name}">
                                    </c:when>
                                    <c:when test="${not empty product.thumbnailUrl}">
                                        <img src="${product.thumbnailUrl.startsWith('data:') ? '' : pageContext.request.contextPath}${product.thumbnailUrl}"
                                             class="product-thumb" alt="${product.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-thumb d-flex align-items-center justify-content-center"
                                             style="background:#f5f3ff;font-size:20px;">📦</div>
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <div class="fw-medium">${product.name}</div>
                                    <div class="text-muted small">#${product.productCode}</div>
                                </div>
                            </div>
                        </td>
                        <td><span class="badge bg-light text-dark border">${product.category.name}</span></td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${product.inventory != null}">
                                    <span class="fw-bold
                                        ${product.inventory.quantityInStock == 0 ? 'stock-empty' :
                                          product.inventory.lowStock ? 'stock-low' : 'stock-high'}">
                                        ${product.inventory.quantityInStock}
                                    </span>
                                </c:when>
                                <c:otherwise><span class="text-muted">—</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center text-muted">
                            ${product.inventory != null ? product.inventory.quantityReserved : '—'}
                        </td>
                        <td class="text-center fw-bold">
                            ${product.inventory != null ? product.inventory.availableQuantity : '—'}
                        </td>
                        <td class="text-center text-muted">
                            ${product.inventory != null ? product.inventory.reorderLevel : '—'}
                        </td>
                        <td class="text-center">
                            <c:if test="${product.inventory != null}">
                                <c:choose>
                                    <c:when test="${product.inventory.quantityInStock == 0}">
                                        <span class="status-badge cancelled">
                                            <i class="bi bi-x-circle-fill"></i> Hết hàng
                                        </span>
                                    </c:when>
                                    <c:when test="${product.inventory.lowStock}">
                                        <span class="status-badge pending">
                                            <i class="bi bi-exclamation-triangle-fill"></i> Sắp hết
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge active">
                                            <i class="bi bi-check-circle-fill"></i> Đủ hàng
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/products/${product.id}/edit"
                               class="btn btn-sm btn-outline-primary" title="Chỉnh sửa tồn kho">
                                <i class="bi bi-pencil-fill"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr>
                        <td colspan="8" class="empty-state">
                            <i class="bi bi-archive"></i>
                            <p>Không có sản phẩm nào</p>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
