<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${pageTitle != null ? pageTitle : 'Bincom — Mua sắm thông minh'}</title>
  <meta name="description" content="${metaDescription != null ? metaDescription : 'Mua sắm trực tuyến thời trang, điện tử, gia dụng chất lượng cao tại Bincom'}">
  <meta name="keywords" content="Bincom, điện tử Bincom, thời trang Bincom, đồ dùng gia đình, mỹ phẩm chính hãng, mua sắm online, mua sắm thông minh">
  <meta name="robots" content="index, follow">
  <meta property="og:type" content="website">
  <meta property="og:title" content="${pageTitle != null ? pageTitle : 'Bincom — Mua sắm thông minh'}">
  <meta property="og:description" content="${metaDescription != null ? metaDescription : 'Mua sắm trực tuyến thời trang, điện tử, gia dụng chất lượng cao tại Bincom'}">
  <meta property="og:image" content="${pageContext.request.contextPath}/resources/images/logo.png">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shop.css">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png?v=1.0.2">
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>
  <script>window.CTX = '${pageContext.request.contextPath}';</script>
</head>
<body>

<!-- SIDE DRAWER OVERLAY -->
<div id="sideDrawerOverlay" onclick="toggleDrawer()" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:2000; opacity:0; transition: opacity 0.3s ease;"></div>

