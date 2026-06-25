<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <!-- ===== SEO PRIMARY ===== -->
  <title>${pageTitle != null ? pageTitle : 'Bincom — Điện thoại, Laptop, Phụ kiện chính hãng'}</title>
  <meta name="description" content="${metaDescription != null ? metaDescription : 'Mua điện thoại, laptop, tablet, phụ kiện công nghệ chính hãng tại Bincom. Giá tốt nhất, bảo hành chính hãng, giao hàng toàn quốc.'}">
  <meta name="keywords"    content="${metaKeywords   != null ? metaKeywords   : 'điện thoại chính hãng, mua iphone, samsung galaxy, laptop giá rẻ, phụ kiện công nghệ, Bincom'}">
  <meta name="robots"      content="index, follow, max-snippet:-1, max-image-preview:large">
  <meta name="author"      content="Bincom E-Commerce">
  <link rel="canonical"    href="${pageContext.request.requestURL}">

  <!-- ===== OPEN GRAPH (Facebook / Zalo) ===== -->
  <meta property="og:type"        content="website">
  <meta property="og:locale"      content="vi_VN">
  <meta property="og:site_name"   content="Bincom">
  <meta property="og:title"       content="${pageTitle != null ? pageTitle : 'Bincom — Điện thoại, Laptop, Phụ kiện chính hãng'}">
  <meta property="og:description" content="${metaDescription != null ? metaDescription : 'Mua điện thoại, laptop, phụ kiện công nghệ chính hãng tại Bincom. Giá tốt, bảo hành chính hãng.'}">
  <meta property="og:image"       content="${pageContext.request.contextPath}/resources/images/logo.png">
  <meta property="og:url"         content="${pageContext.request.requestURL}">

  <!-- ===== TWITTER CARD ===== -->
  <meta name="twitter:card"        content="summary_large_image">
  <meta name="twitter:title"       content="${pageTitle != null ? pageTitle : 'Bincom'}">
  <meta name="twitter:description" content="${metaDescription != null ? metaDescription : 'Mua sắm điện thoại, laptop chính hãng tại Bincom'}">
  <meta name="twitter:image"       content="${pageContext.request.contextPath}/resources/images/logo.png">

  <!-- ===== STRUCTURED DATA (JSON-LD) ===== -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Bincom",
    "url": "${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}",
    "logo": "${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/resources/images/logo.png",
    "contactPoint": {
      "@type": "ContactPoint",
      "telephone": "1800-1234",
      "contactType": "customer service",
      "areaServed": "VN",
      "availableLanguage": "Vietnamese"
    },
    "sameAs": ["https://facebook.com/bincom","https://instagram.com/bincom"]
  }
  </script>

  <!-- ===== BREADCRUMB JSON-LD (dynamic, populated per page via model attr) ===== -->
  <c:if test="${not empty breadcrumbs}">
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
      <c:forEach var="bc" items="${breadcrumbs}" varStatus="st">
      {"@type":"ListItem","position":${st.index+1},"name":"${bc.name}","item":"${bc.url}"}<c:if test="${!st.last}">,</c:if>
      </c:forEach>
    ]
  }
  </script>
  </c:if>

  <!-- ===== PRECONNECT / PERFORMANCE ===== -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link rel="dns-prefetch" href="https://cdn.jsdelivr.net">

  <!-- ===== FONTS ===== -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap" rel="stylesheet">

  <!-- ===== FONTS & STYLES ===== -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

  <!-- ===== MAIN CSS ===== -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shop.css?v=1.2">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/landing.css?v=1.2">

  <!-- ===== FAVICON ===== -->
  <link rel="icon"             type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/resources/images/favicon.png">
  <link rel="apple-touch-icon" sizes="180x180"  href="${pageContext.request.contextPath}/resources/images/favicon.png">

  <!-- ===== CSRF META ===== -->
  <meta name="_csrf"        content="${_csrf.token}">
  <meta name="_csrf_header" content="${_csrf.headerName}">

  <!-- ===== GLOBAL JS CONTEXT ===== -->
  <script>window.CTX = '${pageContext.request.contextPath}';</script>
