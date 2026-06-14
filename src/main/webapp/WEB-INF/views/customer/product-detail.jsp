<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"       value="${product.name} — Bincom" scope="request"/>
<c:set var="metaDescription" value="${product.shortDescription}"  scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<!-- Breadcrumb -->
<div class="breadcrumb-bar">
    <div class="container-shop d-flex gap-2 align-items-center flex-wrap">
        <a href="${pageContext.request.contextPath}/">Trang chủ</a>
        <i class="bi bi-chevron-right" style="font-size:11px;"></i>
        <a href="${pageContext.request.contextPath}/shop">Sản phẩm</a>
        <c:if test="${product.category != null}">
            <i class="bi bi-chevron-right" style="font-size:11px;"></i>
            <a href="${pageContext.request.contextPath}/shop?categoryId=${product.category.id}">${product.category.name}</a>
        </c:if>
        <i class="bi bi-chevron-right" style="font-size:11px;"></i>
        <span>${product.name}</span>
    </div>
</div>

<div class="container-shop" style="padding: 32px 24px;">
    <div class="row g-4" style="background:#fff; border:1px solid var(--border); border-radius:20px; padding:24px; margin-bottom:30px;">
        <!-- Product Images (Left) -->
        <div class="col-lg-5">
            <div style="border-radius:16px; overflow:hidden; background:var(--light); aspect-ratio:1; display:flex; align-items:center; justify-content:center; border:1px solid var(--border);">
                <c:choose>
                    <c:when test="${not empty product.thumbnailUrl}">
                        <img id="mainImage"
                             src="${pageContext.request.contextPath}${product.thumbnailUrl}"
                             alt="${product.name}"
                             style="width:100%; height:100%; object-fit:cover;">
                    </c:when>
                    <c:otherwise>
                        <div style="font-size:80px; color:var(--accent); opacity:0.3;">
                            <i class="bi bi-image"></i>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- Thumbnail Row -->
            <c:if test="${not empty product.images || not empty product.thumbnailUrl}">
                <div class="d-flex gap-2 mt-3 flex-wrap">
                    <c:if test="${not empty product.thumbnailUrl}">
                        <img src="${pageContext.request.contextPath}${product.thumbnailUrl}"
                             onclick="document.getElementById('mainImage').src=this.src; updateActiveThumb(this)"
                             style="width:64px; height:64px; object-fit:cover; border-radius:8px; border:2px solid var(--accent); cursor:pointer;" alt="">
                    </c:if>
                    <c:forEach var="img" items="${product.images}">
                        <img src="${pageContext.request.contextPath}${img.imageUrl}"
                             onclick="document.getElementById('mainImage').src=this.src; updateActiveThumb(this)"
                             style="width:64px; height:64px; object-fit:cover; border-radius:8px; border:2px solid var(--border); cursor:pointer; transition:border-color 0.2s;"
                             alt="${img.altText}">
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <!-- Product Info (Right) -->
        <div class="col-lg-7" style="display:flex; flex-direction:column; justify-content:space-between;">
            <div>
                <div class="mb-2">
                    <a href="${pageContext.request.contextPath}/shop?categoryId=${product.category.id}"
                       style="color:var(--accent); font-size:13px; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">
                        ${product.category.name}
                    </a>
                </div>

                <h1 style="font-size:24px; font-weight:800; color:var(--primary); margin-bottom:12px; line-height:1.3;">
                    ${product.name}
                </h1>

                <!-- Price Section -->
                <div class="d-flex align-items-center gap-3 mb-4 flex-wrap">
                    <div>
                        <span style="font-size:28px; font-weight:800; color:var(--danger);">
                            <fmt:formatNumber value="${product.effectivePrice}" type="number" groupingUsed="true"/>₫
                        </span>
                        <c:if test="${product.onSale}">
                            <span style="font-size:16px; color:var(--text-muted); text-decoration:line-through; margin-left:12px;">
                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
                            </span>
                            <span style="background:#fee2e2; color:var(--danger); padding:4px 10px; border-radius:20px; font-size:11px; font-weight:800; margin-left:8px;">
                                -<fmt:formatNumber value="${(product.price - product.effectivePrice) * 100 / product.price}" maxFractionDigits="0"/>%
                            </span>
                        </c:if>
                    </div>
                </div>

                <!-- Short Description -->
                <c:if test="${not empty product.shortDescription}">
                    <p style="font-size:14px; color:var(--text-muted); line-height:1.6; margin-bottom:20px; border-top:1px solid var(--border); padding-top:16px;">
                        ${product.shortDescription}
                    </p>
                </c:if>

                <!-- Stock Info -->
                <div class="mb-4 d-flex align-items-center gap-2 flex-wrap">
                    <c:choose>
                        <c:when test="${product.inventory != null && product.inventory.availableQuantity > 0}">
                            <span style="background:#d1fae5; color:#065f46; padding:4px 12px; border-radius:20px; font-size:12px; font-weight:700;">
                                <i class="bi bi-check-circle-fill me-1"></i>
                                Còn hàng (${product.inventory.availableQuantity} sản phẩm)
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="background:#fee2e2; color:#991b1b; padding:4px 12px; border-radius:20px; font-size:12px; font-weight:700;">
                                <i class="bi bi-x-circle-fill me-1"></i>Tạm hết hàng
                            </span>
                        </c:otherwise>
                    </c:choose>
                    <span style="color:var(--text-muted); font-size:12px; font-weight:600; margin-left:10px;">Mã sản phẩm: ${product.productCode}</span>
                </div>
            </div>

            <!-- Add to Cart / Buy Now (CTA) -->
            <div>
                <c:if test="${product.inventory != null && product.inventory.availableQuantity > 0}">
                    <div class="d-flex gap-3 align-items-center mb-4 flex-wrap" style="border-top:1px solid var(--border); padding-top:20px;">
                        <div class="qty-box">
                            <button type="button" onclick="changeDetailQty(-1)">
                                <i class="bi bi-dash"></i>
                            </button>
                            <input type="number" id="detailQty" value="1" min="1"
                                   max="${product.inventory.availableQuantity}" readonly>
                            <button type="button" onclick="changeDetailQty(1)">
                                <i class="bi bi-plus"></i>
                            </button>
                        </div>
                        <button class="btn-add-cart" id="addCartBtn" onclick="addToCartWithQty(${product.id}, this)" style="flex:1;">
                            <i class="bi bi-cart-plus-fill"></i> Thêm vào giỏ
                        </button>
                        <button class="btn-primary" id="buyNowBtn" onclick="buyNow(${product.id}, this)"
                                style="flex:1.2; justify-content:center; padding:14px; background:linear-gradient(135deg,#f97316,#ef4444); box-shadow:0 4px 16px rgba(239,68,68,0.25); border-radius:12px;">
                            <i class="bi bi-lightning-fill"></i> MUA NGAY
                        </button>
                    </div>
                </c:if>

                <!-- Shipping info cards -->
                <div style="background:var(--light); border-radius:12px; padding:16px; border:1px solid var(--border);">
                    <div class="d-flex gap-3 mb-3">
                        <i class="bi bi-shield-check text-success" style="font-size:20px;"></i>
                        <div>
                            <div style="font-size:13px; font-weight:700; color:var(--primary);">Bảo hành chính hãng 12 tháng</div>
                            <div style="font-size:12px; color:var(--text-muted);">Cam kết hàng chính hãng 100%</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3">
                        <i class="bi bi-truck text-primary" style="font-size:20px;"></i>
                        <div>
                            <div style="font-size:13px; font-weight:700; color:var(--primary);">Giao hàng siêu tốc 2h</div>
                            <div style="font-size:12px; color:var(--text-muted);">Miễn phí vận chuyển cho đơn hàng từ 500K</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Description & Specs -->
    <div class="row g-4">
        <div class="col-lg-8">
            <c:if test="${not empty product.description}">
                <div style="background:#fff; border:1px solid var(--border); border-radius:20px; padding:24px;">
                    <h3 style="font-size:18px; font-weight:800; margin-bottom:16px; color:var(--primary); border-bottom:1px solid var(--border); padding-bottom:12px;">
                        <i class="bi bi-file-text me-2"></i>Đặc điểm nổi bật
                    </h3>
                    <div style="line-height:1.8; color:var(--primary); font-size:14px;">
                        ${product.description}
                    </div>
                </div>
            </c:if>
        </div>
        
        <!-- Specification sidebar -->
        <div class="col-lg-4">
            <div style="background:#fff; border:1px solid var(--border); border-radius:20px; padding:24px; position:sticky; top:90px;">
                <h3 style="font-size:18px; font-weight:800; margin-bottom:16px; color:var(--primary); border-bottom:1px solid var(--border); padding-bottom:12px;">
                    <i class="bi bi-cpu me-2"></i>Thông số kỹ thuật
                </h3>
                <table class="spec-table">
                    <tr>
                        <td>Mã sản phẩm</td>
                        <td>${product.productCode}</td>
                    </tr>
                    <tr>
                        <td>Danh mục</td>
                        <td>${product.category.name}</td>
                    </tr>
                    <tr>
                        <td>Trạng thái</td>
                        <td>
                            <c:choose>
                                <c:when test="${product.inventory.availableQuantity > 0}">Còn hàng</c:when>
                                <c:otherwise>Hết hàng</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td>Khuyến mãi</td>
                        <td>
                            <c:choose>
                                <c:when test="${product.onSale}">Giảm giá trực tiếp</c:when>
                                <c:otherwise>Mặc định</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Related Products -->
    <c:if test="${not empty relatedProducts}">
        <section class="mt-5">
            <h2 class="section-title" style="margin-bottom:20px;">Sản phẩm tương tự</h2>
            <div class="product-grid">
                <c:forEach var="related" items="${relatedProducts}" begin="0" end="4">
                    <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/shop/product/${related.id}'">
                        <div class="product-img-wrap">
                            <c:if test="${related.onSale}">
                                <div class="product-badges"><span class="badge-sale">SALE</span></div>
                            </c:if>
                            <c:choose>
                                <c:when test="${not empty related.thumbnailUrl}">
                                    <img src="${pageContext.request.contextPath}${related.thumbnailUrl}" alt="${related.name}" onerror="this.src='https://placehold.co/300x400?text=Bincom'"/>
                                </c:when>
                                <c:otherwise>
                                    <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:#f1f5f9;color:#94a3b8;font-size:30px;">
                                        <i class="bi bi-image"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="product-info">
                            <div class="product-cat-label">${related.category.name}</div>
                            <div class="product-name">
                                <a href="${pageContext.request.contextPath}/shop/product/${related.id}">${related.name}</a>
                            </div>
                            <div class="product-price">
                                <span class="price-current">
                                    <fmt:formatNumber value="${related.effectivePrice}" type="number" groupingUsed="true"/>₫
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </c:if>
</div>

