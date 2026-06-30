<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ============================================================
     MOBILE BOTTOM NAV BAR — CellphoneS style
     ============================================================ -->
<nav class="cps-bottomnav" aria-label="Điều hướng chính di động">
  <a href="${pageContext.request.contextPath}/home" class="cps-bottomnav-item" title="Trang chủ Bincom">
    <i class="bi bi-house-fill"></i>
    <span>Trang chủ</span>
  </a>
  <a href="${pageContext.request.contextPath}/shop" class="cps-bottomnav-item" title="Cửa hàng Bincom">
    <i class="bi bi-shop"></i>
    <span>Cửa hàng</span>
  </a>
  <a href="${pageContext.request.contextPath}/cart" class="cps-bottomnav-item cps-bottomnav-cart" title="Giỏ hàng" aria-label="Giỏ hàng">
    <span class="cps-bottomnav-cart-wrap">
      <i class="bi bi-cart3"></i>
      <span class="cps-bottomnav-badge" id="bottomCartBadge" aria-live="polite">0</span>
    </span>
    <span>Giỏ hàng</span>
  </a>
  <a href="${pageContext.request.contextPath}/orders" class="cps-bottomnav-item" title="Đơn hàng của tôi">
    <i class="bi bi-bag-check"></i>
    <span>Đơn hàng</span>
  </a>
  <a href="${pageContext.request.contextPath}/account" class="cps-bottomnav-item" title="Tài khoản của tôi">
    <i class="bi bi-person-circle"></i>
    <span>Tài khoản</span>
  </a>
</nav>

<!-- ============================================================
     MAIN FOOTER — CellphoneS style
     ============================================================ -->