</head>
<body>

<!-- ============================================================
     MOBILE DRAWER OVERLAY
     ============================================================ -->
<div id="cps-overlay" class="cps-overlay" onclick="cpsCloseDrawer()" aria-hidden="true"></div>

<!-- ============================================================
     MOBILE SIDE DRAWER
     ============================================================ -->
<nav id="cps-drawer" class="cps-drawer" aria-label="Menu điều hướng di động">
  <!-- Drawer Header -->
  <div class="cps-drawer-head">
    <a href="${pageContext.request.contextPath}/home" aria-label="Trang chủ Bincom">
      <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom Logo" class="cps-drawer-logo">
    </a>
    <button class="cps-drawer-close" onclick="cpsCloseDrawer()" aria-label="Đóng menu">
      <i class="bi bi-x-lg"></i>
    </button>
  </div>

  <!-- Search inside drawer -->
  <div class="cps-drawer-search">
    <form action="${pageContext.request.contextPath}/shop" method="get" role="search">
      <label for="drawerSearch" class="sr-only">Tìm kiếm sản phẩm</label>
      <input id="drawerSearch" type="search" name="keyword" value="${keyword}" placeholder="Tìm điện thoại, laptop...">
      <button type="submit" aria-label="Tìm kiếm"><i class="bi bi-search"></i></button>
    </form>
  </div>

  <!-- Drawer Menu -->
  <div class="cps-drawer-menu">
    <div class="cps-drawer-section-title">Danh mục sản phẩm</div>
    <ul class="cps-drawer-list">
      <li>
        <a href="${pageContext.request.contextPath}/shop?categoryId=1" title="Điện thoại smartphone chính hãng tại Bincom">
          <span class="cps-drawer-icon cps-icon-blue"><i class="bi bi-phone-fill"></i></span>
          <span class="cps-drawer-text">
            <strong>Điện thoại &amp; Thiết bị</strong>
            <small>Smartphone, Tablet, Phụ kiện</small>
          </span>
          <i class="bi bi-chevron-right cps-drawer-arrow"></i>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/shop?categoryId=2" title="Thời trang phụ kiện chính hãng tại Bincom">
          <span class="cps-drawer-icon cps-icon-purple"><i class="bi bi-gem"></i></span>
          <span class="cps-drawer-text">
            <strong>Thời trang &amp; Phụ kiện</strong>
            <small>Quần áo, Giày dép, Trang sức</small>
          </span>
          <i class="bi bi-chevron-right cps-drawer-arrow"></i>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/shop?categoryId=3" title="Đồ dùng gia đình thông minh tại Bincom">
          <span class="cps-drawer-icon cps-icon-green"><i class="bi bi-house-heart-fill"></i></span>
          <span class="cps-drawer-text">
            <strong>Đồ dùng gia đình</strong>
            <small>Gia dụng thông minh, Nhà bếp</small>
          </span>
          <i class="bi bi-chevron-right cps-drawer-arrow"></i>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/shop?categoryId=4" title="Sách và văn phòng phẩm tại Bincom">
          <span class="cps-drawer-icon cps-icon-orange"><i class="bi bi-book-fill"></i></span>
          <span class="cps-drawer-text">
            <strong>Sách &amp; Văn phòng</strong>
            <small>Sách kỹ năng, Thiết bị văn phòng</small>
          </span>
          <i class="bi bi-chevron-right cps-drawer-arrow"></i>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/shop?categoryId=5" title="Thể thao du lịch tại Bincom">
          <span class="cps-drawer-icon cps-icon-teal"><i class="bi bi-bicycle"></i></span>
          <span class="cps-drawer-text">
            <strong>Thể thao &amp; Du lịch</strong>
            <small>Dụng cụ thể thao, Cắm trại</small>
          </span>
          <i class="bi bi-chevron-right cps-drawer-arrow"></i>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/shop?categoryId=6" title="Mỹ phẩm làm đẹp chính hãng tại Bincom">
          <span class="cps-drawer-icon cps-icon-pink"><i class="bi bi-stars"></i></span>
          <span class="cps-drawer-text">
            <strong>Mỹ phẩm &amp; Làm đẹp</strong>
            <small>Chăm sóc da, Trang điểm</small>
          </span>
          <i class="bi bi-chevron-right cps-drawer-arrow"></i>
        </a>
      </li>
    </ul>

    <div class="cps-drawer-divider"></div>
    <div class="cps-drawer-section-title">Trang chính</div>
    <ul class="cps-drawer-list cps-drawer-list-plain">
      <li><a href="${pageContext.request.contextPath}/home"   title="Trang chủ Bincom"><i class="bi bi-house-door"></i> Trang Chủ</a></li>
      <li><a href="${pageContext.request.contextPath}/shop"   title="Cửa hàng Bincom"><i class="bi bi-shop"></i> Cửa Hàng</a></li>
      <li><a href="${pageContext.request.contextPath}/about"  title="Giới thiệu Bincom"><i class="bi bi-info-circle"></i> Về Bincom</a></li>
      <li><a href="${pageContext.request.contextPath}/contact" title="Liên hệ hỗ trợ Bincom"><i class="bi bi-headset"></i> Hỗ Trợ</a></li>
    </ul>

    <div class="cps-drawer-divider"></div>
    <div class="cps-drawer-section-title">Tài khoản</div>
    <ul class="cps-drawer-list cps-drawer-list-plain">
      <sec:authorize access="!isAuthenticated()">
        <li><a href="${pageContext.request.contextPath}/login"    title="Đăng nhập tài khoản Bincom"><i class="bi bi-box-arrow-in-right"></i> Đăng nhập</a></li>
        <li><a href="${pageContext.request.contextPath}/register" title="Đăng ký tài khoản mới Bincom"><i class="bi bi-person-plus"></i> Đăng ký</a></li>
      </sec:authorize>
      <sec:authorize access="isAuthenticated()">
        <li><a href="${pageContext.request.contextPath}/account" title="Tài khoản của tôi"><i class="bi bi-person-circle"></i> Tài khoản của tôi</a></li>
        <li><a href="${pageContext.request.contextPath}/orders"  title="Đơn hàng của tôi"><i class="bi bi-bag-check"></i> Đơn hàng của tôi</a></li>
        <li>
          <form action="${pageContext.request.contextPath}/logout" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <button type="submit" class="cps-drawer-logout"><i class="bi bi-power"></i> Đăng xuất</button>
          </form>
        </li>
      </sec:authorize>
    </ul>
  </div>

  <!-- Drawer Hotline -->
  <div class="cps-drawer-foot">
    <a href="tel:18001234" class="cps-drawer-hotline">
      <i class="bi bi-telephone-fill"></i>
      <div>
        <span>Hotline hỗ trợ</span>
        <strong>1800 1234</strong>
      </div>
    </a>
  </div>
