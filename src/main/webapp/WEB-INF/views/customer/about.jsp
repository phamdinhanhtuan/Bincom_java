<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Giới thiệu về Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<div style="background:#f8fafc; padding: 60px 0;">
  <div class="kumo-container" style="max-width: 1000px; margin: 0 auto; padding: 0 24px;">
    <!-- Intro Card -->
    <div style="background: white; border-radius: 24px; padding: 48px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;">
      <div style="text-align: center; margin-bottom: 40px;">
        <span style="font-size: 48px;">🛍️</span>
        <h1 style="font-family: 'Plus Jakarta Sans', sans-serif; font-size: 38px; font-weight: 800; color: #0f172a; margin-top: 16px;">
          Giới thiệu về <span style="color: #2563eb;">Bincom</span>
        </h1>
        <p style="font-size: 16px; color: #64748b; margin-top: 8px; font-weight: 500;">
          Hệ thống mua sắm trực tuyến thông minh, tin cậy và tiện lợi.
        </p>
      </div>

      <div style="font-size: 15px; color: #334155; line-height: 1.8; font-weight: 500;">
        <p>
          Chào mừng bạn đến với <strong>Bincom</strong> — giải pháp thương mại điện tử toàn diện giúp kết nối hàng triệu khách hàng với các sản phẩm công nghệ, thời trang và gia dụng chính hãng chất lượng cao.
        </p>
        <p>
          Với sứ mệnh nâng cao trải nghiệm mua sắm kỹ thuật số, chúng tôi không ngừng cải tiến công nghệ và dịch vụ để mang lại sự tiện ích tối đa cho người dùng. Tại Bincom, khách hàng có thể dễ dàng tìm kiếm, so sánh giá cả, đặt mua sản phẩm một cách nhanh chóng và bảo mật cao.
        </p>
        
        <h3 style="font-size: 20px; font-weight: 700; color: #0f172a; margin: 32px 0 16px;">Giá trị cốt lõi của chúng tôi</h3>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-bottom: 32px;">
          <div style="background:#f8fafc; border-radius: 16px; padding: 24px; border: 1px solid #e2e8f0;">
            <div style="font-size: 28px; margin-bottom: 12px;">🌟</div>
            <h4 style="font-weight: 700; color: #0f172a; margin-bottom: 8px;">Chất lượng hàng đầu</h4>
            <p style="font-size: 13px; color: #64748b; margin: 0;">Cam kết 100% sản phẩm chính hãng có nguồn gốc rõ ràng, bảo hành uy tín.</p>
          </div>
          <div style="background:#f8fafc; border-radius: 16px; padding: 24px; border: 1px solid #e2e8f0;">
            <div style="font-size: 28px; margin-bottom: 12px;">⚡</div>
            <h4 style="font-weight: 700; color: #0f172a; margin-bottom: 8px;">Dịch vụ nhanh chóng</h4>
            <p style="font-size: 13px; color: #64748b; margin: 0;">Giao hàng siêu tốc toàn quốc, quy trình xử lý đơn hàng chuyên nghiệp.</p>
          </div>
          <div style="background:#f8fafc; border-radius: 16px; padding: 24px; border: 1px solid #e2e8f0;">
            <div style="font-size: 28px; margin-bottom: 12px;">🛡️</div>
            <h4 style="font-weight: 700; color: #0f172a; margin-bottom: 8px;">Bảo mật an toàn</h4>
            <p style="font-size: 13px; color: #64748b; margin: 0;">Giao dịch được bảo mật tuyệt đối với hệ thống mã hóa dữ liệu hiện đại.</p>
          </div>
        </div>

        <p style="text-align: center; margin-top: 40px;">
          <a href="${pageContext.request.contextPath}/shop" class="btn-primary" style="background:#2563eb; color: white; border: none; font-size: 14px; padding: 14px 32px; border-radius: 12px; font-weight: 700; display: inline-flex; align-items: center; gap: 8px; text-decoration:none; box-shadow: 0 4px 14px rgba(37,99,235,0.35);">
            <i class="bi bi-cart-fill"></i> Bắt đầu mua sắm ngay
          </a>
        </p>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
