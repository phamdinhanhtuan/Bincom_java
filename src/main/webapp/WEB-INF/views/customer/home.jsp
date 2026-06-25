<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="isHome" value="true" scope="request" />
<%-- ====================================================
     HOME PAGE — Bincom CellphoneS-style layout
     Spring MVC / Tomcat 9 / NetBeans compatible
     ==================================================== --%>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>
<h1 class="visually-hidden">Bincom - Điện thoại, Laptop, Phụ kiện chính hãng</h1>

<%-- ===== HERO SECTION ===== --%>
<div class="cps-hero">
  <div class="cps-hero-inner">

    <%-- COLUMN 1: LEFT VERTICAL MENU --%>
    <div class="cps-hero-menu">
      <ul class="cps-hero-menu-list">
        <c:forEach var="cat" items="${categories}">
          <c:if test="${cat.parent == null}">
            <li class="cps-side-menu-item">
              <a href="${pageContext.request.contextPath}/shop?categoryId=${cat.id}" title="${cat.name} chính hãng tại Bincom">
                <span class="cps-menu-icon">
                  <c:choose>
                    <c:when test="${cat.id==1}"><i class="bi bi-phone-fill"></i></c:when>
                    <c:when test="${cat.id==2}"><i class="bi bi-gem"></i></c:when>
                    <c:when test="${cat.id==3}"><i class="bi bi-house-heart-fill"></i></c:when>
                    <c:when test="${cat.id==4}"><i class="bi bi-book-fill"></i></c:when>
                    <c:when test="${cat.id==5}"><i class="bi bi-bicycle"></i></c:when>
                    <c:when test="${cat.id==6}"><i class="bi bi-magic"></i></c:when>
                    <c:otherwise><i class="bi bi-grid-fill"></i></c:otherwise>
                  </c:choose>
                </span>
                <span class="cps-menu-text">${cat.name}</span>
                <i class="bi bi-chevron-right"></i>
              </a>
            <div class="cps-side-submenu ${cat.id == 1 ? 'megamenu-wide' : ''}">
              <div class="cps-side-submenu-grid ${cat.id == 1 ? 'grid-4-cols' : ''}">
                <c:choose>
                  <c:when test="${cat.id==1}">
                    <div class="cps-side-col">
                      <div class="cps-side-title">Hãng điện thoại</div>
                      <div class="brand-badge-grid">
                        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Apple" class="brand-badge-card">iPhone</a>
                        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Samsung" class="brand-badge-card">Samsung</a>
                        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Oppo" class="brand-badge-card">Oppo</a>
                        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Xiaomi" class="brand-badge-card">Xiaomi</a>
                        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Realme" class="brand-badge-card">Realme</a>
                        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Vivo" class="brand-badge-card">Vivo</a>
                      </div>
                      <div class="cps-side-title" style="margin-top: 15px;">Mức giá</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&maxPrice=5000000" title="Dưới 5 triệu"><i class="bi bi-cash"></i> Dưới 5 triệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&minPrice=5000000&maxPrice=15000000" title="5 - 15 triệu"><i class="bi bi-cash"></i> 5 - 15 triệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&minPrice=15000000" title="Trên 15 triệu"><i class="bi bi-cash-stack"></i> Trên 15 triệu</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Điện thoại HOT 🔥</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=iPhone+16" title="iPhone 16 Pro Max"><i class="bi bi-fire text-danger"></i> iPhone 16 Pro Max</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=S24" title="Galaxy S24 Ultra"><i class="bi bi-phone"></i> Galaxy S24 Ultra</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Find" title="OPPO Find N3"><i class="bi bi-phone"></i> OPPO Find N3</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=14T" title="Xiaomi 14T Pro"><i class="bi bi-stars text-warning"></i> Xiaomi 14T Pro</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Redmi" title="Redmi Note 13 Pro"><i class="bi bi-phone"></i> Redmi Note 13 Pro</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Hãng máy tính bảng</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=iPad" title="iPad chính hãng"><i class="bi bi-tablet-landscape"></i> iPad (Apple)</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Tab" title="Samsung Galaxy Tab"><i class="bi bi-tablet-landscape"></i> Samsung Tab</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Pad" title="Xiaomi Pad"><i class="bi bi-tablet-landscape"></i> Xiaomi Pad</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Lenovo" title="Lenovo Tab"><i class="bi bi-tablet-landscape"></i> Lenovo Tab</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Tablet HOT 🔥</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=M4" title="iPad Pro M4"><i class="bi bi-fire text-danger"></i> iPad Pro M4</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Air" title="iPad Air M2"><i class="bi bi-tablet"></i> iPad Air M2</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=S9" title="Galaxy Tab S9"><i class="bi bi-tablet"></i> Galaxy Tab S9</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=SE" title="Redmi Pad SE"><i class="bi bi-stars text-warning"></i> Redmi Pad SE</a></li>
                      </ul>
                    </div>
                  </c:when>
                  
                  <c:when test="${cat.id==2}">
                    <div class="cps-side-col">
                      <div class="cps-side-title">Chọn sản phẩm</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2" title="Quần áo thời trang"><i class="bi bi-gender-ambiguous"></i> Quần áo</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2" title="Giày dép thời trang"><i class="bi bi-footprints"></i> Giày dép</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2" title="Trang sức phụ kiện"><i class="bi bi-gift"></i> Trang sức</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Thương hiệu</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2&keyword=Uniqlo" title="Uniqlo"><i class="bi bi-chevron-right"></i> Uniqlo</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2&keyword=Nike" title="Nike"><i class="bi bi-chevron-right"></i> Nike</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2&keyword=Adidas" title="Adidas"><i class="bi bi-chevron-right"></i> Adidas</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2&keyword=Levi" title="Levi's"><i class="bi bi-chevron-right"></i> Levi's</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Mức giá</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2&maxPrice=500000" title="Dưới 500K"><i class="bi bi-cash"></i> Dưới 500K</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2&minPrice=500000&maxPrice=2000000" title="500K - 2 triệu"><i class="bi bi-cash"></i> 500K - 2 triệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=2&minPrice=2000000" title="Trên 2 triệu"><i class="bi bi-cash-stack"></i> Trên 2 triệu</a></li>
                      </ul>
                    </div>
                  </c:when>

                  <c:when test="${cat.id==3}">
                    <div class="cps-side-col">
                      <div class="cps-side-title">Chọn thiết bị</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=3" title="Thiết bị nhà bếp"><i class="bi bi-fire"></i> Nhà bếp</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=3" title="Gia dụng thông minh"><i class="bi bi-cpu"></i> Gia dụng</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Thương hiệu</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=3&keyword=Sharp" title="Sharp"><i class="bi bi-chevron-right"></i> Sharp</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=3&keyword=Xiaomi" title="Xiaomi"><i class="bi bi-chevron-right"></i> Xiaomi</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=3&keyword=Philips" title="Philips"><i class="bi bi-chevron-right"></i> Philips</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Mức giá</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=3&maxPrice=1000000" title="Dưới 1 triệu"><i class="bi bi-cash"></i> Dưới 1 triệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=3&minPrice=1000000&maxPrice=5000000" title="1 - 5 triệu"><i class="bi bi-cash"></i> 1 - 5 triệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=3&minPrice=5000000" title="Trên 5 triệu"><i class="bi bi-cash-stack"></i> Trên 5 triệu</a></li>
                      </ul>
                    </div>
                  </c:when>

                  <c:when test="${cat.id==4}">
                    <div class="cps-side-col">
                      <div class="cps-side-title">Chọn loại sách</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=4" title="Sách kỹ năng cuộc sống"><i class="bi bi-journal-text"></i> Sách kỹ năng</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=4" title="Thiết bị văn phòng phẩm"><i class="bi bi-printer"></i> Thiết bị văn phòng</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Nhà xuất bản</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=4&keyword=Tre" title="NXB Trẻ"><i class="bi bi-chevron-right"></i> NXB Trẻ</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=4&keyword=NhaNam" title="Nhã Nam"><i class="bi bi-chevron-right"></i> Nhã Nam</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=4&keyword=KimDong" title="Kim Đồng"><i class="bi bi-chevron-right"></i> Kim Đồng</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Mức giá</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=4&maxPrice=100000" title="Dưới 100K"><i class="bi bi-cash"></i> Dưới 100K</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=4&minPrice=100000&maxPrice=500000" title="100K - 500K"><i class="bi bi-cash"></i> 100K - 500K</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=4&minPrice=500000" title="Trên 500K"><i class="bi bi-cash-stack"></i> Trên 500K</a></li>
                      </ul>
                    </div>
                  </c:when>

                  <c:when test="${cat.id==5}">
                    <div class="cps-side-col">
                      <div class="cps-side-title">Chọn dụng cụ</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=5" title="Dụng cụ thể thao chính hãng"><i class="bi bi-trophy"></i> Dụng cụ thể thao</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=5" title="Đồ cắm trại dã ngoại"><i class="bi bi-compass"></i> Cắm trại &amp; Du lịch</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Thương hiệu</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=5&keyword=Giant" title="Giant"><i class="bi bi-chevron-right"></i> Giant</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=5&keyword=Nike" title="Nike"><i class="bi bi-chevron-right"></i> Nike</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=5&keyword=Adidas" title="Adidas"><i class="bi bi-chevron-right"></i> Adidas</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Mức giá</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=5&maxPrice=500000" title="Dưới 500K"><i class="bi bi-cash"></i> Dưới 500K</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=5&minPrice=500000&maxPrice=3000000" title="500K - 3 triệu"><i class="bi bi-cash"></i> 500K - 3 triệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=5&minPrice=3000000" title="Trên 3 triệu"><i class="bi bi-cash-stack"></i> Trên 3 triệu</a></li>
                      </ul>
                    </div>
                  </c:when>

                  <c:when test="${cat.id==6}">
                    <div class="cps-side-col">
                      <div class="cps-side-title">Chọn loại chăm sóc</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=6" title="Mỹ phẩm cao cấp"><i class="bi bi-magic"></i> Mỹ phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=6" title="Chăm sóc da mặt chuyên sâu"><i class="bi bi-heart-pulse"></i> Chăm sóc da</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Thương hiệu</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=6&keyword=Klairs" title="Klairs"><i class="bi bi-chevron-right"></i> Klairs</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=6&keyword=Anessa" title="Anessa"><i class="bi bi-chevron-right"></i> Anessa</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=6&keyword=L'Oreal" title="L'Oreal"><i class="bi bi-chevron-right"></i> L'Oreal</a></li>
                      </ul>
                    </div>
                    <div class="cps-side-col">
                      <div class="cps-side-title">Mức giá</div>
                      <ul>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=6&maxPrice=300000" title="Dưới 300K"><i class="bi bi-cash"></i> Dưới 300K</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=6&minPrice=300000&maxPrice=1000000" title="300K - 1 triệu"><i class="bi bi-cash"></i> 300K - 1 triệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop?categoryId=6&minPrice=1000000" title="Trên 1 triệu"><i class="bi bi-cash-stack"></i> Trên 1 triệu</a></li>
                      </ul>
                    </div>
                  </c:when>

                  <c:when test="${not empty cat.children}">
                    <div class="cps-side-col">
                      <div class="cps-side-title">Chọn loại sản phẩm</div>
                      <ul>
                        <c:forEach var="sub" items="${cat.children}">
                          <c:if test="${sub.active}">
                            <li>
                              <a href="${pageContext.request.contextPath}/shop?categoryId=${sub.id}" title="${sub.name} chính hãng">
                                <i class="bi bi-chevron-right"></i> ${sub.name}
                              </a>
                            </li>
                          </c:if>
                        </c:forEach>
                      </ul>
                    </div>
                  </c:when>
                </c:choose>
              </div>
            </div>
            </li>
          </c:if>
        </c:forEach>
        <li>
          <a href="${pageContext.request.contextPath}/about" title="Giới thiệu về Bincom">
            <span class="cps-menu-icon"><i class="bi bi-info-circle-fill"></i></span>
            <span class="cps-menu-text">Về Bincom</span>
            <i class="bi bi-chevron-right"></i>
          </a>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/contact" title="Liên hệ hỗ trợ Bincom">
            <span class="cps-menu-icon"><i class="bi bi-headset"></i></span>
            <span class="cps-menu-text">Hỗ trợ 24/7</span>
            <i class="bi bi-chevron-right"></i>
          </a>
        </li>
      </ul>
      
      <!-- Trust/Commitment banners to fill empty space -->
      <div class="cps-hero-commitments" style="margin-top:auto; padding: 4px 12px 2px 12px; border-top: 1px dashed var(--cps-gray-200);">
        <div style="font-size:8.5px; font-weight:700; color:var(--cps-gray-500); text-transform:uppercase; margin-bottom:2px; letter-spacing:0.5px;">Cam kết Bincom</div>
        <div style="display:flex; align-items:center; gap:6px; margin-bottom:2px;">
          <i class="bi bi-shield-check" style="color:var(--cps-teal); font-size:11px;"></i>
          <span style="font-size:10px; color:var(--cps-gray-700); font-weight:500;">Chính hãng 100%</span>
        </div>
        <div style="display:flex; align-items:center; gap:6px; margin-bottom:2px;">
          <i class="bi bi-truck" style="color:var(--cps-teal); font-size:11px;"></i>
          <span style="font-size:10px; color:var(--cps-gray-700); font-weight:500;">Freeship từ 500k</span>
        </div>
        <div style="display:flex; align-items:center; gap:6px; margin-bottom:1px;">
          <i class="bi bi-arrow-left-right" style="color:var(--cps-teal); font-size:11px;"></i>
          <span style="font-size:10px; color:var(--cps-gray-700); font-weight:500;">Đổi trả 30 ngày</span>
        </div>
      </div>
    </div>

    <%-- COLUMN 2: CENTER SLIDER --%>
    <div class="cps-hero-slider" id="cpsSlider">
      <div class="cps-hero-slides" id="cpsSlides">

        <div class="cps-hero-slide">
          <img src="${pageContext.request.contextPath}/resources/images/bincom_tech.png"
               alt="Điện thoại chính hãng giảm đến 30% tại Bincom"
               width="900" height="394"
               onerror="this.style.display='none'">
          <div class="cps-hero-slide-overlay">
            <div class="cps-hero-content">
              <span class="cps-hero-tag">Bincom Chính Hãng</span>
              <h2 class="cps-hero-title">Điện Thoại<br>Chính Hãng</h2>
              <p class="cps-hero-sub">iPhone, Samsung, OPPO — Giảm đến 30%</p>
              <a href="${pageContext.request.contextPath}/shop?categoryId=1"
                 class="cps-hero-btn" title="Mua điện thoại chính hãng tại Bincom">
                Mua ngay <i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>
        </div>

        <div class="cps-hero-slide">
          <img src="${pageContext.request.contextPath}/resources/images/bincom_fashion.png"
               alt="Thời trang xu hướng mới nhất tại Bincom"
               width="900" height="394"
               onerror="this.style.display='none'">
          <div class="cps-hero-slide-overlay">
            <div class="cps-hero-content">
              <span class="cps-hero-tag">Thời Trang Mùa Mới</span>
              <h2 class="cps-hero-title">Thời Trang<br>Xu Hướng</h2>
              <p class="cps-hero-sub">Bộ sưu tập mới — Trợ giá cực sâu</p>
              <a href="${pageContext.request.contextPath}/shop?categoryId=2"
                 class="cps-hero-btn" title="Thời trang phụ kiện tại Bincom">
                Khám phá <i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>
        </div>

        <div class="cps-hero-slide">
          <img src="${pageContext.request.contextPath}/resources/images/bincom_home.png"
               alt="Đồ gia dụng thông minh tại Bincom"
               width="900" height="394"
               onerror="this.style.display='none'">
          <div class="cps-hero-slide-overlay">
            <div class="cps-hero-content">
              <span class="cps-hero-tag">Smart Home</span>
              <h2 class="cps-hero-title">Gia Dụng<br>Thông Minh</h2>
              <p class="cps-hero-sub">Hệ sinh thái nhà thông minh — Freeship</p>
              <a href="${pageContext.request.contextPath}/shop?categoryId=3"
                 class="cps-hero-btn" title="Thiết bị gia đình thông minh tại Bincom">
                Khám phá <i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>
        </div>

      </div>
      <button class="cps-hero-nav prev" onclick="cpsSlide(-1)" aria-label="Slide trước">
        <i class="bi bi-chevron-left"></i>
      </button>
      <button class="cps-hero-nav next" onclick="cpsSlide(1)" aria-label="Slide tiếp theo">
        <i class="bi bi-chevron-right"></i>
      </button>
      <div class="cps-hero-dots" id="cpsDots">
        <span class="cps-hero-dot active" onclick="cpsGoTo(0)"></span>
        <span class="cps-hero-dot" onclick="cpsGoTo(1)"></span>
        <span class="cps-hero-dot" onclick="cpsGoTo(2)"></span>
      </div>
    </div>

    <%-- COLUMN 3: RIGHT SIDE PANEL (Smember style) --%>
    <div class="cps-hero-side">

      <!-- Promo Box 1 -->
      <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-promo-box banner-red">
        <div class="cps-promo-icon">🎓</div>
        <div class="cps-promo-info">
          <strong>Ưu đãi cho giáo dục</strong>
          <span>Đăng ký nhận ưu đãi Sinh viên</span>
        </div>
        <i class="bi bi-chevron-right"></i>
      </a>

      <!-- Promo Box 2 -->
      <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-promo-box banner-teal">
        <div class="cps-promo-icon">🔄</div>
        <div class="cps-promo-info">
          <strong>Thu cũ lên đời giá hời</strong>
          <span>Trợ giá đến 3 triệu đồng</span>
        </div>
        <i class="bi bi-chevron-right"></i>
      </a>

      <!-- Promo Box 3 -->
      <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="cps-promo-box banner-orange">
        <div class="cps-promo-icon">🏢</div>
        <div class="cps-promo-info">
          <strong>Khách hàng doanh nghiệp (B2B)</strong>
          <span>Chính sách ưu đãi đặc quyền</span>
        </div>
        <i class="bi bi-chevron-right"></i>
      </a>
    </div>

  </div>