</nav>

<!-- ============================================================
     PROMO TOP BAR
     ============================================================ -->
<div class="cps-topbar" role="banner">
  <div class="cps-topbar-inner">
    <div class="cps-topbar-left">
      <a href="tel:18001234" title="Gọi hotline Bincom miễn phí">
        <i class="bi bi-telephone-fill"></i> 1800 1234
      </a>
      <span class="cps-topbar-sep">|</span>
      <a href="${pageContext.request.contextPath}/contact" title="Liên hệ hỗ trợ khách hàng">
        <i class="bi bi-headset"></i> Hỗ trợ 24/7
      </a>
      <!-- Hidden SEO links for breadcrumb signals -->
      <span class="sr-only">
        <a href="${pageContext.request.contextPath}/shop?categoryId=1">Mua điện thoại chính hãng</a>
        <a href="${pageContext.request.contextPath}/shop?categoryId=2">Thời trang online giá rẻ</a>
      </span>
    </div>
    <div class="cps-topbar-center">
      <span class="cps-topbar-promo">🔥 Flash Sale: Giảm đến 40% — Chỉ hôm nay!</span>
    </div>
    <div class="cps-topbar-right">
      <span>Hệ thống bán lẻ chính hãng Bincom</span>
    </div>
  </div>
</div>