<!-- SIDE DRAWER (Mobile) -->
<div id="sideDrawer" style="position:fixed; top:0; left:-320px; width:320px; height:100%; background:#f0fdfa; z-index:2001; box-shadow:5px 0 30px rgba(0,0,0,0.15); transition: left 0.3s ease; display:flex; flex-direction:column; overflow-y:auto; font-family:'Plus Jakarta Sans', sans-serif;">
  <div style="padding:24px 20px; border-bottom:1px solid rgba(13,148,136,0.15); display:flex; align-items:center; justify-content:space-between; background:#e6f4f1;">
    <div style="display:flex; align-items:center; gap:10px;">
      <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom Logo" style="height:28px; width:auto; object-fit:contain;">
    </div>
    <button onclick="toggleDrawer()" style="background:none; border:none; font-size:24px; color:#0f766e; cursor:pointer; display:flex; align-items:center; justify-content:center;">
      <i class="bi bi-x-lg"></i>
    </button>
  </div>

  <div style="padding:20px; display:flex; flex-direction:column; gap:20px;">
    <!-- Nhóm 1: Hệ thống bán lẻ Bincom -->
    <div>
      <h4 style="font-size:11px; text-transform:uppercase; color:#0f766e; letter-spacing:1px; margin-bottom:8px; font-weight:700; opacity:0.8;">Hệ thống Bincom</h4>
      <ul style="list-style:none; padding:0; margin:0; display:flex; flex-direction:column;">
        <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
          <a href="${pageContext.request.contextPath}/home" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none;" title="Quay lại Trang chủ Bincom E-Commerce">
            <i class="bi bi-house-door-fill" style="color:#0d9488; font-size:16px;"></i> Trang Chủ
          </a>
        </li>
        <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
          <a href="${pageContext.request.contextPath}/about" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none;" title="Tìm hiểu thông tin giới thiệu về Tập đoàn công nghệ và bán lẻ Bincom">
            <i class="bi bi-building-fill" style="color:#0d9488; font-size:16px;"></i> Về Bincom
          </a>
        </li>
        <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
          <div style="display:flex; align-items:center; justify-content:space-between; width:100%;">
            <a href="${pageContext.request.contextPath}/shop" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none; flex-grow:1;" title="Xem tất cả danh mục sản phẩm chính hãng tại Cửa hàng Bincom">
              <i class="bi bi-bag-fill" style="color:#0d9488; font-size:16px;"></i> Cửa hàng (Sản phẩm)
            </a>
            <button onclick="toggleDrawerSubmenu(event)" style="background:none; border:none; color:#0f766e; padding:10px; cursor:pointer; display:flex; align-items:center; justify-content:center;">
              <i id="drawerSubmenuIcon" class="bi bi-chevron-down" style="font-size:14px; transition: transform 0.25s ease;"></i>
            </button>
          </div>
          <!-- Accordion Submenu -->
          <ul id="drawerSubmenuList" style="list-style:none; padding:0 0 10px 28px; margin:0; display:none; flex-direction:column; gap:8px; animation: submenuFadeIn 0.25s ease;">
            <li>
              <a href="${pageContext.request.contextPath}/shop?categoryId=1" style="display:flex; align-items:center; gap:10px; font-size:13px; font-weight:500; color:#475569; padding:6px 0;" title="Xem các sản phẩm Điện thoại & Thiết bị công nghệ số chính hãng">
                <i class="bi bi-phone" style="font-size:14px;"></i> Điện thoại & Thiết bị
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/shop?categoryId=2" style="display:flex; align-items:center; gap:10px; font-size:13px; font-weight:500; color:#475569; padding:6px 0;" title="Xem sản phẩm Thời trang nam nữ và phụ kiện hàng hiệu">
                <i class="bi bi-gem" style="font-size:14px;"></i> Thời trang & Phụ kiện
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/shop?categoryId=3" style="display:flex; align-items:center; gap:10px; font-size:13px; font-weight:500; color:#475569; padding:6px 0;" title="Xem sản phẩm Đồ dùng gia đình và thiết bị thông minh tiện lợi">
                <i class="bi bi-house" style="font-size:14px;"></i> Đồ dùng gia đình
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/shop?categoryId=4" style="display:flex; align-items:center; gap:10px; font-size:13px; font-weight:500; color:#475569; padding:6px 0;" title="Xem Sách kỹ năng, sách văn học và văn phòng phẩm chất lượng">
                <i class="bi bi-book" style="font-size:14px;"></i> Sách & Văn phòng
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/shop?categoryId=5" style="display:flex; align-items:center; gap:10px; font-size:13px; font-weight:500; color:#475569; padding:6px 0;" title="Xem sản phẩm Thể thao, dụng cụ tập luyện và đồ dùng du lịch">
                <i class="bi bi-dribbble" style="font-size:14px;"></i> Thể thao & Du lịch
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/shop?categoryId=6" style="display:flex; align-items:center; gap:10px; font-size:13px; font-weight:500; color:#475569; padding:6px 0;" title="Xem sản phẩm Mỹ phẩm và sản phẩm chăm sóc da mặt chính hãng">
                <i class="bi bi-magic" style="font-size:14px;"></i> Mỹ phẩm & Làm đẹp
              </a>
            </li>
          </ul>
        </li>
        <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
          <a href="${pageContext.request.contextPath}/cart" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none;" title="Kiểm tra thông tin các sản phẩm đã chọn trong Giỏ hàng của bạn">
            <i class="bi bi-cart-fill" style="color:#0d9488; font-size:16px;"></i> Giỏ hàng
          </a>
        </li>
        <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
          <a href="${pageContext.request.contextPath}/contact" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none;" title="Liên hệ và đóng góp ý kiến phản hồi cho bộ phận hỗ trợ khách hàng Bincom">
            <i class="bi bi-telephone-fill" style="color:#0d9488; font-size:16px;"></i> Liên Hệ
          </a>
        </li>
      </ul>
    </div>
 
    <!-- Nhóm 3: Thông tin & Tài khoản -->
    <div>
      <h4 style="font-size:11px; text-transform:uppercase; color:#0f766e; letter-spacing:1px; margin-bottom:8px; font-weight:700; opacity:0.8;">Thông tin tài khoản</h4>
      <ul style="list-style:none; padding:0; margin:0; display:flex; flex-direction:column;">
        <sec:authorize access="!isAuthenticated()">
          <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
            <a href="${pageContext.request.contextPath}/login" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none;" title="Đăng nhập tài khoản thành viên để mua sắm và nhận ưu đãi">
              <i class="bi bi-box-arrow-in-right" style="color:#0d9488; font-size:16px;"></i> Đăng nhập
            </a>
          </li>
          <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
            <a href="${pageContext.request.contextPath}/register" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none;" title="Đăng ký tài khoản thành viên mới tại Bincom E-Commerce">
              <i class="bi bi-person-plus-fill" style="color:#0d9488; font-size:16px;"></i> Đăng ký
            </a>
          </li>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
          <sec:authorize access="hasAnyRole('CUSTOMER','ADMIN','STORE_MANAGER','SALES_STAFF','WAREHOUSE_STAFF')">
            <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
              <a href="${pageContext.request.contextPath}/orders" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none;" title="Tra cứu trạng thái và lịch sử các đơn hàng đã đặt">
                <i class="bi bi-receipt" style="color:#0d9488; font-size:16px;"></i> Đơn hàng
              </a>
            </li>
            <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
              <a href="${pageContext.request.contextPath}/account" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#0f172a; text-decoration:none;" title="Quản lý và thay đổi thông tin cá nhân tài khoản của bạn">
                <i class="bi bi-person-fill" style="color:#0d9488; font-size:16px;"></i> Tài khoản
              </a>
            </li>
          </sec:authorize>
          <li style="border-bottom:1px solid rgba(13,148,136,0.1);">
            <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0; display:block; width:100%;">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <button type="submit" style="display:flex; align-items:center; gap:12px; padding:12px 0; font-size:14px; font-weight:600; color:#ef4444; background:none; border:none; width:100%; text-align:left; cursor:pointer; font-family:inherit;">
                <i class="bi bi-box-arrow-right" style="color:#ef4444; font-size:16px;"></i> Đăng xuất
              </button>
            </form>
          </li>
        </sec:authorize>
      </ul>
    </div>
  </div>

  <div style="margin-top:auto; padding:20px; background:#e6f4f1; border-top:1px solid rgba(13,148,136,0.15); font-size:12px; color:#0f766e; opacity:0.8;">
    <div>Hotline: <strong style="color:#0f172a;">1800 1234</strong></div>
    <div>Email: <strong style="color:#0f172a;">support@bincom.vn</strong></div>
  </div>