<footer class="cps-footer" itemscope itemtype="https://schema.org/WPFooter">

  <!-- ===== USP STRIP ===== -->
  <div class="cps-footer-usps">
    <div class="cps-footer-usps-inner">
      <div class="cps-footer-usp">
        <i class="bi bi-truck-front-fill"></i>
        <div>
          <strong>Miễn phí vận chuyển</strong>
          <span>Đơn từ 500.000đ</span>
        </div>
      </div>
      <div class="cps-footer-usp">
        <i class="bi bi-shield-fill-check"></i>
        <div>
          <strong>Bảo hành chính hãng</strong>
          <span>12 – 24 tháng</span>
        </div>
      </div>
      <div class="cps-footer-usp">
        <i class="bi bi-arrow-repeat"></i>
        <div>
          <strong>Đổi trả 30 ngày</strong>
          <span>Không cần lý do</span>
        </div>
      </div>
      <div class="cps-footer-usp">
        <i class="bi bi-headset"></i>
        <div>
          <strong>Hỗ trợ 24/7</strong>
          <span>Hotline 1800 1234</span>
        </div>
      </div>
    </div>
  </div>

  <!-- ===== MAIN FOOTER CONTENT ===== -->
  <div class="cps-footer-main">
    <div class="cps-footer-grid">

      <!-- Col 1: Brand + Contact -->
      <div class="cps-footer-col cps-footer-brand">
        <a href="${pageContext.request.contextPath}/home" title="Trang chủ Bincom">
          <img src="${pageContext.request.contextPath}/resources/images/logo.png"
               alt="Bincom — Mua điện thoại laptop chính hãng"
               class="cps-footer-logo" width="130" height="36" loading="lazy">
        </a>
        <p class="cps-footer-desc">
          Bincom là hệ thống bán lẻ công nghệ, thời trang &amp; gia dụng chính hãng hàng đầu Việt Nam.
          Cam kết giá tốt, chất lượng đảm bảo, giao hàng toàn quốc.
        </p>
        <!-- Structured contact -->
        <div class="cps-footer-contact" itemscope itemtype="https://schema.org/LocalBusiness">
          <meta itemprop="name" content="Bincom">
          <a href="tel:18001234" class="cps-footer-hotline" itemprop="telephone" title="Hotline Bincom miễn phí">
            <i class="bi bi-telephone-fill"></i>
            <div>
              <span>Tổng đài miễn phí</span>
              <strong itemprop="telephone">1800 1234</strong>
            </div>
          </a>
          <a href="mailto:support@bincom.vn" class="cps-footer-email" itemprop="email" title="Email hỗ trợ Bincom">
            <i class="bi bi-envelope-fill"></i>
            <span itemprop="email">support@bincom.vn</span>
          </a>
          <div class="cps-footer-addr" itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
            <i class="bi bi-geo-alt-fill"></i>
            <span itemprop="streetAddress">123 Nguyễn Huệ, Quận 1</span>,&nbsp;
            <span itemprop="addressLocality">Hồ Chí Minh</span>
          </div>
        </div>
        <!-- Social Links -->
        <div class="cps-footer-socials">
          <a href="https://facebook.com/bincom"  class="cps-social-btn cps-social-fb"  aria-label="Facebook Bincom"  title="Facebook Bincom"  rel="noopener" target="_blank"><i class="bi bi-facebook"></i></a>
          <a href="https://instagram.com/bincom" class="cps-social-btn cps-social-ig"  aria-label="Instagram Bincom" title="Instagram Bincom" rel="noopener" target="_blank"><i class="bi bi-instagram"></i></a>
          <a href="https://youtube.com/bincom"   class="cps-social-btn cps-social-yt"  aria-label="YouTube Bincom"   title="YouTube Bincom"   rel="noopener" target="_blank"><i class="bi bi-youtube"></i></a>
          <a href="https://tiktok.com/@bincom"   class="cps-social-btn cps-social-tt"  aria-label="TikTok Bincom"   title="TikTok Bincom"   rel="noopener" target="_blank"><i class="bi bi-tiktok"></i></a>
          <a href="https://zalo.me/bincom"       class="cps-social-btn cps-social-zl"  aria-label="Zalo Bincom"     title="Zalo Bincom"     rel="noopener" target="_blank"><i class="bi bi-chat-dots-fill"></i></a>
        </div>
      </div>

      <!-- Col 2: Danh mục mua sắm -->
      <div class="cps-footer-col">
        <h3 class="cps-footer-col-title">Danh mục mua sắm</h3>
        <ul class="cps-footer-links">
          <li><a href="${pageContext.request.contextPath}/shop"               title="Tất cả sản phẩm tại Bincom">Tất cả sản phẩm</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=1"  title="Mua điện thoại smartphone chính hãng">Điện thoại &amp; Smartphone</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=1"  title="Mua laptop chính hãng giá tốt">Laptop &amp; Máy tính</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=2"  title="Thời trang phụ kiện hàng hiệu">Thời trang &amp; Phụ kiện</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=3"  title="Đồ dùng gia đình thông minh">Đồ dùng gia đình</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=4"  title="Sách và văn phòng phẩm">Sách &amp; Văn phòng phẩm</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=5"  title="Dụng cụ thể thao du lịch">Thể thao &amp; Du lịch</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=6"  title="Mỹ phẩm chăm sóc da làm đẹp">Mỹ phẩm &amp; Làm đẹp</a></li>
        </ul>
      </div>

      <!-- Col 3: Dịch vụ hỗ trợ -->
      <div class="cps-footer-col">
        <h3 class="cps-footer-col-title">Dịch vụ &amp; Hỗ trợ</h3>
        <ul class="cps-footer-links">
          <li><a href="${pageContext.request.contextPath}/about"   title="Giới thiệu về Bincom">Về chúng tôi</a></li>
          <li><a href="${pageContext.request.contextPath}/contact" title="Liên hệ hỗ trợ khách hàng">Liên hệ hỗ trợ</a></li>
          <li><a href="#" title="Hướng dẫn đặt hàng online tại Bincom">Hướng dẫn đặt hàng</a></li>
          <li><a href="#" title="Chính sách giao hàng Bincom">Chính sách giao hàng</a></li>
          <li><a href="#" title="Chính sách đổi trả 30 ngày">Đổi trả &amp; Hoàn tiền</a></li>
          <li><a href="#" title="Chính sách bảo hành sản phẩm">Chính sách bảo hành</a></li>
          <li><a href="#" title="Chính sách bảo mật thông tin">Bảo mật thông tin</a></li>
          <li><a href="${pageContext.request.contextPath}/orders" title="Tra cứu đơn hàng Bincom">Tra cứu đơn hàng</a></li>
        </ul>
      </div>

      <!-- Col 4: Thanh toán & App -->
      <div class="cps-footer-col">
        <h3 class="cps-footer-col-title">Thanh toán an toàn</h3>
        <div class="cps-footer-payment-grid">
          <span class="cps-payment-badge" title="Thanh toán Visa"><i class="bi bi-credit-card-2-front-fill"></i> Visa</span>
          <span class="cps-payment-badge" title="Thanh toán Mastercard"><i class="bi bi-credit-card-fill"></i> MasterCard</span>
          <span class="cps-payment-badge" title="Thanh toán VNPAY QR"><i class="bi bi-qr-code-scan"></i> VNPAY</span>
          <span class="cps-payment-badge" title="Thanh toán Internet Banking"><i class="bi bi-bank2"></i> Banking</span>
          <span class="cps-payment-badge" title="Ví điện tử MoMo"><i class="bi bi-wallet2"></i> MoMo</span>
          <span class="cps-payment-badge" title="Thanh toán khi nhận hàng"><i class="bi bi-cash-coin"></i> COD</span>
        </div>

        <h3 class="cps-footer-col-title" style="margin-top:24px;">Chứng nhận</h3>
        <div class="cps-footer-certs">
          <div class="cps-cert-badge">
            <i class="bi bi-shield-fill-check"></i>
            <div>
              <strong>Đã đăng ký</strong>
              <span>Bộ Công Thương</span>
            </div>
          </div>
          <div class="cps-cert-badge">
            <i class="bi bi-lock-fill"></i>
            <div>
              <strong>SSL Secured</strong>
              <span>256-bit TLS</span>
            </div>
          </div>
        </div>

        <h3 class="cps-footer-col-title" style="margin-top:24px;">Tải ứng dụng</h3>
        <div class="cps-footer-apps">
          <a href="#" class="cps-app-btn" title="Tải ứng dụng Bincom trên App Store" aria-label="App Store">
            <i class="bi bi-apple"></i>
            <div><small>Tải trên</small><strong>App Store</strong></div>
          </a>
          <a href="#" class="cps-app-btn" title="Tải ứng dụng Bincom trên Google Play" aria-label="Google Play">
            <i class="bi bi-google-play"></i>
            <div><small>Tải trên</small><strong>Google Play</strong></div>
          </a>
        </div>
      </div>

    </div>
  </div>

  <!-- ===== FOOTER BOTTOM ===== -->
  <div class="cps-footer-bottom">
    <div class="cps-footer-bottom-inner">
      <span>© 2026 <a href="${pageContext.request.contextPath}/home" title="Bincom E-Commerce">Bincom E-Commerce</a>. Tất cả quyền được bảo lưu.</span>
      <span>Phát triển bởi Nhóm 2 — Java Spring MVC</span>
      <div class="cps-footer-bottom-links">
        <a href="#" title="Điều khoản sử dụng Bincom">Điều khoản</a>
        <span>|</span>
        <a href="#" title="Chính sách bảo mật Bincom">Bảo mật</a>
        <span>|</span>
        <a href="#" title="Sitemap Bincom">Sitemap</a>
      </div>
    </div>
  </div>
