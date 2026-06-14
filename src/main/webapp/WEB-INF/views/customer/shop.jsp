<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Cửa hàng — Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<!-- BREADCRUMB -->
<div class="breadcrumb-wrap">
  <div class="kumo-container">
    <nav class="breadcrumb">
      <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
      <span class="breadcrumb-sep">/</span>
      <span>Cửa hàng</span>
    </nav>
  </div>
</div>

<div class="kumo-container">
  <div class="shop-layout">

    <!-- SIDEBAR -->
    <aside>
      <div class="sidebar-block">
        <div class="sidebar-title">Danh mục</div>
        <ul class="filter-list">
          <li>
            <a href="${pageContext.request.contextPath}/shop"
               class="${empty categoryId ? 'active' : ''}">
              Tất cả sản phẩm <span></span>
            </a>
          </li>
          <c:forEach var="cat" items="${categories}">
            <li>
              <a href="${pageContext.request.contextPath}/shop?categoryId=${cat.id}"
                 class="${cat.id == categoryId ? 'active' : ''}">
                ${cat.name}
              </a>
            </li>
          </c:forEach>
        </ul>
      </div>

      <div class="sidebar-block">
        <div class="sidebar-title">Khoảng giá</div>
        <form method="get" action="${pageContext.request.contextPath}/shop">
          <c:if test="${not empty categoryId}">
            <input type="hidden" name="categoryId" value="${categoryId}">
          </c:if>
          <c:if test="${not empty keyword}">
            <input type="hidden" name="keyword" value="${keyword}">
          </c:if>
          <div style="margin-bottom:12px;">
            <label style="font-size:11px;color:var(--text-muted);display:block;margin-bottom:4px;font-weight:700;">Từ (₫)</label>
            <input type="number" name="minPrice" value="${minPrice}" placeholder="0"
                   style="width:100%;padding:8px 12px;border:1.5px solid var(--border);border-radius:8px;font-family:inherit;font-size:13px;outline:none;">
          </div>
          <div style="margin-bottom:16px;">
            <label style="font-size:11px;color:var(--text-muted);display:block;margin-bottom:4px;font-weight:700;">Đến (₫)</label>
            <input type="number" name="maxPrice" value="${maxPrice}" placeholder="100,000,000"
                   style="width:100%;padding:8px 12px;border:1.5px solid var(--border);border-radius:8px;font-family:inherit;font-size:13px;outline:none;">
          </div>
          <button type="submit" class="btn-primary" style="width:100%;justify-content:center;border-radius:8px;padding:10px 0;font-size:12px;">Lọc giá</button>
        </form>
      </div>

      <div class="sidebar-block" style="background:var(--accent-light); border:1px dashed var(--accent);">
        <div class="sidebar-title" style="border-bottom-color:var(--accent); color:var(--accent);">Ưu đãi độc quyền</div>
        <div style="font-size:12px; margin-bottom:10px;">
          <div style="font-weight:800;color:var(--primary);margin-bottom:2px;">🏷️ SALE20</div>
          <div style="color:var(--text-muted);">Giảm 20% cho đơn hàng thời trang từ 500K</div>
        </div>
        <div style="font-size:12px;">
          <div style="font-weight:800;color:var(--primary);margin-bottom:2px;">🏷️ GIAM50K</div>
          <div style="color:var(--text-muted);">Giảm ngay 50K cho hóa đơn từ 300K</div>
        </div>
      </div>
    </aside>

    <!-- PRODUCT AREA -->
    <main>
      <!-- TOOLBAR -->
      <div class="shop-toolbar">
        <span class="product-count">
          Tìm thấy <strong>${products.size()}</strong> sản phẩm
          <c:if test="${not empty keyword}"> cho "<strong>${keyword}</strong>"</c:if>
        </span>
        <div style="display:flex;align-items:center;gap:12px;">
          <form method="get" action="${pageContext.request.contextPath}/shop" style="display:flex;gap:8px;align-items:center;margin:0;">
            <c:if test="${not empty categoryId}"><input type="hidden" name="categoryId" value="${categoryId}"></c:if>
            <input type="text" name="keyword" placeholder="Tìm trong danh mục..."
                   style="padding:8px 14px;border:1.5px solid var(--border);border-radius:8px;font-family:inherit;font-size:13px;outline:none;width:180px;">
            <button type="submit" class="btn-primary" style="padding:8px 14px;border-radius:8px;">
              <i class="bi bi-search"></i>
            </button>
          </form>
          <select class="sort-select" onchange="location.href=this.value">
            <option value="">Sắp xếp</option>
            <option value="${pageContext.request.contextPath}/shop?sort=latest&categoryId=${categoryId}&keyword=${keyword}&minPrice=${minPrice}&maxPrice=${maxPrice}">Mới nhất</option>
            <option value="${pageContext.request.contextPath}/shop?sort=price-asc&categoryId=${categoryId}&keyword=${keyword}&minPrice=${minPrice}&maxPrice=${maxPrice}">Giá tăng dần</option>
            <option value="${pageContext.request.contextPath}/shop?sort=price-desc&categoryId=${categoryId}&keyword=${keyword}&minPrice=${minPrice}&maxPrice=${maxPrice}">Giá giảm dần</option>
          </select>
        </div>
      </div>

      <!-- PRODUCTS -->
      <c:choose>
        <c:when test="${empty products}">
          <div style="text-align:center;padding:80px 0;background:#fff;border-radius:16px;border:1px solid var(--border);">
            <div style="font-size:60px;margin-bottom:16px;color:var(--text-muted);"><i class="bi bi-search-heart"></i></div>
            <h3 style="font-size:20px;font-weight:800;margin-bottom:8px;">Không tìm thấy sản phẩm phù hợp</h3>
            <p style="color:var(--text-muted);margin-bottom:24px;font-size:14px;">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm của bạn.</p>
            <a href="${pageContext.request.contextPath}/shop" class="btn-primary" style="border-radius:8px;">Xem tất cả sản phẩm</a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="shop-grid">
            <c:forEach var="product" items="${products}">
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
        </c:otherwise>
      </c:choose>
    </main>
  </div>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
