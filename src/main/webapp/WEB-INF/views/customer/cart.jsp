<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Giỏ hàng — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<style>
  .cps-catnav {
    display: none !important;
  }
</style>

<div class="kumo-container" style="padding-top:60px;padding-bottom:80px;">
  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:40px;">
    <h1 style="font-family:'Playfair Display',serif;font-size:36px;">Giỏ hàng của bạn</h1>
    <a href="${pageContext.request.contextPath}/shop" style="font-size:13px;color:var(--text-muted);display:flex;align-items:center;gap:6px;">
      <i class="bi bi-arrow-left"></i> Tiếp tục mua sắm
    </a>
  </div>

  <c:choose>
    <c:when test="${empty cartItems}">
      <div style="text-align:center;padding:100px 0;">
        <div style="font-size:80px;margin-bottom:24px;color:#c4b5fc;"><i class="bi bi-bag-x-fill"></i></div>
        <h2 style="font-family:'Playfair Display',serif;font-size:28px;margin-bottom:12px;">Giỏ hàng trống</h2>
        <p style="color:var(--text-muted);margin-bottom:32px;">Hãy khám phá cửa hàng và thêm sản phẩm yêu thích vào giỏ!</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn-primary">
          <i class="bi bi-bag"></i> Khám phá sản phẩm
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="cart-grid">
        <!-- CART ITEMS -->
        <div>
          <table class="cart-table">
            <thead>
              <tr>
                <th colspan="2">Sản phẩm</th>
                <th>Đơn giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="item" items="${cartItems}">
                <c:set var="itemKey" value="${item.productId}${not empty item.size ? '_' : ''}${item.size}"/>
                <tr>
                  <td style="width:90px;">
                    <div style="width:80px;height:100px;background:linear-gradient(135deg,#f5f3ff,#ede9fe);border-radius:10px;overflow:hidden;display:flex;align-items:center;justify-content:center;border:1px solid var(--border);">
                      <c:choose>
                        <c:when test="${not empty item.thumbnailUrl}">
                           <img src="${pageContext.request.contextPath}${item.thumbnailUrl}"
                               style="width:100%;height:100%;object-fit:cover;"
                               alt="${item.productName}">
                        </c:when>
                        <c:otherwise>
                          <i class="bi bi-bag-fill" style="font-size:28px;color:#a5b4fc;"></i>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </td>
                  <td>
                    <div style="font-weight:600;font-size:15px;margin-bottom:4px;">${item.productName}</div>
                    <c:if test="${not empty item.size}">
                      <div style="font-size:13px;color:var(--accent);font-weight:700;margin-bottom:2px;">Size: ${item.size}</div>
                    </c:if>
                    <div style="font-size:12px;color:var(--text-muted);">Mã: P${item.productId}</div>
                  </td>
                  <td>
                    <span style="font-size:15px;font-weight:600;">
                      <fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/>₫
                    </span>
                  </td>
                  <td>
                    <form id="update-form-${itemKey}" action="${pageContext.request.contextPath}/cart/update" method="post">
                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                      <input type="hidden" name="productId" value="${item.productId}">
                      <input type="hidden" name="size" value="${item.size}">
                      <div class="qty-box">
                        <button type="button" onclick="changeQty('${itemKey}', -1)">−</button>
                        <input type="number" id="qty-${itemKey}" name="quantity" value="${item.quantity}" min="1" max="99">
                        <button type="button" onclick="changeQty('${itemKey}', 1)">+</button>
                      </div>
                    </form>
                  </td>
                  <td>
                    <span style="font-size:15px;font-weight:700;color:var(--accent);">
                      <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/>₫
                    </span>
                  </td>
                  <td>
                    <form action="${pageContext.request.contextPath}/cart/remove" method="post"
                          onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?');">
                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                      <input type="hidden" name="productId" value="${item.productId}">
                      <input type="hidden" name="size" value="${item.size}">
                      <button type="submit" style="background:none;border:none;cursor:pointer;color:var(--text-muted);font-size:18px;transition:color .2s;" onmouseover="this.style.color='var(--danger)'" onmouseout="this.style.color='var(--text-muted)'">
                        <i class="bi bi-trash3"></i>
                      </button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <!-- Coupon -->
          <div class="coupon-box">
            <input type="text" id="couponInput" placeholder="Nhập mã giảm giá (SALE20, GIAM50K...)"
                   style="flex:1;padding:12px 16px;border:1px solid var(--border);border-radius:4px;font-family:inherit;font-size:14px;outline:none;">
            <button class="btn-outline" onclick="applyCoupon()" style="white-space:nowrap;">Áp dụng</button>
          </div>
          <div id="couponMsg" style="font-size:13px;margin-top:8px;display:none;"></div>
        </div>

        <!-- ORDER SUMMARY -->
        <div class="cart-summary-box" style="position:sticky;top:90px;">
          <div class="cart-summary-title">Tóm tắt đơn hàng</div>

          <div class="summary-row">
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
            <span id="discountAmt">−0₫</span>
          </div>

          <div class="summary-total">
            <span>Tổng cộng</span>
            <span id="totalDisplay" style="color:var(--accent);">
              <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>₫
            </span>
          </div>

          <a href="${pageContext.request.contextPath}/checkout" class="btn-primary" style="display:flex;justify-content:center;padding:16px;margin-top:8px;">
            Tiến hành thanh toán <i class="bi bi-arrow-right"></i>
          </a>
          <a href="${pageContext.request.contextPath}/shop" class="btn-outline" style="display:flex;justify-content:center;padding:14px;margin-top:12px;">
            Tiếp tục mua sắm
          </a>

          <div style="margin-top:20px;display:flex;justify-content:center;gap:16px;font-size:24px;color:var(--text-muted);">
            <i class="bi bi-credit-card-2-front" title="Thẻ tín dụng"></i>
            <i class="bi bi-bank" title="Chuyển khoản ngân hàng"></i>
            <i class="bi bi-phone" title="Ví điện tử"></i>
            <i class="bi bi-shield-check" style="color:var(--success);" title="Bảo mật SSL"></i>
          </div>
          <div style="text-align:center;font-size:11px;color:var(--text-muted);margin-top:8px;letter-spacing:.5px;">
            THANH TOÁN AN TOÀN & BẢO MẬT
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<script>
function changeQty(itemKey, delta) {
  var input = document.getElementById('qty-' + itemKey);
  var val = parseInt(input.value) + delta;
  if (val < 1) val = 1;
  input.value = val;
  document.getElementById('update-form-' + itemKey).submit();
}

function applyCoupon() {
  var code = document.getElementById('couponInput').value.trim().toUpperCase();
  var msg = document.getElementById('couponMsg');
  if (!code) { return; }
  var discounts = {'SALE20': 20, 'GIAM10': 10, 'NEWUSER': 5};
  if (discounts[code]) {
    var pct = discounts[code];
    msg.textContent = '✓ Áp dụng thành công! Giảm ' + pct + '%';
    msg.style.color = 'var(--success)';
    document.getElementById('discountRow').style.display = 'flex';
  } else if (code === 'GIAM50K') {
    msg.textContent = '✓ Áp dụng thành công! Giảm 50,000₫';
    msg.style.color = 'var(--success)';
    document.getElementById('discountRow').style.display = 'flex';
    document.getElementById('discountAmt').textContent = '−50,000₫';
  } else {
    msg.textContent = '✗ Mã giảm giá không hợp lệ hoặc đã hết hạn.';
    msg.style.color = 'var(--danger)';
  }
  msg.style.display = 'block';
}
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
