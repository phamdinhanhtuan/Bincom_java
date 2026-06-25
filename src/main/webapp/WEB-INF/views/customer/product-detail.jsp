<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle"       value="${product.name} — Bincom" scope="request"/>
<c:set var="metaDescription" value="${product.shortDescription}"  scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>


<div class="container-shop" style="padding: 32px 24px;">
    <div class="row g-4" style="background:#fff; border:1px solid var(--border); border-radius:20px; padding:24px; margin-bottom:30px;">
        <!-- Product Images (Left) -->
        <div class="col-lg-5">
            <div style="border-radius:16px; overflow:hidden; background:#fff; aspect-ratio:1; display:flex; align-items:center; justify-content:center; border:1px solid var(--border);">
                <c:choose>
                    <c:when test="${not empty product.thumbnailUrl}">
                        <img id="mainImage"
                             src="${pageContext.request.contextPath}${product.thumbnailUrl}"
                             alt="${product.name}"
                             style="width:100%; height:100%; object-fit:contain; padding:16px;">
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
                             style="width:64px; height:64px; object-fit:contain; padding:4px; background:#fff; border-radius:8px; border:2px solid var(--accent); cursor:pointer;" alt="">
                    </c:if>
                    <c:forEach var="img" items="${product.images}">
                        <img src="${pageContext.request.contextPath}${img.imageUrl}"
                             onclick="document.getElementById('mainImage').src=this.src; updateActiveThumb(this)"
                             style="width:64px; height:64px; object-fit:contain; padding:4px; background:#fff; border-radius:8px; border:2px solid var(--border); cursor:pointer; transition:border-color 0.2s;"
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

                <div class="d-flex align-items-center justify-content-between gap-3 mb-3 flex-wrap">
                    <div>
                        <h1 style="font-size:24px; font-weight:800; color:var(--primary); margin:0; line-height:1.3;">
                            ${product.name}
                        </h1>
                        <c:if test="${reviewsCount > 0}">
                            <div class="d-flex align-items-center gap-2 mt-2">
                                <div style="color: #fbbf24; font-size: 14px;">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="bi bi-star${i <= avgRating ? '-fill' : (i - 0.5 <= avgRating ? '-half' : '')}"></i>
                                    </c:forEach>
                                </div>
                                <span style="font-size: 13px; font-weight: 600; color: var(--text-muted);">
                                    <fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/>/5 (${reviewsCount} đánh giá)
                                </span>
                            </div>
                        </c:if>
                    </div>
                    <sec:authorize access="hasAnyRole('ADMIN','STORE_MANAGER','SALES_STAFF')">
                        <a href="${pageContext.request.contextPath}/admin/products/${product.id}/edit" 
                           style="display:inline-flex; align-items:center; gap:6px; background:#0d9488; color:white; padding:8px 16px; border-radius:8px; font-size:13px; font-weight:700; text-decoration:none; transition: all 0.2s; border: none; cursor: pointer;"
                           onmouseover="this.style.background='#0f766e'"
                           onmouseout="this.style.background='#0d9488'"
                           title="Chỉnh sửa nhanh sản phẩm này trong trang Admin">
                            <i class="bi bi-pencil-square"></i> Sửa sản phẩm
                        </a>
                    </sec:authorize>
                </div>

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

                <!-- Product Size Selection -->
                <c:set var="catName" value="${fn:toLowerCase(product.category.name)}" />
                <c:if test="${product.category.id == 11 || product.category.id == 12 || fn:contains(catName, 'quần áo') || fn:contains(catName, 'giày') || fn:contains(catName, 'dép')}">
                    <style>
                        .btn-size-option {
                            background: #fff;
                            border: 1px solid var(--border);
                            border-radius: 8px;
                            padding: 8px 16px;
                            font-size: 13.5px;
                            font-weight: 600;
                            color: var(--primary);
                            cursor: pointer;
                            transition: all 0.2s ease;
                            min-width: 52px;
                            text-align: center;
                        }
                        .btn-size-option:hover {
                            border-color: var(--accent);
                            color: var(--accent);
                            background: #fef2f2;
                        }
                        .btn-size-option.active {
                            border-color: var(--accent);
                            color: #fff !important;
                            background: var(--accent);
                            box-shadow: 0 2px 6px rgba(220, 38, 38, 0.2);
                        }
                    </style>
                    <div style="border-top: 1px solid var(--border); padding-top: 16px; margin-top: 16px; margin-bottom: 20px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                            <span style="font-size: 14px; font-weight: 700; color: var(--primary);">Kích cỡ:</span>
                            <a href="javascript:void(0)" onclick="showSizeGuide()" style="font-size: 13px; color: var(--accent); text-decoration: underline; font-weight: 600;">
                                Hướng dẫn chọn cỡ
                            </a>
                        </div>
                        <div style="display: flex; gap: 8px; flex-wrap: wrap;" id="sizeSelectorContainer">
                            <c:choose>
                                <c:when test="${product.category.id == 11 || fn:contains(catName, 'quần áo')}">
                                    <c:forEach var="sz" items="${['S', 'M', 'L', 'XL', 'XXL']}">
                                        <button type="button" class="btn-size-option" onclick="selectProductSize('${sz}')" data-size="${sz}">
                                            ${sz}
                                        </button>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="sz" items="${['35', '36', '37', '38', '39', '40', '41', '42', '43']}">
                                        <button type="button" class="btn-size-option" onclick="selectProductSize('${sz}')" data-size="${sz}">
                                            ${sz}
                                        </button>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <input type="hidden" id="selectedProductSize" value="">
                    </div>
                </c:if>
            </div>

            <!-- Add to Cart / Buy Now (CTA) -->
            <div>
                <c:if test="${product.inventory != null && product.inventory.availableQuantity > 0}">
                    <div class="product-actions" style="border-top:1px solid var(--border); padding-top:20px;">
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
                        <button class="btn-add-cart" id="addCartBtn" onclick="addToCartWithQty(${product.id}, this)">
                            <i class="bi bi-cart-plus-fill"></i> Thêm vào giỏ
                        </button>
                        <button class="btn-primary" id="buyNowBtn" onclick="buyNow(${product.id}, this)">
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

    <!-- Reviews and Comments (CellphoneS Style) -->
    <div id="product-reviews" style="background:#fff; border:1px solid var(--border); border-radius:20px; padding:24px; margin-top:30px; margin-bottom:30px;">
        <h3 style="font-size:18px; font-weight:800; margin-bottom:24px; color:var(--primary); border-bottom:1px solid var(--border); padding-bottom:12px;">
            <i class="bi bi-chat-left-text me-2"></i>Đánh giá & Nhận xét ${product.name}
        </h3>

        <div class="row g-4 mb-4" style="align-items: center;">
            <!-- Rating stats -->
            <div class="col-md-4 text-center" style="border-right: 1px solid var(--border);">
                <div style="font-size: 48px; font-weight: 800; color: var(--primary); line-height: 1;">
                    <fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/>
                </div>
                <div style="color: #fbbf24; font-size: 20px; margin: 8px 0;">
                    <c:forEach begin="1" end="5" var="i">
                        <i class="bi bi-star${i <= avgRating ? '-fill' : (i - 0.5 <= avgRating ? '-half' : '')}"></i>
                    </c:forEach>
                </div>
                <div style="font-size: 14px; color: var(--text-muted); font-weight: 600;">
                    ${reviewsCount} đánh giá & nhận xét
                </div>
            </div>

            <!-- Progress bars -->
            <div class="col-md-5">
                <c:forEach begin="1" end="5" var="starIdx">
                    <c:set var="star" value="${6 - starIdx}" />
                    <c:set var="countStar" value="0" />
                    <c:forEach var="rev" items="${reviews}">
                        <c:if test="${rev.rating == star}">
                            <c:set var="countStar" value="${countStar + 1}" />
                        </c:if>
                    </c:forEach>
                    <c:set var="percent" value="${reviewsCount > 0 ? (countStar * 100 / reviewsCount) : 0}" />
                    <div class="d-flex align-items-center gap-2 mb-1" style="font-size: 13px; font-weight: 600; color: var(--primary);">
                        <span style="width: 15px;">${star}</span>
                        <i class="bi bi-star-fill text-warning" style="font-size: 11px;"></i>
                        <div class="progress" style="flex: 1; height: 6px; border-radius: 3px; background: var(--light);">
                            <div class="progress-bar" role="progressbar" style="width: ${percent}%; background-color: #0d9488; border-radius: 3px;" aria-valuenow="${percent}" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <span style="width: 35px; text-align: right; color: var(--text-muted);">${countStar}</span>
                    </div>
                </c:forEach>
            </div>

            <!-- CTA write review -->
            <div class="col-md-3 text-center">
                <p style="font-size: 13px; color: var(--text-muted); margin-bottom: 12px; font-weight: 600;">Bạn đã dùng sản phẩm này?</p>
                <button type="button" class="btn" onclick="toggleReviewForm()" 
                        style="background: #0d9488; color: white; border: 1.5px solid #0d9488; font-weight: 700; border-radius: 12px; padding: 10px 20px; transition: all 0.2s;">
                    Viết đánh giá
                </button>
            </div>
        </div>

        <!-- Write Review Form Container -->
        <div id="review-form-container" style="display: none; background: var(--light); border: 1px dashed var(--border); border-radius: 16px; padding: 20px; margin-bottom: 24px; transition: all 0.3s;">
            <h4 style="font-size: 15px; font-weight: 800; margin-bottom: 15px; color: var(--primary);">Gửi đánh giá của bạn</h4>
            <form id="submit-review-form" onsubmit="submitReview(event)">
                <!-- Star selector -->
                <div class="mb-3">
                    <label style="font-size: 13px; font-weight: 700; color: var(--primary); display: block; margin-bottom: 6px;">Chọn đánh giá của bạn:</label>
                    <div class="d-flex gap-2" style="font-size: 24px; cursor: pointer; color: #cbd5e1;">
                        <i class="bi bi-star star-select" data-value="1" onclick="setSelectStars(1)" onmouseover="highlightSelectStars(1)" onmouseout="resetSelectStars()"></i>
                        <i class="bi bi-star star-select" data-value="2" onclick="setSelectStars(2)" onmouseover="highlightSelectStars(2)" onmouseout="resetSelectStars()"></i>
                        <i class="bi bi-star star-select" data-value="3" onclick="setSelectStars(3)" onmouseover="highlightSelectStars(3)" onmouseout="resetSelectStars()"></i>
                        <i class="bi bi-star star-select" data-value="4" onclick="setSelectStars(4)" onmouseover="highlightSelectStars(4)" onmouseout="resetSelectStars()"></i>
                        <i class="bi bi-star star-select" data-value="5" onclick="setSelectStars(5)" onmouseover="highlightSelectStars(5)" onmouseout="resetSelectStars()"></i>
                    </div>
                    <input type="hidden" id="review-rating" name="rating" value="5">
                </div>
                
                <!-- Comment input -->
                <div class="mb-3">
                    <label for="review-comment" style="font-size: 13px; font-weight: 700; color: var(--primary); display: block; margin-bottom: 6px;">Nhận xét:</label>
                    <textarea id="review-comment" name="comment" rows="3" class="form-control" placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..." style="border-radius: 8px; font-size: 13px;" required></textarea>
                </div>

                <div class="d-flex gap-2 justify-content-end">
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="toggleReviewForm()" style="border-radius: 8px; font-weight: 600; font-size: 13px;">Hủy</button>
                    <button type="submit" class="btn btn-sm" style="background: #0d9488; color: white; border-radius: 8px; font-weight: 700; font-size: 13px; padding: 6px 16px;">Gửi đánh giá</button>
                </div>
            </form>
        </div>

        <!-- Reviews List -->
        <div id="reviews-list" style="border-top: 1px solid var(--border); padding-top: 20px;">
            <c:choose>
                <c:when test="${not empty reviews}">
                    <c:forEach var="rev" items="${reviews}">
                        <div class="review-item mb-4" style="border-bottom: 1px solid var(--light); padding-bottom: 16px;">
                            <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-2">
                                <div class="d-flex align-items-center gap-2">
                                    <div style="width: 32px; height: 32px; border-radius: 50%; background: #e2e8f0; display: flex; align-items: center; justify-content: center; font-weight: 800; color: var(--primary); font-size: 13px; text-transform: uppercase;">
                                        ${rev.user.fullName.substring(0,1)}
                                    </div>
                                    <div>
                                        <div style="font-size: 14px; font-weight: 700; color: var(--primary);">${rev.user.fullName}</div>
                                        <div style="color: #fbbf24; font-size: 11px;">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="bi bi-star${i <= rev.rating ? '-fill' : ''}"></i>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div style="font-size: 12px; color: var(--text-muted); font-weight: 500;">
                                    ${rev.createdAt}
                                </div>
                            </div>
                            <div style="font-size: 13px; color: var(--primary); line-height: 1.5; padding-left: 40px; white-space: pre-line;">
                                ${rev.comment}
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4" style="color: var(--text-muted); font-size: 14px;">
                        <i class="bi bi-chat-square-text" style="font-size: 32px; display: block; margin-bottom: 8px; opacity: 0.5;"></i>
                        Chưa có đánh giá nào cho sản phẩm này. Hãy là người đầu tiên đánh giá!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Related Products -->
    <c:if test="${not empty relatedProducts}">
        <section class="mt-5">
            <h2 class="section-title" style="margin-bottom:20px;">Sản phẩm tương tự</h2>
            <div class="cps-product-grid">
                <c:forEach var="related" items="${relatedProducts}" begin="0" end="4">
                    <div class="cps-product-card" onclick="window.location.href='${pageContext.request.contextPath}/shop/product/${related.id}'">
                        <div class="cps-product-thumb">
                            <c:if test="${related.onSale}">
                                <span class="cps-product-badge">SALE</span>
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
                        <div class="cps-product-body">
                            <div style="font-size:11px;color:var(--text-muted);font-weight:500;text-transform:uppercase;margin-bottom:4px;">${related.category.name}</div>
                            <h3 class="cps-product-name" style="font-size:13.5px;font-weight:600;margin-bottom:6px;">
                                <a href="${pageContext.request.contextPath}/shop/product/${related.id}" style="color:inherit;text-decoration:none;">${related.name}</a>
                            </h3>
                            <div class="cps-product-price-row">
                                <span class="cps-product-price">
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
    var sizeInput = document.getElementById('selectedProductSize');
    var size = sizeInput ? sizeInput.value : '';
    
    if (document.getElementById('sizeSelectorContainer') && !size) {
        showToast('Vui lòng chọn kích cỡ sản phẩm!', 'error');
        return;
    }

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
        body: 'productId=' + productId + '&quantity=' + qty + '&size=' + encodeURIComponent(size)
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
    var sizeInput = document.getElementById('selectedProductSize');
    var size = sizeInput ? sizeInput.value : '';
    
    if (document.getElementById('sizeSelectorContainer') && !size) {
        showToast('Vui lòng chọn kích cỡ sản phẩm!', 'error');
        return;
    }

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
        body: 'productId=' + productId + '&quantity=' + qty + '&size=' + encodeURIComponent(size)
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

