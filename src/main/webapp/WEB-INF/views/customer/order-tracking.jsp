<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Tra cứu đơn hàng — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<div class="container-shop" style="padding:48px 24px;max-width:700px;margin:0 auto;">
    <div class="text-center mb-5">
        <div style="font-size:48px;margin-bottom:12px;">📦</div>
        <h1 class="fw-bold" style="font-size:28px;">Tra cứu đơn hàng</h1>
        <p class="text-muted">Nhập mã đơn hàng để kiểm tra trạng thái giao hàng</p>
    </div>

    <div class="card mb-4">
        <div class="card-body p-4">
            <form action="" method="get">
                <div class="d-flex gap-3">
                    <input type="text" name="orderCode" class="form-control form-control-lg"
                           placeholder="Ví dụ: ORD20240001" value="${orderCode}"
                           style="border-radius:12px;font-size:15px;">
                    <button type="submit" class="btn btn-primary px-4 rounded-3 fw-bold"
                            style="white-space:nowrap;">
                        <i class="bi bi-search me-1"></i>Tra cứu
                    </button>
                </div>
            </form>
        </div>
    </div>

    <c:if test="${not empty orderCode && notFound == true}">
        <div class="text-center p-4 bg-light rounded-3">
            <i class="bi bi-question-circle text-warning" style="font-size:40px;display:block;margin-bottom:12px;"></i>
            <h5 class="fw-bold">Không tìm thấy đơn hàng</h5>
            <p class="text-muted">Mã đơn hàng "<strong>${orderCode}</strong>" không tồn tại. Vui lòng kiểm tra lại.</p>
        </div>
    </c:if>

    <c:if test="${not empty order}">
        <div class="card" style="border-top:3px solid #0d9488;">
            <div class="card-header" style="background:#f0fdfa;">
                <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold fs-5" style="color:#0d9488;">#${order.orderCode}</span>
                    <c:choose>
                        <c:when test="${order.status == 'PENDING'}">
                            <span class="badge bg-warning text-dark">${order.status.displayName}</span>
                        </c:when>
                        <c:when test="${order.status == 'COMPLETED'}">
                            <span class="badge bg-success">${order.status.displayName}</span>
                        </c:when>
                        <c:when test="${order.status == 'CANCELLED'}">
                            <span class="badge bg-danger">${order.status.displayName}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-primary">${order.status.displayName}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="card-body">
                <div class="order-timeline mb-4">
                    <div class="timeline-step done">
                        <div class="step-dot"><i class="bi bi-check-lg"></i></div>
                        <div class="step-label">Đặt hàng</div>
                    </div>
                    <div class="timeline-step ${order.status == 'CONFIRMED' || order.status == 'SHIPPING' || order.status == 'COMPLETED' ? 'done' : ''}">
                        <div class="step-dot"><i class="bi bi-check-circle"></i></div>
                        <div class="step-label">Xác nhận</div>
                    </div>
                    <div class="timeline-step ${order.status == 'SHIPPING' || order.status == 'COMPLETED' ? 'done' : ''}">
                        <div class="step-dot"><i class="bi bi-truck"></i></div>
                        <div class="step-label">Đang giao</div>
                    </div>
                    <div class="timeline-step ${order.status == 'COMPLETED' ? 'done' : ''}">
                        <div class="step-dot"><i class="bi bi-house-check"></i></div>
                        <div class="step-label">Đã nhận</div>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="small text-muted mb-1">Ngày đặt hàng</div>
                        <div class="fw-medium">
                            ${order.createdAt.toString().replace('T',' ').substring(0,16)}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="small text-muted mb-1">Tổng tiền</div>
                        <div class="fw-bold fs-5" style="color:#0d9488;">
                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="small text-muted mb-1">Địa chỉ giao hàng</div>
                        <div>${order.recipientName} · ${order.recipientPhone}</div>
                        <div class="text-muted small">${order.shippingAddress}</div>
                    </div>
                </div>

                <div class="mt-3 pt-3 border-top">
                    <div class="text-muted small mb-2">Sản phẩm:</div>
                    <c:forEach var="item" items="${order.orderItems}">
                        <div class="d-flex justify-content-between align-items-center py-1">
                            <span class="small">
                                ${item.productName}
                                <c:if test="${not empty item.size}">
                                    <span style="font-weight:700; color:var(--accent);">(${item.size})</span>
                                </c:if>
                                × ${item.quantity}
                            </span>
                            <span class="small fw-bold">
                                <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>₫
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
