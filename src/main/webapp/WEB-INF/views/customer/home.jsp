<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Bincom — Mua Sắm Thông Minh" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<style>
/* Inner Hero Image Slider for Slide 1 */
.inner-hero-slider {
  position: relative;
  width: 100%;
  max-width: 420px;
  aspect-ratio: 1 / 1;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
  background: #0f172a;
}
.inner-slides {
  position: relative;
  width: 100%;
  height: 100%;
}
.inner-slide {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  opacity: 0;
  transition: opacity 0.5s ease-in-out, transform 0.5s ease-in-out;
  transform: scale(0.96);
  z-index: 1;
}
.inner-slide.active {
  opacity: 1;
  transform: scale(1);
  z-index: 2;
}
.inner-nav-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.25);
  backdrop-filter: blur(4px);
  border: none;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 10;
  transition: all 0.2s ease;
  font-size: 14px;
}
.inner-nav-btn:hover {
  background: rgba(255, 255, 255, 0.9);
  color: #0f172a;
  transform: translateY(-50%) scale(1.05);
}
.inner-nav-btn.prev {
  left: 12px;
}
.inner-nav-btn.next {
  right: 12px;
}
.inner-dots {
  position: absolute;
  bottom: 12px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 6px;
  z-index: 10;
}
.inner-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.4);
  cursor: pointer;
  transition: all 0.2s ease;
}
.inner-dot.active {
  background: #2563eb;
  transform: scale(1.25);
}
</style>

<!-- Semantic H1 for SEO optimization -->
<h1 style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); border: 0;">Bincom — Hệ thống bán lẻ công nghệ, thời trang & đồ gia dụng chính hãng</h1>
<div style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); border: 0;">
  <h2>Bincom Tech — Siêu thị thiết bị số và điện thoại chính hãng</h2>
  <h2>Bincom Style — Thương hiệu thời trang và phụ kiện cao cấp</h2>
  <h2>Bincom Home — Chuỗi thiết bị thông minh và đồ dùng gia đình</h2>
</div>