<!-- ============================================================
     MAIN NAVBAR — CellphoneS Style
     ============================================================ -->
<header class="cps-header" itemscope itemtype="https://schema.org/SiteNavigationElement">
  <div class="cps-header-inner">

    <!-- Hamburger (mobile) -->
    <button class="cps-hamburger" onclick="cpsOpenDrawer()" aria-label="Mở menu điều hướng" aria-expanded="false" aria-controls="cps-drawer">
      <i class="bi bi-list"></i>
    </button>

    <!-- Logo -->
    <a href="${pageContext.request.contextPath}/home" class="cps-logo" itemprop="url" title="Bincom — Trang chủ mua sắm trực tuyến" aria-label="Bincom trang chủ">
      <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom - Mua sắm điện thoại, laptop chính hãng" itemprop="image" width="140" height="40">
    </a>

    <!-- Search Bar (Desktop) -->
    <div class="cps-searchbar" role="search">
      <form action="${pageContext.request.contextPath}/shop" method="get">
        <label for="mainSearch" class="sr-only">Tìm kiếm sản phẩm tại Bincom</label>
        <div class="cps-search-wrap">
          <input id="mainSearch" type="search" name="keyword" value="${keyword}"
                 placeholder="Tìm điện thoại, laptop, phụ kiện..."
                 autocomplete="off" aria-label="Tìm kiếm sản phẩm">
          <!-- Search suggestions dropdown (populate via JS) -->
          <div class="cps-search-suggest" id="searchSuggest" role="listbox" aria-label="Gợi ý tìm kiếm"></div>
        </div>
        <button type="submit" class="cps-search-btn" aria-label="Tìm kiếm">
          <i class="bi bi-search"></i> <span>Tìm kiếm</span>
        </button>
      </form>
    </div>

    <!-- Header Actions -->
    <div class="cps-header-actions">
      <!-- Wishlist -->
      <a href="#" onclick="openWishlistModal(event)" class="cps-action-btn cps-wishlist-btn" title="Danh sách yêu thích của bạn" aria-label="Yêu thích" style="margin-right: 8px;">
        <div class="cps-action-icon">
          <i class="bi bi-heart"></i>
          <span class="cps-cart-badge" id="wishlistBadge" style="background-color: var(--cps-orange); display: none;">0</span>
        </div>
        <span class="cps-action-label">Yêu thích</span>
      </a>

      <!-- Cart -->
      <a href="${pageContext.request.contextPath}/cart" class="cps-action-btn cps-cart-btn" title="Giỏ hàng của bạn" aria-label="Giỏ hàng">
        <div class="cps-action-icon">
          <i class="bi bi-cart3"></i>
          <span class="cps-cart-badge" id="cartBadge" aria-live="polite">0</span>
        </div>
        <span class="cps-action-label">Giỏ hàng</span>
      </a>

      <!-- Account -->
      <sec:authorize access="!isAuthenticated()">
        <a href="${pageContext.request.contextPath}/login" class="cps-action-btn" title="Đăng nhập tài khoản Bincom" aria-label="Đăng nhập">
          <div class="cps-action-icon"><i class="bi bi-person"></i></div>
          <span class="cps-action-label">Đăng nhập</span>
        </a>
      </sec:authorize>
      <sec:authorize access="isAuthenticated()">
        <div class="cps-account-wrap">
          <button class="cps-action-btn cps-account-trigger" aria-haspopup="true" aria-expanded="false" aria-label="Menu tài khoản">
            <div class="cps-action-icon"><i class="bi bi-person-circle"></i></div>
            <span class="cps-action-label"><sec:authentication property="principal.username"/></span>
          </button>
          <div class="cps-account-dropdown" role="menu">
            <a href="${pageContext.request.contextPath}/account" role="menuitem" title="Thông tin tài khoản">
              <i class="bi bi-person-lines-fill"></i> Tài khoản của tôi
            </a>
            <a href="${pageContext.request.contextPath}/orders" role="menuitem" title="Lịch sử đơn hàng">
              <i class="bi bi-bag-check-fill"></i> Đơn hàng của tôi
            </a>
            <div class="cps-dropdown-divider"></div>
            <form action="${pageContext.request.contextPath}/logout" method="post">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
              <button type="submit" role="menuitem" class="cps-dropdown-logout">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
              </button>
            </form>
          </div>
        </div>
      </sec:authorize>

      <!-- Mobile Search Toggle -->
      <button class="cps-mobile-search-btn" onclick="cpsMobileSearch()" aria-label="Tìm kiếm">
        <i class="bi bi-search"></i>
      </button>
    </div>
  </div>

  <!-- Mobile Search Bar (hidden by default) -->
  <div class="cps-mobile-searchbar" id="mobileSearchbar">
    <form action="${pageContext.request.contextPath}/shop" method="get" role="search">
      <label for="mobileSearch" class="sr-only">Tìm kiếm sản phẩm</label>
      <input id="mobileSearch" type="search" name="keyword" value="${keyword}"
             placeholder="Tìm điện thoại, laptop..." autocomplete="off">
      <button type="submit" aria-label="Tìm kiếm"><i class="bi bi-search"></i></button>
      <button type="button" onclick="cpsMobileSearch()" aria-label="Đóng"><i class="bi bi-x-lg"></i></button>
    </form>
  </div>
