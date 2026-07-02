<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"   value="${empty product.id ? 'Thêm sản phẩm' : 'Chỉnh sửa sản phẩm'}" scope="request"/>
<c:set var="currentPage" value="products" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<style>
/* Card Enhancements */
.card-custom {
    border: 1px solid var(--border-color);
    border-radius: var(--radius);
    background: var(--card-bg);
    box-shadow: var(--shadow-sm);
    transition: transform 0.22s cubic-bezier(.4,0,.2,1), box-shadow 0.22s cubic-bezier(.4,0,.2,1);
    margin-bottom: 24px;
    overflow: hidden;
}
.card-custom:hover {
    box-shadow: var(--shadow-md);
}
.card-custom .card-header {
    background: transparent;
    border-bottom: 1px solid var(--border-color);
    padding: 18px 24px;
    font-weight: 700;
    font-size: 15px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.card-custom .card-body {
    padding: 24px;
}

/* Upload zone */
.upload-zone-custom {
    border: 2px dashed rgba(13, 148, 136, 0.25);
    border-radius: 12px;
    padding: 28px 20px;
    text-align: center;
    cursor: pointer;
    background: rgba(13, 148, 136, 0.01);
    transition: all 0.22s ease-in-out;
    position: relative;
}
.upload-zone-custom:hover {
    border-color: var(--primary);
    background: rgba(13, 148, 136, 0.04);
}
.upload-zone-custom input[type=file] {
    position: absolute;
    inset: 0;
    opacity: 0;
    cursor: pointer;
    width: 100%;
    height: 100%;
    z-index: 2;
}

/* Thumbnails and placeholders */
.thumb-preview-container {
    position: relative;
    border-radius: 12px;
    overflow: hidden;
    margin-bottom: 16px;
    box-shadow: var(--shadow-sm);
    border: 1px solid var(--border-color);
}
.thumb-preview-custom {
    width: 100%;
    height: 220px;
    object-fit: cover;
    display: block;
    transition: transform 0.3s ease;
}
.thumb-preview-container:hover .thumb-preview-custom {
    transform: scale(1.02);
}
.thumb-placeholder-custom {
    width: 100%;
    height: 220px;
    background: linear-gradient(135deg, #f0fdfa, #ccfbf1);
    border-radius: 12px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: var(--primary);
    margin-bottom: 16px;
    border: 2px dashed rgba(13, 148, 136, 0.2);
    transition: background 0.25s ease;
}
.thumb-placeholder-custom i {
    font-size: 40px;
    margin-bottom: 8px;
    opacity: 0.8;
}
.thumb-placeholder-custom p {
    font-size: 13px;
    margin: 0;
    color: var(--text-secondary);
    font-weight: 600;
}

/* Badge tags */
.file-info-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    background: #f1f5f9;
    color: var(--text-secondary);
    border-radius: 6px;
    padding: 5px 10px;
    font-size: 12px;
    font-weight: 500;
    margin-top: 8px;
}
.price-tag-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 600;
    box-shadow: var(--shadow-sm);
}
.price-tag-badge.original {
    background: #f8fafc;
    color: #475569;
    border: 1px solid #e2e8f0;
}
.price-tag-badge.promo {
    background: #ecfdf5;
    color: #047857;
    border: 1px solid #a7f3d0;
}

/* Form control customized */
.form-label-custom {
    font-size: 12.5px;
    font-weight: 600;
    color: var(--text-secondary);
    margin-bottom: 6px;
    display: flex;
    align-items: center;
    gap: 4px;
}
.form-control-custom {
    border: 1.5px solid var(--border-color);
    border-radius: var(--radius-sm);
    padding: 11px 16px;
    font-size: 14px;
    transition: all 0.2s ease-in-out;
    color: var(--text-primary);
    background: white;
}
.form-control-custom:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.12);
    outline: none;
}
.form-control-custom::placeholder {
    color: #cbd5e1;
}