</div>

<%-- ===== CATEGORY STRIP ===== --%>
<div class="cps-container">
  <div class="cps-cat-strip">
    <c:forEach var="cat" items="${categories}">
      <c:if test="${cat.parent == null}">
        <a href="${pageContext.request.contextPath}/shop?categoryId=${cat.id}"
           class="cps-cat-card" title="${cat.name} chính hãng tại Bincom">
        <div class="cps-cat-icon
          <c:choose>
            <c:when test="${cat.id==1}"> cps-icon-blue</c:when>
            <c:when test="${cat.id==2}"> cps-icon-purple</c:when>
            <c:when test="${cat.id==3}"> cps-icon-green</c:when>
            <c:when test="${cat.id==4}"> cps-icon-orange</c:when>
            <c:when test="${cat.id==5}"> cps-icon-teal</c:when>
            <c:otherwise> cps-icon-pink</c:otherwise>
          </c:choose>">
          <c:choose>
            <c:when test="${cat.id==1}"><i class="bi bi-phone-fill"></i></c:when>
            <c:when test="${cat.id==2}"><i class="bi bi-gem"></i></c:when>
            <c:when test="${cat.id==3}"><i class="bi bi-house-heart-fill"></i></c:when>
            <c:when test="${cat.id==4}"><i class="bi bi-book-fill"></i></c:when>
            <c:when test="${cat.id==5}"><i class="bi bi-bicycle"></i></c:when>
            <c:when test="${cat.id==6}"><i class="bi bi-magic"></i></c:when>
            <c:otherwise><i class="bi bi-grid"></i></c:otherwise>
          </c:choose>
        </div>
        <span>${cat.name}</span>
      </a>
      </c:if>
    </c:forEach>
  </div>