</header>

<!-- ============================================================
     CATEGORY NAVBAR — CellphoneS style horizontal menu
     ============================================================ -->
<c:if test="${isHome != 'true'}">
<nav class="cps-catnav" aria-label="Danh mục sản phẩm" itemscope itemtype="https://schema.org/SiteNavigationElement">
  <div class="cps-catnav-inner">

    <!-- All products link -->
    <div class="cps-catnav-item">
      <a href="${pageContext.request.contextPath}/shop" class="cps-catlink ${empty categoryId ? 'active' : ''}" itemprop="url" title="Tất cả sản phẩm Bincom">
        <i class="bi bi-grid-fill"></i> <span itemprop="name">Tất cả sản phẩm</span>
      </a>
    </div>

    <div class="cps-catnav-item cps-submenu-wrap">
      <a href="${pageContext.request.contextPath}/shop?categoryId=1"
         class="cps-catlink ${categoryId == 1 || categoryId == 7 || categoryId == 16 || categoryId == 10 || categoryId == 8 || categoryId == 9 ? 'active' : ''}"
         itemprop="url" title="Điện thoại và thiết bị số chính hãng tại Bincom">
        <i class="bi bi-phone-fill"></i>
        <span itemprop="name">Điện thoại &amp; Thiết bị</span>
      </a>
      <div class="cps-submenu" role="menu">
        <ul>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=7" title="Mua smartphone chính hãng"><i class="bi bi-phone"></i> Smartphone</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=16" title="Mua máy tính bảng chính hãng"><i class="bi bi-tablet"></i> Máy tính bảng</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=10" title="Mua tai nghe chính hãng"><i class="bi bi-headphones"></i> Tai nghe &amp; Loa</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=8" title="Mua laptop chính hãng"><i class="bi bi-laptop"></i> Laptop &amp; MacBook</a></li>
        </ul>
      </div>
    </div>

    <div class="cps-catnav-item cps-submenu-wrap">
      <a href="${pageContext.request.contextPath}/shop?categoryId=2"
         class="cps-catlink ${categoryId == 2 || categoryId == 11 || categoryId == 12 || categoryId == 13 ? 'active' : ''}"
         itemprop="url" title="Thời trang và phụ kiện cao cấp tại Bincom">
        <i class="bi bi-gem"></i>
        <span itemprop="name">Thời trang &amp; Phụ kiện</span>
      </a>
      <div class="cps-submenu" role="menu">
        <ul>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=11" title="Mua quần áo thời trang"><i class="bi bi-gender-ambiguous"></i> Quần áo</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=12" title="Mua giày dép thời trang"><i class="bi bi-footprints"></i> Giày dép</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=13" title="Mua trang sức phụ kiện"><i class="bi bi-gift"></i> Phụ kiện thời trang</a></li>
        </ul>
      </div>
    </div>

    <div class="cps-catnav-item cps-submenu-wrap">
      <a href="${pageContext.request.contextPath}/shop?categoryId=3"
         class="cps-catlink ${categoryId == 3 || categoryId == 14 || categoryId == 15 ? 'active' : ''}"
         itemprop="url" title="Đồ dùng gia đình thông minh tại Bincom">
        <i class="bi bi-house-heart"></i>
        <span itemprop="name">Đồ dùng gia đình</span>
      </a>
      <div class="cps-submenu" role="menu">
        <ul>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=14" title="Đồ dùng gia đình"><i class="bi bi-fire"></i> Đồ dùng gia đình</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=15" title="Thiết bị gia dụng thông minh"><i class="bi bi-cpu"></i> Thiết bị gia dụng</a></li>
        </ul>
      </div>
    </div>

    <div class="cps-catnav-item cps-submenu-wrap">
      <a href="${pageContext.request.contextPath}/shop?categoryId=4"
         class="cps-catlink ${categoryId == 4 ? 'active' : ''}"
         itemprop="url" title="Sách và văn phòng phẩm tại Bincom">
        <i class="bi bi-book"></i>
        <span itemprop="name">Sách &amp; Văn phòng</span>
      </a>
      <div class="cps-submenu" role="menu">
        <ul>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=4&keyword=Sách" title="Sách kỹ năng cuộc sống"><i class="bi bi-journal-text"></i> Sách kỹ năng</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=4&keyword=Vẽ" title="Thiết bị văn phòng phẩm"><i class="bi bi-printer"></i> Dụng cụ vẽ</a></li>
        </ul>
      </div>
    </div>

    <div class="cps-catnav-item cps-submenu-wrap">
      <a href="${pageContext.request.contextPath}/shop?categoryId=5"
         class="cps-catlink ${categoryId == 5 ? 'active' : ''}"
         itemprop="url" title="Thể thao và du lịch tại Bincom">
        <i class="bi bi-bicycle"></i>
        <span itemprop="name">Thể thao &amp; Du lịch</span>
      </a>
      <div class="cps-submenu" role="menu">
        <ul>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=5" title="Dụng cụ thể thao chính hãng"><i class="bi bi-trophy"></i> Dụng cụ thể thao</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=5&keyword=Xe" title="Đồ cắm trại dã ngoại"><i class="bi bi-compass"></i> Xe đạp dã ngoại</a></li>
        </ul>
      </div>
    </div>

    <div class="cps-catnav-item cps-submenu-wrap">
      <a href="${pageContext.request.contextPath}/shop?categoryId=6"
         class="cps-catlink ${categoryId == 6 ? 'active' : ''}"
         itemprop="url" title="Mỹ phẩm và làm đẹp chính hãng tại Bincom">
        <i class="bi bi-stars"></i>
        <span itemprop="name">Mỹ phẩm &amp; Làm đẹp</span>
      </a>
      <div class="cps-submenu" role="menu">
        <ul>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=6" title="Mỹ phẩm cao cấp"><i class="bi bi-magic"></i> Mỹ phẩm</a></li>
          <li><a href="${pageContext.request.contextPath}/shop?categoryId=6&keyword=Serum" title="Chăm sóc da mặt chuyên sâu"><i class="bi bi-heart-pulse"></i> Chăm sóc da</a></li>
        </ul>
      </div>
    </div>

    <!-- Right side: USPs -->
    <div class="cps-catnav-usps">
      <span><i class="bi bi-truck"></i> Miễn phí vận chuyển</span>
      <span><i class="bi bi-shield-check"></i> Bảo hành chính hãng</span>
      <span><i class="bi bi-arrow-counterclockwise"></i> Đổi trả 30 ngày</span>
    </div>
  </div>