/* Additional image layout */
.multi-preview-custom {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    margin-top: 12px;
}
.multi-preview-custom img {
    width: 68px;
    height: 68px;
    object-fit: cover;
    border-radius: 10px;
    border: 1px solid var(--border-color);
    box-shadow: var(--shadow-sm);
}

.existing-image-container {
    position: relative;
    display: inline-block;
    width: 68px;
    height: 68px;
}
.existing-image-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 10px;
    border: 1px solid var(--border-color);
    box-shadow: var(--shadow-sm);
}
.existing-image-container .delete-btn {
    position: absolute;
    top: -6px;
    right: -6px;
    background: var(--danger);
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
    box-shadow: 0 2px 6px rgba(0,0,0,0.2);
    transition: background 0.2s, transform 0.2s;
}
.existing-image-container .delete-btn:hover {
    background: #dc2626;
    transform: scale(1.1);
}

/* Floating Actions bar bottom (For premium layout) */
.form-actions-container {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin-top: 12px;
}
</style>

<div class="page-header">
    <div>
        <h5><i class="bi bi-pencil-square text-primary me-2"></i>${empty product.id ? 'Thêm sản phẩm mới' : 'Chỉnh sửa: '}${product.name}</h5>
        <p>${empty product.id ? 'Điền đầy đủ thông tin để thêm sản phẩm mới' : 'Cập nhật thông tin sản phẩm #'}${product.productCode}</p>
    </div>
    <div class="d-flex gap-2">
        <c:if test="${not empty product.id}">
            <a href="${pageContext.request.contextPath}/shop/product/${product.id}" class="btn btn-outline-primary d-inline-flex align-items-center gap-1" target="_blank">
                <i class="bi bi-eye"></i> Xem trên cửa hàng
            </a>
        </c:if>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary d-inline-flex align-items-center gap-1">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>
    </div>
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

    <spring:hasBindErrors name="product">
        <div class="alert alert-danger mb-4">
            <h6 class="alert-heading fw-bold mb-2"><i class="bi bi-exclamation-triangle-fill me-2"></i>Có lỗi nhập liệu:</h6>
            <ul class="mb-0 ps-3">
                <c:forEach var="err" items="${errors.allErrors}">
                    <li>${err.defaultMessage}</li>
                </c:forEach>
            </ul>
        </div>
    </spring:hasBindErrors>

    <div class="row g-4">
        <!-- ===== LEFT COLUMN ===== -->
        <div class="col-lg-8">

            <!-- Thông tin cơ bản -->
            <div class="card-custom">
                <div class="card-header">
                    <span><i class="bi bi-info-circle-fill me-2 text-primary"></i>Thông tin sản phẩm</span>
                    <span class="badge bg-light text-secondary">Bắt buộc (*)</span>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label-custom"><i class="bi bi-tag text-muted"></i> Tên sản phẩm *</label>
                            <input type="text" name="name" id="productNameInput" class="form-control form-control-custom form-control-lg" required
                                   value="${product.name}" placeholder="VD: iPhone 15 Pro Max 256GB"
                                   oninput="updateTitle(this.value)" maxlength="150">
                            <div class="d-flex justify-content-between mt-1">
                                <span class="text-muted small">Tên hiển thị trên storefront</span>
                                <span class="text-muted small" id="nameCharCount">0/150</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-custom"><i class="bi bi-qr-code text-muted"></i> Mã sản phẩm (SKU)</label>
                            <input type="text" name="productCode" class="form-control form-control-custom"
                                   value="${product.productCode}" placeholder="Auto-generate nếu để trống">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-custom"><i class="bi bi-folder2 text-muted"></i> Danh mục *</label>
                            <select name="category.id" class="form-select form-control-custom" required style="height: 48px;">
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}"
                                            ${product.category != null && product.category.id == cat.id ? 'selected' : ''}>
                                        <c:choose>
                                            <c:when test="${cat.parent != null}">
                                                &nbsp;&nbsp;&mdash;&nbsp;${cat.name} (thuộc ${cat.parent.name})
                                            </c:when>
                                            <c:otherwise>
                                                ${cat.name}
                                            </c:otherwise>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-custom"><i class="bi bi-cash text-muted"></i> Giá bán gốc *</label>
                            <div class="input-group">
                                <input type="number" name="price" id="priceInput" class="form-control form-control-custom" required min="0"
                                       value="${product.price}" placeholder="0"
                                       oninput="updatePriceDisplay()">
                                <span class="input-group-text fw-bold">₫</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-custom"><i class="bi bi-percent text-muted"></i> Giá khuyến mãi</label>
                            <div class="input-group">
                                <input type="number" name="salePrice" id="salePriceInput" class="form-control form-control-custom" min="0"
                                       value="${product.salePrice}" placeholder="Để trống = không giảm"
                                       oninput="updatePriceDisplay()">
                                <span class="input-group-text fw-bold">₫</span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div id="priceDisplay" style="display:flex; gap:10px; flex-wrap:wrap; margin-top:4px;"></div>
                        </div>
                        <div class="col-12">
                            <label class="form-label-custom"><i class="bi bi-card-text text-muted"></i> Mô tả ngắn</label>
                            <input type="text" name="shortDescription" id="shortDescInput" class="form-control form-control-custom"
                                   value="${product.shortDescription}"
                                   placeholder="Mô tả ngắn gọn trong 1 dòng để hiển thị ở danh sách sản phẩm..." maxlength="250">
                            <div class="d-flex justify-content-between mt-1">
                                <span class="text-muted small">Hiển thị trong danh sách sản phẩm</span>
                                <span class="text-muted small" id="shortDescCharCount">0/250</span>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label-custom"><i class="bi bi-file-text text-muted"></i> Mô tả chi tiết</label>
                            <textarea name="description" class="form-control form-control-custom" rows="6"
                                      placeholder="Mô tả đầy đủ — tính năng nổi bật, thông số kỹ thuật, chất liệu, hướng dẫn sử dụng...">${product.description}</textarea>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tồn kho -->
            <div class="card-custom">
                <div class="card-header">
                    <span><i class="bi bi-box-seam-fill me-2 text-warning"></i>Quản lý tồn kho</span>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label-custom">Số lượng trong kho</label>
                            <input type="number" name="stockQty" class="form-control form-control-custom" min="0"
                                   id="stockInput"
                                   value="${product.inventory != null ? product.inventory.quantityInStock : 0}"
                                   oninput="updateStockBadge()">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label-custom">Mức cảnh báo tồn thấp</label>
                            <input type="number" name="reorderLevel" class="form-control form-control-custom" min="0"
                                   value="${product.inventory != null ? product.inventory.reorderLevel : 10}">
                        </div>
                        <div class="col-md-4 d-flex align-items-center justify-content-center" style="padding-top: 28px;">
                            <div id="stockBadge" class="w-100 text-center"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== RIGHT COLUMN ===== -->
        <div class="col-lg-4">

            <!-- Upload ảnh -->
            <div class="card-custom">
                <div class="card-header">
                    <span><i class="bi bi-images me-2 text-success"></i>Ảnh đại diện</span>
                </div>
                <div class="card-body">
                    <!-- Thumbnail preview -->
                    <div id="thumbContainer">
                        <c:choose>
                            <c:when test="${not empty product.id && not empty product.thumbnailUrl}">
                                <div class="thumb-preview-container">
                                    <c:choose>
                                        <c:when test="${product.thumbnailUrl.startsWith('data:')}">
                                            <img id="thumbImg" src="${product.thumbnailUrl}" class="thumb-preview-custom">
                                        </c:when>
                                        <c:otherwise>
                                            <img id="thumbImg" src="${product.thumbnailUrl.startsWith('data:') ? '' : pageContext.request.contextPath}${product.thumbnailUrl}" class="thumb-preview-custom">
                                        </c:otherwise>
                                    </c:choose>
                                    <button type="button" class="delete-btn" style="position: absolute; top: 12px; right: 12px; background: rgba(239, 68, 68, 0.9); color: white; border: none; border-radius: 50%; width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; font-size: 16px; cursor: pointer; box-shadow: 0 4px 10px rgba(0,0,0,0.3); transition: all 0.2s;" onclick="deleteThumbnail(${product.id})" title="Xóa ảnh đại diện">
                                        <i class="bi bi-trash3-fill"></i>
                                    </button>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="thumb-placeholder-custom" id="thumbPlaceholder">
                                    <i class="bi bi-cloud-arrow-up-fill"></i>
                                    <p>Chưa có ảnh đại diện</p>
                                </div>
                                <div class="thumb-preview-container" style="display:none;" id="newThumbPreviewContainer">
                                    <img id="thumbImg" src="" class="thumb-preview-custom">
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Upload zone thumbnail -->
                    <div class="upload-zone-custom">
                        <input type="file" name="thumbnailFile" accept="image/*"
                               onchange="previewThumb(this)" id="thumbFile">
                        <i class="bi bi-camera-fill fs-3 text-primary"></i>
                        <div class="mt-2 fw-bold text-dark" style="font-size:13.5px;">Chọn ảnh chính</div>
                        <div class="text-muted small">JPG, PNG, WEBP — Tối đa 5MB</div>
                    </div>
                    <div id="thumbFileNameDisplay" style="display:none;"></div>

                    <hr style="margin:20px 0; border-color: var(--border-color);">

                    <label class="form-label-custom"><i class="bi bi-images text-muted"></i> Ảnh bổ sung (tối đa 5)</label>
                    <div class="upload-zone-custom" style="padding: 20px 10px;">
                        <input type="file" name="imageFiles" accept="image/*" multiple
                               onchange="previewMulti(this)" id="multiFileInput">
                        <i class="bi bi-plus-circle-dotted fs-4 text-muted"></i>
                        <div class="small fw-semibold text-secondary mt-1">Chọn nhiều ảnh cùng lúc</div>
                    </div>
                    <div id="multiFileNameDisplay" style="display:none;"></div>
                    <div class="multi-preview-custom" id="multiPreview"></div>

                    <!-- Existing Additional Images -->
                    <c:if test="${not empty product.images}">
                        <div style="font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:.8px; color:var(--text-secondary); margin-top:24px; margin-bottom:10px;">Ảnh bổ sung hiện tại</div>
                        <div style="display:flex; gap:10px; flex-wrap:wrap; margin-bottom:8px;" id="existingImagesList">
                            <c:forEach var="img" items="${product.images}">
                                <div class="existing-image-container" id="img-container-${img.id}">
                                    <c:choose>
                                        <c:when test="${img.imageUrl.startsWith('data:')}">
                                            <img src="${img.imageUrl}" alt="Ảnh sản phẩm">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}${img.imageUrl}" alt="Ảnh sản phẩm">
                                        </c:otherwise>
                                    </c:choose>
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
            <div class="card-custom">
                <div class="card-header">
                    <span><i class="bi bi-sliders me-2 text-info"></i>Tùy chọn hiển thị</span>
                </div>
                <div class="card-body">
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" name="active" id="activeCheck"
                               ${product.active || product.id == null ? 'checked' : ''}>
                        <label class="form-check-label fw-bold text-dark" for="activeCheck">
                            <i class="bi bi-eye-fill me-1 text-success"></i> Cho phép hiển thị (Đang bán)
                        </label>
                    </div>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="featured" id="featuredCheck"
                               ${product.featured ? 'checked' : ''}>
                        <label class="form-check-label fw-bold text-dark" for="featuredCheck">
                            <i class="bi bi-star-fill me-1 text-warning"></i> Đánh dấu nổi bật (Featured)
                        </label>
                    </div>
                </div>
            </div>

            <!-- Submit -->
            <div class="form-actions-container">
                <button type="submit" class="btn-primary-custom w-100 justify-content-center" style="font-size:15px; padding:12px 24px; border-radius: 10px;">
                    <i class="bi bi-floppy-fill"></i>
                    ${empty product.id ? 'Thêm sản phẩm' : 'Lưu thay đổi'}
                </button>
            </div>
            <c:if test="${not empty product.id}">
                <a href="${pageContext.request.contextPath}/admin/products/${product.id}/edit"
                   class="btn btn-outline-secondary w-100 mt-2" style="padding: 10px 0; border-radius: 10px; font-weight: 600;">
                    <i class="bi bi-arrow-counterclockwise"></i> Đặt lại form
                </a>
            </c:if>
        </div>
    </div>