</div>

<%-- ===== FLASH SALE / DEAL SỐC ===== --%>
<div class="cps-container">
  <div class="cps-section">
    <div class="cps-section-head">
      <h2 class="cps-section-title">
        <i class="bi bi-lightning-charge-fill" style="color:var(--cps-red)"></i>
        GIÁ SỐC MỖI NGÀY
      </h2>
      <div style="display:flex;align-items:center;gap:12px;">
        <div style="display:flex;align-items:center;gap:6px;font-size:13px;color:var(--cps-gray-500);">
          Kết thúc trong
          <span class="cps-cd-block" id="cpsH">00</span>:
          <span class="cps-cd-block" id="cpsM">00</span>:
          <span class="cps-cd-block" id="cpsS">00</span>
        </div>
        <a href="${pageContext.request.contextPath}/shop?sort=price-asc"
           class="cps-section-more" title="Xem tất cả deal sốc">
          Xem tất cả <i class="bi bi-arrow-right"></i>
        </a>
      </div>
    </div>
    <div style="position:relative; margin: 0 -4px;">
      <!-- Navigation buttons -->
      <button class="cps-carousel-nav prev" onclick="event.stopPropagation();cpsScrollFlashSale(-1)" aria-label="Đầu danh sách" style="position:absolute; top:50%; transform:translateY(-50%); z-index:10;">
        <i class="bi bi-chevron-left"></i>
      </button>
      <button class="cps-carousel-nav next" onclick="event.stopPropagation();cpsScrollFlashSale(1)" aria-label="Cuối danh sách" style="position:absolute; top:50%; transform:translateY(-50%); z-index:10;">
        <i class="bi bi-chevron-right"></i>
      </button>

      <div class="cps-flashsale-track" id="cpsFlashSaleTrack">
        <c:forEach var="p" items="${featuredProducts}">
          <c:if test="${p.onSale}">
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <span class="cps-product-badge">
                  Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                </span>
                <span class="cps-product-badge-right">Trả góp 0%</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                
                <!-- Right-side specs overlay -->
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <c:choose>
                        <c:when test="${p.category.id == 1}">
                          <span class="cps-spec-tag"><i class="bi bi-cpu"></i> Snapdragon</span>
                          <span class="cps-spec-tag"><i class="bi bi-sd-card"></i> 8GB/256GB</span>
                        </c:when>
                        <c:when test="${p.category.id == 2}">
                          <span class="cps-spec-tag"><i class="bi bi-tag-fill"></i> Cotton</span>
                          <span class="cps-spec-tag"><i class="bi bi-wind"></i> Thoáng khí</span>
                        </c:when>
                        <c:when test="${p.category.id == 3}">
                          <span class="cps-spec-tag"><i class="bi bi-lightning-charge-fill"></i> Inverter</span>
                          <span class="cps-spec-tag"><i class="bi bi-check-circle"></i> Tiết kiệm</span>
                        </c:when>
                        <c:otherwise>
                          <span class="cps-spec-tag"><i class="bi bi-patch-check"></i> Chính hãng</span>
                          <span class="cps-spec-tag"><i class="bi bi-shield-check"></i> 12 tháng</span>
                        </c:otherwise>
                      </c:choose>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <span class="cps-product-price-old">
                    <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                  </span>
                </div>
                
                <div class="cps-product-smember-banner">
                  Bincom Member giảm thêm đến 1%
                </div>
                
                <div class="cps-product-promo-label">
                  Trả góp 0% - 0đ phụ phí nhận máy ngay
                </div>
                
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value">
                    <i class="bi bi-star-fill text-warning"></i> 4.9
                  </span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">
                    Yêu thích <i class="bi bi-heart"></i>
                  </span>
                </div>
                
                <button class="cps-product-add-btn"
                        onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${empty featuredProducts}">
          <p style="text-align:center;padding:40px;color:var(--cps-gray-500);width:100%;">
            Chưa có sản phẩm khuyến mãi.
          </p>
        </c:if>
      </div>
    </div>
  </div>
</div>

