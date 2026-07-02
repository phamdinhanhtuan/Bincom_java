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
                    <c:when test="${not empty product.thumbnailUrl && product.thumbnailUrl.startsWith('data:')}">
                        <img id="mainImage"
                             src="${product.thumbnailUrl}"
                             alt="${product.name}"
                             style="width:100%; height:100%; object-fit:contain; padding:16px;">
                    </c:when>
                    <c:when test="${not empty product.thumbnailUrl}">
                        <img id="mainImage"
                             src="${product.thumbnailUrl.startsWith('data:') ? '' : pageContext.request.contextPath}${product.thumbnailUrl}"
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
                        <c:choose>
                            <c:when test="${product.thumbnailUrl.startsWith('data:')}">
                                <img src="${product.thumbnailUrl}"
                                     onclick="document.getElementById('mainImage').src=this.src; updateActiveThumb(this)"
                                     style="width:64px; height:64px; object-fit:contain; padding:4px; background:#fff; border-radius:8px; border:2px solid var(--accent); cursor:pointer;" alt="">
                            </c:when>
                            <c:otherwise>
                                <img src="${product.thumbnailUrl.startsWith('data:') ? '' : pageContext.request.contextPath}${product.thumbnailUrl}"
                                     onclick="document.getElementById('mainImage').src=this.src; updateActiveThumb(this)"
                                     style="width:64px; height:64px; object-fit:contain; padding:4px; background:#fff; border-radius:8px; border:2px solid var(--accent); cursor:pointer;" alt="">
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:forEach var="img" items="${product.images}">
                        <c:choose>
                            <c:when test="${img.imageUrl.startsWith('data:')}">
                                <img src="${img.imageUrl}"
                                     onclick="document.getElementById('mainImage').src=this.src; updateActiveThumb(this)"
                                     style="width:64px; height:64px; object-fit:contain; padding:4px; background:#fff; border-radius:8px; border:2px solid var(--border); cursor:pointer; transition:border-color 0.2s;"
                                     alt="Ảnh sản phẩm">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}${img.imageUrl}"
                                     onclick="document.getElementById('mainImage').src=this.src; updateActiveThumb(this)"
                                     style="width:64px; height:64px; object-fit:contain; padding:4px; background:#fff; border-radius:8px; border:2px solid var(--border); cursor:pointer; transition:border-color 0.2s;"
                                     alt="Ảnh sản phẩm">
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <!-- Product Info (Right) -->
        <div class="col-lg-7" style="display:flex; flex-direction:column; justify-content:space-between;">
            <div>
                <c:if test="${not empty product.category}">
                    <div class="mb-2">
                        <a href="${pageContext.request.contextPath}/shop?categoryId=${product.category.id}"
                           style="color:var(--accent); font-size:13px; font-weight:700; text-transform:uppercase; letter-spacing:0.5px;">
                            ${product.category.name}
                        </a>
                    </div>
                </c:if>

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
                <c:set var="catName" value="${not empty product.category ? fn:toLowerCase(product.category.name) : ''}" />
                <c:if test="${not empty product.category && (product.category.id == 11 || product.category.id == 12 || fn:contains(catName, 'quần áo') || fn:contains(catName, 'giày') || fn:contains(catName, 'dép'))}">
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
                                    <c:forTokens var="sz" items="S,M,L,XL,XXL" delims=",">
                                        <button type="button" class="btn-size-option" onclick="selectProductSize('${sz}')" data-size="${sz}">
                                            ${sz}
                                        </button>
                                    </c:forTokens>
                                </c:when>
                                <c:otherwise>
                                    <c:forTokens var="sz" items="35,36,37,38,39,40,41,42,43" delims=",">
                                        <button type="button" class="btn-size-option" onclick="selectProductSize('${sz}')" data-size="${sz}">
                                            ${sz}
                                        </button>
                                    </c:forTokens>
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
                        <td>${not empty product.category ? product.category.name : 'Chưa phân loại'}</td>
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
                                <c:when test="${not empty related.thumbnailUrl && related.thumbnailUrl.startsWith('data:')}">
                                    <img src="${related.thumbnailUrl}" alt="${related.name}"/>
                                </c:when>
                                <c:when test="${not empty related.thumbnailUrl}">
                                    <img src="${related.thumbnailUrl.startsWith('data:') ? '' : pageContext.request.contextPath}${related.thumbnailUrl}" alt="${related.name}" onerror="this.src='https://placehold.co/300x400?text=Bincom'"/>
                                </c:when>
                                <c:otherwise>
                                    <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:#f1f5f9;color:#94a3b8;font-size:30px;">
                                        <i class="bi bi-image"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="cps-product-body">
                            <div style="font-size:11px;color:var(--text-muted);font-weight:500;text-transform:uppercase;margin-bottom:4px;">${not empty related.category ? related.category.name : 'Chưa phân loại'}</div>
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
/* --- Size Guide Modal styles (injected here to keep it self-contained) --- */
(function(){
var s = document.createElement('style');
s.textContent = `
/* ===== SIZE GUIDE MODAL ===== */
.sg-overlay { display:none; position:fixed; inset:0; z-index:9999; background:rgba(0,0,0,.55); backdrop-filter:blur(4px); justify-content:center; align-items:center; padding:20px; }
.sg-overlay.active { display:flex; animation: sgFadeIn .3s ease; }
@keyframes sgFadeIn { from{opacity:0} to{opacity:1} }
@keyframes sgSlideUp { from{transform:translateY(40px);opacity:0} to{transform:translateY(0);opacity:1} }

.sg-modal {
    background:#fff; border-radius:20px; max-width:520px; width:100%;
    box-shadow:0 25px 60px rgba(0,0,0,.25); overflow:hidden; position:relative;
    animation: sgSlideUp .4s cubic-bezier(.16,1,.3,1);
}
.sg-close {
    position:absolute; top:12px; right:12px; z-index:2;
    width:36px; height:36px; border-radius:50%; border:none;
    background:rgba(255,255,255,.85); cursor:pointer; font-size:18px;
    display:flex; align-items:center; justify-content:center;
    color:#333; transition:all .2s; box-shadow:0 2px 8px rgba(0,0,0,.1);
}
.sg-close:hover { background:#fff; transform:scale(1.1); }

/* Header */
.sg-header {
    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 50%, #f0932b 100%);
    padding:28px 24px 20px; text-align:center; position:relative; overflow:hidden;
}
.sg-header::before {
    content:''; position:absolute; inset:0;
    background:url("data:image/svg+xml,%3Csvg width='60' height='60' xmlns='http://www.w3.org/2000/svg'%3E%3Ccircle cx='30' cy='30' r='2' fill='rgba(255,255,255,0.15)'/%3E%3C/svg%3E");
}
.sg-header-emoji { font-size:48px; margin-bottom:6px; position:relative; animation: sgBounce 2s infinite; }
@keyframes sgBounce { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-8px)} }
.sg-header h2 { color:#fff; font-size:26px; font-weight:800; margin:0; position:relative; text-shadow:0 2px 8px rgba(0,0,0,.15); }
.sg-header p { color:rgba(255,255,255,.9); font-size:13px; margin:6px 0 0; position:relative; font-weight:500; }

/* Countdown */
.sg-countdown-wrap { display:flex; justify-content:center; gap:4px; margin-top:14px; position:relative; }
.sg-cd-num { background:rgba(0,0,0,.35); color:#fff; padding:5px 9px; border-radius:6px; font-size:16px; font-weight:800; font-family:'Inter',monospace; min-width:36px; text-align:center; display:inline-block; }
.sg-cd-sep { color:#fff; font-weight:800; font-size:16px; line-height:32px; }

/* Body */
.sg-body { padding:20px 24px 24px; }

/* Coupon card */
.sg-coupon {
    background: linear-gradient(135deg, #fff5f5, #ffe8e8);
    border:2px dashed #ff6b6b; border-radius:14px; padding:16px;
    text-align:center; margin-bottom:20px; position:relative;
}
.sg-coupon-badge { font-size:36px; font-weight:900; color:#ee5a24; line-height:1; }
.sg-coupon-label { font-size:13px; color:#666; margin-top:2px; font-weight:600; }
.sg-coupon-code {
    display:inline-flex; align-items:center; gap:8px; margin-top:10px;
    background:#fff; border:1.5px solid #ff6b6b; border-radius:8px; padding:6px 14px;
}
.sg-coupon-code span { font-weight:800; font-size:15px; color:#ee5a24; letter-spacing:1.5px; }
.sg-coupon-code button {
    background:linear-gradient(135deg,#ff6b6b,#ee5a24); color:#fff; border:none;
    padding:5px 14px; border-radius:6px; font-size:12px; font-weight:700;
    cursor:pointer; transition:all .2s;
}
.sg-coupon-code button:hover { transform:scale(1.05); }

/* Tabs */
.sg-tabs { display:flex; gap:0; margin-bottom:16px; border-radius:10px; overflow:hidden; border:1px solid #e5e7eb; }
.sg-tab {
    flex:1; padding:10px; text-align:center; font-size:13px; font-weight:700;
    cursor:pointer; background:#f9fafb; color:#6b7280; transition:all .2s; border:none;
}
.sg-tab.active { background:linear-gradient(135deg,#ff6b6b,#ee5a24); color:#fff; }
.sg-tab:hover:not(.active) { background:#f3f4f6; }

/* Table */
.sg-table-wrap { max-height:220px; overflow-y:auto; border-radius:10px; border:1px solid #e5e7eb; }
.sg-table-wrap::-webkit-scrollbar { width:4px; }
.sg-table-wrap::-webkit-scrollbar-thumb { background:#ddd; border-radius:4px; }
.sg-table { width:100%; border-collapse:collapse; font-size:13px; }
.sg-table thead th {
    background:linear-gradient(135deg,#1a1a2e,#16213e); color:#fff;
    padding:10px 12px; font-weight:700; position:sticky; top:0; z-index:1;
    text-align:center; font-size:12px; text-transform:uppercase; letter-spacing:.5px;
}
.sg-table tbody td { padding:9px 12px; text-align:center; border-bottom:1px solid #f3f4f6; color:#374151; font-weight:500; }
.sg-table tbody tr:hover { background:#fef2f2; }
.sg-table tbody tr:nth-child(even) { background:#fafafa; }
.sg-table tbody tr:nth-child(even):hover { background:#fef2f2; }

/* CTA */
.sg-cta {
    display:block; width:100%; margin-top:18px; padding:15px;
    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 50%, #f0932b 100%);
    color:#fff; border:none; border-radius:14px; font-size:16px; font-weight:800;
    cursor:pointer; transition:all .3s; text-align:center;
    box-shadow: 0 4px 15px rgba(238,90,36,.3);
}
.sg-cta:hover { transform:translateY(-2px); box-shadow:0 6px 20px rgba(238,90,36,.4); }

@media(max-width:480px) {
    .sg-modal { border-radius:16px; }
    .sg-header { padding:20px 16px 16px; }
    .sg-header h2 { font-size:22px; }
    .sg-body { padding:16px; }
    .sg-coupon-badge { font-size:28px; }
}
`;
document.head.appendChild(s);
})();
</script>

