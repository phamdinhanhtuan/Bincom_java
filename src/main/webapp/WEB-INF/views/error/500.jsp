<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>500 — Lỗi hệ thống</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f0f2f8; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .error-box { text-align: center; max-width: 500px; padding: 40px; background: white; border-radius: 24px; box-shadow: 0 20px 40px rgba(108,99,255,0.12); }
        .error-code { font-size: 80px; font-weight: 800; background: linear-gradient(135deg,#ef4444,#b91c1c); -webkit-background-clip: text; -webkit-text-fill-color: transparent; line-height: 1; }
        .error-title { font-size: 24px; font-weight: 700; color: #1e1b4b; margin: 16px 0 8px; }
        .error-desc { color: #6b7280; margin-bottom: 24px; }
        .btn-home { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg,#6c63ff,#5a52d5); color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; text-decoration: none; transition: all 0.25s; }
        .btn-home:hover { box-shadow: 0 8px 20px rgba(108,99,255,0.4); transform: translateY(-2px); color: white; }
    </style>
</head>
<body>
<div class="error-box">
    <div style="font-size:60px;margin-bottom:16px;">⚠️</div>
    <div class="error-code">500</div>
    <h1 class="error-title">Lỗi hệ thống</h1>
    <p class="error-desc">Đã có lỗi xảy ra trên hệ thống của chúng tôi. Vui lòng thử lại sau.</p>
    <a href="${pageContext.request.contextPath}/" class="btn-home">
        <i class="bi bi-house-fill"></i> Về trang chủ
    </a>
</div>
</body>
</html>