<%-- ===== ĐIỆN THOẠI & MÁY TÍNH BẢNG SHOWCASE ===== --%>
<div class="cps-container">
  <div class="cps-showcase-section">
    <div class="cps-showcase-header">
      <div class="cps-showcase-tabs">
        <button type="button" class="cps-tab-link active" onclick="switchShowcaseTab(this, 0)" data-banner-bg="linear-gradient(135deg, #0d9488, #0f766e)" data-banner-title="Bincom Tech Hub" data-banner-desc="Điện thoại chính hãng">ĐIỆN THOẠI</button>
        <button type="button" class="cps-tab-link" onclick="switchShowcaseTab(this, 1)" data-banner-bg="linear-gradient(135deg, #0284c7, #0369a1)" data-banner-title="Tablet Cực Chất" data-banner-desc="Trải nghiệm màn hình lớn đa tác vụ">MÁY TÍNH BẢNG</button>
      </div>
      <div class="cps-showcase-tags">
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-tag-link">Điện thoại chơi game</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-tag-link">Điện thoại pin trâu</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-tag-link">Điện thoại 5G</a>
      </div>
      <div class="cps-showcase-brands">
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Apple" class="cps-brand-link">Apple</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Samsung" class="cps-brand-link">Samsung</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Xiaomi" class="cps-brand-link">Xiaomi</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=OPPO" class="cps-brand-link">OPPO</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-brand-link view-all">Xem tất cả <i class="bi bi-chevron-right"></i></a>
      </div>
    </div>

    <div class="cps-showcase-body">
      <%-- Left Promo Banner --%>
      <div class="cps-showcase-banner">
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Samsung">
          <img src="${pageContext.request.contextPath}/resources/images/bincom_tech.png"
               alt="Công nghệ chính hãng tại Bincom"
               onerror="this.style.background='linear-gradient(135deg, #0d9488, #0f766e)'">
          <div class="cps-banner-content">
            <h3>Bincom Tech Hub</h3>
            <p>Điện thoại chính hãng</p>
            <span class="cps-banner-btn">Mua ngay</span>
          </div>
        </a>
      </div>

      <%-- Product Grid (4 items of Category 1 - Phones) --%>
      <div class="cps-product-grid showcase-grid">
        <c:set var="phoneCount" value="0"/>
        <c:forEach var="p" items="${latestProducts}">
          <c:if test="${(p.category.id == 1 || (p.category.parent != null && p.category.parent.id == 1)) && (p.category.name == 'Điện thoại' || (p.category.name == 'Điện tử' && !(fn:containsIgnoreCase(p.name, 'tablet') || fn:containsIgnoreCase(p.name, 'ipad') || fn:containsIgnoreCase(p.name, 'máy tính bảng') || fn:containsIgnoreCase(p.name, 'tab') || fn:containsIgnoreCase(p.name, 'laptop') || fn:containsIgnoreCase(p.name, 'macbook') || fn:containsIgnoreCase(p.name, 'màn hình') || fn:containsIgnoreCase(p.name, 'monitor')))) && phoneCount < 4}">
            <c:set var="phoneCount" value="${phoneCount + 1}"/>
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <c:if test="${p.onSale}">
                  <span class="cps-product-badge">
                    Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
                <span class="cps-product-badge-right">Trả góp 0%</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-cpu"></i> Snapdragon</span>
                      <span class="cps-spec-tag"><i class="bi bi-sd-card"></i> 8GB/256GB</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <c:if test="${p.onSale}">
                    <span class="cps-product-price-old">
                      <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </span>
                  </c:if>
                </div>
                <div class="cps-product-smember-banner">Bincom Member giảm thêm đến 1%</div>
                <div class="cps-product-promo-label">Trả góp 0% - 0đ phụ phí</div>
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value"><i class="bi bi-star-fill text-warning"></i> 4.9</span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">Yêu thích <i class="bi bi-heart"></i></span>
                </div>
                <button class="cps-product-add-btn" onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${phoneCount == 0}">
          <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
            Chưa có sản phẩm Điện thoại.
          </p>
        </c:if>
      </div>

      <%-- Product Grid (4 items of Category 1 - Tablets) --%>
      <div class="cps-product-grid showcase-grid" style="display:none;">
        <c:set var="tabletCount" value="0"/>
        <c:forEach var="p" items="${latestProducts}">
          <c:set var="prodCatName" value="${fn:toLowerCase(p.category.name)}" />
          <c:if test="${(p.category.id == 16 || p.category.id == 1 || (p.category.parent != null && (p.category.parent.id == 1 || p.category.parent.id == 16))) && (prodCatName == 'máy tính bảng' || prodCatName == 'tablet' || prodCatName == 'ipad' || (prodCatName == 'điện tử' && (fn:containsIgnoreCase(p.name, 'tablet') || fn:containsIgnoreCase(p.name, 'ipad') || fn:containsIgnoreCase(p.name, 'máy tính bảng') || fn:containsIgnoreCase(p.name, 'tab')))) && tabletCount < 4}">
            <c:set var="tabletCount" value="${tabletCount + 1}"/>
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <c:if test="${p.onSale}">
                  <span class="cps-product-badge">
                    Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
                <span class="cps-product-badge-right">Màn hình lớn</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-cpu"></i> Octa-Core</span>
                      <span class="cps-spec-tag"><i class="bi bi-sd-card"></i> 4GB/64GB</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <c:if test="${p.onSale}">
                    <span class="cps-product-price-old">
                      <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </span>
                  </c:if>
                </div>
                <div class="cps-product-smember-banner">Bincom Member giảm thêm đến 1%</div>
                <div class="cps-product-promo-label">Trả góp 0% - 0đ phụ phí</div>
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value"><i class="bi bi-star-fill text-warning"></i> 4.9</span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">Yêu thích <i class="bi bi-heart"></i></span>
                </div>
                <button class="cps-product-add-btn" onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${tabletCount == 0}">
          <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
            Chưa có sản phẩm Máy tính bảng.
          </p>
        </c:if>
      </div>

    </div>
  </div>
</div>

<%-- ===== LAPTOP & MÀN HÌNH SHOWCASE ===== --%>
<div class="cps-container">
  <div class="cps-showcase-section">
    <div class="cps-showcase-header">
      <div class="cps-showcase-tabs">
        <button type="button" class="cps-tab-link active" onclick="switchShowcaseTab(this, 0)" data-banner-bg="linear-gradient(135deg, #4f46e5, #4338ca)" data-banner-title="Laptop Workstation" data-banner-desc="Hiệu năng đỉnh cao">LAPTOP</button>
        <button type="button" class="cps-tab-link" onclick="switchShowcaseTab(this, 1)" data-banner-bg="linear-gradient(135deg, #0d9488, #0f766e)" data-banner-title="Màn Hình Sắc Nét" data-banner-desc="Hình ảnh chân thực 165Hz">MÀN HÌNH MÁY TÍNH</button>
      </div>
      <div class="cps-showcase-tags">
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-tag-link">Văn phòng</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-tag-link">Gaming</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-tag-link">Mỏng nhẹ</a>
      </div>
      <div class="cps-showcase-brands">
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Asus" class="cps-brand-link">ASUS</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Apple" class="cps-brand-link">MacBook</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Lenovo" class="cps-brand-link">Lenovo</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1&keyword=Dell" class="cps-brand-link">Dell</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cps-brand-link view-all">Xem tất cả <i class="bi bi-chevron-right"></i></a>
      </div>
    </div>

    <div class="cps-showcase-body">
      <%-- Left Promo Banner --%>
      <div class="cps-showcase-banner laptop-banner" id="techShowcaseBanner" style="background: linear-gradient(135deg, #4f46e5, #4338ca);">
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" id="techShowcaseBannerLink">
          <img src="${pageContext.request.contextPath}/resources/images/bincom_tech.png"
               alt="Laptop chính hãng tại Bincom"
               onerror="this.style.background='transparent'">
          <div class="cps-banner-content">
            <h3 id="techShowcaseBannerTitle">Laptop Workstation</h3>
            <p id="techShowcaseBannerDesc">Hiệu năng đỉnh cao</p>
            <span class="cps-banner-btn">Khám phá</span>
          </div>
        </a>
      </div>

      <%-- Laptop Tab Grid --%>
      <div class="cps-product-grid showcase-grid tech-tab-content" id="techLaptopGrid">
        <c:set var="laptopCount" value="0"/>
        <c:forEach var="p" items="${latestProducts}">
          <c:if test="${(p.category.id == 1 || (p.category.parent != null && p.category.parent.id == 1)) && (p.category.name == 'Laptop' || p.category.name == 'MacBook' || (p.category.name == 'Điện tử' && (fn:containsIgnoreCase(p.name, 'laptop') || fn:containsIgnoreCase(p.name, 'macbook')))) && laptopCount < 4}">
            <c:set var="laptopCount" value="${laptopCount + 1}"/>
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <c:if test="${p.onSale}">
                  <span class="cps-product-badge">
                    Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
                <span class="cps-product-badge-right">Trả góp 0%</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-cpu"></i> Intel Core i5</span>
                      <span class="cps-spec-tag"><i class="bi bi-sd-card"></i> 16GB/512GB</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <c:if test="${p.onSale}">
                    <span class="cps-product-price-old">
                      <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </span>
                  </c:if>
                </div>
                <div class="cps-product-smember-banner">Bincom Member giảm thêm đến 1%</div>
                <div class="cps-product-promo-label">Trả góp 0% - 0đ phụ phí</div>
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value"><i class="bi bi-star-fill text-warning"></i> 4.9</span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">Yêu thích <i class="bi bi-heart"></i></span>
                </div>
                <button class="cps-product-add-btn" onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${laptopCount == 0}">
          <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
            Chưa có sản phẩm Laptop.
          </p>
        </c:if>
      </div>

      <%-- Monitor Tab Grid --%>
      <div class="cps-product-grid showcase-grid tech-tab-content" id="techMonitorGrid" style="display:none;">
        <c:set var="monitorCount" value="0"/>
        <c:forEach var="p" items="${latestProducts}">
          <c:if test="${(p.category.id == 1 || (p.category.parent != null && p.category.parent.id == 1)) && (p.category.name == 'Màn hình' || p.category.name == 'Màn hình máy tính' || p.category.name == 'Monitor' || (p.category.name == 'Điện tử' && (fn:containsIgnoreCase(p.name, 'màn hình') || fn:containsIgnoreCase(p.name, 'monitor')))) && monitorCount < 4}">
            <c:set var="monitorCount" value="${monitorCount + 1}"/>
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <c:if test="${p.onSale}">
                  <span class="cps-product-badge">
                    Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
                <span class="cps-product-badge-right">Trả góp 0%</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-aspect-ratio"></i> IPS FHD</span>
                      <span class="cps-spec-tag"><i class="bi bi-lightning-charge"></i> 75Hz - 165Hz</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <c:if test="${p.onSale}">
                    <span class="cps-product-price-old">
                      <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </span>
                  </c:if>
                </div>
                <div class="cps-product-smember-banner">Bincom Member giảm thêm đến 1%</div>
                <div class="cps-product-promo-label">Trả góp 0% - 0đ phụ phí</div>
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value"><i class="bi bi-star-fill text-warning"></i> 4.9</span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">Yêu thích <i class="bi bi-heart"></i></span>
                </div>
                <button class="cps-product-add-btn" onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${monitorCount == 0}">
          <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
            Chưa có sản phẩm Màn hình.
          </p>
        </c:if>
      </div>

    </div>
  </div>
