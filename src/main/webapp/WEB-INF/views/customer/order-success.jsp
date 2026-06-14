<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đặt hàng thành công — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<div class="container-shop" style="padding:60px 24px;text-align:center;max-width:600px;margin:0 auto;">
    <div style="width:100px;height:100px;background:linear-gradient(135deg,#10b981,#34d399);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:48px;margin:0 auto 24px;">
        ✅
    </div>
    <h1 class="fw-bold mb-3" style="font-size:32px;color:#1e1b4b;">Đặt hàng thành công!</h1>
    <p class="text-muted mb-2" style="font-size:16px;">Cảm ơn bạn đã mua hàng tại Bincom!</p>

    <c:if test="${not empty orderCode}">
        <div style="background:#f0fdf4;border:2px solid #86efac;border-radius:16px;padding:20px;margin:24px 0;">
            <div class="text-muted small mb-1">Mã đơn hàng của bạn</div>
            <div style="font-size:24px;font-weight:800;color:#10b981;letter-spacing:2px;">${orderCode}</div>
        </div>
    </c:if>

    <p class="text-muted mb-4">Email xác nhận đã được gửi tới địa chỉ email của bạn. Chúng tôi sẽ liên hệ để xác nhận đơn hàng trong thời gian sớm nhất.</p>

    <div class="d-flex gap-3 justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/orders/${orderCode}"
           class="btn-add-cart d-inline-flex" style="width:auto;padding:12px 28px;">
            <i class="bi bi-eye me-2"></i>Xem chi tiết đơn hàng
        </a>
        <a href="${pageContext.request.contextPath}/orders"
           class="btn btn-outline-primary rounded-pill px-4" style="padding:12px 28px;font-weight:600;display:inline-flex;align-items:center;justify-content:center;gap:8px;">
            <i class="bi bi-bag-check"></i>Lịch sử đơn hàng
        </a>
        <a href="${pageContext.request.contextPath}/shop"
           class="btn btn-outline-secondary rounded-pill px-4" style="padding:12px 28px;font-weight:600;display:inline-flex;align-items:center;justify-content:center;gap:8px;">
            <i class="bi bi-shop"></i>Tiếp tục mua sắm
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
