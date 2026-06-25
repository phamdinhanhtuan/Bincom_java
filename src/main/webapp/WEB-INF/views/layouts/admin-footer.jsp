<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    </div><!-- end admin-content -->
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
<!-- Form validation script to trim whitespaces and block blank required fields -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    const forms = document.querySelectorAll("form");
    forms.forEach(function(form) {
        form.addEventListener("submit", function(event) {
            let hasError = false;
            const inputs = form.querySelectorAll("input[type='text'], input[type='email'], input[type='password'], textarea");
            
            inputs.forEach(function(input) {
                input.value = input.value.trim();
                
                if (input.hasAttribute("required") && input.value === "") {
                    hasError = true;
                    input.classList.add("is-invalid");
                    
                    let feedback = input.nextElementSibling;
                    if (!feedback || !feedback.classList.contains("invalid-feedback")) {
                        feedback = document.createElement("div");
                        feedback.className = "invalid-feedback";
                        feedback.style.display = "block";
                        feedback.style.color = "#dc2626";
                        feedback.style.fontSize = "12px";
                        feedback.style.marginTop = "4px";
                        feedback.innerHTML = "<i class='bi bi-exclamation-circle-fill'></i> Vui lòng không để trống hoặc chỉ nhập khoảng trắng.";
                        input.parentNode.insertBefore(feedback, input.nextSibling);
                    } else {
                        feedback.style.display = "block";
                        feedback.innerHTML = "<i class='bi bi-exclamation-circle-fill'></i> Vui lòng không để trống hoặc chỉ nhập khoảng trắng.";
                    }
                } else {
                    input.classList.remove("is-invalid");
                    let feedback = input.nextElementSibling;
                    if (feedback && feedback.classList.contains("invalid-feedback")) {
                        feedback.style.display = "none";
                    }
                }
            });
            
            if (hasError) {
                event.preventDefault();
                event.stopPropagation();
                const firstInvalid = form.querySelector(".is-invalid");
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalid.focus();
                }
            }
        });
    });
});
</script>

<!-- ===== SWEETALERT2 JS ===== -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // Intercept standard browser confirm() in form submissions (e.g. Delete, lock user)
    const forms = document.querySelectorAll("form");
    forms.forEach(function(form) {
        const onsubmitAttr = form.getAttribute("onsubmit");
        if (onsubmitAttr && onsubmitAttr.includes("confirm(")) {
            form.removeAttribute("onsubmit");
            
            let confirmMsg = "Bạn có chắc chắn muốn thực hiện hành động này?";
            const match = onsubmitAttr.match(/confirm\(['"](.+?)['"]\)/);
            if (match && match[1]) {
                confirmMsg = match[1];
            }
            
            form.addEventListener("submit", function(event) {
                event.preventDefault();
                
                Swal.fire({
                    title: 'Xác nhận',
                    text: confirmMsg,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Đồng ý',
                    cancelButtonText: 'Hủy',
                    background: '#ffffff',
                    customClass: {
                        popup: 'rounded-4 shadow-lg border-0',
                        confirmButton: 'btn btn-primary px-4 py-2 fw-semibold mx-2',
                        cancelButton: 'btn btn-danger px-4 py-2 fw-semibold mx-2'
                    },
                    buttonsStyling: false
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            });
        }
    });

    // Premium Toast helper using SweetAlert2
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3500,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    // Check for Flash Messages from Spring Redirects
    <c:if test="${not empty success}">
        Toast.fire({
            icon: 'success',
            title: '${success}'
        });
    </c:if>
    <c:if test="${not empty error}">
        Toast.fire({
            icon: 'error',
            title: '${error}'
        });
    </c:if>
});
</script>

</body>
</html>