</form>

<script>
// === Word and Character Counters ===
const nameInput = document.getElementById('productNameInput');
const nameCounter = document.getElementById('nameCharCount');
const shortDescInput = document.getElementById('shortDescInput');
const shortDescCounter = document.getElementById('shortDescCharCount');

function updateCharCount(input, counter, max) {
    if (input && counter) {
        counter.textContent = input.value.length + '/' + max;
        if (input.value.length >= max) {
            counter.classList.add('text-danger');
        } else {
            counter.classList.remove('text-danger');
        }
    }
}

if (nameInput) {
    updateCharCount(nameInput, nameCounter, 150);
    nameInput.addEventListener('input', () => updateCharCount(nameInput, nameCounter, 150));
}
if (shortDescInput) {
    updateCharCount(shortDescInput, shortDescCounter, 250);
    shortDescInput.addEventListener('input', () => updateCharCount(shortDescInput, shortDescCounter, 250));
}

// === Image Preview ===
function previewThumb(input) {
    const file = input.files[0];
    const badgeContainer = document.getElementById('thumbFileNameDisplay');
    
    if (!file) {
        if (badgeContainer) badgeContainer.style.display = 'none';
        return;
    }
    
    // Display File info
    if (badgeContainer) {
        const sizeInMb = (file.size / (1024 * 1024)).toFixed(2);
        badgeContainer.innerHTML = `<span class="file-info-badge"><i class="bi bi-file-earmark-image"></i> ${file.name} (${sizeInMb} MB)</span>`;
        badgeContainer.style.display = 'block';
    }

    const reader = new FileReader();
    reader.onload = e => {
        const img = document.getElementById('thumbImg');
        const placeholder = document.getElementById('thumbPlaceholder');
        const newContainer = document.getElementById('newThumbPreviewContainer');
        
        img.src = e.target.result;
        img.style.display = 'block';
        
        if (placeholder) placeholder.style.display = 'none';
        if (newContainer) newContainer.style.display = 'block';
    };
    reader.readAsDataURL(file);
}