</div>

<!-- TOP BAR (Promo/Announce) -->
<div class="top-bar">
  <span>
    🚚 Miễn phí vận chuyển cho đơn hàng từ 500K &nbsp;|&nbsp; Hotline hỗ trợ: 1800 1234 &nbsp;|&nbsp;
    <sec:authorize access="!isAuthenticated()">
      <a href="${pageContext.request.contextPath}/login" style="color:#fff;font-weight:700;text-decoration:underline;">Đăng nhập</a>
      &nbsp;/&nbsp;
      <a href="${pageContext.request.contextPath}/register" style="color:#fff;font-weight:700;text-decoration:underline;">Đăng ký</a>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
      Xin chào, <strong style="color:#93c5fd;"><sec:authentication property="principal.username"/></strong>
    </sec:authorize>
  </span>
</div>

<!-- MAIN NAVBAR (TGDD layout) -->
<nav class="kumo-navbar">
  <div class="nav-inner">
    <!-- Logo & Mobile menu button -->
    <div style="display:flex; align-items:center; gap:10px;">
      <button onclick="toggleDrawer()" style="font-size:24px; color:#0f172a; background:none; border:none; cursor:pointer; display:none;" class="mobile-menu-trigger">
        <i class="bi bi-list"></i>
      </button>
      <a href="${pageContext.request.contextPath}/home" class="nav-logo" style="display:flex; align-items:center; text-decoration:none;">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom Logo" style="height:38px; width:auto; object-fit:contain;">
      </a>
    </div>

    <!-- Search Bar in Center -->
    <div class="nav-search">
      <form action="${pageContext.request.contextPath}/shop" method="get">
        <input type="text" name="keyword" value="${keyword}" placeholder="Bạn tìm gì hôm nay? (Điện thoại, áo thun, đồ gia dụng...)">
        <button type="submit">
          <i class="bi bi-search"></i>
        </button>
      </form>
    </div>

    <!-- Actions (TGDD icons & labels) -->
    <div class="nav-actions">
      <!-- Product Dropdown Menu Wrapper -->
      <div class="nav-action-dropdown-wrap desktop-only">
        <button class="nav-action-btn" id="productMenuBtn" onclick="toggleProductDropdown(event)" style="background:none; border:none; padding:6px 12px; font-family:inherit;">
          <i class="bi bi-grid"></i>
          <span class="nav-action-label" style="display:flex; align-items:center; gap:2px;">
            Sản phẩm <i class="bi bi-chevron-down" style="font-size:10px;"></i>
          </span>
        </button>
        <div class="nav-product-dropdown" id="productDropdownMenu">
          <div class="dropdown-arrow"></div>
          <div class="dropdown-header">
            <i class="bi bi-tag-fill" style="color:var(--accent);"></i> DANH MỤC SẢN PHẨM
          </div>
          <div class="dropdown-grid">
            <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="dropdown-item" title="Điện thoại di động, máy tính bảng và phụ kiện số chính hãng tại Bincom">
              <div class="item-icon" style="background:#eff6ff; color:#3b82f6;"><i class="bi bi-phone"></i></div>
              <div class="item-info">
                <span class="item-title">Điện thoại & Thiết bị</span>
                <span class="item-desc">Smartphones, Tablet, Phụ kiện</span>
              </div>
            </a>
            <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="dropdown-item" title="Thời trang nam nữ, phụ kiện và trang sức cao cấp tại Bincom">
              <div class="item-icon" style="background:#faf5ff; color:#a855f7;"><i class="bi bi-gem"></i></div>
              <div class="item-info">
                <span class="item-title">Thời trang & Phụ kiện</span>
                <span class="item-desc">Quần áo thời trang, Phụ kiện</span>
              </div>
            </a>
            <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="dropdown-item" title="Thiết bị thông minh, đồ dùng gia đình và nhà bếp tiện nghi tại Bincom">
              <div class="item-icon" style="background:#ecfdf5; color:#10b981;"><i class="bi bi-house"></i></div>
              <div class="item-info">
                <span class="item-title">Đồ dùng gia đình</span>
                <span class="item-desc">Gia dụng thông minh, Đồ bếp</span>
              </div>
            </a>
            <a href="${pageContext.request.contextPath}/shop?categoryId=4" class="dropdown-item" title="Sách hay, văn phòng phẩm và dụng cụ học tập chất lượng tại Bincom">
              <div class="item-icon" style="background:#fff7ed; color:#f97316;"><i class="bi bi-book"></i></div>
              <div class="item-info">
                <span class="item-title">Sách & Văn phòng</span>
                <span class="item-desc">Sách kỹ năng, Thiết bị văn phòng</span>
              </div>
            </a>
            <a href="${pageContext.request.contextPath}/shop?categoryId=5" class="dropdown-item" title="Dụng cụ thể thao, đồ dã ngoại và cắm trại ngoài trời tại Bincom">
              <div class="item-icon" style="background:#f0fdfa; color:#14b8a6;"><i class="bi bi-dribbble"></i></div>
              <div class="item-info">
                <span class="item-title">Thể thao & Du lịch</span>
                <span class="item-desc">Dụng cụ tập luyện, Đồ dã ngoại</span>
              </div>
            </a>
            <a href="${pageContext.request.contextPath}/shop?categoryId=6" class="dropdown-item" title="Mỹ phẩm chính hãng, sản phẩm chăm sóc da và làm đẹp tại Bincom">
              <div class="item-icon" style="background:#fff1f2; color:#f43f5e;"><i class="bi bi-magic"></i></div>
              <div class="item-info">
                <span class="item-title">Mỹ phẩm & Làm đẹp</span>
                <span class="item-desc">Chăm sóc da, Trang điểm</span>
              </div>
            </a>
          </div>
        </div>
      </div>
      <a href="${pageContext.request.contextPath}/about" class="nav-action-btn desktop-only" title="Tìm hiểu về Tập đoàn công nghệ và bán lẻ Bincom">
        <i class="bi bi-building"></i>
        <span class="nav-action-label">Về Bincom</span>
      </a>

      <!-- Hidden SEO Anchor Links on Main Header -->
      <div style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); border: 0;">
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" title="Điện thoại & Thiết bị số chính hãng tại Bincom">Điện thoại Bincom chính hãng</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=2" title="Thời trang & Phụ kiện hàng hiệu tại Bincom">Thời trang & Phụ kiện Bincom</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=3" title="Thiết bị thông minh & Đồ dùng gia đình Bincom">Thiết bị thông minh gia đình Bincom</a>
      </div>

      <sec:authorize access="isAuthenticated()">
        <sec:authorize access="hasAnyRole('CUSTOMER','ADMIN','STORE_MANAGER','SALES_STAFF','WAREHOUSE_STAFF')">
          <a href="${pageContext.request.contextPath}/orders" class="nav-action-btn">
            <i class="bi bi-receipt"></i>
            <span class="nav-action-label">Đơn hàng</span>
          </a>
          <a href="${pageContext.request.contextPath}/account" class="nav-action-btn">
            <i class="bi bi-person"></i>
            <span class="nav-action-label">Tài khoản</span>
          </a>
        </sec:authorize>
      </sec:authorize>
      <a href="${pageContext.request.contextPath}/cart" class="nav-action-btn nav-cart-btn" id="cartBtn">
        <i class="bi bi-cart3"></i>
        <span class="nav-action-label">Giỏ hàng</span>
        <span class="cart-count" id="cartBadge">0</span>
      </a>
      <sec:authorize access="isAuthenticated()">
        <form action="${pageContext.request.contextPath}/logout" method="post" id="logoutFormHeader" style="display:inline; margin:0;">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          <button type="submit" class="nav-action-btn" style="background:none; border:none; font-family:inherit;">
            <i class="bi bi-box-arrow-right"></i>
            <span class="nav-action-label">Đăng xuất</span>
          </button>
        </form>
      </sec:authorize>
    </div>
  </div>