</div>

<%-- ===== THỜI TRANG & PHỤ KIỆN SHOWCASE ===== --%>
<div class="cps-container">
  <div class="cps-showcase-section">
    <div class="cps-showcase-header">
      <div class="cps-showcase-tabs">
        <button type="button" class="cps-tab-link active" onclick="switchShowcaseTab(this, 0)" data-banner-bg="linear-gradient(135deg, #db2777, #9d174d)" data-banner-title="Bincom Fashion" data-banner-desc="Đón đầu xu hướng thời trang mới">THỜI TRANG</button>
        <button type="button" class="cps-tab-link" onclick="switchShowcaseTab(this, 1)" data-banner-bg="linear-gradient(135deg, #7c3aed, #5b21b6)" data-banner-title="Phụ Kiện Thời Trang" data-banner-desc="Điểm nhấn cá tính của riêng bạn">PHỤ KIỆN</button>
      </div>
      <div class="cps-showcase-tags">
        <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="cps-tag-link">Xu hướng hè 2026</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="cps-tag-link">Giày dép</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="cps-tag-link">Túi xách</a>
      </div>
      <div class="cps-showcase-brands">
        <a href="${pageContext.request.contextPath}/shop?categoryId=2&keyword=Nike" class="cps-brand-link">Nike</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=2&keyword=Adidas" class="cps-brand-link">Adidas</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=2&keyword=Uniqlo" class="cps-brand-link">Uniqlo</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="cps-brand-link view-all">Xem tất cả <i class="bi bi-chevron-right"></i></a>
      </div>
    </div>

    <div class="cps-showcase-body">
      <%-- Left Promo Banner --%>
      <div class="cps-showcase-banner">
        <a href="${pageContext.request.contextPath}/shop?categoryId=2">
          <img src="${pageContext.request.contextPath}/resources/images/bincom_fashion.png"
               alt="Thời trang cao cấp tại Bincom"
               onerror="this.style.background='linear-gradient(135deg, #db2777, #9d174d)'">
          <div class="cps-banner-content">
            <h3>Bincom Fashion</h3>
            <p>Đón đầu xu hướng thời trang mới</p>
            <span class="cps-banner-btn">Khám phá</span>
          </div>
        </a>
      </div>

      <%-- Product Grid (4 items of Category 2 - Clothing) --%>
      <div class="cps-product-grid showcase-grid">
        <c:set var="fashionCount" value="0"/>
        <c:forEach var="p" items="${latestProducts}">
          <c:if test="${(p.category.id == 2 || (p.category.parent != null && p.category.parent.id == 2)) && (p.category.name == 'Quần áo' || (p.category.name == 'Thời trang' && !(fn:containsIgnoreCase(p.name, 'giày') || fn:containsIgnoreCase(p.name, 'kính') || fn:containsIgnoreCase(p.name, 'ví') || fn:containsIgnoreCase(p.name, 'túi') || fn:containsIgnoreCase(p.name, 'phụ kiện') || fn:containsIgnoreCase(p.name, 'đồng hồ') || fn:containsIgnoreCase(p.name, 'dây nịt') || fn:containsIgnoreCase(p.name, 'thắt lưng') || fn:containsIgnoreCase(p.name, 'dép')))) && fashionCount < 4}">
            <c:set var="fashionCount" value="${fashionCount + 1}"/>
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <c:if test="${p.onSale}">
                  <span class="cps-product-badge">
                    Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
                <span class="cps-product-badge-right">Hàng mới về</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-patch-check"></i> Chính hãng</span>
                      <span class="cps-spec-tag"><i class="bi bi-arrow-repeat"></i> Đổi trả 7 ngày</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <c:if test="${p.onSale}">
                    <span class="cps-product-price-old">
                      <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </span>
                  </c:if>
                </div>
                <div class="cps-product-smember-banner">Bincom Member giảm thêm đến 1%</div>
                <div class="cps-product-promo-label">Hoàn tiền 100% nếu phát hiện giả</div>
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value"><i class="bi bi-star-fill text-warning"></i> 4.9</span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">Yêu thích <i class="bi bi-heart"></i></span>
                </div>
                <button class="cps-product-add-btn" onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${fashionCount == 0}">
          <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
            Chưa có sản phẩm Thời trang.
          </p>
        </c:if>
      </div>

      <%-- Product Grid (4 items of Category 2 - Accessories) --%>
      <div class="cps-product-grid showcase-grid" style="display:none;">
        <c:set var="accessoryCount" value="0"/>
        <c:forEach var="p" items="${latestProducts}">
          <c:if test="${(p.category.id == 2 || (p.category.parent != null && p.category.parent.id == 2)) && (p.category.name == 'Phụ kiện' || p.category.name == 'Giày' || p.category.name == 'Giày dép' || p.category.name == 'Túi xách' || (p.category.name == 'Thời trang' && (fn:containsIgnoreCase(p.name, 'giày') || fn:containsIgnoreCase(p.name, 'kính') || fn:containsIgnoreCase(p.name, 'ví') || fn:containsIgnoreCase(p.name, 'túi') || fn:containsIgnoreCase(p.name, 'phụ kiện') || fn:containsIgnoreCase(p.name, 'đồng hồ') || fn:containsIgnoreCase(p.name, 'dây nịt') || fn:containsIgnoreCase(p.name, 'thắt lưng') || fn:containsIgnoreCase(p.name, 'dép')))) && accessoryCount < 4}">
            <c:set var="accessoryCount" value="${accessoryCount + 1}"/>
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <c:if test="${p.onSale}">
                  <span class="cps-product-badge">
                    Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
                <span class="cps-product-badge-right">Hàng tuyển chọn</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-tag"></i> Phụ kiện hot</span>
                      <span class="cps-spec-tag"><i class="bi bi-shield-check"></i> Đổi trả 7 ngày</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <c:if test="${p.onSale}">
                    <span class="cps-product-price-old">
                      <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </span>
                  </c:if>
                </div>
                <div class="cps-product-smember-banner">Bincom Member giảm thêm đến 1%</div>
                <div class="cps-product-promo-label">Đảm bảo hàng chính hãng 100%</div>
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value"><i class="bi bi-star-fill text-warning"></i> 4.9</span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">Yêu thích <i class="bi bi-heart"></i></span>
                </div>
                <button class="cps-product-add-btn" onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${accessoryCount == 0}">
          <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
            Chưa có sản phẩm Phụ kiện.
          </p>
        </c:if>
      </div>

    </div>
  </div>
</div>

