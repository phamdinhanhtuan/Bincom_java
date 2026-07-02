<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"   value="Quản lý sản phẩm" scope="request"/>
<c:set var="currentPage" value="products"          scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="page-header">
    <div>
        <h5>Danh sách sản phẩm</h5>
        <p>Quản lý toàn bộ sản phẩm trong hệ thống</p>
    </div>
    <sec:authorize access="hasAnyRole('ADMIN','STORE_MANAGER')">
    <a href="${pageContext.request.contextPath}/admin/products/new" class="btn-primary-custom">
        <i class="bi bi-plus-lg"></i> Thêm sản phẩm
    </a>
    </sec:authorize>
</div>

<!-- Filter Bar -->
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
                <select name="categoryId" class="form-select">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" ${cat.id == categoryId ? 'selected' : ''}>${cat.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100 rounded-3">Lọc</button>
            </div>
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/admin/products"
                   class="btn btn-outline-secondary w-100 rounded-3">Đặt lại</a>
            </div>
        </form>
    </div>
</div>

<!-- Products Table -->
<div class="card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Giá</th>
                    <th>Tồn kho</th>
                    <th>Trạng thái</th>
                    <th>Nổi bật</th>
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
                                             style="background:linear-gradient(135deg,#f5f3ff,#ede9fe);font-size:22px;color:#a5b4fc;">
                                            <i class="bi bi-box-seam-fill"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <div class="fw-medium">${product.name}</div>
                                    <div class="text-muted small">#${product.productCode}</div>
                                </div>
                            </div>
                        </td>
                        <td><span class="badge bg-light text-dark border">${product.category.name}</span></td>
                        <td>
                            <div class="fw-bold text-primary">
                                <fmt:formatNumber value="${product.effectivePrice}" type="number" groupingUsed="true"/>₫
                            </div>
                            <c:if test="${product.onSale}">
                                <div class="text-muted small" style="text-decoration:line-through;">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${product.inventory != null}">
                                <span class="fw-bold ${product.inventory.lowStock ? 'text-danger' : 'text-success'}">
                                    ${product.inventory.quantityInStock}
                                </span>
                                <c:if test="${product.inventory.lowStock}">
                                    <i class="bi bi-exclamation-triangle-fill text-warning ms-1" title="Sắp hết hàng"></i>
                                </c:if>
                            </c:if>
                        </td>
                        <td>
                            <span class="status-badge ${product.active ? 'active' : 'inactive'}">
                                ${product.active ? 'Đang bán' : 'Ẩn'}
                            </span>
                        </td>
                        <td>
                            <sec:authorize access="hasAnyRole('ADMIN','STORE_MANAGER')">
                            <form action="${pageContext.request.contextPath}/admin/products/${product.id}/toggle-featured" method="post" class="d-inline"
                                  onsubmit="return confirm('Bạn có chắc chắn muốn ${product.featured ? 'Bỏ nổi bật' : 'Đánh dấu nổi bật'} sản phẩm \'${product.name}\' không?');">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-sm ${product.featured ? 'btn-warning' : 'btn-outline-secondary'} rounded-pill" title="${product.featured ? 'Bỏ nổi bật' : 'Đánh dấu nổi bật'}">
                                    <i class="bi bi-star${product.featured ? '-fill' : ''}"></i>
                                </button>
                            </form>
                            </sec:authorize>
                            <sec:authorize access="!hasAnyRole('ADMIN','STORE_MANAGER')">
                                <span class="badge ${product.featured ? 'bg-warning text-dark' : 'bg-light text-secondary'} rounded-pill" style="padding: 6px 10px;">
                                    <i class="bi bi-star${product.featured ? '-fill' : ''}"></i>
                                </span>
                            </sec:authorize>
                        </td>
                        <td>
                            <div class="d-flex gap-1">
                                <sec:authorize access="hasAnyRole('ADMIN','STORE_MANAGER')">
                                <a href="${pageContext.request.contextPath}/admin/products/${product.id}/edit"
                                   class="btn btn-sm btn-outline-primary rounded-2" title="Chỉnh sửa">
                                    <i class="bi bi-pencil-fill"></i>
                                </a>
                                <form action="${pageContext.request.contextPath}/admin/products/${product.id}/toggle-status" method="post" class="d-inline"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn ${product.active ? 'Ẩn' : 'Hiện'} sản phẩm \'${product.name}\' không?');">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-sm ${product.active ? 'btn-outline-warning' : 'btn-outline-success'} rounded-2" title="${product.active ? 'Ẩn' : 'Hiện'}">
                                        <i class="bi bi-${product.active ? 'eye-slash' : 'eye'}-fill"></i>
                                    </button>
                                </form>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ADMIN')">
                                <form action="${pageContext.request.contextPath}/admin/products/${product.id}/delete" method="post" class="d-inline"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm \'${product.name}\'?');">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-2"
                                            title="Xóa">
                                        <i class="bi bi-trash3-fill"></i>
                                    </button>
                                </form>
                                </sec:authorize>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr>
                        <td colspan="7" class="text-center py-5 text-muted">
                            <i class="bi bi-box-seam fs-1 d-block mb-3 opacity-25"></i>
                            Không có sản phẩm nào
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