</nav>

<!-- CATEGORY NAVBAR (Horizontal row below main nav - TGDD inspired) -->
<div class="category-navbar">
  <div class="category-navbar-inner">
    <a href="${pageContext.request.contextPath}/shop" class="cat-nav-item ${empty categoryId ? 'active' : ''}">
      <i class="bi bi-grid-fill"></i>
      <span>Tất cả</span>
    </a>
    <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="cat-nav-item ${categoryId == 1 ? 'active' : ''}">
      <i class="bi bi-phone"></i>
      <span>Điện thoại & Thiết bị</span>
    </a>
    <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="cat-nav-item ${categoryId == 2 ? 'active' : ''}">
      <i class="bi bi-gem"></i>
      <span>Thời trang & Phụ kiện</span>
    </a>
    <a href="${pageContext.request.contextPath}/shop?categoryId=3" class="cat-nav-item ${categoryId == 3 ? 'active' : ''}">
      <i class="bi bi-house"></i>
      <span>Đồ dùng gia đình</span>
    </a>
    <a href="${pageContext.request.contextPath}/shop?categoryId=4" class="cat-nav-item ${categoryId == 4 ? 'active' : ''}">
      <i class="bi bi-book"></i>
      <span>Sách & Văn phòng phẩm</span>
    </a>
    <a href="${pageContext.request.contextPath}/shop?categoryId=5" class="cat-nav-item ${categoryId == 5 ? 'active' : ''}">
      <i class="bi bi-dribbble"></i>
      <span>Thể thao & Du lịch</span>
    </a>
    <a href="${pageContext.request.contextPath}/shop?categoryId=6" class="cat-nav-item ${categoryId == 6 ? 'active' : ''}">
      <i class="bi bi-magic"></i>
      <span>Mỹ phẩm & Làm đẹp</span>
    </a>
  </div>