</footer>

<!-- Sync bottom nav cart badge with header badge -->
<script>
(function(){
  var bottomBadge = document.getElementById('bottomCartBadge');
  var headerBadge = document.getElementById('cartBadge');
  if (bottomBadge && headerBadge) {
    var observer = new MutationObserver(function(){
      bottomBadge.textContent = headerBadge.textContent;
      bottomBadge.style.display = headerBadge.style.display;
    });
    observer.observe(headerBadge, { childList: true, characterData: true, subtree: true });
  }
})();

function updateWishlistBadge() {
  var wishlist = JSON.parse(localStorage.getItem('bincom_wishlist') || '[]');
  var badge = document.getElementById('wishlistBadge');
  if (badge) {
    badge.textContent = wishlist.length;
    badge.style.display = wishlist.length > 0 ? 'inline-block' : 'none';
  }
}

function toggleWishlist(e, productId, btn) {
  if (e) {
    if (typeof e.preventDefault === 'function') e.preventDefault();
    if (typeof e.stopPropagation === 'function') e.stopPropagation();
  }
  var wishlist = JSON.parse(localStorage.getItem('bincom_wishlist') || '[]');
  var idx = wishlist.indexOf(productId);
  if (idx > -1) {
    wishlist.splice(idx, 1);
    btn.classList.remove('active');
    btn.innerHTML = 'Yêu thích <i class="bi bi-heart"></i>';
    showToast('Đã xóa khỏi danh sách yêu thích', 'warning');
  } else {
    wishlist.push(productId);
    btn.classList.add('active');
    btn.innerHTML = 'Đã thích <i class="bi bi-heart-fill text-danger"></i>';
    showToast('Đã thêm vào danh sách yêu thích', 'success');
  }
  localStorage.setItem('bincom_wishlist', JSON.stringify(wishlist));
  updateWishlistBadge();
}

function openWishlistModal(e) {
  if (e) {
    e.preventDefault();
    e.stopPropagation();
  }
  var modal = document.getElementById('wishlistModal');
  if (modal) {
    modal.style.display = 'block';
    loadWishlistItems();
  }
}

function closeWishlistModal() {
  var modal = document.getElementById('wishlistModal');
  if (modal) {
    modal.style.display = 'none';
  }
}

window.addEventListener('click', function(event) {
  var modal = document.getElementById('wishlistModal');
  if (event.target == modal) {
    modal.style.display = 'none';
  }
});

function loadWishlistItems() {
  var wishlist = JSON.parse(localStorage.getItem('bincom_wishlist') || '[]');
  var container = document.getElementById('wishlistModalBody');
  if (!container) return;
  
  if (wishlist.length === 0) {
    container.innerHTML = '<div style="text-align: center; padding: 40px 20px; color: #64748b;">' +
                          '  <i class="bi bi-heart-break" style="font-size: 48px; color: #cbd5e1; display: block; margin-bottom: 12px;"></i>' +
                          '  Danh sách yêu thích của bạn đang trống.' +
                          '</div>';
    return;
  }
  
  container.innerHTML = '<div style="text-align: center; padding: 30px; color: #64748b;"><div class="spinner-border text-primary spinner-border-sm me-2" role="status"></div> Đang tải...</div>';
  
  var url = '${pageContext.request.contextPath}/shop/api/wishlist?ids=' + wishlist.join(',');
  fetch(url)
    .then(response => response.json())
    .then(data => {
      if (data.length === 0) {
        container.innerHTML = '<div style="text-align: center; padding: 40px 20px; color: #64748b;">' +
                              '  Danh sách yêu thích của bạn đang trống.' +
                              '</div>';
        return;
      }
      
      var html = '<div style="display: flex; flex-direction: column; gap: 12px;">';
      data.forEach(function(p) {
        var formattedPrice = new Intl.NumberFormat('vi-VN').format(p.effectivePrice) + '₫';
        var oldPriceHtml = '';
        if (p.onSale) {
          oldPriceHtml = '<span style="text-decoration: line-through; color: #94a3b8; font-size: 12px; margin-left: 6px;">' + new Intl.NumberFormat('vi-VN').format(p.price) + '₫</span>';
        }
        var thumb = p.thumbnailUrl ? '${pageContext.request.contextPath}' + p.thumbnailUrl : 'https://placehold.co/80x80?text=Bincom';
        
        html += '<div style="display: flex; gap: 16px; align-items: center; padding: 12px; border: 1px solid #f1f5f9; border-radius: 8px; transition: background 0.2s;">' +
                '  <img src="' + thumb + '" alt="' + p.name + '" style="width: 60px; height: 60px; object-fit: cover; border-radius: 6px; border: 1px solid #f1f5f9;">' +
                '  <div style="flex-grow: 1; min-width: 0;">' +
                '    <h4 style="margin: 0 0 4px; font-size: 14px; font-weight: 600; color: #0f172a; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' +
                '      <a href="${pageContext.request.contextPath}/shop/product/' + p.id + '" style="color: inherit; text-decoration: none;" onclick="closeWishlistModal()">' + p.name + '</a>' +
                '    </h4>' +
                '    <div style="display: flex; align-items: baseline;">' +
                '      <span style="color: #d70018; font-weight: 700; font-size: 14px;">' + formattedPrice + '</span>' +
                '      ' + oldPriceHtml +
                '    </div>' +
                '  </div>' +
                '  <div style="display: flex; gap: 8px; flex-shrink: 0;">' +
                '    <button onclick="addToCart(' + p.id + ', this); event.stopPropagation();" class="btn btn-primary btn-sm" style="padding: 6px 12px; font-size: 12px; border-radius: 6px; background-color: #0d9488; border-color: #0d9488;">' +
                '      <i class="bi bi-cart-plus"></i>' +
                '    </button>' +
                '    <button onclick="removeFromWishlist(' + p.id + ', this); event.stopPropagation();" class="btn btn-outline-danger btn-sm" style="padding: 6px 10px; font-size: 12px; border-radius: 6px;">' +
                '      <i class="bi bi-trash"></i>' +
                '    </button>' +
                '  </div>' +
                '</div>';
      });
      html += '</div>';
      container.innerHTML = html;
    })
    .catch(err => {
      container.innerHTML = '<div style="text-align: center; padding: 30px; color: #ef4444;">Không thể tải danh sách sản phẩm yêu thích. Vui lòng thử lại sau.</div>';
    });
}

