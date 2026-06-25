<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đơn hàng của tôi — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>



<div class="kumo-container" style="padding-top:60px;padding-bottom:80px;">
  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:40px;">
    <h1 style="font-family:'Playfair Display',serif;font-size:36px;">Đơn hàng của tôi</h1>
    <a href="${pageContext.request.contextPath}/shop" class="btn-primary">
      <i class="bi bi-bag"></i> Tiếp tục mua sắm
    </a>
  </div>

  <c:choose>
    <c:when test="${empty orders}">
      <div style="text-align:center;padding:80px 0;">
        <div style="font-size:70px;margin-bottom:24px;opacity:.3;">📦</div>
        <h2 style="font-family:'Playfair Display',serif;font-size:26px;margin-bottom:12px;">Chưa có đơn hàng nào</h2>
        <p style="color:var(--text-muted);margin-bottom:28px;">Hãy khám phá và đặt hàng ngay hôm nay!</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn-primary">Khám phá sản phẩm</a>
      </div>
    </c:when>
    <c:otherwise>
      <div style="display:flex;flex-direction:column;gap:16px;">
        <c:forEach var="order" items="${orders}">
          <div style="border:1px solid var(--border);border-radius:8px;overflow:hidden;">
            <!-- Order Header -->
            <div style="background:var(--light);padding:16px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;">
              <div style="display:flex;gap:32px;flex-wrap:wrap;">
                <div>
                  <div style="font-size:10px;color:var(--text-muted);letter-spacing:1px;text-transform:uppercase;margin-bottom:2px;">Mã đơn hàng</div>
                  <div style="font-weight:700;font-size:14px;">
                    <a href="${pageContext.request.contextPath}/orders/${order.orderCode}" style="color:#0d9488;text-decoration:none;transition:color 0.2s;" onmouseover="this.style.color='#0f766e'" onmouseout="this.style.color='#0d9488'">
                      ${order.orderCode}
                    </a>
                  </div>
                </div>
                <div>
                  <div style="font-size:10px;color:var(--text-muted);letter-spacing:1px;text-transform:uppercase;margin-bottom:2px;">Ngày đặt</div>
                  <div style="font-size:14px;">${order.createdAt.toString().replace('T',' ').substring(0,16)}</div>
                </div>
                <div>
                  <div style="font-size:10px;color:var(--text-muted);letter-spacing:1px;text-transform:uppercase;margin-bottom:2px;">Tổng tiền</div>
                  <div style="font-weight:700;font-size:15px;color:var(--accent);">
                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                  </div>
                </div>
              </div>

              <div style="display:flex;align-items:center;gap:12px;">
                <span style="padding:6px 14px;border-radius:20px;font-size:12px;font-weight:700;letter-spacing:.5px;
                  background:${order.status == 'COMPLETED' ? '#f0fdf4' : order.status == 'CANCELLED' ? '#fef2f2' : order.status == 'SHIPPING' ? '#f0fdfa' : '#fffbeb'};
                  color:${order.status == 'COMPLETED' ? '#16a34a' : order.status == 'CANCELLED' ? '#dc2626' : order.status == 'SHIPPING' ? '#0d9488' : '#d97706'};">
                  <c:choose>
                    <c:when test="${order.status == 'PENDING'}">⏳ Chờ xác nhận</c:when>
                    <c:when test="${order.status == 'CONFIRMED'}">✅ Đã xác nhận</c:when>
                    <c:when test="${order.status == 'SHIPPING'}">🚚 Đang giao</c:when>
                    <c:when test="${order.status == 'COMPLETED'}">✔ Hoàn thành</c:when>
                    <c:when test="${order.status == 'CANCELLED'}">✕ Đã huỷ</c:when>
                    <c:otherwise>${order.status}</c:otherwise>
                  </c:choose>
                </span>
                <a href="${pageContext.request.contextPath}/orders/${order.orderCode}" class="btn-outline" style="padding:6px 16px;font-size:11px;">
                  Chi tiết
                </a>
              </div>
            </div>

            <!-- Order Items preview -->
            <div style="padding:16px 24px;">
              <c:forEach var="item" items="${order.orderItems}" varStatus="itemStatus" begin="0" end="1">
                <a href="${pageContext.request.contextPath}/orders/${order.orderCode}" style="display:block;text-decoration:none;color:inherit;transition:opacity 0.2s;outline:none;" onmouseover="this.style.opacity='0.8'" onmouseout="this.style.opacity='1'">
                  <div style="display:flex;align-items:center;gap:12px;${!itemStatus.last ? 'margin-bottom:12px;' : ''}">
                    <div style="width:48px;height:60px;background:var(--light);border-radius:4px;display:flex;align-items:center;justify-content:center;font-size:22px;flex-shrink:0;">🛍️</div>
                    <div style="flex:1;">
                      <div style="font-size:14px;font-weight:500;color:#0f172a;">${item.productName}</div>
                      <div style="font-size:12px;color:var(--text-muted);">Số lượng: ${item.quantity} × <fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/>₫</div>
                    </div>
                  </div>
                </a>
              </c:forEach>
              <c:if test="${order.orderItems.size() > 2}">
                <div style="font-size:12px;color:var(--text-muted);margin-top:8px;">
                  <a href="${pageContext.request.contextPath}/orders/${order.orderCode}" style="color:#0d9488;text-decoration:none;font-weight:500;">
                    +${order.orderItems.size() - 2} sản phẩm khác...
                  </a>
                </div>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