<!-- HERO BANNER GRID CONTAINER -->
<div class="hero-section-container">
  <!-- HERO BANNER SLIDER (TGDD Style) -->
  <section class="hero-slider">
    <div class="hero-slides" id="heroSlides">
      <!-- Slide 1: Bincom Brand -->
      <div class="hero-slide" style="background: linear-gradient(135deg, #090e1a 0%, #1a2536 100%);">
        <div class="hero-slide-overlay">
          <div class="hero-content">
            <span class="hero-tag">Thương hiệu uy tín</span>
            <h2 class="hero-title">Hệ Thống Bán Lẻ Bincom</h2>
            <p class="hero-sub">Địa chỉ mua sắm thiết bị số, thời trang và gia dụng chính hãng hàng đầu Việt Nam. Cam kết chất lượng, bảo hành uy tín.</p>
            <a href="${pageContext.request.contextPath}/about" class="hero-btn" title="Tìm hiểu thêm thông tin về Hệ thống bán lẻ Bincom">
              Tìm hiểu ngay <i class="bi bi-arrow-right"></i>
            </a>
          </div>
          <div class="hero-image-wrap">
            <a href="${pageContext.request.contextPath}/about" class="inner-hero-slider" id="innerHeroSlider" title="Tìm hiểu thông tin về Hệ thống bán lẻ Bincom" style="display: block;">
              <div class="inner-slides">
                <img src="${pageContext.request.contextPath}/resources/images/bincom_tech.png" class="inner-slide active" alt="Bincom Tech - Điện thoại & Thiết bị số chính hãng">
                <img src="${pageContext.request.contextPath}/resources/images/bincom_fashion.png" class="inner-slide" alt="Bincom Style - Thời trang & Phụ kiện hàng hiệu">
                <img src="${pageContext.request.contextPath}/resources/images/bincom_home.png" class="inner-slide" alt="Bincom Home - Thiết bị thông minh gia đình">
              </div>
            </a>
          </div>
        </div>
      </div>
      <!-- Slide 2: Technology -->
      <div class="hero-slide" style="background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%);">
        <div class="hero-slide-overlay">
          <div class="hero-content">
            <span class="hero-tag">Bộ sưu tập công nghệ</span>
            <h2 class="hero-title">Kỷ Nguyên Thiết Bị Số</h2>
            <p class="hero-sub">Trải nghiệm đỉnh cao công nghệ với ưu đãi đặc biệt lên đến 30% cho smartphone và phụ kiện cao cấp.</p>
            <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="hero-btn" title="Xem tất cả Điện thoại & Thiết bị số chính hãng tại Bincom Tech">
              Khám phá ngay <i class="bi bi-arrow-right"></i>
            </a>
          </div>
          <div class="hero-image-wrap">
            <img src="${pageContext.request.contextPath}/resources/images/hero_phone.png" alt="Technology Collection">
          </div>
        </div>
      </div>
      <!-- Slide 3: Fashion -->
      <div class="hero-slide" style="background: linear-gradient(135deg, #1e1b4b 0%, #4c1d95 100%);">
        <div class="hero-slide-overlay">
          <div class="hero-content">
            <span class="hero-tag">Thời trang hiện đại</span>
            <h2 class="hero-title">Định Hình Phong Cách</h2>
            <p class="hero-sub">Đón đầu xu hướng thời trang mùa mới. BST quần áo, phụ kiện trẻ trung, năng động đang giảm giá cực sâu.</p>
            <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="hero-btn" title="Xem tất cả sản phẩm Thời trang & Phụ kiện tại Bincom Style">
              Xem khuyến mãi <i class="bi bi-tag"></i>
            </a>
          </div>
          <div class="hero-image-wrap">
            <img src="${pageContext.request.contextPath}/resources/images/hero_fashion.png" alt="Fashion Style">
          </div>
        </div>
      </div>
      <!-- Slide 4: Smart Home -->
      <div class="hero-slide" style="background: linear-gradient(135deg, #0b132b 0%, #1c2541 100%);">
        <div class="hero-slide-overlay">
          <div class="hero-content">
            <span class="hero-tag">Đồ dùng gia đình</span>
            <h2 class="hero-title">Thiết bị thông minh cho nhà</h2>
            <p class="hero-sub">Tận hưởng cuộc sống tiện nghi với hệ sinh thái robot hút bụi và thiết bị trung tâm điều khiển hiện đại.</p>
            <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="hero-btn" title="Xem tất cả Thiết bị thông minh gia đình tại Bincom Home">
              Mua ngay <i class="bi bi-cart"></i>
            </a>
          </div>
          <div class="hero-image-wrap">
            <img src="${pageContext.request.contextPath}/resources/images/banner_tech.png" alt="Smart Home Collection">
          </div>
        </div>
      </div>
    </div>
    
  </section>

  <!-- HERO SIDE BANNER (Right Column) -->
  <a href="${pageContext.request.contextPath}/shop?categoryId=6" class="hero-side-banner" title="Xem tất cả sản phẩm Mỹ phẩm & Làm đẹp chính hãng tại Bincom Beauty">
    <div class="hero-side-content">
      <h3 class="hero-side-title">Mỹ phẩm & Làm đẹp</h3>
      <p class="hero-side-desc">Chăm sóc da chuyên sâu - Đẹp rạng ngời</p>
      <span class="hero-side-btn">Mua ngay <i class="bi bi-chevron-right"></i></span>
    </div>
    <div class="hero-side-img-wrap">
      <img src="${pageContext.request.contextPath}/resources/images/banner_streetwear.png" alt="Bincom Beauty Collection">
    </div>
  </a>
</div>
 
