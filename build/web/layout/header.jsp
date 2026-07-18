<%-- 
    Document   : header
    Created on : Nov 20, 2025, 9:07:19 PM
    Author     : 06052
--%>

<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- HEADER AREA -->
<header class="topmenu">

  <!-- TOP BAR -->
  <div class="container py-2 d-flex align-items-center justify-content-between">

    <!-- LOGO -->
    <a href="index" class="text-decoration-none text-dark brand">🌸 ShopHoa</a>

    <!-- SEARCH -->
    <form action="search" method="get" class="search-form">
      <input type="text"
             name="keyword"
             class="search-input"
             placeholder="Tìm bó hoa, loại hoa..."
             aria-label="Tìm kiếm">
      <button type="submit" class="search-btn">
        <span class="visually-hidden">Tìm kiếm</span>
        <svg xmlns="http://www.w3.org/2000/svg"
             width="18" height="18" viewBox="0 0 24 24" fill="none"
             stroke="currentColor" stroke-width="2"
             stroke-linecap="round" stroke-linejoin="round">
          <circle cx="11" cy="11" r="7"></circle>
          <line x1="16.5" y1="16.5" x2="21" y2="21"></line>
        </svg>
      </button>
    </form>

    <!-- RIGHT AREA -->
    <div class="d-flex align-items-center gap-2">

      <!-- CART -->
      <a href="cart" class="btn btn-outline-primary me-3 btn-header-pill btn-cart">
        <i class="bi bi-bag me-1"></i> Giỏ hàng
      </a>

      <!-- USER -->
      <c:choose>

                <%-- Khi người dùng ĐÃ đăng nhập --%>
        <c:when test="${not empty sessionScope.currentUser}">
          <div class="dropdown">
            <button class="btn btn-outline-secondary btn-header-pill btn-account dropdown-toggle"
                    type="button" data-bs-toggle="dropdown">
              <i class="bi bi-person-circle me-1"></i>
              ${sessionScope.currentUser.name}
            </button>

            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="profile-edit">Chỉnh sửa tài khoản</a></li>
              <li><a class="dropdown-item" href="change-password">Đổi mật khẩu</a></li>
              <li><a class="dropdown-item" href="orders">Lịch sử đơn hàng</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item text-danger" href="logout">Đăng xuất</a></li>
            </ul>
          </div>
        </c:when>

        <%-- Khi CHƯA đăng nhập --%>
        <c:otherwise>
          <a href="login" class="btn btn-primary btn-header-pill">
            Đăng nhập
          </a>
          <a href="register.jsp" class="btn btn-outline-secondary btn-header-pill btn-account">
            Đăng ký
          </a>
        </c:otherwise>


      </c:choose>

    </div>
  </div>

  <!-- NAV MENU -->
  <nav class="border-top">
    <div class="container">
      <ul class="nav py-2 justify-content-center">
        <li class="nav-item">
          <a class="nav-link" href="index">Trang chủ</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="about.jsp">Giới thiệu</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="index#products-section">Sản phẩm mới</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="blog.jsp">Blog</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="contact">Liên hệ</a>
        </li>
      </ul>
    </div>
  </nav>

</header>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
