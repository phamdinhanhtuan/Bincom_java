/* ===== ADMIN JS — ECommerce Pro ===== */

/* Sidebar toggle */
function toggleSidebar() {
    const sidebar = document.getElementById('adminSidebar');
    const main    = document.getElementById('adminMain');
    sidebar.classList.toggle('collapsed');
    main.classList.toggle('expanded');
    localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
}

/* Restore sidebar state */
(function() {
    if (localStorage.getItem('sidebarCollapsed') === 'true') {
        const sidebar = document.getElementById('adminSidebar');
        const main    = document.getElementById('adminMain');
        if (sidebar && main) {
            sidebar.classList.add('collapsed');
            main.classList.add('expanded');
        }
    }
})();

/* Mobile sidebar overlay */
document.addEventListener('click', function(e) {
    const sidebar = document.getElementById('adminSidebar');
    if (!sidebar) return;
    if (window.innerWidth <= 992 && !sidebar.contains(e.target) && !e.target.closest('.sidebar-toggle')) {
        sidebar.classList.remove('mobile-open');
    }
});

function toggleMobileSidebar() {
    document.getElementById('adminSidebar').classList.toggle('mobile-open');
}

/* Auto-dismiss alerts */
setTimeout(function() {
    document.querySelectorAll('.alert').forEach(function(a) {
        a.style.transition = 'opacity .4s';
        a.style.opacity = '0';
        setTimeout(function() { a.remove(); }, 400);
    });
}, 4000);

/* Confirm delete */
document.addEventListener('click', function(e) {
    const btn = e.target.closest('[data-confirm]');
    if (btn) {
        if (!confirm(btn.dataset.confirm)) {
            e.preventDefault();
            e.stopPropagation();
        }
    }
});

/* Image preview */
function previewImage(input, targetId) {
    if (!input.files || !input.files[0]) return;
    const reader = new FileReader();
    reader.onload = function(e) {
        const target = document.getElementById(targetId);
        if (!target) return;
        target.innerHTML = '';
        const img = document.createElement('img');
        img.src = e.target.result;
        img.style.cssText = 'width:100%;max-height:220px;object-fit:cover;border-radius:12px;border:1px solid #e2e8f0;';
        target.appendChild(img);
    };
    reader.readAsDataURL(input.files[0]);
}

/* Admin toast */
function showAdminToast(msg, type) {
    type = type || 'success';
    const t = document.createElement('div');
    t.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger');
    t.style.cssText = 'position:fixed;top:80px;right:24px;z-index:9999;min-width:300px;animation:fadeInUp .3s ease;';
    t.innerHTML = '<i class="bi bi-' + (type === 'success' ? 'check-circle-fill' : 'exclamation-triangle-fill') + ' me-2"></i>' + msg;
    document.body.appendChild(t);
    setTimeout(function() { t.style.opacity='0'; setTimeout(function(){ t.remove(); }, 400); }, 3500);
}

/* Stats counter animation */
function animateCounters() {
    document.querySelectorAll('.stat-value').forEach(function(el) {
        const text = el.textContent.trim();
        const numMatch = text.match(/[\d,]+/);
        if (!numMatch) return;
        const target = parseInt(numMatch[0].replace(/,/g,''));
        if (isNaN(target) || target === 0) return;
        let current = 0;
        const step = Math.ceil(target / 40);
        const suffix = text.replace(numMatch[0], '');
        const prefix = text.substring(0, text.indexOf(numMatch[0]));
        const timer = setInterval(function() {
            current = Math.min(current + step, target);
            el.textContent = prefix + current.toLocaleString('vi-VN') + suffix;
            if (current >= target) clearInterval(timer);
        }, 25);
    });
}

document.addEventListener('DOMContentLoaded', function() {
    animateCounters();
    /* Active nav on mobile */
    if (window.innerWidth <= 992) {
        document.querySelector('.sidebar-toggle') && document.querySelector('.sidebar-toggle').addEventListener('click', toggleMobileSidebar);
    }
});