</nav>
</c:if>

<!-- ============================================================
     BREADCRUMB (SEO semantic, shown per page)
     ============================================================ -->
<c:if test="${not empty breadcrumbs}">
<nav class="cps-breadcrumb" aria-label="Breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
  <div class="cps-container">
    <ol>
      <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
        <a href="${pageContext.request.contextPath}/home" itemprop="item" title="Trang chủ">
          <span itemprop="name">Trang chủ</span>
        </a>
        <meta itemprop="position" content="1">
        <i class="bi bi-chevron-right"></i>
      </li>
      <c:forEach var="bc" items="${breadcrumbs}" varStatus="st">
      <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
        <c:choose>
          <c:when test="${st.last}">
            <span itemprop="name" aria-current="page">${bc.name}</span>
          </c:when>
          <c:otherwise>
            <a href="${bc.url}" itemprop="item" title="${bc.name}">
              <span itemprop="name">${bc.name}</span>
            </a>
            <i class="bi bi-chevron-right"></i>
          </c:otherwise>
        </c:choose>
        <meta itemprop="position" content="${st.index + 2}">
      </li>
      </c:forEach>
    </ol>
  </div>
</nav>
</c:if>

<!-- Toast container -->
<div id="toastContainer" aria-live="assertive" aria-atomic="true"></div>

