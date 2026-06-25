<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"   value="Chi tiết đơn hàng" scope="request"/>
<c:set var="currentPage" value="orders"            scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="d-flex align-items-center justify-content-between mb-4">
    <div>
        <h5 class="fw-bold mb-1">Đơn hàng #${order.orderCode}</h5>
        <p class="text-muted small mb-0">
            Đặt lúc: ${order.createdAt.toString().replace('T',' ').substring(0,16)}
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary rounded-3">
        <i class="bi bi-arrow-left me-1"></i>Quay lại
    </a>
</div>

<div class="row g-4">
    <div class="col-lg-8">
        <!-- Items -->
        <div class="card mb-4">
            <div class="card-header fw-bold"><i class="bi bi-list-ul me-2"></i>Chi tiết sản phẩm</div>
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th class="text-center">SL</th>
                            <th class="text-end">Đơn giá</th>
                            <th class="text-end">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.orderItems}">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <c:if test="${not empty item.productThumbnail}">
                                            <img src="${pageContext.request.contextPath}${item.productThumbnail}"
                                                 class="product-thumb" alt="${item.productName}">
                                        </c:if>
                                        <div>
                                            <div class="fw-medium">${item.productName}</div>
                                            <c:if test="${not empty item.size}">
                                                <div class="small text-danger fw-bold">Size: ${item.size}</div>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-center fw-bold">${item.quantity}</td>
                                <td class="text-end">
                                    <fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/>₫
                                </td>
                                <td class="text-end fw-bold text-primary">
                                    <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>₫
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot style="border-top:2px solid #e5e7eb;">
                        <tr>
                            <td colspan="3" class="text-end text-muted">Tạm tính:</td>
                            <td class="text-end fw-medium">
                                <fmt:formatNumber value="${order.subtotal}" type="number" groupingUsed="true"/>₫
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-end text-muted">Phí vận chuyển:</td>
                            <td class="text-end fw-medium">
                                <fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true"/>₫
                            </td>
                        </tr>
                        <c:if test="${order.discountAmount > 0}">
                        <tr>
                            <td colspan="3" class="text-end text-success">Giảm giá (${order.couponCode}):</td>
                            <td class="text-end text-success fw-medium">
                                -<fmt:formatNumber value="${order.discountAmount}" type="number" groupingUsed="true"/>₫
                            </td>
                        </tr>
                        </c:if>
                        <tr>
                            <td colspan="3" class="text-end fw-bold fs-6">Tổng cộng:</td>
                            <td class="text-end fw-bold fs-5 text-primary">
                                <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <!-- Update Status -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Cập nhật trạng thái</div>
            <div class="card-body">
                <div class="mb-3">
                    <span class="text-muted small">Trạng thái hiện tại:</span>
                    <div class="mt-1">
                        <span class="status-badge ${order.status.name().toLowerCase()}" style="font-size:14px;">
                            ${order.status.displayName}
                        </span>
                    </div>
                </div>
                <form action="${pageContext.request.contextPath}/admin/orders/${order.id}/update-status" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="mb-3">
                        <label class="form-label fw-medium">Chuyển sang:</label>
                        <select name="status" class="form-select">
                            <c:forEach var="s" items="${statuses}">
                                <option value="${s}" ${s == order.status ? 'selected' : ''}>${s.displayName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn-primary-custom w-100 justify-content-center">
                        <i class="bi bi-arrow-repeat"></i> Cập nhật
                    </button>
                </form>
            </div>
        </div>

        <!-- Customer Info -->
        <div class="card mb-4">
            <div class="card-header fw-bold"><i class="bi bi-person-fill me-2"></i>Khách hàng</div>
            <div class="card-body">
                <div class="mb-2"><span class="text-muted small">Tên:</span> <strong>${order.customer.fullName}</strong></div>
                <div class="mb-2"><span class="text-muted small">Email:</span> ${order.customer.email}</div>
                <div class="mb-2"><span class="text-muted small">SĐT:</span> ${order.customer.phoneNumber}</div>
            </div>
        </div>

        <!-- Shipping Info -->
        <div class="card">
            <div class="card-header fw-bold"><i class="bi bi-geo-alt-fill me-2 text-primary"></i>Thông tin giao hàng</div>
            <div class="card-body">
                <div class="mb-2"><span class="text-muted small">Người nhận:</span> <strong>${order.recipientName}</strong></div>
                <div class="mb-2"><span class="text-muted small">SĐT:</span> ${order.recipientPhone}</div>
                <div class="mb-2"><span class="text-muted small">Địa chỉ:</span> ${order.shippingAddress}</div>
                <div class="mb-2"><span class="text-muted small">Phương thức TT:</span>
                    <span class="badge bg-primary">${order.paymentMethod}</span>
                </div>
                <c:if test="${not empty order.note}">
                    <div><span class="text-muted small">Ghi chú:</span> <em>${order.note}</em></div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
