<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<c:set var="currentPage" value="dashboard" scope="request"/>

<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<style>
.chart-container { position: relative; height: 320px; }
.quick-stats { grid-template-columns: repeat(4, 1fr); }
</style>

<!-- Stats Row -->
<div class="quick-stats mb-4">
    <div class="stat-card purple">
        <div class="stat-info">
            <p class="stat-label">Tổng doanh thu</p>
            <h3 class="stat-value">
                <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>₫
            </h3>
            <p class="stat-sub">Tất cả thời gian</p>
        </div>
        <div class="stat-icon purple"><i class="bi bi-currency-dollar"></i></div>
    </div>
    <div class="stat-card green">
        <div class="stat-info">
            <p class="stat-label">Doanh thu tháng này</p>
            <h3 class="stat-value">
                <fmt:formatNumber value="${monthRevenue}" type="number" groupingUsed="true"/>₫
            </h3>
            <p class="stat-sub">Năm ${currentYear}</p>
        </div>
        <div class="stat-icon green"><i class="bi bi-graph-up-arrow"></i></div>
    </div>
    <div class="stat-card orange">
        <div class="stat-info">
            <p class="stat-label">Đơn chờ xử lý</p>
            <h3 class="stat-value">${pendingOrders}</h3>
            <p class="stat-sub">Cần xác nhận</p>
        </div>
        <div class="stat-icon orange"><i class="bi bi-hourglass-split"></i></div>
    </div>
    <div class="stat-card blue">
        <div class="stat-info">
            <p class="stat-label">Khách hàng</p>
            <h3 class="stat-value">${totalCustomers}</h3>
            <p class="stat-sub">Đã đăng ký</p>
        </div>
        <div class="stat-icon blue"><i class="bi bi-people-fill"></i></div>
    </div>
</div>

<!-- Charts Row -->
<div class="row g-3 mb-4">
    <div class="col-xl-8">
        <div class="card h-100">
            <div class="card-header">
                <span><i class="bi bi-bar-chart-fill me-2 text-primary"></i>Doanh thu theo tháng — ${currentYear}</span>
                <select class="form-select form-select-sm w-auto" id="yearSelect" onchange="loadRevenueData(this.value)">
                    <c:forEach var="y" begin="${currentYear - 2}" end="${currentYear}">
                        <option value="${y}" ${y == currentYear ? 'selected' : ''}>${y}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="card-body">
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-4">
        <div class="card h-100">
            <div class="card-header">
                <span><i class="bi bi-pie-chart-fill me-2 text-success"></i>Tổng quan hôm nay</span>
            </div>
            <div class="card-body">
                <div class="chart-container">
                    <canvas id="todayChart"></canvas>
                </div>
                <div class="row mt-3 text-center">
                    <div class="col-6">
                        <div class="fw-bold fs-4 text-primary">${todayOrders}</div>
                        <div class="text-muted small">Đơn hôm nay</div>
                    </div>
                    <div class="col-6">
                        <div class="fw-bold fs-4 text-success">
                            <fmt:formatNumber value="${todayRevenue}" type="number" groupingUsed="true"/>₫
                        </div>
                        <div class="text-muted small">Doanh thu hôm nay</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Tables Row -->
<div class="row g-3">
    <!-- Recent Pending Orders -->
    <div class="col-xl-7">
        <div class="card">
            <div class="card-header">
                <span><i class="bi bi-clock-history me-2 text-warning"></i>Đơn hàng chờ xử lý</span>
                <a href="${pageContext.request.contextPath}/admin/orders?status=PENDING"
                   class="btn btn-sm btn-outline-warning">Xem tất cả</a>
            </div>
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>Tổng tiền</th>
                            <th>Ngày đặt</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${recentOrders}" end="9">
                            <tr>
                                <td><code class="text-primary fw-bold">${order.orderCode}</code></td>
                                <td>${order.customer.fullName}</td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                                </td>
                                <td>
                                    ${order.createdAt.toString().replace('T',' ').substring(0,16)}
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/orders/${order.id}"
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentOrders}">
                            <tr><td colspan="5" class="text-center text-muted py-4">Không có đơn chờ xử lý</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Low Stock Products -->
    <div class="col-xl-5">
        <div class="card">
            <div class="card-header">
                <span><i class="bi bi-exclamation-triangle-fill me-2 text-danger"></i>Sản phẩm tồn kho thấp</span>
            </div>
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Tồn kho</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${lowStockProducts}" end="9">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <c:if test="${not empty product.thumbnailUrl}">
                                            <img src="${pageContext.request.contextPath}${product.thumbnailUrl}"
                                                 class="product-thumb" alt="${product.name}">
                                        </c:if>
                                        <span class="fw-medium">${product.name}</span>
                                    </div>
                                </td>
                                <td>
                                    <span class="fw-bold ${product.inventory.availableQuantity == 0 ? 'text-danger' : 'text-warning'}">
                                        ${product.inventory.quantityInStock}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.inventory.quantityInStock == 0}">
                                            <span class="status-badge cancelled">Hết hàng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge pending">Sắp hết</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty lowStockProducts}">
                            <tr><td colspan="3" class="text-center text-muted py-4">
                                <i class="bi bi-check-circle text-success fs-4 d-block mb-2"></i>
                                Tồn kho đủ hàng
                            </td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
// Revenue Chart
const revenueByMonth = [
    <c:forEach var="row" items="${revenueByMonth}" varStatus="s">
        {month: ${row[0]}, revenue: ${row[1]}, orders: ${row[2]}}${!s.last ? ',' : ''}
    </c:forEach>
];

const months = ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'];
const revenueData = Array(12).fill(0);
revenueByMonth.forEach(r => { revenueData[r.month - 1] = r.revenue; });

const revenueCtx = document.getElementById('revenueChart').getContext('2d');
const gradient = revenueCtx.createLinearGradient(0, 0, 0, 300);
gradient.addColorStop(0, 'rgba(108, 99, 255, 0.3)');
gradient.addColorStop(1, 'rgba(108, 99, 255, 0)');

new Chart(revenueCtx, {
    type: 'line',
    data: {
        labels: months,
        datasets: [{
            label: 'Doanh thu (₫)',
            data: revenueData,
            borderColor: '#6c63ff',
            backgroundColor: gradient,
            borderWidth: 2.5,
            fill: true,
            tension: 0.4,
            pointBackgroundColor: '#6c63ff',
            pointRadius: 4,
            pointHoverRadius: 7
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: { display: false },
            tooltip: {
                callbacks: {
                    label: ctx => ctx.parsed.y.toLocaleString('vi-VN') + '₫'
                }
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                grid: { color: 'rgba(0,0,0,0.05)' },
                ticks: {
                    callback: v => (v / 1000000).toFixed(0) + 'M₫'
                }
            },
            x: { grid: { display: false } }
        }
    }
});

// Today Doughnut Chart
const todayCtx = document.getElementById('todayChart').getContext('2d');
new Chart(todayCtx, {
    type: 'doughnut',
    data: {
        labels: ['Chờ xác nhận', 'Đang giao', 'Hoàn thành'],
        datasets: [{
            data: [${pendingOrders}, 5, 20],
            backgroundColor: ['#f59e0b', '#6c63ff', '#10b981'],
            borderWidth: 0
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: '70%',
        plugins: { legend: { position: 'bottom' } }
    }
});
</script>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
