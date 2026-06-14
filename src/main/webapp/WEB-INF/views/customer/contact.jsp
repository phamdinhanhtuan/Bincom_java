<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Liên hệ với Bincom" scope="request"/>
<%@ include file="/WEB-INF/views/layouts/customer-header.jsp" %>

<div style="background:#f8fafc; padding: 60px 0;">
  <div class="kumo-container" style="max-width: 1000px; margin: 0 auto; padding: 0 24px;">
    <!-- Contact Info Card -->
    <div style="background: white; border-radius: 24px; padding: 48px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;">
      <div style="text-align: center; margin-bottom: 40px;">
        <span style="font-size: 48px;">📞</span>
        <h1 style="font-family: 'Plus Jakarta Sans', sans-serif; font-size: 38px; font-weight: 800; color: #0f172a; margin-top: 16px;">
          Liên hệ <span style="color: #2563eb;">Bincom</span>
        </h1>
        <p style="font-size: 16px; color: #64748b; margin-top: 8px; font-weight: 500;">
          Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn 24/7.
        </p>
      </div>

      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 32px; font-size: 15px; color: #334155; line-height: 1.8;">
        <!-- Left: Form -->
        <div>
          <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin-bottom: 20px;">Gửi tin nhắn cho chúng tôi</h3>
          
          <c:if test="${not empty successMessage}">
            <div style="background:#f0fdf4; border: 1px solid #bbf7d0; border-radius: 8px; padding: 12px 16px; font-size: 14px; color: #16a34a; margin-bottom: 20px; font-weight: 500;">
              <i class="bi bi-check-circle-fill" style="margin-right: 8px;"></i> ${successMessage}
            </div>
          </c:if>
          
          <c:if test="${not empty errorMessage}">
            <div style="background:#fef2f2; border: 1px solid #fecaca; border-radius: 8px; padding: 12px 16px; font-size: 14px; color: #dc2626; margin-bottom: 20px; font-weight: 500;">
              <i class="bi bi-exclamation-triangle-fill" style="margin-right: 8px;"></i> ${errorMessage}
            </div>
          </c:if>

          <form action="${pageContext.request.contextPath}/contact" method="post" style="display: flex; flex-direction: column; gap: 16px;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
            <!-- Honeypot Spam Control (hidden from users, bot trap) -->
            <div style="display: none;">
              <input type="text" name="honeypot" value="" autocomplete="off" />
            </div>

            <div>
              <label style="display: block; font-size: 13px; font-weight: 600; color: #0f172a; margin-bottom: 6px;">Họ và tên</label>
              <input type="text" name="name" class="form-control" style="width: 100%; padding: 10px 14px; border-radius: 8px; border: 1px solid #e2e8f0;" placeholder="Nguyễn Văn A" required>
            </div>
            <div>
              <label style="display: block; font-size: 13px; font-weight: 600; color: #0f172a; margin-bottom: 6px;">Email</label>
              <input type="email" name="email" class="form-control" style="width: 100%; padding: 10px 14px; border-radius: 8px; border: 1px solid #e2e8f0;" placeholder="an@gmail.com" required>
            </div>
            <div>
              <label style="display: block; font-size: 13px; font-weight: 600; color: #0f172a; margin-bottom: 6px;">Nội dung</label>
              <textarea name="message" class="form-control" rows="4" style="width: 100%; padding: 10px 14px; border-radius: 8px; border: 1px solid #e2e8f0;" placeholder="Lời nhắn của bạn..." required></textarea>
            </div>
            <button type="submit" style="background:#2563eb; color: white; border: none; font-size: 14px; padding: 12px; border-radius: 8px; font-weight: 700; cursor: pointer;">
              Gửi liên hệ
            </button>
          </form>
        </div>
        
        <!-- Right: Info -->
        <div style="background: #f8fafc; border-radius: 16px; padding: 32px; border: 1px solid #e2e8f0; display: flex; flex-direction: column; gap: 20px;">
          <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin-bottom: 8px;">Thông tin liên hệ</h3>
          <div>
            <div style="font-weight: 700; color: #0f172a;"><i class="bi bi-geo-alt-fill me-2" style="color:#2563eb;"></i>Địa chỉ chính</div>
            <div style="color: #64748b; font-size: 14px;">Tòa nhà Bincom, Quận 1, TP. Hồ Chí Minh</div>
          </div>
          <div>
            <div style="font-weight: 700; color: #0f172a;"><i class="bi bi-telephone-fill me-2" style="color:#2563eb;"></i>Hotline hỗ trợ</div>
            <div style="color: #64748b; font-size: 14px;">1800 1234 (Miễn phí cuộc gọi, 8:00 – 22:00)</div>
          </div>
          <div>
            <div style="font-weight: 700; color: #0f172a;"><i class="bi bi-envelope-fill me-2" style="color:#2563eb;"></i>Email</div>
            <div style="color: #64748b; font-size: 14px;">support@bincom.vn</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/layouts/customer-footer.jsp" %>
