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

<!-- WELCOME POPUP -->
<div id="welcomePopupOverlay" class="wlc-overlay" role="dialog" aria-modal="true" aria-labelledby="wlcTitle" style="display:none;">
  <div class="wlc-popup">
    <div class="wlc-left">
      <div class="wlc-left-content">
        <div class="wlc-tag">Ưu đãi thành viên mới</div>
        <div class="wlc-big-number">10<span>%</span></div>
        <p class="wlc-left-desc">Giảm giá cho đơn hàng<br>đầu tiên của bạn</p>
        <div class="wlc-divider"></div>
        <ul class="wlc-perks">
          <li><i class="bi bi-check2"></i> Miễn phí giao hàng từ 500K</li>
          <li><i class="bi bi-check2"></i> Đổi trả trong 30 ngày</li>
          <li><i class="bi bi-check2"></i> Bảo hành chính hãng</li>
        </ul>
      </div>
    </div>
    <div class="wlc-right">
      <button class="wlc-close-btn" onclick="closeWelcomePopup()" aria-label="Đóng"><i class="bi bi-x"></i></button>
      <div class="wlc-right-content">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom" class="wlc-logo" onerror="this.style.display='none'">
        <div id="wlcFormView">
          <h2 class="wlc-title" id="wlcTitle">Chào mừng đến Bincom</h2>
          <p class="wlc-desc">Để lại email, chúng tôi sẽ gửi mã giảm giá 10% cho đơn hàng đầu tiên của bạn.</p>
          <div class="wlc-field-wrap">
            <input type="email" id="wlcEmailInput" class="wlc-field" placeholder="Email của bạn" autocomplete="email">
          </div>
          <button class="wlc-cta" id="wlcCta" onclick="submitWelcomeEmail()">
            <span id="wlcCtaText">Nhận mã giảm giá</span>
            <i class="bi bi-arrow-right" id="wlcCtaIcon"></i>
          </button>
          <p class="wlc-fine">Chúng tôi cam kết bảo mật email của bạn.</p>
          <button class="wlc-later" onclick="closeWelcomePopup()">Để sau</button>
        </div>
        <div id="wlcSuccessView" style="display:none;">
          <div class="wlc-check-wrap"><div class="wlc-check-circle"><i class="bi bi-check-lg"></i></div></div>
          <h2 class="wlc-title">Cảm ơn bạn!</h2>
          <p class="wlc-desc">Sử dụng mã bên dưới khi thanh toán để được giảm ngay 10%.</p>
          <div class="wlc-code-box" onclick="copyWelcomeCode()" title="Nhấn để sao chép">
            <span class="wlc-code" id="wlcCode">BINCOM10</span>
            <span class="wlc-copy-hint"><i class="bi bi-copy"></i> Sao chép</span>
          </div>
          <p class="wlc-expiry">Mã có hiệu lực trong 30 ngày.</p>
          <button class="wlc-cta" onclick="closeWelcomePopup()">Mua sắm ngay</button>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
