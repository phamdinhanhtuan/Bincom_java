<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle"   value="${empty category.id ? 'Thêm danh mục' : 'Sửa danh mục'}" scope="request"/>
<c:set var="currentPage" value="categories" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<style>
/* Card Custom */
.card-custom {
    border: 1px solid var(--border-color);
    border-radius: var(--radius);
    background: var(--card-bg);
    box-shadow: var(--shadow-sm);
    transition: transform 0.22s cubic-bezier(.4,0,.2,1), box-shadow 0.22s cubic-bezier(.4,0,.2,1);
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

/* Custom form styles */
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
</style>

<div class="page-header">
    <div>
        <h5><i class="bi bi-tags-fill text-primary me-2"></i>${empty category.id ? 'Thêm danh mục mới' : 'Chỉnh sửa: '}${category.name}</h5>
        <p>${empty category.id ? 'Điền thông tin để tạo danh mục mới' : 'Cập nhật thông tin danh mục'}</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary d-inline-flex align-items-center gap-1">
        <i class="bi bi-arrow-left"></i> Quay lại
    </a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="card-custom">
            <div class="card-header">
                <span><i class="bi bi-info-circle-fill text-primary me-2"></i>Thông tin danh mục</span>
                <span class="badge bg-light text-secondary">Bắt buộc (*)</span>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty category.id}">
                        <c:set var="formAction" value="${pageContext.request.contextPath}/admin/categories/save"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="formAction" value="${pageContext.request.contextPath}/admin/categories/${category.id}/update"/>
                    </c:otherwise>
                </c:choose>
                <form action="${formAction}" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    
                    <div class="mb-3">
                        <label class="form-label-custom"><i class="bi bi-tag text-muted"></i> Tên danh mục *</label>
                        <input type="text" name="name" class="form-control form-control-custom" required value="${category.name}" placeholder="Ví dụ: Điện tử, Thời trang,...">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label-custom"><i class="bi bi-folder-symlink text-muted"></i> Danh mục cha (nếu có)</label>
                        <select name="parent.id" class="form-select form-control-custom" style="height: 48px;">
                            <option value="">— Danh mục gốc —</option>
                            <c:forEach var="parent" items="${parents}">
                                <option value="${parent.id}" ${category.parent != null && category.parent.id == parent.id ? 'selected' : ''}>${parent.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label-custom"><i class="bi bi-card-text text-muted"></i> Mô tả</label>
                        <textarea name="description" class="form-control form-control-custom" rows="3" placeholder="Mô tả ngắn về danh mục...">${category.description}</textarea>
                    </div>
                    
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label-custom"><i class="bi bi-sort-numeric-down text-muted"></i> Thứ tự sắp xếp</label>
                            <input type="number" name="sortOrder" class="form-control form-control-custom" value="${category.sortOrder != null ? category.sortOrder : 0}" min="0">
                        </div>
                        <div class="col-md-6 d-flex align-items-center" style="padding-top: 28px;">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="active" id="activeChk"
                                       ${category.active || category.id == null ? 'checked' : ''}>
                                <label class="form-check-label fw-bold text-dark" for="activeChk">
                                    <i class="bi bi-eye-fill text-success me-1"></i> Cho phép hiển thị
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2">
                        <button type="submit" class="btn-primary-custom" style="padding: 11px 24px; border-radius: 8px;">
                            <i class="bi bi-floppy-fill"></i>
                            ${empty category.id ? 'Thêm danh mục' : 'Lưu thay đổi'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
