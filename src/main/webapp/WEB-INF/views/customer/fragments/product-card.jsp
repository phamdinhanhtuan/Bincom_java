<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- Product Card Fragment - used in listings --%>
<div class="product-card h-100">
    <div class="product-img-wrap">
        <c:choose>
            <c:when test="${not empty product.thumbnailUrl}">
                <img src="${pageContext.request.contextPath}${product.thumbnailUrl}"
                     alt="${product.name}" loading="lazy">
            </c:when>
            <c:otherwise>
                <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:48px;">📦</div>
            </c:otherwise>
        </c:choose>

        <c:if test="${product.onSale}">
            <span class="product-badge">SALE</span>
        </c:if>
        <c:if test="${product.featured && !product.onSale}">
            <span class="product-badge featured">⭐</span>
        </c:if>

        <div class="product-actions">
            <a href="${pageContext.request.contextPath}/shop/product/${product.id}"
               class="action-btn" title="Xem chi tiết">
                <i class="bi bi-eye-fill"></i>
            </a>
        </div>
    </div>

    <div class="product-info">
        <div class="product-category">${product.category.name}</div>
        <a href="${pageContext.request.contextPath}/shop/product/${product.id}"
           class="product-name d-block text-decoration-none">${product.name}</a>

        <div class="product-price">
            <span class="price-current">
                <fmt:formatNumber value="${product.effectivePrice}" type="number" groupingUsed="true"/>₫
            </span>
            <c:if test="${product.onSale}">
                <span class="price-original">
                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
                </span>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${product.inventory != null && product.inventory.availableQuantity > 0}">
                <button class="btn-add-cart" onclick="addToCart(${product.id}, this)">
                    <i class="bi bi-cart-plus-fill"></i> Thêm vào giỏ
                </button>
            </c:when>
            <c:otherwise>
                <button class="btn-add-cart" disabled>
                    <i class="bi bi-x-circle-fill"></i> Hết hàng
                </button>
            </c:otherwise>
        </c:choose>
    </div>
</div>