function previewMulti(input) {
    const container = document.getElementById('multiPreview');
    const badgeContainer = document.getElementById('multiFileNameDisplay');
    container.innerHTML = '';
    
    if (input.files.length === 0) {
        if (badgeContainer) badgeContainer.style.display = 'none';
        return;
    }

    // Display multi info
    if (badgeContainer) {
        badgeContainer.innerHTML = `<span class="file-info-badge"><i class="bi bi-files"></i> Đã chọn ${input.files.length} ảnh bổ sung</span>`;
        badgeContainer.style.display = 'block';
    }

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
        display.style.display = 'flex';
        if (sale > 0 && sale < price) {
            const pct = Math.round((price - sale) / price * 100);
            display.innerHTML = 
                '<span class="price-tag-badge original">Giá bán gốc: ' + fmt(price) + '</span>' +
                '<span class="price-tag-badge promo">Giá khuyến mãi: ' + fmt(sale) + ' (Giảm ' + pct + '%)</span>';
        } else {
            display.innerHTML = '<span class="price-tag-badge original">Giá bán gốc: ' + fmt(price) + '</span>';
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
        badge.innerHTML = '<span class="status-badge cancelled w-100 d-flex align-items-center justify-content-center gap-1" style="height:38px;"><i class="bi bi-x-circle-fill"></i> Hết hàng</span>';
    } else if (qty < 10) {
        badge.innerHTML = '<span class="status-badge pending w-100 d-flex align-items-center justify-content-center gap-1" style="height:38px;"><i class="bi bi-exclamation-triangle-fill"></i> Tồn kho thấp: ' + qty + '</span>';
    } else {
        badge.innerHTML = '<span class="status-badge completed w-100 d-flex align-items-center justify-content-center gap-1" style="height:38px;"><i class="bi bi-check-circle-fill"></i> Sẵn sàng: ' + qty + '</span>';
    }
}