<script>
function updateActiveThumb(img) {
    var thumbs = img.parentNode.querySelectorAll('img');
    thumbs.forEach(t => t.style.borderColor = 'var(--border)');
    img.style.borderColor = 'var(--accent)';
}

function changeDetailQty(delta) {
    var input = document.getElementById('detailQty');
    if (!input) return;
    var val = parseInt(input.value) + delta;
    var max = parseInt(input.getAttribute('max')) || 99;
    if (val < 1) val = 1;
    if (val > max) val = max;
    input.value = val;
}

function addToCartWithQty(productId, btn) {
    var qty = parseInt(document.getElementById('detailQty').value) || 1;
    var csrfToken  = document.querySelector('meta[name="_csrf"]')?.getAttribute('content') || '';
    var csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content') || 'X-CSRF-TOKEN';

    var originalHtml = btn.innerHTML;
    btn.innerHTML = '<i class="bi bi-arrow-repeat"></i> Đang thêm...';
    btn.disabled = true;

    fetch(window.CTX + '/cart/add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            [csrfHeader]: csrfToken
        },
        body: 'productId=' + productId + '&quantity=' + qty
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            showToast(data.message, 'success');
            updateCartBadge(data.cartCount);
            btn.innerHTML = '<i class="bi bi-check-circle-fill"></i> Đã thêm!';
            setTimeout(() => { btn.innerHTML = originalHtml; btn.disabled = false; }, 2500);
        } else {
            showToast(data.message, 'error');
            btn.innerHTML = originalHtml;
            btn.disabled = false;
        }
    })
    .catch(() => {
        showToast('Vui lòng đăng nhập để thêm vào giỏ hàng', 'error');
        btn.innerHTML = originalHtml;
        btn.disabled = false;
    });
}

function buyNow(productId, btn) {
    var qty = parseInt(document.getElementById('detailQty').value) || 1;
    var csrfToken  = document.querySelector('meta[name="_csrf"]')?.getAttribute('content') || '';
    var csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content') || 'X-CSRF-TOKEN';

    var originalHtml = btn.innerHTML;
    btn.innerHTML = '<i class="bi bi-arrow-repeat"></i> Đang xử lý...';
    btn.disabled = true;

    fetch(window.CTX + '/cart/add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            [csrfHeader]: csrfToken
        },
        body: 'productId=' + productId + '&quantity=' + qty
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            window.location.href = window.CTX + '/checkout';
        } else {
            showToast(data.message, 'error');
            btn.innerHTML = originalHtml;
            btn.disabled = false;
        }
    })
    .catch(() => {
        showToast('Vui lòng đăng nhập để mua ngay', 'error');
        btn.innerHTML = originalHtml;
        btn.disabled = false;
    });
}
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
