<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>404 — Không tìm thấy trang</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f0f2f8; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .error-box { text-align: center; max-width: 480px; padding: 40px; background: white; border-radius: 24px; box-shadow: 0 20px 40px rgba(108,99,255,0.12); }
        .error-code { font-size: 80px; font-weight: 800; background: linear-gradient(135deg,#f59e0b,#ef4444); -webkit-background-clip: text; -webkit-text-fill-color: transparent; line-height: 1; }
        .error-title { font-size: 24px; font-weight: 700; color: #1e1b4b; margin: 16px 0 8px; }
        .error-desc { color: #6b7280; margin-bottom: 24px; }
        .btn-home { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg,#6c63ff,#5a52d5); color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; text-decoration: none; }
        .btn-home:hover { color: white; }
    </style>
</head>
<body>
<div class="error-box">
    <div style="font-size:60px;margin-bottom:16px;">🔍</div>
    <div class="error-code">404</div>
    <h1 class="error-title">Trang không tồn tại</h1>
    <p class="error-desc">Trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển.</p>
    <a href="${pageContext.request.contextPath}/" class="btn-home">🏠 Về trang chủ</a>
</div>
</body>
</html>
