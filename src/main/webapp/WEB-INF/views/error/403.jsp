<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>403 — Không có quyền truy cập</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f0f2f8; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .error-box { text-align: center; max-width: 480px; padding: 40px; background: white; border-radius: 24px; box-shadow: 0 20px 40px rgba(108,99,255,0.12); }
        .error-code { font-size: 80px; font-weight: 800; background: linear-gradient(135deg,#6c63ff,#ff6584); -webkit-background-clip: text; -webkit-text-fill-color: transparent; line-height: 1; }
        .error-title { font-size: 24px; font-weight: 700; color: #1e1b4b; margin: 16px 0 8px; }
        .error-desc { color: #6b7280; margin-bottom: 24px; }
        .btn-home { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg,#6c63ff,#5a52d5); color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; text-decoration: none; transition: all 0.25s; }
        .btn-home:hover { box-shadow: 0 8px 20px rgba(108,99,255,0.4); transform: translateY(-2px); color: white; }
        .btn-logout { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg,#64748b,#475569); color: white; padding: 12px 24px; border: none; border-radius: 50px; font-weight: 600; text-decoration: none; cursor: pointer; transition: all 0.25s; font-family: inherit; font-size: 16px; }
        .btn-logout:hover { box-shadow: 0 8px 20px rgba(100,116,139,0.4); transform: translateY(-2px); color: white; }
    </style>
</head>
<body>
<div class="error-box">
    <div class="error-code">403</div>
    <h1 class="error-title">Không có quyền truy cập</h1>
    <p class="error-desc">Bạn không có quyền để xem trang này. Vui lòng đăng nhập với tài khoản phù hợp.</p>
    <div style="display: flex; gap: 12px; justify-content: center; align-items: center; margin-top: 24px;">
        <a href="${pageContext.request.contextPath}/" class="btn-home">
            <i class="bi bi-house-fill"></i> Về trang chủ
        </a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin: 0;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn-logout">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </button>
        </form>
    </div>
</div>
</body>
</html>
