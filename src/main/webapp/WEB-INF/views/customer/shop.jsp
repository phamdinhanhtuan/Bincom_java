<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Cửa hàng — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>
<h1 class="visually-hidden">Cửa hàng công nghệ Bincom - Điện thoại, Laptop, Phụ kiện</h1>

<div class="cps-shop-container">

  <!-- Mobile Horizontal Category Bar (hidden on desktop) -->
  <div class="cps-mobile-filter-bar">
    <a href="${pageContext.request.contextPath}/shop" 
       class="cps-btn ${empty categoryId ? 'cps-btn-primary' : 'cps-btn-outline'}" 
       style="flex-shrink:0; padding:8px 16px; font-size:12.5px;"
       title="Tất cả sản phẩm">
       Tất cả
    </a>
    <c:forEach var="cat" items="${categories}">
      <a href="${pageContext.request.contextPath}/shop?categoryId=${cat.id}" 
         class="cps-btn ${cat.id == categoryId ? 'cps-btn-primary' : 'cps-btn-outline'}" 
         style="flex-shrink:0; padding:8px 16px; font-size:12.5px;"
         title="${cat.name} chính hãng">
         ${cat.name}
      </a>
    </c:forEach>
  </div>

  <div class="cps-shop-layout">

    <!-- DESKTOP SIDEBAR -->
    <aside class="cps-shop-sidebar">
      <!-- Category Filter -->
      <div class="cps-filter-card">
        <h2 class="cps-filter-title">Danh mục</h2>
        <div class="cps-filter-links">
          <a href="${pageContext.request.contextPath}/shop"
             class="cps-filter-link ${empty categoryId ? 'active' : ''}">
            <span>Tất cả sản phẩm</span>
            <i class="bi bi-chevron-right"></i>
          </a>
          <c:forEach var="cat" items="${categories}">
            <a href="${pageContext.request.contextPath}/shop?categoryId=${cat.id}"
               class="cps-filter-link ${cat.id == categoryId ? 'active' : ''}">
              <span>${cat.name}</span>
              <i class="bi bi-chevron-right"></i>
            </a>
          </c:forEach>
        </div>
      </div>

      <!-- Price Filter -->
      <div class="cps-filter-card">
        <h2 class="cps-filter-title">Khoảng giá</h2>
        <form method="get" action="${pageContext.request.contextPath}/shop">
          <c:if test="${not empty categoryId}">
            <input type="hidden" name="categoryId" value="${categoryId}">
          </c:if>
          <c:if test="${not empty keyword}">
            <input type="hidden" name="keyword" value="${keyword}">
          </c:if>
          <div class="cps-form-group">
            <label class="cps-form-label">Từ (₫)</label>
            <input type="number" name="minPrice" value="${minPrice}" placeholder="0" class="cps-form-control">
          </div>
          <div class="cps-form-group">
            <label class="cps-form-label">Đến (₫)</label>
            <input type="number" name="maxPrice" value="${maxPrice}" placeholder="100,000,000" class="cps-form-control">
          </div>
          <button type="submit" class="cps-btn cps-btn-primary" style="width:100%; justify-content:center; padding:10px 0; font-size:13px;">
            Áp dụng
          </button>
        </form>
      </div>

      <!-- Exclusive Offers -->
      <div class="cps-filter-card" style="border: 1.5px dashed var(--cps-red); background: var(--cps-red-light);">
        <h2 class="cps-filter-title" style="color: var(--cps-red); border-bottom-color: rgba(13,148,136,0.2);">
          Ưu đãi độc quyền
        </h2>
        <div style="font-size:12.5px; display:flex; flex-direction:column; gap:12px;">
          <div>
            <strong style="color:var(--cps-red); display:block; margin-bottom:2px;"><i class="bi bi-tag-fill"></i> SALE20</strong>
            <span style="color:var(--cps-gray-700);">Giảm 20% cho đơn hàng từ 500K</span>
          </div>
          <div style="border-top:1px dashed rgba(13,148,136,0.2); padding-top:10px;">
            <strong style="color:var(--cps-red); display:block; margin-bottom:2px;"><i class="bi bi-tag-fill"></i> FREESHIP</strong>
            <span style="color:var(--cps-gray-700);">Freeship toàn quốc đơn từ 300K</span>
          </div>
        </div>
      </div>
    </aside>

    <!-- MAIN PRODUCT AREA -->
    <main class="cps-shop-main">
      <!-- SHOP TOOLBAR -->
      <div class="cps-shop-toolbar">
        <div class="cps-toolbar-left">
          Tìm thấy <strong>${products.size()}</strong> sản phẩm
          <c:if test="${not empty keyword}"> cho "<strong>${keyword}</strong>"</c:if>
        </div>
        <div class="cps-toolbar-right">
          <!-- In-category Search -->
          <form method="get" action="${pageContext.request.contextPath}/shop" style="display:flex; gap:6px; margin:0;">
            <c:if test="${not empty categoryId}"><input type="hidden" name="categoryId" value="${categoryId}"></c:if>
            <input type="text" name="keyword" placeholder="Lọc nhanh sản phẩm..." value="${keyword}" class="cps-form-control"
                   style="padding:8px 12px; font-size:12.5px; width:160px; height:38px;">
            <button type="submit" class="cps-btn cps-btn-primary" style="padding:8px 12px; height:38px;">
              <i class="bi bi-search"></i>
            </button>
          </form>

          <!-- Sorting -->
          <select class="cps-sort-select" onchange="location.href=this.value" aria-label="Sắp xếp sản phẩm">
            <option value="">Sắp xếp theo</option>
            <option value="${pageContext.request.contextPath}/shop?sort=latest&categoryId=${categoryId}&keyword=${keyword}&minPrice=${minPrice}&maxPrice=${maxPrice}">Mới nhất</option>
            <option value="${pageContext.request.contextPath}/shop?sort=price-asc&categoryId=${categoryId}&keyword=${keyword}&minPrice=${minPrice}&maxPrice=${maxPrice}">Giá tăng dần</option>
            <option value="${pageContext.request.contextPath}/shop?sort=price-desc&categoryId=${categoryId}&keyword=${keyword}&minPrice=${minPrice}&maxPrice=${maxPrice}">Giá giảm dần</option>
          </select>
        </div>
      </div>

      <!-- PRODUCTS GRID -->
      <c:choose>
        <c:when test="${empty products}">
          <div style="text-align:center; padding:80px 24px; background:var(--cps-white); border-radius:var(--cps-radius-lg); border:1.5px solid var(--cps-gray-200); box-shadow:var(--cps-shadow-sm);">
            <div style="font-size:52px; margin-bottom:16px; color:var(--cps-gray-500);"><i class="bi bi-inbox-fill"></i></div>
            <h3 style="font-size:18px; font-weight:800; margin-bottom:8px; color:var(--cps-dark);">Không tìm thấy sản phẩm phù hợp</h3>
            <p style="color:var(--cps-gray-500); margin-bottom:24px; font-size:13.5px;">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm của bạn.</p>
            <a href="${pageContext.request.contextPath}/shop" class="cps-btn cps-btn-primary" style="padding:10px 24px;">
              Xem tất cả sản phẩm
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="cps-product-grid">
            <c:forEach var="product" items="${products}">
              <div class="cps-product-card" data-id="${product.id}" onclick="location.href='${pageContext.request.contextPath}/shop/product/${product.id}'" role="article" aria-label="${product.name}">
                <div class="cps-product-thumb">
                  <c:if test="${product.onSale}">
                    <span class="cps-product-badge">
                      Giảm <fmt:formatNumber value="${(product.price - product.effectivePrice) * 100 / product.price}" maxFractionDigits="0"/>%
                    </span>
                  </c:if>
                  <span class="cps-product-badge-right">Trả góp 0%</span>
                  <c:choose>
                    <c:when test="${not empty product.thumbnailUrl}">
                      <img src="${pageContext.request.contextPath}${product.thumbnailUrl}" alt="${product.name} — Mua chính hãng tại Bincom" loading="lazy" width="200" height="200" onerror="this.src='https://placehold.co/200x200?text=Bincom'"/>
                    </c:when>
                    <c:otherwise>
                      <img src="https://placehold.co/200x200?text=${product.name}" alt="${product.name}" loading="lazy" width="200" height="200"/>
                    </c:otherwise>
                  </c:choose>
                  
                  <!-- Right-side specs overlay -->
                  <div class="cps-product-specs-overlay">
                    <c:choose>
                      <c:when test="${not empty product.shortDescription}">
                        <c:forEach var="spec" items="${fn:split(product.shortDescription, ',')}">
                          <span class="cps-spec-tag">${fn:trim(spec)}</span>
                        </c:forEach>
                      </c:when>
                      <c:otherwise>
                        <c:choose>
                          <c:when test="${product.category.id == 1}">
                            <span class="cps-spec-tag"><i class="bi bi-cpu"></i> Snapdragon</span>
                            <span class="cps-spec-tag"><i class="bi bi-sd-card"></i> 8GB/256GB</span>
                          </c:when>
                          <c:when test="${product.category.id == 2}">
                            <span class="cps-spec-tag"><i class="bi bi-tag-fill"></i> Cotton</span>
                            <span class="cps-spec-tag"><i class="bi bi-wind"></i> Thoáng khí</span>
                          </c:when>
                          <c:when test="${product.category.id == 3}">
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
                    <a href="${pageContext.request.contextPath}/shop/product/${product.id}" title="${product.name} giá tốt tại Bincom">
                      ${product.name}
                    </a>
                  </h3>
                  <div class="cps-product-price-row">
                    <span class="cps-product-price">
                      <fmt:formatNumber value="${product.effectivePrice}" type="number" groupingUsed="true"/>₫
                    </span>
                    <c:if test="${product.onSale}">
                      <span class="cps-product-price-old">
                        <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
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
                    <span class="cps-product-wishlist-btn" onclick="toggleWishlist(event, ${product.id}, this)">
                      Yêu thích <i class="bi bi-heart"></i>
                    </span>
                  </div>
                  
                  <button class="cps-product-add-btn" onclick="event.stopPropagation(); addToCart(${product.id}, this)">
                    <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                  </button>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </main>
  </div>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