<%-- ===== ĐỒ DÙNG GIA ĐÌNH & GIA DỤNG SHOWCASE ===== --%>
<div class="cps-container">
  <div class="cps-showcase-section">
    <div class="cps-showcase-header">
      <div class="cps-showcase-tabs">
        <button type="button" class="cps-tab-link active" onclick="switchShowcaseTab(this, 0)" data-banner-bg="linear-gradient(135deg, #059669, #047857)" data-banner-title="Bincom Smart Home" data-banner-desc="Gia dụng thông minh & Đồ dùng tiện ích">ĐỒ DÙNG GIA ĐÌNH</button>
        <button type="button" class="cps-tab-link" onclick="switchShowcaseTab(this, 1)" data-banner-bg="linear-gradient(135deg, #0891b2, #0e7490)" data-banner-title="Thiết Bị Gia Dụng" data-banner-desc="Hiện đại, tiết kiệm năng lượng">THIẾT BỊ GIA DỤNG</button>
      </div>
      <div class="cps-showcase-tags">
        <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="cps-tag-link">Máy hút bụi</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="cps-tag-link">Đồ nhà bếp</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="cps-tag-link">Quạt thông minh</a>
      </div>
      <div class="cps-showcase-brands">
        <a href="${pageContext.request.contextPath}/shop?categoryId=3&keyword=Sunhouse" class="cps-brand-link">Sunhouse</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=3&keyword=Philips" class="cps-brand-link">Philips</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=3&keyword=Lock" class="cps-brand-link">Lock&Lock</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="cps-brand-link view-all">Xem tất cả <i class="bi bi-chevron-right"></i></a>
      </div>
    </div>

    <div class="cps-showcase-body">
      <%-- Left Promo Banner --%>
      <div class="cps-showcase-banner">
        <a href="${pageContext.request.contextPath}/shop?categoryId=3">
          <img src="${pageContext.request.contextPath}/resources/images/bincom_home.png"
               alt="Đồ gia dụng thông minh tại Bincom"
               onerror="this.style.background='linear-gradient(135deg, #059669, #047857)'">
          <div class="cps-banner-content">
            <h3>Bincom Smart Home</h3>
            <p>Gia dụng thông minh & Đồ dùng tiện ích</p>
            <span class="cps-banner-btn">Mua ngay</span>
          </div>
        </a>
      </div>

      <%-- Product Grid (4 items of Category 3 - Household items) --%>
      <div class="cps-product-grid showcase-grid">
        <c:set var="homeCount" value="0"/>
        <c:forEach var="p" items="${latestProducts}">
          <c:if test="${(p.category.id == 3 || (p.category.parent != null && p.category.parent.id == 3)) && (p.category.name == 'Đồ dùng gia đình' || (p.category.name == 'Gia dụng' && !(fn:containsIgnoreCase(p.name, 'máy') || fn:containsIgnoreCase(p.name, 'nồi') || fn:containsIgnoreCase(p.name, 'quạt') || fn:containsIgnoreCase(p.name, 'lò') || fn:containsIgnoreCase(p.name, 'bếp') || fn:containsIgnoreCase(p.name, 'robot') || fn:containsIgnoreCase(p.name, 'lọc') || fn:containsIgnoreCase(p.name, 'gia dụng') || fn:containsIgnoreCase(p.name, 'thiết bị')))) && homeCount < 4}">
            <c:set var="homeCount" value="${homeCount + 1}"/>
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <c:if test="${p.onSale}">
                  <span class="cps-product-badge">
                    Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
                <span class="cps-product-badge-right">Hàng tiện ích</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-house"></i> Tiện dụng</span>
                      <span class="cps-spec-tag"><i class="bi bi-shield-check"></i> An toàn cao</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <c:if test="${p.onSale}">
                    <span class="cps-product-price-old">
                      <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </span>
                  </c:if>
                </div>
                <div class="cps-product-smember-banner">Bincom Member giảm thêm đến 1%</div>
                <div class="cps-product-promo-label">Độ bền vượt trội chính hãng</div>
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value"><i class="bi bi-star-fill text-warning"></i> 4.9</span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">Yêu thích <i class="bi bi-heart"></i></span>
                </div>
                <button class="cps-product-add-btn" onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${homeCount == 0}">
          <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
            Chưa có sản phẩm Đồ dùng gia đình.
          </p>
        </c:if>
      </div>

      <%-- Product Grid (4 items of Category 3 - Appliances) --%>
      <div class="cps-product-grid showcase-grid" style="display:none;">
        <c:set var="applianceCount" value="0"/>
        <c:forEach var="p" items="${latestProducts}">
          <c:if test="${(p.category.id == 3 || (p.category.parent != null && p.category.parent.id == 3)) && (p.category.name == 'Thiết bị gia dụng' || (p.category.name == 'Gia dụng' && (fn:containsIgnoreCase(p.name, 'máy') || fn:containsIgnoreCase(p.name, 'nồi') || fn:containsIgnoreCase(p.name, 'quạt') || fn:containsIgnoreCase(p.name, 'lò') || fn:containsIgnoreCase(p.name, 'bếp') || fn:containsIgnoreCase(p.name, 'robot') || fn:containsIgnoreCase(p.name, 'lọc') || fn:containsIgnoreCase(p.name, 'gia dụng') || fn:containsIgnoreCase(p.name, 'thiết bị')))) && applianceCount < 4}">
            <c:set var="applianceCount" value="${applianceCount + 1}"/>
            <div class="cps-product-card" data-id="${p.id}"
                 onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
                 role="article" aria-label="${p.name}">
              <div class="cps-product-thumb">
                <c:if test="${p.onSale}">
                  <span class="cps-product-badge">
                    Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
                  </span>
                </c:if>
                <span class="cps-product-badge-right">Tiết kiệm điện</span>
                <c:choose>
                  <c:when test="${not empty p.thumbnailUrl}">
                    <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                         alt="${p.name} — Mua chính hãng tại Bincom"
                         loading="lazy" width="200" height="200"
                         onerror="this.src='https://placehold.co/200x200?text=Bincom'">
                  </c:when>
                  <c:otherwise>
                    <img src="https://placehold.co/200x200?text=${p.name}"
                         alt="${p.name}" loading="lazy" width="200" height="200">
                  </c:otherwise>
                </c:choose>
                <div class="cps-product-specs-overlay">
                  <c:choose>
                    <c:when test="${not empty p.shortDescription}">
                      <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                        <span class="cps-spec-tag">${fn:trim(spec)}</span>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-lightning-charge-fill"></i> Inverter</span>
                      <span class="cps-spec-tag"><i class="bi bi-shield-check"></i> Bảo hành 2 năm</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="cps-product-body">
                <h3 class="cps-product-name">
                  <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                     title="${p.name} giá tốt tại Bincom">${p.name}</a>
                </h3>
                <div class="cps-product-price-row">
                  <span class="cps-product-price">
                    <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
                  </span>
                  <c:if test="${p.onSale}">
                    <span class="cps-product-price-old">
                      <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </span>
                  </c:if>
                </div>
                <div class="cps-product-smember-banner">Bincom Member giảm thêm đến 1%</div>
                <div class="cps-product-promo-label">Miễn phí giao hàng & lắp đặt nhanh</div>
                <div class="cps-product-bottom-row">
                  <span class="cps-product-rating-value"><i class="bi bi-star-fill text-warning"></i> 4.9</span>
                  <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">Yêu thích <i class="bi bi-heart"></i></span>
                </div>
                <button class="cps-product-add-btn" onclick="event.stopPropagation();addToCart(${p.id},this)">
                  <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                </button>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <c:if test="${applianceCount == 0}">
          <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
            Chưa có sản phẩm Thiết bị gia dụng.
          </p>
        </c:if>
      </div>

    </div>
  </div>
</div>