function selectProductSize(size) {
    var input = document.getElementById('selectedProductSize');
    if (input) {
        input.value = size;
    }
    var buttons = document.querySelectorAll('.btn-size-option');
    buttons.forEach(btn => {
        if (btn.getAttribute('data-size') === size) {
            btn.classList.add('active');
        } else {
            btn.classList.remove('active');
        }
    });
}

function showSizeGuide() {
    alert("Hướng dẫn chọn cỡ:\n- Quần áo: S (45-55kg), M (55-65kg), L (65-75kg), XL (75-85kg), XXL (>85kg).\n- Giày dép: 38 (24cm), 39 (24.5cm), 40 (25cm), 41 (25.5cm), 42 (26cm), 43 (26.5cm).");
}

/* ===== REVIEWS & RATINGS ===== */
let selectedRating = 5;

function toggleReviewForm() {
    var container = document.getElementById('review-form-container');
    if (!container) return;
    container.style.display = container.style.display === 'none' ? 'block' : 'none';
}

function setSelectStars(rating) {
    selectedRating = rating;
    document.getElementById('review-rating').value = rating;
    updateStarsDisplay(rating);
}

function highlightSelectStars(rating) {
    updateStarsDisplay(rating);
}

function resetSelectStars() {
    updateStarsDisplay(selectedRating);
}