<!-- ===== SIZE GUIDE MODAL (SHEIN-style) ===== -->
<div id="sizeGuideModal" class="sg-overlay" onclick="if(event.target===this)closeSizeGuide()">
    <div class="sg-modal">
        <button class="sg-close" onclick="closeSizeGuide()" aria-label="Đóng">&times;</button>

        <!-- Header with gradient & emoji -->
        <div class="sg-header">
            <div class="sg-header-emoji">🎁</div>
            <h2>Chúc mừng!</h2>
            <p>Chọn đúng size — nhận ngay ưu đãi đặc biệt</p>
            <div class="sg-countdown-wrap" id="sgCountdown">
                <span class="sg-cd-num">23</span><span class="sg-cd-sep">:</span>
                <span class="sg-cd-num">59</span><span class="sg-cd-sep">:</span>
                <span class="sg-cd-num">59</span>
            </div>
        </div>

        <div class="sg-body">
            <!-- Coupon -->
            <div class="sg-coupon">
                <div class="sg-coupon-badge">-15%</div>
                <div class="sg-coupon-label">Gói phiếu giảm giá cho đơn hàng đầu tiên</div>
                <div class="sg-coupon-code">
                    <span>SIZE15</span>
                    <button id="sgCopyBtn" onclick="copySizeGuideCode()">Sao chép mã</button>
                </div>
            </div>

            <!-- Tabs -->
            <div class="sg-tabs">
                <button class="sg-tab active" onclick="switchSizeTab('clothing',this)">👕 Quần áo</button>
                <button class="sg-tab" onclick="switchSizeTab('shoes',this)">👟 Giày dép</button>
            </div>

            <!-- Clothing Table -->
            <div id="sgTabClothing" class="sg-table-wrap">
                <table class="sg-table">
                    <thead><tr><th>Size</th><th>Cân nặng</th><th>Chiều cao</th><th>Ngực</th><th>Eo</th></tr></thead>
                    <tbody>
                        <tr><td><strong>S</strong></td><td>45–55 kg</td><td>155–162 cm</td><td>82–86 cm</td><td>64–68 cm</td></tr>
                        <tr><td><strong>M</strong></td><td>55–65 kg</td><td>160–168 cm</td><td>86–90 cm</td><td>68–72 cm</td></tr>
                        <tr><td><strong>L</strong></td><td>65–75 kg</td><td>165–175 cm</td><td>90–96 cm</td><td>72–78 cm</td></tr>
                        <tr><td><strong>XL</strong></td><td>75–85 kg</td><td>170–180 cm</td><td>96–102 cm</td><td>78–84 cm</td></tr>
                        <tr><td><strong>XXL</strong></td><td>> 85 kg</td><td>175–185 cm</td><td>102–108 cm</td><td>84–90 cm</td></tr>
                    </tbody>
                </table>
            </div>

            <!-- Shoes Table -->
            <div id="sgTabShoes" class="sg-table-wrap" style="display:none;">
                <table class="sg-table">
                    <thead><tr><th>Size</th><th>Chiều dài bàn chân</th><th>EU</th><th>US (Nam)</th><th>US (Nữ)</th></tr></thead>
                    <tbody>
                        <tr><td><strong>35</strong></td><td>22.5 cm</td><td>35</td><td>4</td><td>5</td></tr>
                        <tr><td><strong>36</strong></td><td>23.0 cm</td><td>36</td><td>4.5</td><td>5.5</td></tr>
                        <tr><td><strong>37</strong></td><td>23.5 cm</td><td>37</td><td>5</td><td>6</td></tr>
                        <tr><td><strong>38</strong></td><td>24.0 cm</td><td>38</td><td>6</td><td>7</td></tr>
                        <tr><td><strong>39</strong></td><td>24.5 cm</td><td>39</td><td>6.5</td><td>7.5</td></tr>
                        <tr><td><strong>40</strong></td><td>25.0 cm</td><td>40</td><td>7</td><td>8</td></tr>
                        <tr><td><strong>41</strong></td><td>25.5 cm</td><td>41</td><td>8</td><td>9</td></tr>
                        <tr><td><strong>42</strong></td><td>26.0 cm</td><td>42</td><td>8.5</td><td>9.5</td></tr>
                        <tr><td><strong>43</strong></td><td>26.5 cm</td><td>43</td><td>9.5</td><td>10.5</td></tr>
                    </tbody>
                </table>
            </div>

            <!-- CTA button -->
            <button class="sg-cta" onclick="closeSizeGuide()">
                Đã hiểu — Chọn size ngay!
            </button>
        </div>
    </div>
