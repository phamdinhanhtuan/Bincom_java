/* ===== SHOP JS — EShop Customer Front ===== */

const CTX = window.CTX || '';

/* ===== CSRF ===== */
function getCsrfToken() {
    const meta = document.querySelector('meta[name="_csrf"]');
    return meta ? meta.content : '';
}
function getCsrfHeader() {
    const meta = document.querySelector('meta[name="_csrf_header"]');
    return meta ? meta.content : 'X-CSRF-TOKEN';
}

/* ===== CART BADGE ===== */
function updateCartBadge(count) {
    if (typeof count === 'number' || typeof count === 'string') {
        const badge = document.getElementById('cartBadge');
        if (badge) {
            badge.textContent = count;
            badge.style.display = parseInt(count) > 0 ? 'flex' : 'none';
        }
        return;
    }
    fetch(CTX + '/cart/count', { credentials: 'same-origin' })
        .then(r => r.ok ? r.text() : null)
        .then(text => {
            if (text === null) return;
            const cnt = parseInt(text) || 0;
            const badge = document.getElementById('cartBadge');
            if (!badge) return;
            badge.textContent = cnt;
            badge.style.display = cnt > 0 ? 'flex' : 'none';
        })
        .catch(() => {});
}

/* ===== ADD TO CART ===== */
function addToCart(productId, btn) {
    const prevText = btn ? btn.textContent : '';
    if (btn) { btn.textContent = '...'; btn.disabled = true; }

    const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
    headers[getCsrfHeader()] = getCsrfToken();

    fetch(CTX + '/cart/add', {
        method: 'POST',
        headers,
        credentials: 'same-origin',
        body: 'productId=' + productId + '&quantity=1'
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            showToast('✓ Đã thêm vào giỏ hàng!', 'success');
            updateCartBadge();
        } else {
            showToast(data.message || 'Không thể thêm sản phẩm', 'error');
        }
    })
    .catch(() => showToast('Lỗi kết nối, thử lại sau', 'error'))
    .finally(() => {
        if (btn) { btn.textContent = prevText; btn.disabled = false; }
    });
}

/* ===== TOAST ===== */
function showToast(message, type) {
    type = type || 'success';
    const container = document.getElementById('toastContainer');
    if (!container) return;
    const t = document.createElement('div');
    t.className = 'toast-item ' + type;
    const icon = type === 'success' ? '✓' : '✕';
    t.innerHTML = '<span style="font-size:16px;">' + icon + '</span><span>' + message + '</span>';
    container.appendChild(t);
    setTimeout(function() {
        t.style.transition = 'all .3s';
        t.style.opacity = '0';
        t.style.transform = 'translateX(100%)';
        setTimeout(function() { t.remove(); }, 300);
    }, 3000);
}

/* ===== SEARCH TOGGLE ===== */
function toggleSearch() {
    const bar = document.getElementById('searchBar');
    if (!bar) return;
    const isHidden = bar.style.display === 'none' || bar.style.display === '';
    bar.style.display = isHidden ? 'block' : 'none';
    if (isHidden) {
        const input = bar.querySelector('input[type="text"]');
        if (input) { input.focus(); }
    }
}

/* ===== QTY CONTROLS ===== */
function changeQty(productId, delta) {
    const input = document.getElementById('qty-' + productId);
    if (!input) return;
    const newQty = Math.max(1, parseInt(input.value || 1) + delta);
    input.value = newQty;
    updateCartItem(productId, newQty);
}

function updateCartItem(productId, qty) {
    const headers = {};
    headers[getCsrfHeader()] = getCsrfToken();
    fetch(CTX + '/cart/update', {
        method: 'POST',
        headers: Object.assign({ 'Content-Type': 'application/json' }, headers),
        credentials: 'same-origin',
        body: JSON.stringify({ productId, quantity: qty })
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { setTimeout(function() { location.reload(); }, 400); }
    })
    .catch(() => {});
}

function removeFromCart(productId) {
    if (!confirm('Xóa sản phẩm khỏi giỏ hàng?')) return;
    const headers = {};
    headers[getCsrfHeader()] = getCsrfToken();
    fetch(CTX + '/cart/remove/' + productId, {
        method: 'POST',
        headers,
        credentials: 'same-origin'
    })
    .then(() => location.reload())
    .catch(() => {});
}

/* ===== INIT ===== */
document.addEventListener('DOMContentLoaded', function() {
    updateCartBadge();
    /* Animate numbers */
    document.querySelectorAll('.hero-stat-number').forEach(function(el) {
        const target = parseFloat(el.dataset.value || el.textContent);
        if (isNaN(target)) return;
        let current = 0;
        const step = target / 40;
        const suffix = el.dataset.suffix || '';
        const timer = setInterval(function() {
            current = Math.min(current + step, target);
            el.textContent = (Number.isInteger(target) ? Math.round(current) : current.toFixed(1)) + suffix;
            if (current >= target) clearInterval(timer);
        }, 25);
    });
});