function removeFromWishlist(productId, btnElement) {
  var wishlist = JSON.parse(localStorage.getItem('bincom_wishlist') || '[]');
  var idx = wishlist.indexOf(productId);
  if (idx > -1) {
    wishlist.splice(idx, 1);
    localStorage.setItem('bincom_wishlist', JSON.stringify(wishlist));
    updateWishlistBadge();
    
    document.querySelectorAll('.cps-product-card').forEach(function(card) {
      if (card.getAttribute('data-id') == productId) {
        var cardBtn = card.querySelector('.cps-product-wishlist-btn');
        if (cardBtn) {
          cardBtn.classList.remove('active');
          cardBtn.innerHTML = 'Yêu thích <i class="bi bi-heart"></i>';
        }
      }
    });
    
    loadWishlistItems();
    showToast('Đã xóa khỏi danh sách yêu thích', 'warning');
  }
}

document.addEventListener('DOMContentLoaded', function() {
  updateWishlistBadge();
  var wishlist = JSON.parse(localStorage.getItem('bincom_wishlist') || '[]');
  document.querySelectorAll('.cps-product-card').forEach(function(card) {
    var idAttr = card.getAttribute('data-id');
    if (!idAttr) return;
    var productId = parseInt(idAttr);
    if (wishlist.indexOf(productId) > -1) {
      var btn = card.querySelector('.cps-product-wishlist-btn');
      if (btn) {
        btn.classList.add('active');
        btn.innerHTML = 'Đã thích <i class="bi bi-heart-fill text-danger"></i>';
      }
    }
  });
});
</script>

<!-- FLOATING WIDGETS (Hotline & Scroll to Top) -->
<div class="floating-widgets-wrap">
  <!-- Scroll to Top Button -->
  <button id="scrollToTopBtn" class="floating-btn scroll-to-top-btn" title="Lên đầu trang" aria-label="Lên đầu trang">
    <i class="bi bi-arrow-up-short"></i>
  </button>
  
  <!-- Floating Hotline Button -->
  <a href="tel:18001234" class="floating-btn hotline-floating-btn" title="Gọi hotline" aria-label="Gọi hotline">
    <span class="hotline-pulse"></span>
    <i class="bi bi-telephone-fill"></i>
  </a>
</div>

<style>
.floating-widgets-wrap {
  position: fixed;
  bottom: 80px;
  right: 20px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  z-index: 1000;
}

.floating-btn {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  text-decoration: none !important;
}

/* Scroll to Top button */
.scroll-to-top-btn {
  background-color: #ffffff;
  color: #1f2937;
  border: 1px solid rgba(0,0,0,0.08);
  opacity: 0;
  visibility: hidden;
  transform: translateY(20px);
}
.scroll-to-top-btn.show {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}
.scroll-to-top-btn:hover {
  background-color: #f3f4f6;
  color: #0d9488;
  transform: translateY(-3px);
}
.scroll-to-top-btn i {
  font-size: 24px;
}

/* Hotline button */
.hotline-floating-btn {
  background-color: #e11d48;
  color: white;
  position: relative;
}
.hotline-floating-btn:hover {
  background-color: #be123c;
  transform: scale(1.08);
}
.hotline-floating-btn i {
  font-size: 18px;
  z-index: 2;
}

/* Hotline pulse animation */
.hotline-pulse {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background-color: rgba(225, 29, 72, 0.4);
  z-index: 1;
  animation: pulse-ring 1.5s cubic-bezier(0.455, 0.03, 0.515, 0.955) infinite;
}

@keyframes pulse-ring {
  0% {
    transform: scale(0.95);
    opacity: 0.8;
  }
  50% {
    opacity: 0.4;
  }
  100% {
    transform: scale(1.6);
    opacity: 0;
  }
}