</div>

<script>
function switchSizeTab(tab, el) {
    document.querySelectorAll('.sg-tab').forEach(function(t){ t.classList.remove('active'); });
    el.classList.add('active');
    document.getElementById('sgTabClothing').style.display = tab==='clothing' ? '' : 'none';
    document.getElementById('sgTabShoes').style.display = tab==='shoes' ? '' : 'none';
}

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
    document.getElementById('sizeGuideModal').classList.add('active');
    document.body.style.overflow = 'hidden';
    startSizeGuideCountdown();
}
function closeSizeGuide() {
    document.getElementById('sizeGuideModal').classList.remove('active');
    document.body.style.overflow = '';
}
function startSizeGuideCountdown() {
    var end = new Date().getTime() + 24*60*60*1000;
    function tick() {
        var now = new Date().getTime();
        var d = end - now;
        if (d <= 0) return;
        var h = Math.floor(d/(1000*60*60));
        var m = Math.floor((d%(1000*60*60))/(1000*60));
        var s = Math.floor((d%(1000*60))/1000);
        var el = document.getElementById('sgCountdown');
        if (el) el.innerHTML =
            '<span class="sg-cd-num">' + String(h).padStart(2,'0') + '</span>' +
            '<span class="sg-cd-sep">:</span>' +
            '<span class="sg-cd-num">' + String(m).padStart(2,'0') + '</span>' +
            '<span class="sg-cd-sep">:</span>' +
            '<span class="sg-cd-num">' + String(s).padStart(2,'0') + '</span>';
        setTimeout(tick, 1000);
    }
    tick();
}
function copySizeGuideCode() {
    var code = 'SIZE15';
    navigator.clipboard.writeText(code).then(function() {
        var btn = document.getElementById('sgCopyBtn');
        btn.textContent = 'Đã sao chép!';
        btn.style.background = '#16a34a';
        setTimeout(function() { btn.textContent = 'Sao chép mã'; btn.style.background = ''; }, 2000);
    });
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