<!-- TRIPLE BANNER (TGDD Sub-banners) -->
<div class="triple-banner">
  <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="triple-banner-item" style="background: linear-gradient(135deg, #0a1128 0%, #1e3a8a 100%);" title="Xem tất cả Smartphones chính hãng giảm giá sốc tại Bincom Tech">
    <div class="triple-banner-content">
      <h3 class="triple-banner-title">Smartphones giảm sốc</h3>
      <p class="triple-banner-desc">Thu cũ đổi mới - Trợ giá đến 2 triệu</p>
      <span class="triple-banner-btn">Mua ngay <i class="bi bi-chevron-right"></i></span>
    </div>
    <div class="triple-banner-img-wrap">
      <img src="${pageContext.request.contextPath}/resources/images/banner_fashion.png" alt="Smartphone Banner">
    </div>
  </a>
  <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="triple-banner-item" style="background: linear-gradient(135deg, #2e0854 0%, #6b21a8 100%);" title="Xem tất cả sản phẩm Thời trang hàng hiệu tại Bincom Style">
    <div class="triple-banner-content">
      <h3 class="triple-banner-title">Thời trang hàng hiệu</h3>
      <p class="triple-banner-desc">Giảm thêm 15% khi thanh toán online</p>
      <span class="triple-banner-btn">Xem ngay <i class="bi bi-chevron-right"></i></span>
    </div>
    <div class="triple-banner-img-wrap">
      <img src="${pageContext.request.contextPath}/resources/images/hero_fashion.png" alt="Fashion Banner">
    </div>
  </a>
  <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="triple-banner-item" style="background: linear-gradient(135deg, #064e3b 0%, #0d9488 100%);" title="Xem tất cả Thiết bị thông minh gia đình tại Bincom Home">
    <div class="triple-banner-content">
      <h3 class="triple-banner-title">Thiết bị thông minh cho nhà</h3>
      <p class="triple-banner-desc">Tận hưởng cuộc sống tiện nghi</p>
      <span class="triple-banner-btn">Mua ngay <i class="bi bi-chevron-right"></i></span>
    </div>
    <div class="triple-banner-img-wrap">
      <img src="${pageContext.request.contextPath}/resources/images/banner_tech.png" alt="Smart Home Collection">
    </div>
  </a>
</div>

<!-- FLASH SALE SECTION (TGDD style) -->
<section class="flash-sale-section">
  <div class="flash-sale-header">
    <div class="flash-sale-title">
      <span class="flash-sale-badge">⚡ Giờ vàng</span>
      <h2>GIÁ SỐC ONLINE</h2>
      <div class="countdown-timer">
        <span class="countdown-label">Kết thúc trong</span>
        <div class="countdown-block" id="timerHour">00</div>
        <span class="countdown-sep">:</span>
        <div class="countdown-block" id="timerMin">00</div>
        <span class="countdown-sep">:</span>
        <div class="countdown-block" id="timerSec">00</div>
      </div>
    </div>
    <a href="${pageContext.request.contextPath}/shop?sort=price-asc" class="flash-sale-view-all">
      Xem tất cả <i class="bi bi-chevron-right"></i>
    </a>
  </div>

  <div class="product-scroll-wrapper" style="max-width:1320px; margin:0 auto; padding:0 24px;">
    <button class="scroll-arrow-btn prev" onclick="scrollProductRow(this, -1)"><i class="bi bi-chevron-left"></i></button>
    <div class="product-scroll-row">
      <!-- Render only items that are actually on sale from featuredProducts -->
      <c:forEach var="product" items="${featuredProducts}">
        <c:if test="${product.onSale}">
          <div class="flash-product-card" onclick="window.location.href='${pageContext.request.contextPath}/shop/product/${product.id}'">
            <div class="flash-product-img">
              <span class="flash-discount-badge">-<fmt:formatNumber value="${(product.price - product.effectivePrice) * 100 / product.price}" maxFractionDigits="0"/>%</span>
              <c:choose>
                <c:when test="${not empty product.thumbnailUrl}">
                  <img src="${pageContext.request.contextPath}${product.thumbnailUrl}" alt="${product.name}" onerror="this.src='https://placehold.co/300x300?text=Bincom'"/>
                </c:when>
                <c:otherwise>
                  <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:#f1f5f9;color:#94a3b8;font-size:24px;">
                    <i class="bi bi-image"></i>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
            <div class="flash-product-name">${product.name}</div>
            <div class="flash-product-price">
              <fmt:formatNumber value="${product.effectivePrice}" type="number" groupingUsed="true"/>₫
            </div>
            <div class="flash-product-original">
              <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
            </div>
            
            <!-- TGDD Sold Progress Bar -->
            <div class="flash-progress">
              <div class="flash-progress-bar" style="width: 65%;"></div>
            </div>
            <div class="flash-progress-label">🔥 Đã bán 23/30</div>
          </div>
        </c:if>
      </c:forEach>
    </div>
    <button class="scroll-arrow-btn next" onclick="scrollProductRow(this, 1)"><i class="bi bi-chevron-right"></i></button>
  </div>
