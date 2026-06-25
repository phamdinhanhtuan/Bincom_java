<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle"   value="Quản lý danh mục" scope="request"/>
<c:set var="currentPage" value="categories"       scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="page-header">
    <div>
        <h5>Danh mục sản phẩm</h5>
        <p>Quản lý cấu trúc phân loại sản phẩm</p>
    </div>
    <sec:authorize access="hasAnyRole('ADMIN','STORE_MANAGER')">
    <a href="${pageContext.request.contextPath}/admin/categories/new" class="btn-primary-custom">
        <i class="bi bi-plus-lg"></i> Thêm danh mục
    </a>
    </sec:authorize>
</div>

<div class="card">
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Tên danh mục</th>
                    <th>Danh mục cha</th>
                    <th class="text-center">Số SP</th>
                    <th class="text-center">Thứ tự</th>
                    <th class="text-center">Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cat" items="${categories}" varStatus="s">
                    <tr>
                        <td class="text-muted fw-medium">${s.count}</td>
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <div style="width:36px;height:36px;background:linear-gradient(135deg,#f5f3ff,#ede9fe);border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:18px;flex-shrink:0;">
                                    🏷️
                                </div>
                                <span class="fw-medium">${cat.name}</span>
                            </div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${cat.parent != null}">
                                    <span class="badge bg-light text-dark border">${cat.parent.name}</span>
                                </c:when>
                                <c:otherwise><span class="text-muted">—</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <span class="badge bg-light text-dark border">${cat.products.size()}</span>
                        </td>
                        <td class="text-center text-muted">${cat.sortOrder}</td>
                        <td class="text-center">
                            <span class="status-badge ${cat.active ? 'active' : 'inactive'}">
                                ${cat.active ? 'Hiển thị' : 'Ẩn'}
                            </span>
                        </td>
                        <td>
                            <div class="d-flex gap-1">
                                <sec:authorize access="hasAnyRole('ADMIN','STORE_MANAGER')">
                                <a href="${pageContext.request.contextPath}/admin/categories/${cat.id}/edit"
                                   class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                    <i class="bi bi-pencil-fill"></i>
                                </a>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ADMIN')">
                                <form action="${pageContext.request.contextPath}/admin/categories/${cat.id}/delete"
                                      method="post" class="d-inline"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa danh mục \'${cat.name}\'? Hành động này không thể hoàn tác.');">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-sm btn-outline-danger"
                                            title="Xóa">
                                        <i class="bi bi-trash3-fill"></i>
                                    </button>
                                </form>
                                </sec:authorize>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty categories}">
                    <tr>
                        <td colspan="7" class="empty-state">
                            <i class="bi bi-tags"></i>
                            <p>Chưa có danh mục nào</p>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