/* Mobile responsive adjustments */
@media (max-width: 992px) {
  .floating-widgets-wrap {
    bottom: 90px;
    right: 15px;
  }
  .floating-btn {
    width: 44px;
    height: 44px;
  }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
  var scrollBtn = document.getElementById('scrollToTopBtn');
  if (scrollBtn) {
    window.addEventListener('scroll', function() {
      if (window.pageYOffset > 300) {
        scrollBtn.classList.add('show');
      } else {
        scrollBtn.classList.remove('show');
      }
    });
    
    scrollBtn.addEventListener('click', function() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    });
  }
});
</script>
<!-- WISHLIST MODAL -->
<div id="wishlistModal" class="cps-modal" style="display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.5); backdrop-filter: blur(4px); transition: opacity 0.3s ease;">
  <div class="cps-modal-content" style="background-color: #fff; margin: 10% auto; padding: 24px; border-radius: 12px; width: 90%; max-width: 600px; box-shadow: 0 10px 25px rgba(0,0,0,0.15); position: relative; border: 1px solid #f1f5f9;">
    <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; padding-bottom: 12px; margin-bottom: 16px;">
      <h3 style="margin: 0; font-size: 18px; font-weight: 700; color: #0f172a; display: flex; align-items: center; gap: 8px;">
        <i class="bi bi-heart-fill text-danger"></i> Sản phẩm yêu thích của bạn
      </h3>
      <button onclick="closeWishlistModal()" style="background: none; border: none; font-size: 24px; cursor: pointer; color: #64748b; line-height: 1;"><i class="bi bi-x"></i></button>
    </div>
    <div id="wishlistModalBody" style="max-height: 400px; overflow-y: auto;">
      <div style="text-align: center; padding: 30px; color: #64748b;">Đang tải danh sách yêu thích...</div>
    </div>
  </div>
</div>

<!-- Form validation script to trim whitespaces and block blank required fields -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    const forms = document.querySelectorAll("form");
    forms.forEach(function(form) {
        form.addEventListener("submit", function(event) {
            let hasError = false;
            const inputs = form.querySelectorAll("input[type='text'], input[type='email'], input[type='password'], textarea");
            
            inputs.forEach(function(input) {
                input.value = input.value.trim();
                
                if (input.hasAttribute("required") && input.value === "") {
                    hasError = true;
                    input.classList.add("is-invalid");
                    
                    let feedback = input.nextElementSibling;
                    if (!feedback || !feedback.classList.contains("invalid-feedback")) {
                        feedback = document.createElement("div");
                        feedback.className = "invalid-feedback";
                        feedback.style.display = "block";
                        feedback.style.color = "#dc2626";
                        feedback.style.fontSize = "12px";
                        feedback.style.marginTop = "4px";
                        feedback.innerHTML = "<i class='bi bi-exclamation-circle-fill'></i> Vui lòng không để trống hoặc chỉ nhập khoảng trắng.";
                        input.parentNode.insertBefore(feedback, input.nextSibling);
                    } else {
                        feedback.style.display = "block";
                        feedback.innerHTML = "<i class='bi bi-exclamation-circle-fill'></i> Vui lòng không để trống hoặc chỉ nhập khoảng trắng.";
                    }
                } else {
                    input.classList.remove("is-invalid");
                    let feedback = input.nextElementSibling;
                    if (feedback && feedback.classList.contains("invalid-feedback")) {
                        feedback.style.display = "none";
                    }
                }
            });
            
            if (hasError) {
                event.preventDefault();
                event.stopPropagation();
                const firstInvalid = form.querySelector(".is-invalid");
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalid.focus();
                }
            }
        });
    });
});
</script>