</section>

<!-- CATEGORY GRID QUICK LINKS (TGDD Style) -->
<section class="section-pad" style="background: var(--light);">
  <div class="kumo-container">
    <div class="section-head">
      <div class="section-head-left">
        <h2 class="section-title">Danh mục nổi bật</h2>
      </div>
    </div>
    <div class="home-category-grid">
      <c:forEach var="cat" items="${categories}">
        <a href="${pageContext.request.contextPath}/shop?categoryId=${cat.id}" class="home-cat-card">
          <span class="home-cat-icon">
            <c:choose>
              <c:when test="${cat.id == 1}"><i class="bi bi-phone"></i></c:when>
              <c:when test="${cat.id == 2}"><i class="bi bi-gem"></i></c:when>
              <c:when test="${cat.id == 3}"><i class="bi bi-house"></i></c:when>
              <c:when test="${cat.id == 4}"><i class="bi bi-book"></i></c:when>
              <c:when test="${cat.id == 5}"><i class="bi bi-dribbble"></i></c:when>
              <c:when test="${cat.id == 6}"><i class="bi bi-magic"></i></c:when>
              <c:otherwise><i class="bi bi-grid"></i></c:otherwise>
            </c:choose>
          </span>
          <div class="home-cat-name">${cat.name}</div>
        </a>
      </c:forEach>
    </div>
  </div>
</section>

<!-- FEATURED PRODUCTS GRID (5 Columns TGDD-style) -->
<section class="section-pad">
  <div class="kumo-container">
    <div class="section-head">
      <div class="section-head-left">
        <h2 class="section-title">Gợi ý hôm nay</h2>
      </div>
      <a href="${pageContext.request.contextPath}/shop" class="section-view-all">
        Xem tất cả <i class="bi bi-chevron-right"></i>
      </a>
    </div>

    <div class="product-scroll-wrapper">
      <button class="scroll-arrow-btn prev" onclick="scrollProductRow(this, -1)"><i class="bi bi-chevron-left"></i></button>
      <div class="product-scroll-row">
        <c:forEach var="product" items="${latestProducts}" begin="0" end="14">
          <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/shop/product/${product.id}'">
            <div class="product-img-wrap">
              <c:if test="${product.onSale}">
                <div class="product-badges"><span class="badge-sale">SALE</span></div>
              </c:if>
              <c:choose>
                <c:when test="${not empty product.thumbnailUrl}">
                  <img src="${pageContext.request.contextPath}${product.thumbnailUrl}" alt="${product.name}" onerror="this.src='https://placehold.co/300x400?text=Bincom'"/>
                </c:when>
                <c:otherwise>
                  <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:#f1f5f9;color:#94a3b8;font-size:36px;">
                    <i class="bi bi-image"></i>
                  </div>
                </c:otherwise>
              </c:choose>
              <div class="product-actions">
                <button class="btn-add-cart-overlay" onclick="event.stopPropagation(); addToCart(${product.id}, this)">
                  + Thêm vào giỏ
                </button>
              </div>
            </div>
            <div class="product-info">
              <div class="product-cat-label">${product.category.name}</div>
              <div class="product-name">
                <a href="${pageContext.request.contextPath}/shop/product/${product.id}">${product.name}</a>
              </div>
              <div class="product-price">
                <span class="price-current">
                  <fmt:formatNumber value="${product.effectivePrice}" type="number" groupingUsed="true"/>₫
                </span>
                <c:if test="${product.onSale}">
                  <span class="price-original">
                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
                  </span>
                  <span class="price-percent">-<fmt:formatNumber value="${(product.price - product.effectivePrice) * 100 / product.price}" maxFractionDigits="0"/>%</span>
                </c:if>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
      <button class="scroll-arrow-btn next" onclick="scrollProductRow(this, 1)"><i class="bi bi-chevron-right"></i></button>
    </div>
  </div>