</div>

<!-- Toast Container -->
<div id="toastContainer"></div>

<!-- CSS inline fixes to hide mobile elements on desktop and show hamburger on mobile -->
<style>
  @media(max-width: 768px) {
    .desktop-only { display: none !important; }
    .mobile-menu-trigger { display: block !important; }
  }
  @keyframes submenuFadeIn {
    from { opacity: 0; transform: translateY(-8px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>

<script>
function toggleDrawer() {
  var overlay = document.getElementById('sideDrawerOverlay');
  var drawer = document.getElementById('sideDrawer');
  if (!drawer || !overlay) return;
  if (drawer.style.left === '0px') {
    drawer.style.left = '-320px';
    overlay.style.opacity = '0';
    setTimeout(function() { overlay.style.display = 'none'; }, 300);
  } else {
    overlay.style.display = 'block';
    setTimeout(function() { overlay.style.opacity = '1'; }, 10);
    drawer.style.left = '0px';
  }
}

function toggleDrawerSubmenu(e) {
  if (e) e.stopPropagation();
  var submenu = document.getElementById('drawerSubmenuList');
  var icon = document.getElementById('drawerSubmenuIcon');
  if (submenu) {
    if (submenu.style.display === 'flex') {
      submenu.style.display = 'none';
      icon.style.transform = 'rotate(0deg)';
    } else {
      submenu.style.display = 'flex';
      icon.style.transform = 'rotate(180deg)';
    }
  }
}

function toggleProductDropdown(e) {
  if (e) e.stopPropagation();
  var dropdown = document.getElementById('productDropdownMenu');
  if (dropdown) {
    dropdown.classList.toggle('active');
  }
}

document.addEventListener('click', function(e) {
  var dropdown = document.getElementById('productDropdownMenu');
  var btn = document.getElementById('productMenuBtn');
  if (dropdown && dropdown.classList.contains('active')) {
    if (!dropdown.contains(e.target) && !btn.contains(e.target)) {
      dropdown.classList.remove('active');
    }
  }
});
</script>

<!-- Script -->
<script src="${pageContext.request.contextPath}/resources/js/shop.js"></script>