<!-- JS -->
<script src="${pageContext.request.contextPath}/resources/js/shop.js"></script>
<script>
/* ===== CPS DRAWER ===== */
function cpsOpenDrawer() {
  document.getElementById('cps-drawer').classList.add('open');
  document.getElementById('cps-overlay').classList.add('show');
  document.body.style.overflow = 'hidden';
  document.querySelector('.cps-hamburger').setAttribute('aria-expanded', 'true');
}
function cpsCloseDrawer() {
  document.getElementById('cps-drawer').classList.remove('open');
  document.getElementById('cps-overlay').classList.remove('show');
  document.body.style.overflow = '';
  document.querySelector('.cps-hamburger').setAttribute('aria-expanded', 'false');
}
/* ===== ACCOUNT DROPDOWN ===== */
(function(){
  var trigger = document.querySelector('.cps-account-trigger');
  if (!trigger) return;
  var dd = trigger.closest('.cps-account-wrap').querySelector('.cps-account-dropdown');
  trigger.addEventListener('click', function(e){
    e.stopPropagation();
    var open = dd.classList.toggle('show');
    trigger.setAttribute('aria-expanded', open);
  });
  document.addEventListener('click', function(){ dd.classList.remove('show'); });
})();
/* ===== MOBILE SEARCH ===== */
function cpsMobileSearch() {
  var bar = document.getElementById('mobileSearchbar');
  var show = bar.classList.toggle('open');
  if (show) { var inp = bar.querySelector('input'); if(inp) inp.focus(); }
}
/* ===== SEARCH SUGGESTIONS (basic) ===== */
(function(){
  var inp = document.getElementById('mainSearch');
  var box = document.getElementById('searchSuggest');
  if (!inp || !box) return;
  var timer;
  inp.addEventListener('input', function(){
    clearTimeout(timer);
    var q = inp.value.trim();
    if (q.length < 2) { box.style.display='none'; return; }
    timer = setTimeout(function(){
      fetch(CTX + '/shop?keyword=' + encodeURIComponent(q) + '&ajax=suggest', {credentials:'same-origin'})
        .then(function(r){ return r.ok ? r.json() : null; })
        .then(function(data){
          if (!data || !data.length) { box.style.display='none'; return; }
          box.innerHTML = data.slice(0,6).map(function(item){
            return '<a href="'+ CTX +'/shop?keyword='+ encodeURIComponent(item) +'" role="option">'+ item +'</a>';
          }).join('');
          box.style.display = 'block';
        }).catch(function(){ box.style.display='none'; });
    }, 300);
  });
  document.addEventListener('click', function(e){
    if (!inp.contains(e.target)) box.style.display = 'none';
  });
  inp.addEventListener('keydown', function(e){
    if (e.key === 'Escape') box.style.display = 'none';
  });
})();
</script>