</section>

<!-- BRAND LOGOS STRIP (Trust banner) -->
<section style="background: #fff; padding: 30px 0; border-top: 1px solid var(--border);">
  <div class="kumo-container" style="display:flex; align-items:center; justify-content:space-around; gap:20px; flex-wrap:wrap; opacity:0.6;">
    <span style="font-weight:800; font-size:16px; color:var(--primary);">BINCOM PARTNERS:</span>
    <span style="font-size:20px; font-weight:700;"><i class="bi bi-apple"></i> Apple</span>
    <span style="font-size:20px; font-weight:700;"><i class="bi bi-nvidia"></i> Nvidia</span>
    <span style="font-size:20px; font-weight:700;"><i class="bi bi-playstation"></i> Sony</span>
    <span style="font-size:20px; font-weight:700;"><i class="bi bi-nintendo-switch"></i> Nintendo</span>
  </div>
</section>

<!-- PROMO CALL TO ACTION BANNER -->
<section class="promo-cta">
  <h2>ƯU ĐÃI CHỈ CÓ TẠI BINCOM APP</h2>
  <p>Tải ứng dụng ngay hôm nay để nhận mã giảm giá 100K cho đơn hàng đầu tiên.</p>
  <div style="display:flex; justify-content:center; gap:16px; flex-wrap:wrap;">
    <a href="#" class="btn-primary" style="background:#fff; color:var(--accent); box-shadow:none;">
      <i class="bi bi-apple"></i> App Store
    </a>
    <a href="#" class="btn-primary" style="background:#fff; color:var(--accent); box-shadow:none;">
      <i class="bi bi-play-fill"></i> Google Play
    </a>
  </div>
</section>

<!-- FEATURES STRIP (TGDD Trust factors) -->
<section class="features-strip">
  <div class="features-inner">
    <div class="feature-item">
      <div class="feature-icon"><i class="bi bi-truck"></i></div>
      <div class="feature-text">
        <strong>Giao hàng siêu tốc</strong>
        <span>Cam kết giao nhanh 2h</span>
      </div>
    </div>
    <div class="feature-item">
      <div class="feature-icon"><i class="bi bi-arrow-left-right"></i></div>
      <div class="feature-text">
        <strong>Lỗi là đổi mới</strong>
        <span>Đổi trả trong vòng 30 ngày</span>
      </div>
    </div>
    <div class="feature-item">
      <div class="feature-icon"><i class="bi bi-shield-check"></i></div>
      <div class="feature-text">
        <strong>Bảo hành chính hãng</strong>
        <span>Cam kết 100% chính hiệu</span>
      </div>
    </div>
    <div class="feature-item">
      <div class="feature-icon"><i class="bi bi-headphones"></i></div>
      <div class="feature-text">
        <strong>Hỗ trợ 24/7</strong>
        <span>Hotline chăm sóc tận tình</span>
      </div>
    </div>
  </div>
</section>

<!-- FLOATING CONTACT BUTTONS (TGDD Style Zalo/Hotline) -->
<div class="floating-contact-buttons">
  <a href="tel:18001234" class="float-btn" style="background:var(--accent); color:#fff;" title="Gọi Hotline">
    <i class="bi bi-telephone-fill"></i>
  </a>
  <button onclick="window.scrollTo({top: 0, behavior: 'smooth'})" class="float-btn" style="background:#fff; border:1px solid var(--border); color:var(--primary);" title="Lên đầu trang">
    <i class="bi bi-arrow-up-short"></i>
  </button>
