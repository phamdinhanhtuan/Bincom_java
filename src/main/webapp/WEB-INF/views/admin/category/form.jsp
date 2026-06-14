<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle"   value="${empty category.id ? 'Thêm danh mục' : 'Sửa danh mục'}" scope="request"/>
<c:set var="currentPage" value="categories" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="page-header">
    <div>
        <h5>${empty category.id ? 'Thêm danh mục mới' : 'Chỉnh sửa danh mục'}</h5>
        <p>${empty category.id ? 'Điền thông tin để tạo danh mục mới' : 'Cập nhật thông tin danh mục'}</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary">
        <i class="bi bi-arrow-left me-1"></i>Quay lại
    </a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="card">
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
                        <label class="form-label">Tên danh mục *</label>
                        <input type="text" name="name" class="form-control" required value="${category.name}" placeholder="Ví dụ: Điện tử, Thời trang,...">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Danh mục cha (để trống nếu là danh mục gốc)</label>
                        <select name="parent.id" class="form-select">
                            <option value="">— Danh mục gốc —</option>
                            <c:forEach var="parent" items="${parents}">
                                <option value="${parent.id}" ${category.parent != null && category.parent.id == parent.id ? 'selected' : ''}>${parent.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description" class="form-control" rows="3" placeholder="Mô tả ngắn về danh mục...">${category.description}</textarea>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Thứ tự sắp xếp</label>
                            <input type="number" name="sortOrder" class="form-control" value="${category.sortOrder != null ? category.sortOrder : 0}" min="0">
                        </div>
                        <div class="col-md-6 d-flex align-items-end">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="active" id="activeChk"
                                       ${category.active || category.id == null ? 'checked' : ''}>
                                <label class="form-check-label fw-medium" for="activeChk">Hiển thị</label>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn-primary-custom">
                        <i class="bi bi-floppy-fill me-1"></i>
                        ${empty category.id ? 'Thêm danh mục' : 'Lưu thay đổi'}
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
