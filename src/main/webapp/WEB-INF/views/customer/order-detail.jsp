<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đơn hàng ${order.orderCode} — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<style>
  .detail-card {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(15, 23, 42, 0.02);
    margin-bottom: 24px;
    overflow: hidden;
    transition: all 0.3s ease;
  }
  .detail-card:hover {
    box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
  }
  .detail-card-header {
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    padding: 18px 24px;
    font-weight: 700;
    font-size: 15px;
    color: #0f172a;
    display: flex;
    align-items: center;
    gap: 10px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  .detail-card-body {
    padding: 24px;
  }
  
  /* Timeline Stepper */
  .stepper-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
    padding: 28px 20px;
    background: #ffffff;
    border-radius: 16px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 4px 20px rgba(15, 23, 42, 0.02);
    margin-bottom: 32px;
  }
  
  .stepper-line {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    left: 12.5%;
    width: 75%;
    height: 4px;
    background: #e2e8f0;
    z-index: 1;
  }
  
  .stepper-line-progress {
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    background: #0d9488;
    transition: width 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  }
  
  .stepper-item {
    position: relative;
    z-index: 2;
    background: #ffffff;
    padding: 0 8px;
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 25%;
  }
  
  .stepper-circle {
    width: 44px;
    height: 44px;
    border-radius: 50%;
    background: #ffffff;
    border: 2px solid #cbd5e1;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 15px;
    font-weight: 700;
    color: #64748b;
    transition: all 0.3s ease;
  }
  
  .stepper-item.completed .stepper-circle {
    background: #0d9488;
    border-color: #0d9488;
    color: #ffffff;
    box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.15);
  }
  
  .stepper-item.active .stepper-circle {
    background: #ffffff;
    border-color: #0d9488;
    color: #0d9488;
    font-weight: 700;
    box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.2);
  }
  
  .stepper-text {
    margin-top: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #64748b;
    text-align: center;
    transition: color 0.3s ease;
  }
  
  .stepper-item.completed .stepper-text {
    color: #0f172a;
  }
  
  .stepper-item.active .stepper-text {
    color: #0d9488;
    font-weight: 700;
  }
  
  @media (max-width: 576px) {
    .stepper-container {
      flex-direction: column;
      align-items: flex-start;
      gap: 24px;
      padding: 24px 32px;
    }
    .stepper-line {
      display: none; /* Hide background line on mobile for clean stacked circles */
    }
    .stepper-item {
      flex-direction: row;
      width: 100%;
      gap: 16px;
      padding: 0;
      align-items: center;
    }
    .stepper-text {
      margin-top: 0;
      text-align: left;
    }
  }
  
  /* Status Badge premium */
  .badge-premium {
    padding: 6px 14px;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.5px;
    border-radius: 30px;
    text-transform: uppercase;
    display: inline-flex;
    align-items: center;
  }
  .badge-premium.pending { background: #fffbeb; color: #d97706; border: 1px solid #fde68a; }
  .badge-premium.confirmed { background: #f0fdfa; color: #0d9488; border: 1px solid #99f6e4; }
  .badge-premium.shipping { background: #f5f3ff; color: #7c3aed; border: 1px solid #ddd6fe; }
  .badge-premium.completed { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
  .badge-premium.cancelled { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
  .badge-premium.returned { background: #f1f5f9; color: #475569; border: 1px solid #cbd5e1; }
  
  /* Product row list */
  .product-item {
    display: flex;
    align-items: center;
    gap: 18px;
    padding: 20px 24px;
    border-bottom: 1px solid #f1f5f9;
    transition: background 0.2s ease;
  }
  .product-item:last-child {
    border-bottom: none;
  }
  .product-item:hover {
    background: #f8fafc;
  }
  
  /* Summary row */
  .summary-item {
    display: flex;
    justify-content: space-between;
    padding: 12px 0;
    font-size: 14px;
    color: #64748b;
    border-bottom: 1px solid #f1f5f9;
  }
  .summary-item.total {
    border-bottom: none;
    padding-top: 18px;
    font-size: 18px;
    font-weight: 800;
    color: #0f172a;
  }
</style>

<div class="container-shop" style="padding-top:40px; padding-bottom:80px;">
    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-3" style="border-bottom:1px solid #f1f5f9; padding-bottom: 24px;">
        <div>
            <div style="display:flex; align-items:center; gap:12px; margin-bottom: 8px; flex-wrap: wrap;">
                <h1 class="fw-bold mb-0" style="font-size:26px; color:#0f172a; font-family:'Plus Jakarta Sans',sans-serif;">
                    Đơn hàng <span style="color:#0d9488;">#${order.orderCode}</span>
                </h1>
                <c:choose>
                    <c:when test="${order.status == 'PENDING'}">
                        <span class="badge-premium pending">⏳ ${order.status.displayName}</span>
                    </c:when>
                    <c:when test="${order.status == 'CONFIRMED'}">
                        <span class="badge-premium confirmed">✓ ${order.status.displayName}</span>
                    </c:when>
                    <c:when test="${order.status == 'SHIPPING'}">
                        <span class="badge-premium shipping">🚚 ${order.status.displayName}</span>
                    </c:when>
                    <c:when test="${order.status == 'COMPLETED'}">
                        <span class="badge-premium completed">✔ ${order.status.displayName}</span>
                    </c:when>
                    <c:when test="${order.status == 'CANCELLED'}">
                        <span class="badge-premium cancelled">✕ ${order.status.displayName}</span>
                    </c:when>
                    <c:when test="${order.status == 'RETURNED'}">
                        <span class="badge-premium returned">↩ ${order.status.displayName}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge-premium pending">${order.status.displayName}</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <p class="text-muted small mb-0" style="font-size: 13px;">
                <i class="bi bi-clock-history me-1"></i> Đặt lúc: ${order.createdAt.toString().replace('T',' ').substring(0,16)}
            </p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/orders" class="btn-outline" style="padding: 8px 20px; font-size: 13px; border-radius: 10px;">
                <i class="bi bi-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>
    
    <!-- Alert Messages -->
    <c:if test="${not empty success}">
        <div style="background: #ecfdf5; border: 1px solid #10b981; color: #065f46; padding: 16px 20px; border-radius: 12px; margin-bottom: 24px; font-weight: 500; display: flex; align-items: center; gap: 10px; font-family: 'Plus Jakarta Sans', sans-serif; font-size: 14px;">
            <i class="bi bi-check-circle-fill" style="color: #10b981; font-size: 18px;"></i>
            <span>${success}</span>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div style="background: #fef2f2; border: 1px solid #ef4444; color: #991b1b; padding: 16px 20px; border-radius: 12px; margin-bottom: 24px; font-weight: 500; display: flex; align-items: center; gap: 10px; font-family: 'Plus Jakarta Sans', sans-serif; font-size: 14px;">
            <i class="bi bi-exclamation-triangle-fill" style="color: #ef4444; font-size: 18px;"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- Stepper Status Timeline -->
    <c:choose>
        <c:when test="${order.status == 'CANCELLED'}">
            <div class="d-flex align-items-center gap-3 p-4 mb-4" style="background:#fef2f2; border: 1px solid #fecaca; border-radius: 16px;">
                <i class="bi bi-x-circle-fill text-danger" style="font-size: 32px;"></i>
                <div>
                    <h4 class="text-danger fw-bold mb-1" style="font-size: 15px; margin: 0;">Đơn hàng đã bị huỷ</h4>
                    <p class="text-muted small mb-0" style="margin: 0; font-size:13px;">Đơn hàng này không còn hiệu lực. Quý khách vui lòng chọn mua sản phẩm khác.</p>
                </div>
            </div>
        </c:when>
        <c:when test="${order.status == 'RETURNED'}">
            <div class="d-flex align-items-center gap-3 p-4 mb-4" style="background:#f1f5f9; border: 1px solid #cbd5e1; border-radius: 16px;">
                <i class="bi bi-arrow-counterclockwise text-secondary" style="font-size: 32px;"></i>
                <div>
                    <h4 class="text-secondary fw-bold mb-1" style="font-size: 15px; margin: 0;">Đơn hàng đã trả hàng thành công</h4>
                    <p class="text-muted small mb-0" style="margin: 0; font-size:13px;">Chúng tôi đã nhận lại hàng và hoàn tất các thủ tục liên quan.</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Timeline progress calculation -->
            <c:set var="progressWidth" value="0%" />
            <c:if test="${order.status == 'CONFIRMED'}"><c:set var="progressWidth" value="33.33%" /></c:if>
            <c:if test="${order.status == 'SHIPPING'}"><c:set var="progressWidth" value="66.66%" /></c:if>
            <c:if test="${order.status == 'COMPLETED'}"><c:set var="progressWidth" value="100%" /></c:if>

            <div class="stepper-container">
                <div class="stepper-line">
                    <div class="stepper-line-progress" style="width: ${progressWidth};"></div>
                </div>

                <!-- Step 1: Chờ xác nhận -->
                <div class="stepper-item ${order.status == 'PENDING' ? 'active' : 'completed'}">
                    <div class="stepper-circle">
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}">1</c:when>
                            <c:otherwise><i class="bi bi-check-lg"></i></c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stepper-text">Chờ xác nhận</div>
                </div>

                <!-- Step 2: Đã xác nhận -->
                <div class="stepper-item ${order.status == 'CONFIRMED' ? 'active' : (order.status == 'SHIPPING' || order.status == 'COMPLETED' ? 'completed' : '')}">
                    <div class="stepper-circle">
                        <c:choose>
                            <c:when test="${order.status == 'SHIPPING' || order.status == 'COMPLETED'}"><i class="bi bi-check-lg"></i></c:when>
                            <c:otherwise>2</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stepper-text">Đã xác nhận</div>
                </div>

                <!-- Step 3: Đang giao hàng -->
                <div class="stepper-item ${order.status == 'SHIPPING' ? 'active' : (order.status == 'COMPLETED' ? 'completed' : '')}">
                    <div class="stepper-circle">
                        <c:choose>
                            <c:when test="${order.status == 'COMPLETED'}"><i class="bi bi-check-lg"></i></c:when>
                            <c:otherwise><i class="bi bi-truck"></i></c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stepper-text">Đang giao hàng</div>
                </div>

                <!-- Step 4: Hoàn thành -->
                <div class="stepper-item ${order.status == 'COMPLETED' ? 'completed active' : ''}">
                    <div class="stepper-circle">
                        <i class="bi bi-bag-check"></i>
                    </div>
                    <div class="stepper-text">Hoàn thành</div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Layout Grid -->
    <div class="row g-4">
        <!-- Products Column -->
        <div class="col-lg-7 col-md-12">
            <div class="detail-card">
                <div class="detail-card-header">
                    <i class="bi bi-bag-fill text-primary" style="font-size:16px;"></i> Sản phẩm đã đặt
                </div>
                <div class="detail-card-body" style="padding: 0;">
                    <c:forEach var="item" items="${order.orderItems}">
                        <div class="product-item">
                            <c:choose>
                                <c:when test="${not empty item.productThumbnail}">
                                    <img src="${pageContext.request.contextPath}${item.productThumbnail}"
                                         style="width:64px;height:80px;object-fit:cover;border-radius:10px;border:1px solid #e2e8f0;flex-shrink:0;">
                                </c:when>
                                <c:otherwise>
                                    <div style="width:64px;height:80px;background:#f8fafc;border:1px solid #e2e8f0;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:24px;flex-shrink:0;">📦</div>
                                </c:otherwise>
                            </c:choose>
                            <div class="flex-grow-1">
                                <div style="font-weight:700; font-size:14px; color:#0f172a; margin-bottom:4px;">${item.productName}</div>
                                <div style="color:#64748b; font-size:13px;">
                                    <c:if test="${not empty item.size}">
                                        Kích cỡ: <span style="font-weight:600; color:var(--accent);">${item.size}</span> &nbsp;•&nbsp;
                                    </c:if>
                                    Đơn giá: <span style="font-weight:500; color:#0f172a;"><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/>₫</span>
                                    &nbsp;•&nbsp; Số lượng: <span style="font-weight:600; color:#0f172a;">${item.quantity}</span>
                                </div>
                            </div>
                            <div style="font-weight: 700; color: #0d9488; font-size:15px;">
                                <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>₫
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Summary & Shipping Info Column -->
        <div class="col-lg-5 col-md-12">
            <!-- Order Summary -->
            <div class="detail-card">
                <div class="detail-card-header">
                    <i class="bi bi-receipt-cutoff text-primary" style="font-size:16px;"></i> Tóm tắt đơn hàng
                </div>
                <div class="detail-card-body">
                    <div class="summary-item">
                        <span>Tạm tính</span>
                        <span style="color:#0f172a; font-weight:600;"><fmt:formatNumber value="${order.subtotal}" type="number" groupingUsed="true"/>₫</span>
                    </div>
                    <div class="summary-item">
                        <span>Phí vận chuyển</span>
                        <span class="${order.shippingFee == 0 ? 'text-success fw-bold' : ''}" style="font-weight:600;">
                            <c:choose>
                                <c:when test="${order.shippingFee == 0}">Miễn phí</c:when>
                                <c:otherwise><fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true"/>₫</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <c:if test="${order.discountAmount > 0}">
                        <div class="summary-item" style="color: #16a34a;">
                            <span>Giảm giá (${order.couponCode})</span>
                            <span style="font-weight:700;">-<fmt:formatNumber value="${order.discountAmount}" type="number" groupingUsed="true"/>₫</span>
                        </div>
                    </c:if>
                    <div class="summary-item total">
                        <span>Tổng cộng</span>
                        <span style="color:#0d9488;"><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫</span>
                    </div>
                    <div style="margin-top: 16px; padding: 12px 16px; background: #f8fafc; border-radius: 12px; font-size: 13px; color: #64748b; display: flex; align-items: center; gap: 8px;">
                        <i class="bi bi-credit-card-fill text-primary" style="font-size: 16px;"></i>
                        Phương thức thanh toán: <strong style="color: #0f172a;">${order.paymentMethod}</strong>
                    </div>
                </div>
            </div>

            <!-- Shipping Information -->
            <div class="detail-card">
                <div class="detail-card-header">
                    <i class="bi bi-geo-alt-fill text-primary" style="font-size:16px;"></i> Địa chỉ nhận hàng
                </div>
                <div class="detail-card-body">
                    <div style="display:flex; flex-direction:column; gap:12px;">
                        <div style="display:flex; align-items:center; gap:8px;">
                            <i class="bi bi-person-circle text-muted" style="font-size:16px;"></i>
                            <span style="font-weight:700; color:#0f172a;">${order.recipientName}</span>
                        </div>
                        <div style="display:flex; align-items:center; gap:8px;">
                            <i class="bi bi-telephone-fill text-muted" style="font-size:14px;"></i>
                            <span style="color:#0f172a; font-weight:500;">${order.recipientPhone}</span>
                        </div>
                        <div style="display:flex; gap:8px; align-items: flex-start;">
                            <i class="bi bi-geo-alt text-muted" style="margin-top:3px; font-size:15px;"></i>
                            <span style="color:#334155; line-height: 1.6; font-size:14px;">${order.shippingAddress}</span>
                        </div>
                        <c:if test="${not empty order.note}">
                            <div style="margin-top:8px; padding:10px 14px; background:#f0f9ff; border-left:4px solid #0ea5e9; border-radius:8px; font-size:13px; color:#0369a1;">
                                <i class="bi bi-chat-left-text-fill me-1"></i> <strong>Ghi chú:</strong> ${order.note}
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Action Button -->
            <c:if test="${order.status == 'PENDING'}">
                <form action="${pageContext.request.contextPath}/orders/${order.orderCode}/cancel" method="post" style="margin-top: 16px;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn-outline" 
                            style="width: 100%; justify-content: center; border-color: #ef4444; color: #ef4444; border-radius: 12px; padding: 12px; font-weight: 700; transition: all 0.2s ease; display: flex; align-items: center; gap: 8px; background:transparent; cursor:pointer;"
                            onmouseover="this.style.background='#ef4444'; this.style.color='#ffffff'; this.style.boxShadow='0 4px 12px rgba(239, 68, 68, 0.25)';"
                            onmouseout="this.style.background='transparent'; this.style.color='#ef4444'; this.style.boxShadow='none';"
                            onclick="return confirm('Bạn có chắc chắn muốn huỷ đơn hàng này không?')">
                        <i class="bi bi-x-circle"></i> Hủy đơn hàng
                    </button>
                </form>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>