<!-- ===== SWEETALERT2 JS ===== -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // Intercept standard browser confirm() in form submissions (e.g. Delete, status toggle)
    const forms = document.querySelectorAll("form");
    forms.forEach(function(form) {
        const onsubmitAttr = form.getAttribute("onsubmit");
        if (onsubmitAttr && onsubmitAttr.includes("confirm(")) {
            form.removeAttribute("onsubmit");
            
            let confirmMsg = "Bạn có chắc chắn muốn thực hiện hành động này?";
            const match = onsubmitAttr.match(/confirm\(['"](.+?)['"]\)/);
            if (match && match[1]) {
                confirmMsg = match[1];
            }
            
            form.addEventListener("submit", function(event) {
                event.preventDefault();
                
                Swal.fire({
                    title: 'Xác nhận',
                    text: confirmMsg,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#0d9488',
                    cancelButtonColor: '#e11d48',
                    confirmButtonText: 'Đồng ý',
                    cancelButtonText: 'Hủy',
                    background: '#ffffff',
                    customClass: {
                        popup: 'rounded-4 shadow-lg border-0',
                        confirmButton: 'btn btn-success px-4 py-2 fw-semibold mx-2',
                        cancelButton: 'btn btn-danger px-4 py-2 fw-semibold mx-2'
                    },
                    buttonsStyling: false
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            });
        }
    });

    // Premium Toast helper using SweetAlert2
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3500,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    // Check for Flash Messages from Spring Redirects
    <c:if test="${not empty message}">
        Toast.fire({
            icon: 'info',
            title: '${message}'
        });
    </c:if>
    <c:if test="${not empty success}">
        Toast.fire({
            icon: 'success',
            title: '${success}'
        });
    </c:if>
    <c:if test="${not empty error}">
        Toast.fire({
            icon: 'error',
            title: '${error}'
        });
    </c:if>
});
</script>

<!-- ============================================================
     WELCOME POPUP — Chào mừng + Mã giảm giá
     ============================================================ -->
<div id="welcomePopupOverlay" class="wlc-overlay" role="dialog" aria-modal="true" aria-labelledby="wlcTitle" style="display:none;">
  <div class="wlc-popup">
    <!-- Close button -->
    <button class="wlc-close" onclick="closeWelcomePopup()" aria-label="Đóng popup">
      <i class="bi bi-x-lg"></i>
    </button>

    <!-- Left panel: decorative -->
    <div class="wlc-left">
      <div class="wlc-left-inner">
        <div class="wlc-icon-wrap">
          <i class="bi bi-gift-fill"></i>
        </div>
        <div class="wlc-badge-text">Ưu đãi độc quyền</div>
        <div class="wlc-discount-circle">
          <span class="wlc-discount-num">10%</span>
          <span class="wlc-discount-label">GIẢM GIÁ</span>
        </div>
        <p class="wlc-left-note">Cho đơn hàng đầu tiên của bạn</p>
        <div class="wlc-features">
          <div class="wlc-feature-item"><i class="bi bi-truck-front-fill"></i> Miễn phí vận chuyển</div>
          <div class="wlc-feature-item"><i class="bi bi-shield-fill-check"></i> Bảo hành chính hãng</div>
          <div class="wlc-feature-item"><i class="bi bi-arrow-repeat"></i> Đổi trả 30 ngày</div>
        </div>
      </div>
    </div>

    <!-- Right panel: form -->
    <div class="wlc-right">
      <div class="wlc-right-inner">
        <div class="wlc-logo-wrap">
          <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom" class="wlc-logo" onerror="this.style.display='none'">
        </div>
        <h2 class="wlc-title" id="wlcTitle">Chào mừng đến với Bincom! 🎉</h2>
        <p class="wlc-subtitle">Đăng ký ngay để nhận <strong>mã giảm giá 10%</strong> cho đơn hàng đầu tiên của bạn.</p>

        <!-- Form state 1: Email input -->
        <div id="wlcFormState">
          <div class="wlc-form-group">
            <div class="wlc-input-wrap">
              <i class="bi bi-envelope-fill wlc-input-icon"></i>
              <input type="email" id="wlcEmail" class="wlc-input" placeholder="Nhập email của bạn..." autocomplete="email">
            </div>
            <button class="wlc-btn-submit" onclick="submitWelcomeEmail()" id="wlcSubmitBtn">
              <span id="wlcBtnText">Nhận mã giảm giá</span>
              <i class="bi bi-arrow-right-circle-fill"></i>
            </button>
          </div>
          <p class="wlc-privacy"><i class="bi bi-lock-fill"></i> Chúng tôi cam kết không spam email của bạn.</p>
        </div>

        <!-- Form state 2: Success -->
        <div id="wlcSuccessState" style="display:none;">
          <div class="wlc-success-wrap">
            <div class="wlc-success-icon"><i class="bi bi-check-circle-fill"></i></div>
            <h3 class="wlc-success-title">Thành công! 🎊</h3>
            <p class="wlc-success-text">Cảm ơn bạn đã đăng ký. Mã giảm giá của bạn là:</p>
            <div class="wlc-coupon-wrap" onclick="copyWelcomeCoupon()" title="Click để sao chép">
              <span class="wlc-coupon-code" id="wlcCouponCode">BINCOM10</span>
              <span class="wlc-coupon-copy"><i class="bi bi-copy"></i> Sao chép</span>
            </div>
            <p class="wlc-coupon-hint">Áp dụng khi thanh toán. HSD: 30 ngày.</p>
            <button class="wlc-btn-shop" onclick="closeWelcomePopup()">
              <i class="bi bi-bag-fill"></i> Mua sắm ngay
            </button>
          </div>
        </div>

        <button class="wlc-skip" onclick="closeWelcomePopup()">Bỏ qua, tôi không cần ưu đãi này</button>
      </div>
    </div>
  </div>
</div>

<style>
/* === WELCOME POPUP STYLES === */
.wlc-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,0.65);
  backdrop-filter: blur(6px);
  z-index: 99999;
  display: flex !important;
  align-items: center;
  justify-content: center;
  padding: 16px;
  animation: wlcFadeIn 0.35s ease;
}
@keyframes wlcFadeIn { from { opacity:0 } to { opacity:1 } }

.wlc-popup {
  background: #fff;
  border-radius: 20px;
  overflow: hidden;
  display: flex;
  width: 100%;
  max-width: 760px;
  max-height: 90vh;
  box-shadow: 0 25px 60px rgba(0,0,0,0.3);
  position: relative;
  animation: wlcSlideUp 0.4s cubic-bezier(0.34,1.56,0.64,1);
}
@keyframes wlcSlideUp { from { transform:translateY(40px) scale(0.95); opacity:0 } to { transform:none; opacity:1 } }

.wlc-close {
  position: absolute;
  top: 14px;
  right: 14px;
  z-index: 10;
  width: 34px;
  height: 34px;
  border-radius: 50%;
  border: none;
  background: rgba(255,255,255,0.9);
  color: #374151;
  font-size: 14px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  transition: all 0.2s;
}
.wlc-close:hover { background:#f9fafb; transform:scale(1.1); color:#ef4444; }

/* LEFT PANEL */
.wlc-left {
  width: 42%;
  background: linear-gradient(145deg, #0d9488 0%, #0f766e 50%, #134e4a 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 36px 28px;
  flex-shrink: 0;
  position: relative;
  overflow: hidden;
}
.wlc-left::before {
  content: '';
  position: absolute;
  top: -40px; right: -40px;
  width: 180px; height: 180px;
  border-radius: 50%;
  background: rgba(255,255,255,0.06);
}
.wlc-left::after {
  content: '';
  position: absolute;
  bottom: -30px; left: -30px;
  width: 130px; height: 130px;
  border-radius: 50%;
  background: rgba(255,255,255,0.05);
}
.wlc-left-inner { text-align:center; position:relative; z-index:2; }

.wlc-icon-wrap {
  width: 56px; height: 56px;
  border-radius: 50%;
  background: rgba(255,255,255,0.15);
  display: flex; align-items: center; justify-content: center;
  margin: 0 auto 12px;
  font-size: 26px; color: #fff;
  animation: wlcPulse 2s ease-in-out infinite;
}
@keyframes wlcPulse { 0%,100% { transform:scale(1) } 50% { transform:scale(1.08) } }

.wlc-badge-text {
  background: rgba(255,255,255,0.2);
  color: #fff;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 1.5px;
  text-transform: uppercase;
  padding: 4px 12px;
  border-radius: 20px;
  display: inline-block;
  margin-bottom: 16px;
}

.wlc-discount-circle {
  width: 110px; height: 110px;
  border-radius: 50%;
  border: 3px dashed rgba(255,255,255,0.5);
  display: flex; flex-direction: column;
  align-items: center; justify-content: center;
  margin: 0 auto 14px;
  background: rgba(255,255,255,0.12);
}
.wlc-discount-num {
  font-size: 32px;
  font-weight: 900;
  color: #fff;
  line-height: 1;
}
.wlc-discount-label {
  font-size: 10px;
  font-weight: 700;
  color: rgba(255,255,255,0.85);
  letter-spacing: 2px;
  margin-top: 2px;
}
.wlc-left-note {
  color: rgba(255,255,255,0.8);
  font-size: 12px;
  margin: 0 0 20px;
}
.wlc-features { display:flex; flex-direction:column; gap:8px; }
.wlc-feature-item {
  display: flex; align-items: center; gap: 8px;
  color: rgba(255,255,255,0.9);
  font-size: 12px;
  font-weight: 500;
}
.wlc-feature-item i { font-size: 13px; color: #6ee7b7; }

/* RIGHT PANEL */
.wlc-right {
  flex: 1;
  display: flex;
  align-items: center;
  overflow-y: auto;
}
.wlc-right-inner {
  padding: 36px 32px;
  width: 100%;
}
.wlc-logo-wrap { margin-bottom: 16px; }
.wlc-logo { height: 32px; object-fit: contain; }

.wlc-title {
  font-size: 22px;
  font-weight: 800;
  color: #0f172a;
  margin: 0 0 8px;
  line-height: 1.3;
}
.wlc-subtitle {
  font-size: 13.5px;
  color: #475569;
  margin: 0 0 24px;
  line-height: 1.6;
}
.wlc-subtitle strong { color: #0d9488; }

.wlc-form-group { display:flex; flex-direction:column; gap:10px; }
.wlc-input-wrap {
  position: relative;
  display: flex;
  align-items: center;
}
.wlc-input-icon {
  position: absolute;
  left: 14px;
  color: #94a3b8;
  font-size: 15px;
  pointer-events: none;
}
.wlc-input {
  width: 100%;
  height: 48px;
  padding: 0 16px 0 42px;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  font-size: 14px;
  color: #0f172a;
  outline: none;
  transition: border-color 0.2s, box-shadow 0.2s;
  background: #f8fafc;
}
.wlc-input:focus {
  border-color: #0d9488;
  box-shadow: 0 0 0 4px rgba(13,148,136,0.12);
  background: #fff;
}
.wlc-input.wlc-error { border-color: #ef4444; box-shadow: 0 0 0 4px rgba(239,68,68,0.1); }

.wlc-btn-submit {
  height: 48px;
  border-radius: 12px;
  border: none;
  background: linear-gradient(135deg, #0d9488, #0f766e);
  color: #fff;
  font-size: 14px;
  font-weight: 700;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.2s;
  box-shadow: 0 4px 15px rgba(13,148,136,0.35);
}
.wlc-btn-submit:hover { transform:translateY(-2px); box-shadow: 0 6px 20px rgba(13,148,136,0.45); }
.wlc-btn-submit:active { transform:none; }
.wlc-btn-submit:disabled { opacity:0.7; cursor:not-allowed; transform:none; }

.wlc-privacy {
  font-size: 11px;
  color: #94a3b8;
  margin: 8px 0 0;
  display: flex;
  align-items: center;
  gap: 4px;
}
.wlc-privacy i { color: #6ee7b7; }

.wlc-skip {
  display: block;
  width: 100%;
  margin-top: 20px;
  background: none;
  border: none;
  color: #94a3b8;
  font-size: 12px;
  cursor: pointer;
  text-decoration: underline;
  text-align: center;
  padding: 0;
  transition: color 0.2s;
}
.wlc-skip:hover { color: #64748b; }

/* SUCCESS STATE */
.wlc-success-wrap { text-align: center; }
.wlc-success-icon {
  font-size: 52px;
  color: #0d9488;
  margin-bottom: 12px;
  animation: wlcBounce 0.5s ease;
}
@keyframes wlcBounce { 0% { transform:scale(0) } 70% { transform:scale(1.1) } 100% { transform:scale(1) } }
.wlc-success-title { font-size: 20px; font-weight: 800; color: #0f172a; margin: 0 0 8px; }
.wlc-success-text { font-size: 13px; color: #475569; margin: 0 0 16px; }

.wlc-coupon-wrap {
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: linear-gradient(135deg, #f0fdf4, #dcfce7);
  border: 2px dashed #16a34a;
  border-radius: 12px;
  padding: 14px 18px;
  cursor: pointer;
  margin-bottom: 8px;
  transition: all 0.2s;
}
.wlc-coupon-wrap:hover { background: linear-gradient(135deg, #dcfce7, #bbf7d0); transform:scale(1.02); }
.wlc-coupon-code {
  font-size: 22px;
  font-weight: 900;
  color: #15803d;
  letter-spacing: 3px;
  font-family: monospace;
}
.wlc-coupon-copy {
  font-size: 12px;
  color: #16a34a;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 4px;
}
.wlc-coupon-hint { font-size: 11px; color: #94a3b8; margin: 0 0 20px; }

.wlc-btn-shop {
  width: 100%;
  height: 46px;
  border-radius: 12px;
  border: none;
  background: linear-gradient(135deg, #0d9488, #0f766e);
  color: #fff;
  font-size: 14px;
  font-weight: 700;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.2s;
  box-shadow: 0 4px 15px rgba(13,148,136,0.35);
}
.wlc-btn-shop:hover { transform:translateY(-2px); }

/* RESPONSIVE */
@media (max-width: 600px) {
  .wlc-popup { flex-direction: column; max-height: 95vh; border-radius: 16px; }
  .wlc-left { width: 100%; padding: 24px 20px; }
  .wlc-discount-circle { width: 80px; height: 80px; }
  .wlc-discount-num { font-size: 24px; }
  .wlc-features { flex-direction: row; flex-wrap: wrap; justify-content: center; }
  .wlc-right-inner { padding: 24px 20px; }
  .wlc-title { font-size: 18px; }
  .wlc-icon-wrap { display:none; }
  .wlc-left-note, .wlc-badge-text { display:none; }
}
</style>

<script>
(function() {
  var POPUP_KEY = 'bincom_welcome_popup_shown_v1';
  var DELAY_MS = 1800;

  function showWelcomePopup() {
    var overlay = document.getElementById('welcomePopupOverlay');
    if (overlay) overlay.style.display = 'flex';
  }

  function isAdminPage() {
    return window.location.pathname.indexOf('/admin') !== -1 ||
           window.location.pathname.indexOf('/login') !== -1 ||
           window.location.pathname.indexOf('/register') !== -1;
  }

  document.addEventListener('DOMContentLoaded', function() {
    if (isAdminPage()) return;
    if (sessionStorage.getItem(POPUP_KEY)) return;
    setTimeout(showWelcomePopup, DELAY_MS);
  });
})();

function closeWelcomePopup() {
  var overlay = document.getElementById('welcomePopupOverlay');
  if (overlay) {
    overlay.style.animation = 'wlcFadeIn 0.25s ease reverse forwards';
    setTimeout(function() { overlay.style.display = 'none'; }, 240);
  }
  sessionStorage.setItem('bincom_welcome_popup_shown_v1', '1');
}

function submitWelcomeEmail() {
  var emailInput = document.getElementById('wlcEmail');
  var email = emailInput ? emailInput.value.trim() : '';
  var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!email || !emailRegex.test(email)) {
    emailInput.classList.add('wlc-error');
    emailInput.focus();
    emailInput.placeholder = 'Vui lòng nhập email hợp lệ!';
    setTimeout(function() {
      emailInput.classList.remove('wlc-error');
      emailInput.placeholder = 'Nhập email của bạn...';
    }, 2500);
    return;
  }

  var btn = document.getElementById('wlcSubmitBtn');
  var btnText = document.getElementById('wlcBtnText');
  if (btn) btn.disabled = true;
  if (btnText) btnText.textContent = 'Đang xử lý...';

  // Simulate processing then show success
  setTimeout(function() {
    document.getElementById('wlcFormState').style.display = 'none';
    var successState = document.getElementById('wlcSuccessState');
    successState.style.display = 'block';
    // Mark as shown so it doesn't re-appear
    sessionStorage.setItem('bincom_welcome_popup_shown_v1', '1');
  }, 900);
}

function copyWelcomeCoupon() {
  var code = document.getElementById('wlcCouponCode');
  if (!code) return;
  var text = code.textContent;

  if (navigator.clipboard && navigator.clipboard.writeText) {
    navigator.clipboard.writeText(text).then(function() {
      showCopySuccess();
    });
  } else {
    var tmp = document.createElement('textarea');
    tmp.value = text;
    document.body.appendChild(tmp);
    tmp.select();
    document.execCommand('copy');
    document.body.removeChild(tmp);
    showCopySuccess();
  }
}

function showCopySuccess() {
  if (typeof showToast === 'function') {
    showToast('Đã sao chép mã: BINCOM10 🎉', 'success');
  } else if (typeof Swal !== 'undefined') {
    Swal.mixin({ toast:true, position:'top-end', showConfirmButton:false, timer:2500 })
        .fire({ icon:'success', title:'Đã sao chép mã BINCOM10! 🎉' });
  }
}

// Close on overlay click
document.addEventListener('DOMContentLoaded', function() {
  var overlay = document.getElementById('welcomePopupOverlay');
  if (overlay) {
    overlay.addEventListener('click', function(e) {
      if (e.target === overlay) closeWelcomePopup();
    });
  }
  // Close on Escape key
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') closeWelcomePopup();
  });
});
</script>

</body>
</html>