function updateStarsDisplay(rating) {
    var stars = document.querySelectorAll('.star-select');
    stars.forEach((star, idx) => {
        if (idx < rating) {
            star.className = 'bi bi-star-fill star-select';
            star.style.color = '#fbbf24';
        } else {
            star.className = 'bi bi-star star-select';
            star.style.color = '#cbd5e1';
        }
    });
}

function submitReview(event) {
    event.preventDefault();
    var productId = ${product.id};
    var rating = document.getElementById('review-rating').value;
    var comment = document.getElementById('review-comment').value;

    var csrfToken  = document.querySelector('meta[name="_csrf"]')?.getAttribute('content') || '';
    var csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content') || 'X-CSRF-TOKEN';

    fetch(window.CTX + '/shop/product/' + productId + '/review', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            [csrfHeader]: csrfToken
        },
        body: 'rating=' + rating + '&comment=' + encodeURIComponent(comment)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            showToast(data.message, 'success');
            setTimeout(() => { window.location.reload(); }, 1500);
        } else {
            showToast(data.message, 'error');
        }
    })
    .catch(() => {
        showToast('Vui lòng đăng nhập để gửi đánh giá', 'error');
    });
}

document.addEventListener('DOMContentLoaded', () => {
    if (document.querySelector('.star-select')) {
        updateStarsDisplay(5);
    }
});
</script>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
