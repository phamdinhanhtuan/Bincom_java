<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"   value="${empty product.id ? 'Thêm sản phẩm' : 'Chỉnh sửa sản phẩm'}" scope="request"/>
<c:set var="currentPage" value="products" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<style>
.upload-zone {
    border: 2px dashed rgba(99,102,241,.35);
    border-radius: 14px;
    padding: 24px;
    text-align: center;
    cursor: pointer;
    transition: all .2s;
    background: rgba(99,102,241,.03);
    position: relative;
}
.upload-zone:hover { border-color: #6366f1; background: rgba(99,102,241,.07); }
.upload-zone input[type=file] { position:absolute;inset:0;opacity:0;cursor:pointer;width:100%;height:100%; }
.thumb-preview {
    width: 100%; height: 200px;
    object-fit: cover;
    border-radius: 12px;
    border: 1px solid rgba(0,0,0,.08);
    margin-bottom: 12px;
    display: block;
}
.thumb-placeholder {
    width:100%; height:200px;
    background: linear-gradient(135deg,#f5f3ff,#ede9fe);
    border-radius:12px;
    display:flex; flex-direction:column;
    align-items:center; justify-content:center;
    color: #a5b4fc; font-size: 48px;
    margin-bottom: 12px;
    border: 2px dashed rgba(99,102,241,.25);
}
.thumb-placeholder p { font-size:13px; margin:8px 0 0; color:#94a3b8; }
.multi-preview { display:flex; gap:8px; flex-wrap:wrap; margin-top:12px; }
.multi-preview img { width:64px; height:64px; object-fit:cover; border-radius:8px; border:1px solid #e2e8f0; }
.form-label { font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:.5px; color:#64748b; margin-bottom:6px; }
.price-badge { display:inline-flex; align-items:center; gap:6px; background:#f0fdf4; color:#16a34a; border-radius:8px; padding:6px 12px; font-size:13px; font-weight:600; margin-top:8px; }
.price-badge.sale { background:#fff7ed; color:#ea580c; }
.existing-image-container {
    position: relative;
    display: inline-block;
    width: 64px;
    height: 64px;
}
.existing-image-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 8px;
    border: 1px solid #e2e8f0;
}
.existing-image-container .delete-btn {
    position: absolute;
    top: -6px;
    right: -6px;
    background: #ef4444;
    color: white;
    border: none;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 11px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
    transition: background 0.2s;
}
.existing-image-container .delete-btn:hover {
    background: #dc2626;
}
</style>

<div class="page-header">
    <div>
        <h5>${empty product.id ? 'Thêm sản phẩm mới' : 'Chỉnh sửa: '}${product.name}</h5>
        <p>${empty product.id ? 'Điền đầy đủ thông tin để thêm sản phẩm mới' : 'Cập nhật thông tin sản phẩm #'}${product.productCode}</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary">
        <i class="bi bi-arrow-left me-1"></i>Quay lại
    </a>
</div>

<c:choose>
    <c:when test="${empty product.id}">
        <c:set var="formAction" value="${pageContext.request.contextPath}/admin/products/save"/>
    </c:when>
    <c:otherwise>
        <c:set var="formAction" value="${pageContext.request.contextPath}/admin/products/${product.id}/update"/>
    </c:otherwise>
</c:choose>
<form action="${formAction}?${_csrf.parameterName}=${_csrf.token}"
      method="post" enctype="multipart/form-data" id="productForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <div class="row g-4">
        <!-- ===== LEFT COLUMN ===== -->
        <div class="col-lg-8">

            <!-- Thông tin cơ bản -->
            <div class="card mb-4">
                <div class="card-header">
                    <span><i class="bi bi-info-circle-fill me-2 text-primary"></i>Thông tin sản phẩm</span>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">Tên sản phẩm *</label>
                            <input type="text" name="name" class="form-control form-control-lg" required
                                   value="${product.name}" placeholder="VD: iPhone 15 Pro Max 256GB"
                                   oninput="updateTitle(this.value)">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Mã sản phẩm</label>
                            <input type="text" name="productCode" class="form-control"
                                   value="${product.productCode}" placeholder="Auto nếu để trống">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Danh mục *</label>
                            <select name="category.id" class="form-select" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}"
                                            ${product.category != null && product.category.id == cat.id ? 'selected' : ''}>
                                        ${cat.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Giá bán gốc *</label>
                            <div class="input-group">
                                <input type="number" name="price" id="priceInput" class="form-control" required min="0"
                                       value="${product.price}" placeholder="0"
                                       oninput="updatePriceDisplay()">
                                <span class="input-group-text fw-bold">₫</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Giá khuyến mãi <span class="text-muted">(tùy chọn)</span></label>
                            <div class="input-group">
                                <input type="number" name="salePrice" id="salePriceInput" class="form-control" min="0"
                                       value="${product.salePrice}" placeholder="Để trống = không giảm"
                                       oninput="updatePriceDisplay()">
                                <span class="input-group-text fw-bold">₫</span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div id="priceDisplay" style="display:none;"></div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Mô tả ngắn</label>
                            <input type="text" name="shortDescription" class="form-control"
                                   value="${product.shortDescription}"
                                   placeholder="Mô tả 1 dòng ngắn gọn..." maxlength="500">
                            <div class="text-muted small mt-1">Hiển thị trong danh sách sản phẩm</div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Mô tả chi tiết</label>
                            <textarea name="description" class="form-control" rows="6"
                                      placeholder="Mô tả đầy đủ — tính năng, thông số, chất liệu...">${product.description}</textarea>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tồn kho -->
            <div class="card mb-4">
                <div class="card-header">
                    <span><i class="bi bi-box-seam-fill me-2 text-warning"></i>Quản lý tồn kho</span>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Số lượng trong kho</label>
                            <input type="number" name="stockQty" class="form-control" min="0"
                                   id="stockInput"
                                   value="${product.inventory != null ? product.inventory.quantityInStock : 0}"
                                   oninput="updateStockBadge()">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Mức cảnh báo tồn thấp</label>
                            <input type="number" name="reorderLevel" class="form-control" min="0"
                                   value="${product.inventory != null ? product.inventory.reorderLevel : 10}">
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <div id="stockBadge" class="w-100 text-center"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== RIGHT COLUMN ===== -->
        <div class="col-lg-4">

            <!-- Upload ảnh -->
            <div class="card mb-4">
                <div class="card-header">
                    <span><i class="bi bi-images me-2 text-success"></i>Ảnh sản phẩm</span>
                </div>
                <div class="card-body">
                    <!-- Thumbnail preview -->
                    <div id="thumbContainer" style="position: relative;">
                        <c:choose>
                            <c:when test="${not empty product.thumbnailUrl}">
                                <img id="thumbImg"
                                     src="${pageContext.request.contextPath}${product.thumbnailUrl}"
                                     class="thumb-preview">
                                <button type="button" class="delete-btn" style="position: absolute; top: 10px; right: 10px; background: #ef4444; color: white; border: none; border-radius: 50%; width: 28px; height: 28px; display: flex; align-items: center; justify-content: center; font-size: 16px; cursor: pointer; box-shadow: 0 2px 4px rgba(0,0,0,0.15);" onclick="deleteThumbnail(${product.id})" title="Xóa ảnh đại diện">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <div class="thumb-placeholder" id="thumbPlaceholder">
                                    <i class="bi bi-image-fill"></i>
                                    <p>Click để chọn ảnh chính</p>
                                </div>
                                <img id="thumbImg" src="" class="thumb-preview" style="display:none;">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Upload zone thumbnail -->
                    <div class="upload-zone">
                        <input type="file" name="thumbnailFile" accept="image/*"
                               onchange="previewThumb(this)" id="thumbFile">
                        <i class="bi bi-cloud-arrow-up fs-3 text-primary"></i>
                        <div class="mt-2 fw-medium" style="font-size:14px;">Chọn ảnh thumbnail</div>
                        <div class="text-muted small">JPG, PNG, WEBP — Tối đa 5MB</div>
                    </div>

                    <hr style="margin:16px 0;">

                    <label class="form-label">Ảnh bổ sung (tối đa 5)</label>
                    <div class="upload-zone" style="padding:16px;">
                        <input type="file" name="imageFiles" accept="image/*" multiple
                               onchange="previewMulti(this)">
                        <i class="bi bi-images fs-4 text-muted"></i>
                        <div class="small text-muted mt-1">Chọn nhiều ảnh cùng lúc</div>
                    </div>
                    <div class="multi-preview" id="multiPreview"></div>

                    <!-- Existing Additional Images -->
                    <c:if test="${not empty product.images}">
                        <div style="font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:.5px; color:#64748b; margin-top:20px; margin-bottom:8px;">Ảnh hiện tại</div>
                        <div style="display:flex; gap:12px; flex-wrap:wrap; margin-bottom:8px;" id="existingImagesList">
                            <c:forEach var="img" items="${product.images}">
                                <div class="existing-image-container" id="img-container-${img.id}">
                                    <img src="${pageContext.request.contextPath}${img.imageUrl}" alt="${img.altText}">
                                    <button type="button" class="delete-btn" onclick="deleteExistingImage(${img.id})" title="Xóa ảnh này">
                                        <i class="bi bi-x"></i>
                                    </button>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Tùy chọn -->
            <div class="card mb-4">
                <div class="card-header">
                    <span><i class="bi bi-toggles me-2 text-info"></i>Tùy chọn</span>
                </div>
                <div class="card-body">
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" name="active" id="activeCheck"
                               ${product.active || product.id == null ? 'checked' : ''}>
                        <label class="form-check-label fw-medium" for="activeCheck">
                            <i class="bi bi-eye-fill me-1 text-success"></i>Hiển thị (Đang bán)
                        </label>
                    </div>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="featured" id="featuredCheck"
                               ${product.featured ? 'checked' : ''}>
                        <label class="form-check-label fw-medium" for="featuredCheck">
                            <i class="bi bi-star-fill me-1 text-warning"></i>Sản phẩm nổi bật
                        </label>
                    </div>
                </div>
            </div>

            <!-- Submit -->
            <button type="submit" class="btn-primary-custom w-100 justify-content-center" style="font-size:16px; padding:14px;">
                <i class="bi bi-floppy-fill"></i>
                ${empty product.id ? 'Thêm sản phẩm' : 'Lưu thay đổi'}
            </button>
            <c:if test="${not empty product.id}">
                <a href="${pageContext.request.contextPath}/admin/products/${product.id}/edit"
                   class="btn btn-outline-secondary w-100 mt-2">
                    <i class="bi bi-arrow-counterclockwise me-1"></i>Đặt lại
                </a>
            </c:if>
        </div>
    </div>
</form>

<script>
// === Image Preview ===
function previewThumb(input) {
    const file = input.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = e => {
        const img = document.getElementById('thumbImg');
        const placeholder = document.getElementById('thumbPlaceholder');
        img.src = e.target.result;
        img.style.display = 'block';
        if (placeholder) placeholder.style.display = 'none';
    };
    reader.readAsDataURL(file);
}

function previewMulti(input) {
    const container = document.getElementById('multiPreview');
    container.innerHTML = '';
    Array.from(input.files).slice(0, 5).forEach(file => {
        const reader = new FileReader();
        reader.onload = e => {
            const img = document.createElement('img');
            img.src = e.target.result;
            container.appendChild(img);
        };
        reader.readAsDataURL(file);
    });
}

// === Price display ===
function updatePriceDisplay() {
    const price    = parseFloat(document.getElementById('priceInput').value) || 0;
    const sale     = parseFloat(document.getElementById('salePriceInput').value) || 0;
    const display  = document.getElementById('priceDisplay');
    const fmt      = function(n) { return n.toLocaleString('vi-VN') + '₫'; };

    if (price > 0) {
        display.style.display = 'block';
        if (sale > 0 && sale < price) {
            const pct = Math.round((price - sale) / price * 100);
            display.innerHTML = 
                '<span class="price-badge">Giá bán: ' + fmt(price) + '</span>' +
                '<span class="price-badge sale ms-2">Sau giảm: ' + fmt(sale) + ' (−' + pct + '%)</span>';
        } else {
            display.innerHTML = '<span class="price-badge">Giá bán: ' + fmt(price) + '</span>';
        }
    } else {
        display.style.display = 'none';
    }
}

// === Stock badge ===
function updateStockBadge() {
    const qty    = parseInt(document.getElementById('stockInput').value) || 0;
    const badge  = document.getElementById('stockBadge');
    if (qty === 0) {
        badge.innerHTML = '<span class="status-badge inactive">Hết hàng</span>';
    } else if (qty < 10) {
        badge.innerHTML = '<span class="status-badge pending">Tồn thấp: ' + qty + '</span>';
    } else {
        badge.innerHTML = '<span class="status-badge active">Còn hàng: ' + qty + '</span>';
    }
}

// Run on page load
updatePriceDisplay();
updateStockBadge();

function deleteExistingImage(imageId) {
    if (!confirm('Bạn có chắc chắn muốn xóa ảnh này không?')) return;
    
    // Fetch CSRF Token
    const csrfHeader = document.querySelector("meta[name='_csrf_header']")?.getAttribute("content") || "X-CSRF-TOKEN";
    const csrfToken = document.querySelector("meta[name='_csrf']")?.getAttribute("content");
    
    const headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
    };
    if (csrfToken) {
        headers[csrfHeader] = csrfToken;
    }
    
    fetch(window.CTX + '/admin/products/images/' + imageId + '/delete', {
        method: 'POST',
        headers: headers
    })
    .then(response => {
        if (response.ok) {
            const container = document.getElementById('img-container-' + imageId);
            if (container) {
                container.style.transition = 'opacity 0.3s';
                container.style.opacity = '0';
                setTimeout(() => container.remove(), 300);
            }
        } else {
            response.text().then(text => alert('Lỗi khi xóa ảnh: ' + text));
        }
    })
    .catch(error => {
        alert('Lỗi khi xóa ảnh: ' + error);
    });
}

function deleteThumbnail(productId) {
    if (!confirm('Bạn có chắc chắn muốn xóa ảnh đại diện này không?')) return;
    
    const csrfHeader = document.querySelector("meta[name='_csrf_header']")?.getAttribute("content") || "X-CSRF-TOKEN";
    const csrfToken = document.querySelector("meta[name='_csrf']")?.getAttribute("content");
    
    const headers = {};
    if (csrfToken) {
        headers[csrfHeader] = csrfToken;
    }
    
    fetch(window.CTX + '/admin/products/' + productId + '/delete-thumbnail', {
        method: 'POST',
        headers: headers
    })
    .then(response => {
        if (response.ok) {
            const container = document.getElementById('thumbContainer');
            if (container) {
                container.innerHTML = `
                    <div class="thumb-placeholder" id="thumbPlaceholder">
                        <i class="bi bi-image-fill"></i>
                        <p>Click để chọn ảnh chính</p>
                    </div>
                    <img id="thumbImg" src="" class="thumb-preview" style="display:none;">
                `;
            }
        } else {
            response.text().then(text => alert('Lỗi khi xóa ảnh đại diện: ' + text));
        }
    })
    .catch(error => {
        alert('Lỗi khi xóa ảnh đại diện: ' + error);
    });
}
</script>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
