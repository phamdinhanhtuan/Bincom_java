<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Thanh toán — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<div class="breadcrumb-wrap">
  <div class="kumo-container">
    <nav class="breadcrumb">
      <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
      <span class="breadcrumb-sep">/</span>
      <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
      <span class="breadcrumb-sep">/</span>
      <span>Thanh toán</span>
    </nav>
  </div>
</div>

<div class="kumo-container">
  <div class="checkout-grid">

    <!-- LEFT: FORM -->
    <div>
      <form id="checkoutForm" action="${pageContext.request.contextPath}/checkout/place-order" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="couponCode" id="couponCodeField">

        <!-- Shipping Info -->
        <div style="margin-bottom:40px;">
          <div class="form-section-title">Thông tin giao hàng</div>
          <div class="form-row">
            <div class="form-group">
              <label>Họ và tên người nhận *</label>
              <input type="text" name="recipientName" required
                     value="${user.fullName}" placeholder="Nguyễn Văn A">
            </div>
            <div class="form-group">
              <label>Số điện thoại *</label>
              <input type="tel" name="recipientPhone" required
                     value="${user.phoneNumber}" placeholder="0901234567">
            </div>
          </div>
          <div class="form-group">
            <label>Địa chỉ giao hàng *</label>
            <textarea name="shippingAddress" rows="3" required
                      placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố">${user.address}</textarea>
          </div>
          <div class="form-group">
            <label>Ghi chú cho đơn hàng</label>
            <textarea name="note" rows="2" placeholder="VD: Giao giờ hành chính, gọi trước khi đến..."></textarea>
          </div>
        </div>

        <!-- Payment Method -->
        <div style="margin-bottom:40px;">
          <div class="form-section-title">Phương thức thanh toán</div>

          <label class="payment-option selected" id="pay-cod">
            <input type="radio" name="paymentMethod" value="COD" checked onchange="selectPayment(this, 'pay-cod')">
            <div style="font-size:28px;color:#16a34a;"><i class="bi bi-cash-stack"></i></div>
            <div>
              <div style="font-weight:600;font-size:14px;">Thanh toán khi nhận hàng (COD)</div>
              <div style="font-size:12px;color:var(--text-muted);">Thanh toán bằng tiền mặt khi nhận hàng</div>
            </div>
          </label>

          <label class="payment-option" id="pay-bank">
            <input type="radio" name="paymentMethod" value="BANK_TRANSFER" onchange="selectPayment(this, 'pay-bank')">
            <div style="font-size:28px;color:#2563eb;"><i class="bi bi-bank2"></i></div>
            <div>
              <div style="font-weight:600;font-size:14px;">Chuyển khoản ngân hàng</div>
              <div style="font-size:12px;color:var(--text-muted);">Chuyển khoản trước, xác nhận trong 24h</div>
            </div>
          </label>

          <label class="payment-option" id="pay-vnpay">
            <input type="radio" name="paymentMethod" value="VNPAY" onchange="selectPayment(this, 'pay-vnpay')">
            <div style="font-size:28px;color:#dc2626;"><i class="bi bi-credit-card-2-front-fill"></i></div>
            <div>
              <div style="font-weight:600;font-size:14px;">VNPay</div>
              <div style="font-size:12px;color:var(--text-muted);">Thanh toán qua cổng VNPay an toàn</div>
            </div>
          </label>

          <label class="payment-option" id="pay-momo">
            <input type="radio" name="paymentMethod" value="MOMO" onchange="selectPayment(this, 'pay-momo')">
            <div style="font-size:28px;color:#be185d;"><i class="bi bi-phone-fill"></i></div>
            <div>
              <div style="font-weight:600;font-size:14px;">MoMo</div>
              <div style="font-size:12px;color:var(--text-muted);">Ví điện tử MoMo</div>
            </div>
          </label>
        </div>

        <!-- Coupon -->
        <div style="margin-bottom:32px;">
          <div class="form-section-title">Mã giảm giá</div>
          <div style="display:flex;gap:12px;">
            <input type="text" id="couponInput" placeholder="Nhập mã: SALE20, GIAM50K..."
                   style="flex:1;padding:12px 16px;border:1px solid var(--border);border-radius:4px;font-family:inherit;font-size:14px;outline:none;">
            <button type="button" class="btn-outline" onclick="applyCoupon()">Áp dụng</button>
          </div>
          <div id="couponMsg" style="font-size:13px;margin-top:8px;"></div>
        </div>

        <button type="submit" class="btn-primary"
                style="width:100%;justify-content:center;padding:18px;font-size:16px;font-weight:700;background:linear-gradient(135deg,#6c63ff,#4f46e5);border:none;border-radius:14px;color:#fff;cursor:pointer;display:flex;align-items:center;gap:10px;transition:opacity .2s;"
                onmouseover="this.style.opacity='.88'" onmouseout="this.style.opacity='1'">
          <i class="bi bi-bag-check-fill"></i> Đặt hàng ngay
        </button>
      </form>
    </div>

    <!-- RIGHT: ORDER SUMMARY -->
    <div>
      <div class="cart-summary-box" style="position:sticky;top:90px;">
        <div class="cart-summary-title">Đơn hàng của bạn</div>

        <c:forEach var="item" items="${cartItems}">
          <div style="display:flex;align-items:center;gap:12px;padding:12px 0;border-bottom:1px solid var(--border);">
            <div style="width:64px;height:64px;border-radius:10px;overflow:hidden;flex-shrink:0;background:linear-gradient(135deg,#f5f3ff,#ede9fe);display:flex;align-items:center;justify-content:center;">
              <c:choose>
                <c:when test="${not empty item.thumbnailUrl}">
                  <img src="${pageContext.request.contextPath}${item.thumbnailUrl}"
                       style="width:100%;height:100%;object-fit:cover;"
                       alt="${item.productName}">
                </c:when>
                <c:otherwise>
                  <i class="bi bi-bag-fill" style="font-size:22px;color:#a5b4fc;"></i>
                </c:otherwise>
              </c:choose>
            </div>
            <div style="flex:1;min-width:0;">
              <div style="font-size:13px;font-weight:600;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${item.productName}</div>
              <div style="font-size:12px;color:var(--text-muted);">Số lượng: × ${item.quantity}</div>
            </div>
            <div style="font-size:13px;font-weight:700;flex-shrink:0;color:#6c63ff;">
              <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>₫
            </div>
          </div>
        </c:forEach>


        <div class="summary-row" style="margin-top:8px;">
          <span style="color:var(--text-muted);">Tạm tính</span>
          <span><fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/>₫</span>
        </div>
        <div class="summary-row">
          <span style="color:var(--text-muted);">Phí vận chuyển</span>
          <c:choose>
            <c:when test="${subtotal >= 500000}">
              <span style="color:var(--success);font-weight:600;">MIỄN PHÍ</span>
            </c:when>
            <c:otherwise><span>30,000₫</span></c:otherwise>
          </c:choose>
        </div>
        <div class="summary-row" id="discountRow" style="display:none;color:var(--success);">
          <span>Giảm giá</span>
          <span id="discountDisplay">−0₫</span>
        </div>
        <div class="summary-total">
          <span>Tổng cộng</span>
          <span id="grandTotal" style="color:var(--accent);">
            <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>₫
          </span>
        </div>

        <div style="margin-top:16px;padding:12px;background:rgba(200,169,110,.1);border-radius:4px;font-size:12px;color:var(--text-muted);display:flex;align-items:center;gap:8px;">
          <i class="bi bi-shield-check-fill" style="color:var(--accent);"></i>
          Thông tin thanh toán được mã hoá và bảo mật an toàn.
        </div>
      </div>
    </div>
  </div>
</div>

<script>
function selectPayment(radio, id) {
  document.querySelectorAll('.payment-option').forEach(function(el) { el.classList.remove('selected'); });
  document.getElementById(id).classList.add('selected');
}

function applyCoupon() {
  var code = document.getElementById('couponInput').value.trim().toUpperCase();
  var msg = document.getElementById('couponMsg');
  if (!code) return;
  var validCoupons = {'SALE20':true,'GIAM10':true,'GIAM50K':true,'NEWUSER':true};
  if (validCoupons[code]) {
    document.getElementById('couponCodeField').value = code;
    document.getElementById('discountRow').style.display = 'flex';
    document.getElementById('discountDisplay').textContent = '−' + (code==='GIAM50K'?'50,000':'áp dụng') + '₫';
    msg.textContent = '✓ Mã giảm giá hợp lệ! Đã áp dụng.';
    msg.style.color = 'var(--success)';
  } else {
    msg.textContent = '✗ Mã giảm giá không hợp lệ.';
    msg.style.color = 'var(--danger)';
  }
}
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
