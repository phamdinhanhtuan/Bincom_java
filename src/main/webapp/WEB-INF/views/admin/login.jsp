<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Admin — Bincom</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png?v=1.0.2">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        body{font-family:'Inter',sans-serif;background:#0a0b14;min-height:100vh;display:flex;align-items:center;justify-content:center;position:relative;overflow:hidden;}
        body::before{content:'';position:absolute;top:-200px;right:-200px;width:600px;height:600px;background:radial-gradient(circle,rgba(13,148,136,.18) 0%,transparent 65%);border-radius:50%;}
        body::after{content:'';position:absolute;bottom:-200px;left:-200px;width:500px;height:500px;background:radial-gradient(circle,rgba(2,132,199,.12) 0%,transparent 65%);border-radius:50%;}

        .login-wrap{position:relative;z-index:1;width:100%;max-width:440px;padding:24px;}
        .login-card{
            background:rgba(255,255,255,.04);
            border:1px solid rgba(255,255,255,.1);
            border-radius:20px;
            padding:48px 40px;
            backdrop-filter:blur(20px);
            box-shadow:0 24px 80px rgba(0,0,0,.5),inset 0 1px 0 rgba(255,255,255,.08);
        }
        .login-logo{text-align:center;margin-bottom:8px;}
        .logo-icon{
            width:60px;height:60px;
            background:linear-gradient(135deg,#0d9488,#0284c7);
            border-radius:16px;
            display:inline-flex;align-items:center;justify-content:center;
            font-size:28px;color:white;
            box-shadow:0 8px 30px rgba(13,148,136,.5);
            margin-bottom:20px;
        }
        .login-title{font-size:24px;font-weight:800;color:white;margin-bottom:4px;text-align:center;}
        .login-subtitle{font-size:13px;color:rgba(255,255,255,.45);text-align:center;margin-bottom:36px;}

        .form-group{margin-bottom:18px;}
        .form-group label{display:block;font-size:11.5px;font-weight:600;letter-spacing:.5px;text-transform:uppercase;color:rgba(255,255,255,.5);margin-bottom:8px;}
        .form-group input{
            width:100%;padding:13px 16px;
            background:rgba(255,255,255,.06);
            border:1.5px solid rgba(255,255,255,.1);
            border-radius:12px;
            color:white;font-family:'Inter',sans-serif;font-size:14px;
            transition:all .2s;outline:none;
        }
        .form-group input::placeholder{color:rgba(255,255,255,.25);}
        .form-group input:focus{
            border-color:rgba(13,148,136,.7);
            background:rgba(13,148,136,.08);
            box-shadow:0 0 0 3px rgba(13,148,136,.15);
        }
        .input-icon-wrap{position:relative;}
        .input-icon-wrap i{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,.3);font-size:16px;}
        .input-icon-wrap input{padding-left:44px!important;}

        .btn-login{
            width:100%;padding:14px;
            background:linear-gradient(135deg,#0d9488,#0f766e);
            border:none;border-radius:12px;
            color:white;font-family:'Inter',sans-serif;font-size:14px;font-weight:700;
            cursor:pointer;transition:all .25s;
            box-shadow:0 4px 20px rgba(13,148,136,.45);
            margin-top:8px;
        }
        .btn-login:hover{filter:brightness(1.12);transform:translateY(-1px);box-shadow:0 8px 28px rgba(13,148,136,.55);}
        .btn-login:active{transform:translateY(0);}

        .alert-err{
            background:rgba(239,68,68,.12);border:1px solid rgba(239,68,68,.3);
            border-radius:10px;padding:12px 16px;color:#fca5a5;font-size:13px;
            margin-bottom:20px;display:flex;align-items:center;gap:8px;
        }
        .divider{margin:24px 0;border-top:1px solid rgba(255,255,255,.08);position:relative;text-align:center;}
        .divider span{position:absolute;top:-9px;left:50%;transform:translateX(-50%);background:#12131f;padding:0 12px;color:rgba(255,255,255,.3);font-size:11px;}
        .back-link{display:block;text-align:center;color:rgba(255,255,255,.4);font-size:13px;text-decoration:none;transition:color .2s;}
        .back-link:hover{color:#2dd4bf;}
        .back-link i{margin-right:6px;}
        @media (max-width: 480px) {
            .login-card {
                padding: 32px 20px;
            }
            .login-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
<div class="login-wrap">
    <div class="login-card">
        <div class="login-logo" style="margin-bottom:24px;">
            <a href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Bincom Logo" style="height:48px; width:auto; object-fit:contain; filter:brightness(0) invert(1);">
            </a>
        </div>
        <h1 class="login-title">Đăng nhập Admin</h1>
        <p class="login-subtitle">Hệ thống quản lý Bincom</p>

        <c:if test="${not empty error}">
            <div class="alert-err">
                <i class="bi bi-exclamation-circle-fill"></i>
                ${error}
            </div>
        </c:if>
        <c:if test="${param.logout != null}">
            <div style="background:rgba(16,185,129,.12);border:1px solid rgba(16,185,129,.3);border-radius:10px;padding:12px 16px;color:#6ee7b7;font-size:13px;margin-bottom:20px;display:flex;align-items:center;gap:8px;">
                <i class="bi bi-check-circle-fill"></i> Đã đăng xuất thành công
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="form-group">
                <label>Tên đăng nhập</label>
                <div class="input-icon-wrap">
                    <i class="bi bi-person-fill"></i>
                    <input type="text" name="username" required placeholder="Username hoặc email"
                           value="${param.username}" autocomplete="username">
                </div>
            </div>

            <div class="form-group">
                <label>Mật khẩu</label>
                <div class="input-icon-wrap">
                    <i class="bi bi-lock-fill"></i>
                    <input type="password" name="password" required placeholder="Nhập mật khẩu"
                           autocomplete="current-password">
                </div>
            </div>

            <button type="submit" class="btn-login">
                <i class="bi bi-arrow-right-circle me-2"></i>Đăng nhập
            </button>
        </form>

        <div class="divider"><span>hoặc</span></div>
        <a href="${pageContext.request.contextPath}/home" class="back-link">
            <i class="bi bi-arrow-left"></i>Quay về cửa hàng
        </a>
    </div>
</div>
</body>
</html>