// Run on page load
updatePriceDisplay();
updateStockBadge();

function deleteExistingImage(imageId) {
    Swal.fire({
        title: 'Xác nhận xóa',
        text: 'Bạn có chắc chắn muốn xóa ảnh này không?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Xóa',
        cancelButtonText: 'Hủy',
        background: '#ffffff',
        customClass: {
            popup: 'rounded-4 shadow-lg border-0',
            confirmButton: 'btn btn-danger px-4 py-2 fw-semibold mx-2',
            cancelButton: 'btn btn-secondary px-4 py-2 fw-semibold mx-2'
        },
        buttonsStyling: false
    }).then((result) => {
        if (result.isConfirmed) {
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
                        container.style.transition = 'opacity 0.25s';
                        container.style.opacity = '0';
                        setTimeout(() => container.remove(), 250);
                    }
                    Swal.fire({
                        title: 'Đã xóa!',
                        text: 'Ảnh đã được xóa khỏi sản phẩm.',
                        icon: 'success',
                        timer: 2000,
                        showConfirmButton: false
                    });
                } else {
                    response.text().then(text => Swal.fire('Lỗi', 'Lỗi khi xóa ảnh: ' + text, 'error'));
                }
            })
            .catch(error => {
                Swal.fire('Lỗi', 'Lỗi khi xóa ảnh: ' + error, 'error');
            });
        }
    });
}

