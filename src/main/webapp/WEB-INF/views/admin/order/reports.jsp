<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle"   value="Báo cáo doanh thu" scope="request"/>
<c:set var="currentPage" value="reports"           scope="request"/>
<%@ include file="/WEB-INF/views/layouts/admin-header.jsp" %>

<div class="mb-4">
    <h5 class="fw-bold mb-1">📊 Báo cáo doanh thu</h5>
</div>

<!-- Year/Month Selector -->
<div class="card mb-4">
    <div class="card-body p-3">
        <form action="" method="get" class="row g-2 align-items-end">
            <div class="col-md-3">
                <label class="form-label fw-medium">Năm</label>
                <select name="year" class="form-select">
                    <c:forEach var="y" begin="${currentYear - 3}" end="${currentYear}">
                        <option value="${y}" ${y == currentYear ? 'selected' : ''}>${y}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label fw-medium">Tháng (tùy chọn)</label>
                <select name="month" class="form-select">
                    <option value="0">Xem theo tháng</option>
                    <c:forEach var="m" begin="1" end="12">
                        <option value="${m}" ${m == month ? 'selected' : ''}>Tháng ${m}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100 rounded-3">Xem báo cáo</button>
            </div>
        </form>
    </div>
</div>

<!-- Revenue Chart -->
<div class="card mb-4">
    <div class="card-header fw-bold">
        <i class="bi bi-bar-chart-fill me-2 text-primary"></i>
        <c:choose>
            <c:when test="${month > 0}">Doanh thu theo ngày — Tháng ${month}/${currentYear}</c:when>
            <c:otherwise>Doanh thu theo tháng — Năm ${currentYear}</c:otherwise>
        </c:choose>
    </div>
    <div class="card-body">
        <div style="height:350px;"><canvas id="revenueChart"></canvas></div>
    </div>
</div>

<!-- Revenue Table -->
<div class="card">
    <div class="card-header fw-bold">Chi tiết doanh thu</div>
    <div class="table-responsive">
        <table class="table mb-0">
            <thead>
                <tr>
                    <th><c:choose><c:when test="${month > 0}">Ngày</c:when><c:otherwise>Tháng</c:otherwise></c:choose></th>
                    <th class="text-end">Số đơn hoàn thành</th>
                    <th class="text-end">Doanh thu</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="totalRevenue" value="0"/>
                <c:set var="totalOrders"  value="0"/>
                <c:forEach var="row" items="${month > 0 ? revenueByDay : revenueByMonth}">
                    <tr>
                        <td><c:choose><c:when test="${month > 0}">Ngày ${row[0]}</c:when><c:otherwise>Tháng ${row[0]}</c:otherwise></c:choose></td>
                        <td class="text-end">${row[2]}</td>
                        <td class="text-end fw-bold text-primary">
                            <fmt:formatNumber value="${row[1]}" type="number" groupingUsed="true"/>₫
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
const labels = [
    <c:forEach var="row" items="${month > 0 ? revenueByDay : revenueByMonth}" varStatus="s">
        '${month > 0 ? "Ngày ".concat(row[0]) : "T".concat(row[0])}'${!s.last ? ',' : ''}
    </c:forEach>
];
const revenues = [
    <c:forEach var="row" items="${month > 0 ? revenueByDay : revenueByMonth}" varStatus="s">
        ${row[1]}${!s.last ? ',' : ''}
    </c:forEach>
];

const ctx = document.getElementById('revenueChart').getContext('2d');
const grad = ctx.createLinearGradient(0, 0, 0, 350);
grad.addColorStop(0, 'rgba(108,99,255,0.5)');
grad.addColorStop(1, 'rgba(108,99,255,0)');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels,
        datasets: [{
            label: 'Doanh thu (₫)',
            data: revenues,
            backgroundColor: grad,
            borderColor: '#6c63ff',
            borderWidth: 2,
            borderRadius: 6
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
                ticks: { callback: v => (v/1000000).toFixed(0) + 'M₫' }
            }
        }
    }
});
</script>

<%@ include file="/WEB-INF/views/layouts/admin-footer.jsp" %>