<%-- ===== DANH MỤC GỢI Ý MUA SẮM ===== --%>
<div class="cps-container">
  <div class="cps-accessories-section">
    <div class="cps-accessories-header">
      <h2>DANH MỤC GỢI Ý MUA SẮM</h2>
      <a href="${pageContext.request.contextPath}/shop" class="cps-acc-view-all">Xem tất cả <i class="bi bi-arrow-right"></i></a>
    </div>

    <div class="cps-accessories-grid">
      <%-- Điện tử --%>
      <a href="${pageContext.request.contextPath}/shop?categoryId=10" class="cps-acc-card" title="Tai nghe & Loa">
        <div class="cps-acc-icon">🎧</div>
        <span class="cps-acc-title">Tai nghe & Loa</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=8" class="cps-acc-card" title="Laptop & MacBook">
        <div class="cps-acc-icon">💻</div>
        <span class="cps-acc-title">Laptop & MacBook</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=9" class="cps-acc-card" title="Màn hình máy tính">
        <div class="cps-acc-icon">🖥️</div>
        <span class="cps-acc-title">Màn hình máy tính</span>
      </a>

      <%-- Thời trang --%>
      <a href="${pageContext.request.contextPath}/shop?categoryId=12" class="cps-acc-card" title="Giày thể thao">
        <div class="cps-acc-icon">👟</div>
        <span class="cps-acc-title">Giày thể thao</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=11" class="cps-acc-card" title="Áo thun & Áo khoác">
        <div class="cps-acc-icon">👕</div>
        <span class="cps-acc-title">Áo thun & Áo khoác</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=11&keyword=Váy" class="cps-acc-card" title="Váy thời trang">
        <div class="cps-acc-icon">👗</div>
        <span class="cps-acc-title">Váy thời trang</span>
      </a>

      <%-- Gia dụng --%>
      <a href="${pageContext.request.contextPath}/shop?categoryId=15&keyword=Nồi" class="cps-acc-card" title="Nồi cơm điện">
        <div class="cps-acc-icon">🍚</div>
        <span class="cps-acc-title">Nồi cơm điện</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=15&keyword=Quạt" class="cps-acc-card" title="Quạt thông minh">
        <div class="cps-acc-icon">🍃</div>
        <span class="cps-acc-title">Quạt thông minh</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=15&keyword=Robot" class="cps-acc-card" title="Robot hút bụi">
        <div class="cps-acc-icon">🧹</div>
        <span class="cps-acc-title">Robot hút bụi</span>
      </a>

      <%-- Sách --%>
      <a href="${pageContext.request.contextPath}/shop?categoryId=4&keyword=Sách" class="cps-acc-card" title="Sách kỹ năng">
        <div class="cps-acc-icon">📖</div>
        <span class="cps-acc-title">Sách kỹ năng</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=4&keyword=Vẽ" class="cps-acc-card" title="Dụng cụ vẽ">
        <div class="cps-acc-icon">🎨</div>
        <span class="cps-acc-title">Dụng cụ vẽ</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=4" class="cps-acc-card" title="Văn phòng phẩm">
        <div class="cps-acc-icon">✏️</div>
        <span class="cps-acc-title">Văn phòng phẩm</span>
      </a>

      <%-- Thể thao --%>
      <a href="${pageContext.request.contextPath}/shop?categoryId=5&keyword=Xe" class="cps-acc-card" title="Xe đạp địa hình">
        <div class="cps-acc-icon">🚲</div>
        <span class="cps-acc-title">Xe đạp địa hình</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=5&keyword=Tạ" class="cps-acc-card" title="Tạ tay tại nhà">
        <div class="cps-acc-icon">🏋️</div>
        <span class="cps-acc-title">Tạ tay tại nhà</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=5" class="cps-acc-card" title="Dụng cụ thể thao">
        <div class="cps-acc-icon">⚽</div>
        <span class="cps-acc-title">Dụng cụ thể thao</span>
      </a>

      <%-- Mỹ phẩm --%>
      <a href="${pageContext.request.contextPath}/shop?categoryId=6&keyword=Serum" class="cps-acc-card" title="Serum dưỡng da">
        <div class="cps-acc-icon">🧴</div>
        <span class="cps-acc-title">Serum dưỡng da</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=6&keyword=Kem" class="cps-acc-card" title="Kem chống nắng">
        <div class="cps-acc-icon">☀️</div>
        <span class="cps-acc-title">Kem chống nắng</span>
      </a>
      <a href="${pageContext.request.contextPath}/shop?categoryId=6" class="cps-acc-card" title="Mỹ phẩm & Làm đẹp">
        <div class="cps-acc-icon">💅</div>
        <span class="cps-acc-title">Mỹ phẩm & Làm đẹp</span>
      </a>
    </div>
  </div>
</div>

<%-- ===== SẢN PHẨM MỚI NHẤT ===== --%>
<div class="cps-container">
  <div class="cps-section">
    <div class="cps-section-head">
      <h2 class="cps-section-title">
        <i class="bi bi-stars" style="color:var(--cps-orange)"></i>
        SẢN PHẨM NỔI BẬT
      </h2>
      <a href="${pageContext.request.contextPath}/shop"
         class="cps-section-more" title="Xem tất cả sản phẩm Bincom">
        Xem tất cả <i class="bi bi-arrow-right"></i>
      </a>
    </div>

    <%-- Category filter chips --%>
    <div style="display:flex;gap:8px;margin-bottom:16px;overflow-x:auto;scrollbar-width:none;padding-bottom:4px;">
      <button class="cps-btn cps-btn-primary" style="flex-shrink:0;padding:6px 16px;font-size:12px;"
              onclick="cpsFilter(this,'')">Tất cả</button>
      <c:forEach var="cat" items="${categories}">
        <c:if test="${cat.parent == null}">
          <button class="cps-btn cps-btn-outline" style="flex-shrink:0;padding:6px 16px;font-size:12px;"
                  onclick="cpsFilter(this,'${cat.id}')">${cat.name}</button>
        </c:if>
      </c:forEach>
    </div>

    <div class="cps-product-grid" id="cpsProductGrid">
      <c:forEach var="p" items="${latestProducts}" begin="0" end="19" varStatus="status">
        <div class="cps-product-card ${status.index >= 8 ? 'cps-load-more-hidden' : ''}" 
             data-id="${p.id}" 
             data-cat="${p.category.id}"
             data-parent-cat="${p.category.parent != null ? p.category.parent.id : ''}"
             onclick="location.href='${pageContext.request.contextPath}/shop/product/${p.id}'"
             role="article" aria-label="${p.name}">
          <div class="cps-product-thumb">
            <c:if test="${p.onSale}">
              <span class="cps-product-badge">
                Giảm <fmt:formatNumber value="${(p.price-p.effectivePrice)*100/p.price}" maxFractionDigits="0"/>%
              </span>
            </c:if>
            <span class="cps-product-badge-right">Trả góp 0%</span>
            <c:choose>
              <c:when test="${not empty p.thumbnailUrl}">
                <img src="${pageContext.request.contextPath}${p.thumbnailUrl}"
                     alt="${p.name} — Mua chính hãng tại Bincom"
                     loading="lazy" width="200" height="200"
                     onerror="this.src='https://placehold.co/200x200?text=Bincom'">
              </c:when>
              <c:otherwise>
                <img src="https://placehold.co/200x200?text=${p.name}"
                     alt="${p.name}" loading="lazy" width="200" height="200">
              </c:otherwise>
            </c:choose>
            
            <!-- Right-side specs overlay -->
            <div class="cps-product-specs-overlay">
              <c:choose>
                <c:when test="${not empty p.shortDescription}">
                  <c:forEach var="spec" items="${fn:split(p.shortDescription, ',')}">
                    <span class="cps-spec-tag">${fn:trim(spec)}</span>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <c:choose>
                    <c:when test="${p.category.id == 1}">
                      <span class="cps-spec-tag"><i class="bi bi-cpu"></i> Snapdragon</span>
                      <span class="cps-spec-tag"><i class="bi bi-sd-card"></i> 8GB/256GB</span>
                    </c:when>
                    <c:when test="${p.category.id == 2}">
                      <span class="cps-spec-tag"><i class="bi bi-tag-fill"></i> Cotton</span>
                      <span class="cps-spec-tag"><i class="bi bi-wind"></i> Thoáng khí</span>
                    </c:when>
                    <c:when test="${p.category.id == 3}">
                      <span class="cps-spec-tag"><i class="bi bi-lightning-charge-fill"></i> Inverter</span>
                      <span class="cps-spec-tag"><i class="bi bi-check-circle"></i> Tiết kiệm</span>
                    </c:when>
                    <c:otherwise>
                      <span class="cps-spec-tag"><i class="bi bi-patch-check"></i> Chính hãng</span>
                      <span class="cps-spec-tag"><i class="bi bi-shield-check"></i> 12 tháng</span>
                    </c:otherwise>
                  </c:choose>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
          <div class="cps-product-body">
            <h3 class="cps-product-name">
              <a href="${pageContext.request.contextPath}/shop/product/${p.id}"
                 title="${p.name} giá tốt tại Bincom">${p.name}</a>
            </h3>
            <div class="cps-product-price-row">
              <span class="cps-product-price">
                <fmt:formatNumber value="${p.effectivePrice}" type="number" groupingUsed="true"/>₫
              </span>
              <c:if test="${p.onSale}">
                <span class="cps-product-price-old">
                  <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                </span>
              </c:if>
            </div>
            
            <div class="cps-product-smember-banner">
              Bincom Member giảm thêm đến 1%
            </div>
            
            <div class="cps-product-promo-label">
              Trả góp 0% - 0đ phụ phí nhận máy ngay
            </div>
            
            <div class="cps-product-bottom-row">
              <span class="cps-product-rating-value">
                <i class="bi bi-star-fill text-warning"></i> 4.9
              </span>
              <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${p.id}, this)">
                Yêu thích <i class="bi bi-heart"></i>
              </span>
            </div>
            
            <button class="cps-product-add-btn"
                    onclick="event.stopPropagation();addToCart(${p.id},this)">
              <i class="bi bi-cart-plus"></i> Thêm vào giỏ
            </button>
          </div>
        </div>
      </c:forEach>
      <c:if test="${empty latestProducts}">
        <p style="grid-column:1/-1;text-align:center;padding:40px;color:var(--cps-gray-500);">
          <i class="bi bi-box-seam" style="font-size:40px;display:block;margin-bottom:12px;"></i>
          Chưa có sản phẩm nào.
        </p>
      </c:if>
    </div>

    <div style="text-align:center;margin-top:28px;display:flex;justify-content:center;gap:16px;flex-wrap:wrap;">
      <button id="cpsLoadMoreBtn" class="cps-btn cps-btn-outline"
              style="padding:13px 36px;font-size:15px;color:var(--cps-teal);border:1px solid var(--cps-teal);background:transparent;"
              onclick="cpsLoadMore()">
        Xem thêm sản phẩm <i class="bi bi-chevron-down" style="margin-left:6px;"></i>
      </button>
      <a href="${pageContext.request.contextPath}/shop"
         class="cps-btn cps-btn-primary" style="padding:13px 44px;font-size:15px;"
         title="Xem tất cả sản phẩm Bincom">
        Vào trang cửa hàng <i class="bi bi-arrow-right"></i>
      </a>
    </div>
  </div>