function deleteThumbnail(productId) {
    Swal.fire({
        title: 'Xác nhận xóa',
        text: 'Bạn có chắc chắn muốn xóa ảnh đại diện này không?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Xóa',
        cancelButtonText: 'Hủy',
        background: '#ffffff',
        customClass: {
            popup: 'rounded-4 shadow-lg border-0',
            confirmButton: 'btn btn-danger px-4 py-2 fw-semibold mx-2',
            cancelButton: 'btn btn-secondary px-4 py-2 fw-semibold mx-2'
        },
        buttonsStyling: false
    }).then((result) => {
        if (result.isConfirmed) {
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
                            <div class="thumb-placeholder-custom" id="thumbPlaceholder">
                                <i class="bi bi-cloud-arrow-up-fill"></i>
                                <p>Chưa có ảnh đại diện</p>
                            </div>
                            <div class="thumb-preview-container" style="display:none;" id="newThumbPreviewContainer">
                                <img id="thumbImg" src="" class="thumb-preview-custom">
                            </div>
                        `;
                    }
                    const badgeContainer = document.getElementById('thumbFileNameDisplay');
                    if (badgeContainer) badgeContainer.style.display = 'none';
                    
                    Swal.fire({
                        title: 'Đã xóa!',
                        text: 'Ảnh đại diện đã được xóa.',
                        icon: 'success',
                        timer: 2000,
                        showConfirmButton: false
                    });
                } else {
                    response.text().then(text => Swal.fire('Lỗi', 'Lỗi khi xóa ảnh đại diện: ' + text, 'error'));
                }
            })
            .catch(error => {
                Swal.fire('Lỗi', 'Lỗi khi xóa ảnh đại diện: ' + error, 'error');
            });
        }
    });
}
</script>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