</div>

<!-- HERO SLIDER SCRIPT -->
<script>
  let slideIndex = 0;
  const slides = document.getElementById('heroSlides');
  const totalSlides = document.querySelectorAll('.hero-slide').length;

  function showSlide(index) {
    if (totalSlides <= 0) return;
    if (index >= totalSlides) slideIndex = 0;
    else if (index < 0) slideIndex = totalSlides - 1;
    else slideIndex = index;

    if (slides) {
      slides.style.transform = `translateX(-${slideIndex * 100}%)`;
    }
  }

  function moveSlide(step) {
    showSlide(slideIndex + step);
  }

  function setSlide(index) {
    showSlide(index);
  }

  // Auto-play slide
  let slideTimer = setInterval(() => moveSlide(1), 5000);

  // Restart timer on interaction
  document.querySelector('.hero-slider')?.addEventListener('mouseenter', () => clearInterval(slideTimer));
  document.querySelector('.hero-slider')?.addEventListener('mouseleave', () => {
    clearInterval(slideTimer);
    slideTimer = setInterval(() => moveSlide(1), 5000);
  });

  // INNER SLIDER LOGIC FOR SLIDE 1
  let currentInnerSlide = 0;
  function showInnerSlide(index) {
    const innerSlides = document.querySelectorAll('.inner-slide');
    if (!innerSlides || innerSlides.length === 0) return;
    
    if (index >= innerSlides.length) {
      currentInnerSlide = 0;
    } else if (index < 0) {
      currentInnerSlide = innerSlides.length - 1;
    } else {
      currentInnerSlide = index;
    }
    
    innerSlides.forEach((slide, idx) => {
      if (idx === currentInnerSlide) {
        slide.classList.add('active');
      } else {
        slide.classList.remove('active');
      }
    });
  }

  window.changeInnerSlide = function(direction) {
    showInnerSlide(currentInnerSlide + direction);
  };

  let innerInterval = setInterval(() => {
    window.changeInnerSlide(1);
  }, 4000);

  const innerHeroSlider = document.getElementById('innerHeroSlider');
  if (innerHeroSlider) {
    innerHeroSlider.addEventListener('mouseenter', () => {
      clearInterval(innerInterval);
    });
    innerHeroSlider.addEventListener('mouseleave', () => {
      clearInterval(innerInterval);
      innerInterval = setInterval(() => {
        window.changeInnerSlide(1);
      }, 4000);
    });
  }

  // COUNTDOWN TIMER SCRIPT
  function startCountdown() {
    const hourEl = document.getElementById('timerHour');
    const minEl = document.getElementById('timerMin');
    const secEl = document.getElementById('timerSec');

    if (!hourEl || !minEl || !secEl) return;

    function update() {
      const now = new Date();
      const endOfDay = new Date();
      endOfDay.setHours(23, 59, 59, 999);

      const diff = endOfDay - now;
      if (diff <= 0) {
        hourEl.textContent = "00";
        minEl.textContent = "00";
        secEl.textContent = "00";
        return;
      }

      const hours = Math.floor(diff / (1000 * 60 * 60));
      const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
      const secs = Math.floor((diff % (1000 * 60)) / 1000);

      hourEl.textContent = String(hours).padStart(2, '0');
      minEl.textContent = String(mins).padStart(2, '0');
      secEl.textContent = String(secs).padStart(2, '0');
    }

    update();
    setInterval(update, 1000);
  }

  document.addEventListener('DOMContentLoaded', startCountdown);

  function scrollProductRow(btn, direction) {
    var wrapper = btn.closest('.product-scroll-wrapper');
    var row = wrapper.querySelector('.product-scroll-row');
    if (row) {
      var scrollAmount = row.clientWidth * 0.8;
      row.scrollBy({
        left: direction * scrollAmount,
        behavior: 'smooth'
      });
    }
  }
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