</div>

<style>
/* Countdown blocks */
.cps-cd-block{display:inline-flex;align-items:center;justify-content:center;width:32px;height:32px;background:var(--cps-red);color:#fff;font-size:14px;font-weight:800;border-radius:6px;}

/* Flash Sale Track & Carousel navigation */
.cps-flashsale-track {
  display: flex;
  overflow-x: auto;
  scroll-behavior: smooth;
  gap: 14px;
  padding: 10px 4px;
  scrollbar-width: none; /* Firefox */
}
.cps-flashsale-track::-webkit-scrollbar {
  display: none; /* Chrome/Safari */
}
.cps-flashsale-track .cps-product-card {
  flex: 0 0 calc(20% - 12px); /* 5 cards on desktop */
  min-width: 210px;
}
@media (max-width: 1024px) {
  .cps-flashsale-track .cps-product-card {
    flex: 0 0 calc(33.333% - 10px);
  }
}
@media (max-width: 600px) {
  .cps-flashsale-track .cps-product-card {
    flex: 0 0 calc(50% - 7px);
  }
}
.cps-carousel-nav {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #fff;
  border: 1px solid var(--cps-gray-200);
  box-shadow: var(--cps-shadow-md);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s ease;
  color: var(--cps-gray-700);
}
.cps-carousel-nav:hover {
  background: var(--cps-gray-100);
  color: var(--cps-teal);
}
.cps-carousel-nav.prev {
  left: -20px;
}
.cps-carousel-nav.next {
  right: -20px;
}
/* Showcase tab buttons styling */
.cps-showcase-tabs button.cps-tab-link {
  background: transparent;
  border: none;
  font-size: 18px;
  font-weight: 700;
  color: var(--cps-gray-500);
  padding: 8px 16px;
  cursor: pointer;
  position: relative;
  transition: all 0.2s ease;
  outline: none;
}
.cps-showcase-tabs button.cps-tab-link.active {
  color: var(--cps-teal);
}
.cps-showcase-tabs button.cps-tab-link.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 16px;
  right: 16px;
  height: 3px;
  background: var(--cps-teal);
  border-radius: 2px;
}
</style>

<script>
/* ---- HERO SLIDER ---- */
var cpsIdx=0, cpsTotal=3;
function cpsGoTo(n){
  if(n<0) n=cpsTotal-1; if(n>=cpsTotal) n=0; cpsIdx=n;
  var s=document.getElementById('cpsSlides');
  if(s) s.style.transform='translateX(-'+cpsIdx*100+'%)';
  document.querySelectorAll('.cps-hero-dot').forEach(function(d,i){
    d.classList.toggle('active',i===cpsIdx);
  });
}
function cpsSlide(d){cpsGoTo(cpsIdx+d);}
var cpsAuto=setInterval(function(){cpsGoTo(cpsIdx+1);},5000);
var sliderEl=document.getElementById('cpsSlider');
if(sliderEl){
  sliderEl.addEventListener('mouseenter',function(){clearInterval(cpsAuto);});
  sliderEl.addEventListener('mouseleave',function(){
    clearInterval(cpsAuto);
    cpsAuto=setInterval(function(){cpsGoTo(cpsIdx+1);},5000);
  });
}

/* ---- COUNTDOWN ---- */
(function tick(){
  var now=new Date(), end=new Date();
  end.setHours(23,59,59,999);
  var d=end-now; if(d<=0)return;
  var h=String(Math.floor(d/3600000)).padStart(2,'0');
  var m=String(Math.floor((d%3600000)/60000)).padStart(2,'0');
  var s=String(Math.floor((d%60000)/1000)).padStart(2,'0');
  var hE=document.getElementById('cpsH'),mE=document.getElementById('cpsM'),sE=document.getElementById('cpsS');
  if(hE)hE.textContent=h; if(mE)mE.textContent=m; if(sE)sE.textContent=s;
  setTimeout(tick,1000);
})();

/* ---- CATEGORY FILTER ---- */
function cpsFilter(btn,catId){
  document.querySelectorAll('[onclick^="cpsFilter"]').forEach(function(b){
    b.className='cps-btn cps-btn-outline';
    b.style.cssText='flex-shrink:0;padding:6px 16px;font-size:12px;';
  });
  btn.className='cps-btn cps-btn-primary';
  btn.style.cssText='flex-shrink:0;padding:6px 16px;font-size:12px;';

  var visibleCount = 0;
  document.querySelectorAll('#cpsProductGrid .cps-product-card').forEach(function(c){
    if (catId === '') {
      c.style.display = '';
      if (visibleCount >= 8) {
        c.classList.add('cps-load-more-hidden');
      } else {
        c.classList.remove('cps-load-more-hidden');
      }
      visibleCount++;
    } else {
      if (c.dataset.cat == catId || c.dataset.parentCat == catId) {
        c.style.display = '';
        c.classList.remove('cps-load-more-hidden');
      } else {
        c.style.display = 'none';
      }
    }
  });

  var loadMoreBtn = document.getElementById('cpsLoadMoreBtn');
  if (loadMoreBtn) {
    loadMoreBtn.style.display = (catId === '') ? '' : 'none';
  }
}

/* ---- LOAD MORE ---- */
function cpsLoadMore() {
  document.querySelectorAll('#cpsProductGrid .cps-load-more-hidden').forEach(function(el) {
    el.classList.remove('cps-load-more-hidden');
  });
  var loadMoreBtn = document.getElementById('cpsLoadMoreBtn');
  if (loadMoreBtn) {
    loadMoreBtn.style.display = 'none';
  }
}
/* ---- FLASH SALE CAROUSEL ---- */
function cpsScrollFlashSale(direction) {
  var track = document.getElementById('cpsFlashSaleTrack');
  if (track) {
    var card = track.querySelector('.cps-product-card');
    if (card) {
      var cardWidth = card.offsetWidth + 14;
      track.scrollBy({ left: direction * cardWidth * 2, behavior: 'smooth' });
    }
  }
}
/* ---- GENERIC SHOWCASE TAB SWITCHER ---- */
function switchShowcaseTab(button, tabIndex) {
  var section = button.closest('.cps-showcase-section');
  if (!section) return;
  
  // 1. Toggle active class on tab buttons
  section.querySelectorAll('.cps-tab-link').forEach(function(btn) {
    btn.classList.remove('active');
  });
  button.classList.add('active');
  
  // 2. Toggle active grid
  var grids = section.querySelectorAll('.cps-product-grid.showcase-grid');
  grids.forEach(function(grid, idx) {
    if (idx === tabIndex) {
      grid.style.setProperty('display', 'grid', 'important');
    } else {
      grid.style.setProperty('display', 'none', 'important');
    }
  });

  // 3. Update banner content & background color
  var bannerBg = button.getAttribute('data-banner-bg');
  var bannerTitle = button.getAttribute('data-banner-title');
  var bannerDesc = button.getAttribute('data-banner-desc');
  
  var banner = section.querySelector('.cps-showcase-banner');
  if (banner) {
    if (bannerBg) banner.style.background = bannerBg;
    
    var titleEl = banner.querySelector('h3');
    if (titleEl && bannerTitle) titleEl.textContent = bannerTitle;
    
    var descEl = banner.querySelector('p');
    if (descEl && bannerDesc) descEl.textContent = bannerDesc;
  }
}
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