.wlc-overlay{position:fixed;inset:0;background:rgba(10,14,22,.6);backdrop-filter:blur(4px);z-index:99999;align-items:center;justify-content:center;padding:16px;animation:wlcIn .3s ease both}
@keyframes wlcIn{from{opacity:0}to{opacity:1}}
.wlc-popup{display:flex;width:100%;max-width:720px;max-height:92vh;border-radius:16px;overflow:hidden;box-shadow:0 32px 80px rgba(0,0,0,.32);animation:wlcUp .38s cubic-bezier(.22,.68,0,1.2) both}
@keyframes wlcUp{from{transform:translateY(24px);opacity:0}to{transform:none;opacity:1}}
.wlc-left{width:44%;flex-shrink:0;background:#0a0e16;display:flex;align-items:center;justify-content:center;padding:48px 36px;position:relative;overflow:hidden}
.wlc-left::before{content:'';position:absolute;width:300px;height:300px;border-radius:50%;background:radial-gradient(circle,rgba(13,148,136,.22) 0%,transparent 70%);top:-70px;left:-70px;pointer-events:none}
.wlc-left::after{content:'';position:absolute;width:180px;height:180px;border-radius:50%;background:radial-gradient(circle,rgba(13,148,136,.14) 0%,transparent 70%);bottom:-50px;right:-40px;pointer-events:none}
.wlc-left-content{position:relative;z-index:1;color:#fff}
.wlc-tag{display:inline-block;font-size:10px;font-weight:600;letter-spacing:2px;text-transform:uppercase;color:#0d9488;border:1px solid rgba(13,148,136,.4);padding:4px 10px;border-radius:4px;margin-bottom:28px}
.wlc-big-number{font-size:86px;font-weight:900;line-height:1;color:#fff;letter-spacing:-4px;margin-bottom:6px}
.wlc-big-number span{font-size:38px;font-weight:700;color:#0d9488;letter-spacing:0;vertical-align:super;margin-left:2px}
.wlc-left-desc{font-size:13px;color:rgba(255,255,255,.5);line-height:1.65;margin:0 0 22px}
.wlc-divider{height:1px;background:rgba(255,255,255,.08);margin-bottom:20px}
.wlc-perks{list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:10px}
.wlc-perks li{font-size:12.5px;color:rgba(255,255,255,.6);display:flex;align-items:center;gap:8px}
.wlc-perks li i{color:#0d9488;font-size:14px;flex-shrink:0}
.wlc-right{flex:1;background:#fff;display:flex;align-items:center;position:relative;overflow-y:auto}
.wlc-close-btn{position:absolute;top:16px;right:16px;width:32px;height:32px;border-radius:50%;border:1px solid #e5e7eb;background:#fff;color:#9ca3af;font-size:16px;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:all .2s;z-index:5}
.wlc-close-btn:hover{border-color:#374151;color:#111827}
.wlc-right-content{padding:48px 40px;width:100%}
.wlc-logo{height:28px;object-fit:contain;display:block;margin-bottom:28px}
.wlc-title{font-size:22px;font-weight:700;color:#0f172a;letter-spacing:-.4px;margin:0 0 10px;line-height:1.3}
.wlc-desc{font-size:13.5px;color:#6b7280;line-height:1.65;margin:0 0 26px}
.wlc-field-wrap{margin-bottom:12px}
.wlc-field{width:100%;height:46px;padding:0 16px;border:1.5px solid #e5e7eb;border-radius:8px;font-size:14px;color:#111827;outline:none;background:#f9fafb;transition:border-color .2s,box-shadow .2s;box-sizing:border-box}
.wlc-field::placeholder{color:#9ca3af}
.wlc-field:focus{border-color:#0d9488;background:#fff;box-shadow:0 0 0 3px rgba(13,148,136,.1)}
.wlc-field.wlc-err{border-color:#ef4444;box-shadow:0 0 0 3px rgba(239,68,68,.1)}
.wlc-cta{width:100%;height:46px;border:none;border-radius:8px;background:#0f172a;color:#fff;font-size:14px;font-weight:600;letter-spacing:.2px;cursor:pointer;display:flex;align-items:center;justify-content:center;gap:8px;transition:background .2s,transform .15s;margin-bottom:16px}
.wlc-cta:hover{background:#0d9488}
.wlc-cta:active{transform:scale(.98)}
.wlc-cta:disabled{opacity:.6;cursor:not-allowed}
.wlc-fine{font-size:11.5px;color:#9ca3af;text-align:center;margin:0 0 20px}
.wlc-later{display:block;width:100%;background:none;border:none;font-size:12.5px;color:#9ca3af;cursor:pointer;text-align:center;padding:0;transition:color .2s}
.wlc-later:hover{color:#374151}
.wlc-check-wrap{margin-bottom:20px}
.wlc-check-circle{width:52px;height:52px;border-radius:50%;background:#f0fdf4;border:1.5px solid #d1fae5;display:flex;align-items:center;justify-content:center;font-size:22px;color:#059669;animation:wlcCheck .4s ease both}
@keyframes wlcCheck{from{transform:scale(0)}60%{transform:scale(1.12)}to{transform:scale(1)}}
.wlc-code-box{display:flex;align-items:center;justify-content:space-between;padding:14px 18px;border:1.5px dashed #d1d5db;border-radius:8px;background:#f9fafb;cursor:pointer;margin-bottom:10px;transition:border-color .2s,background .2s}
.wlc-code-box:hover{border-color:#0d9488;background:#f0fdfa}
.wlc-code{font-family:'SF Mono','Fira Code',monospace;font-size:20px;font-weight:700;color:#0f172a;letter-spacing:3px}
.wlc-copy-hint{font-size:12px;color:#6b7280;display:flex;align-items:center;gap:4px;transition:color .2s}
.wlc-code-box:hover .wlc-copy-hint{color:#0d9488}
.wlc-expiry{font-size:11.5px;color:#9ca3af;margin:0 0 24px}
@media(max-width:580px){.wlc-popup{flex-direction:column;border-radius:12px}.wlc-left{width:100%;padding:28px 28px 24px}.wlc-big-number{font-size:64px}.wlc-big-number span{font-size:30px}.wlc-perks,.wlc-divider,.wlc-left-desc{display:none}.wlc-right-content{padding:32px 24px}.wlc-logo{display:none}}
</style>

<script>
(function(){var K='bincom_wlc_v2';function bad(){var p=location.pathname;return p.indexOf('/admin')>-1||p.indexOf('/login')>-1||p.indexOf('/register')>-1}document.addEventListener('DOMContentLoaded',function(){if(bad()||sessionStorage.getItem(K))return;setTimeout(function(){var e=document.getElementById('welcomePopupOverlay');if(e)e.style.display='flex'},1600);var e=document.getElementById('welcomePopupOverlay');if(e)e.addEventListener('click',function(ev){if(ev.target===e)closeWelcomePopup()});document.addEventListener('keydown',function(ev){if(ev.key==='Escape')closeWelcomePopup()})})})();
function closeWelcomePopup(){var e=document.getElementById('welcomePopupOverlay');if(!e)return;e.style.transition='opacity .25s';e.style.opacity='0';setTimeout(function(){e.style.display='none';e.style.opacity=''},260);sessionStorage.setItem('bincom_wlc_v2','1')}
function submitWelcomeEmail(){var i=document.getElementById('wlcEmailInput'),email=i?i.value.trim():'';if(!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)){i.classList.add('wlc-err');i.focus();setTimeout(function(){i.classList.remove('wlc-err')},2000);return}var c=document.getElementById('wlcCta'),t=document.getElementById('wlcCtaText'),ic=document.getElementById('wlcCtaIcon');if(c)c.disabled=true;if(t)t.textContent='Đang xử lý...';if(ic)ic.style.display='none';setTimeout(function(){document.getElementById('wlcFormView').style.display='none';document.getElementById('wlcSuccessView').style.display='block';sessionStorage.setItem('bincom_wlc_v2','1')},800)}
function copyWelcomeCode(){var code=((document.getElementById('wlcCode')||{}).textContent)||'BINCOM10',done=function(){if(typeof Swal!=='undefined')Swal.mixin({toast:true,position:'top-end',showConfirmButton:false,timer:2200}).fire({icon:'success',title:'Đã sao chép mã '+code})};if(navigator.clipboard)navigator.clipboard.writeText(code).then(done);else{var t=document.createElement('textarea');t.value=code;document.body.appendChild(t);t.select();document.execCommand('copy');document.body.removeChild(t);done()}}
</script>

</body>
</html>
