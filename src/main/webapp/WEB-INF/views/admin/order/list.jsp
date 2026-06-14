<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"   value="Quản lý đơn hàng" scope="request"/>
<c:set var="currentPage" value="orders"            scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="page-header">
    <div>
        <h5>Danh sách đơn hàng</h5>
        <p>Quản lý và xử lý tất cả đơn hàng</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/orders/reports" class="btn-primary-custom">
        <i class="bi bi-bar-chart-fill"></i> Báo cáo
    </a>
</div>

<!-- Filter -->
<div class="card mb-4">
    <div class="card-body p-3">
        <form action="" method="get" class="row g-2 align-items-end">
            <div class="col-md-4">
                <div class="search-box">
                    <i class="bi bi-search"></i>
                    <input type="text" name="orderCode" class="form-control" placeholder="Tìm mã đơn hàng...">
                </div>
            </div>
            <div class="col-md-4">
                <select name="status" class="form-select">
                    <option value="">Tất cả trạng thái</option>
                    <c:forEach var="s" items="${statuses}">
                        <option value="${s}" ${filterStatus == s ? 'selected' : ''}>${s.displayName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100 rounded-3">Lọc</button>
            </div>
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/admin/orders"
                   class="btn btn-outline-secondary w-100 rounded-3">Đặt lại</a>
            </div>
        </form>
    </div>
</div>

<!-- Orders Table -->
<div class="card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Khách hàng</th>
                    <th>SĐT nhận hàng</th>
                    <th>Tổng tiền</th>
                    <th>Thanh toán</th>
                    <th>Trạng thái</th>
                    <th>Ngày đặt</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td><code class="text-primary fw-bold">${order.orderCode}</code></td>
                        <td>
                            <div class="fw-medium">${order.customer.fullName}</div>
                            <div class="text-muted small">${order.customer.email}</div>
                        </td>
                        <td>${order.recipientPhone}</td>
                        <td class="fw-bold text-primary">
                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                        </td>
                        <td>
                            <span class="badge bg-light text-dark border">${order.paymentMethod}</span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${order.status == 'PENDING'}">
                                    <span class="status-badge pending"><i class="bi bi-hourglass-split"></i>${order.status.displayName}</span>
                                </c:when>
                                <c:when test="${order.status == 'CONFIRMED'}">
                                    <span class="status-badge confirmed"><i class="bi bi-check-circle"></i>${order.status.displayName}</span>
                                </c:when>
                                <c:when test="${order.status == 'SHIPPING'}">
                                    <span class="status-badge shipping"><i class="bi bi-truck"></i>${order.status.displayName}</span>
                                </c:when>
                                <c:when test="${order.status == 'COMPLETED'}">
                                    <span class="status-badge completed"><i class="bi bi-check-circle-fill"></i>${order.status.displayName}</span>
                                </c:when>
                                <c:when test="${order.status == 'CANCELLED'}">
                                    <span class="status-badge cancelled"><i class="bi bi-x-circle"></i>${order.status.displayName}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge inactive">${order.status.displayName}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-muted small">
                            ${order.createdAt.toString().replace('T',' ').substring(0,16)}
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/orders/${order.id}"
                               class="btn btn-sm btn-outline-primary rounded-2">
                                <i class="bi bi-eye-fill me-1"></i>Xem
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="8" class="text-center py-5 text-muted">
                            <i class="bi bi-bag-x fs-1 d-block mb-3 opacity-25"></i>
                            Không có đơn hàng nào
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
