package com.ecommerce.controller.customer;

import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import com.ecommerce.service.CouponService;
import com.ecommerce.service.OrderService;
import com.ecommerce.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.*;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {

    private static final String CART_SESSION_KEY = "CART";

    @Autowired private OrderService orderService;
    @Autowired private UserService userService;
    @Autowired private CouponService couponService;

    @GetMapping
    public String checkoutForm(HttpSession session, Authentication auth, Model model, javax.servlet.http.HttpServletRequest request) {
        Map<String, CartItem> cart = getCart(session);
        if (cart.isEmpty()) {
            return "redirect:/cart";
        }

        User user = userService.findByUsername(auth.getName()).orElseThrow();
        BigDecimal subtotal = cart.values().stream()
            .map(CartItem::getTotalPrice)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal shippingFee = subtotal.compareTo(new BigDecimal("500000")) >= 0
            ? BigDecimal.ZERO : new BigDecimal("30000");

        model.addAttribute("user",        user);
        model.addAttribute("cartItems",   cart.values());
        model.addAttribute("subtotal",    subtotal);
        model.addAttribute("shippingFee", shippingFee);
        model.addAttribute("total",       subtotal.add(shippingFee));

        model.addAttribute("pageTitle", "Thanh toán đơn hàng — Bincom");
        model.addAttribute("metaDescription", "Nhập thông tin nhận hàng và hoàn tất đơn đặt hàng của bạn tại Bincom.");

        List<Map<String, String>> breadcrumbs = new ArrayList<>();
        Map<String, String> bc1 = new LinkedHashMap<>();
        bc1.put("name", "Giỏ hàng");
        bc1.put("url", request.getContextPath() + "/cart");
        breadcrumbs.add(bc1);

        Map<String, String> bc2 = new LinkedHashMap<>();
        bc2.put("name", "Thanh toán");
        bc2.put("url", request.getContextPath() + "/checkout");
        breadcrumbs.add(bc2);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/checkout";
    }

    @PostMapping("/place-order")
    public String placeOrder(
            @RequestParam String recipientName,
            @RequestParam String recipientPhone,
            @RequestParam String shippingAddress,
            @RequestParam(defaultValue = "COD") String paymentMethod,
            @RequestParam(required = false) String note,
            @RequestParam(required = false) String couponCode,
            HttpSession session,
            Authentication auth,
            RedirectAttributes redirectAttrs) {

        Map<String, CartItem> cart = getCart(session);
        if (cart.isEmpty()) {
            return "redirect:/cart";
        }

        try {
            User user = userService.findByUsername(auth.getName()).orElseThrow();
            Order order = orderService.createOrder(
                user.getId(),
                new ArrayList<>(cart.values()),
                recipientName, recipientPhone, shippingAddress,
                paymentMethod, note, couponCode
            );

            // Clear cart after successful order
            session.removeAttribute(CART_SESSION_KEY);
            redirectAttrs.addFlashAttribute("orderCode", order.getOrderCode());
            return "redirect:/checkout/success";

        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", e.getMessage());
            return "redirect:/checkout";
        }
    }

    @GetMapping("/success")
    public String orderSuccess(Model model, javax.servlet.http.HttpServletRequest request) {
        model.addAttribute("pageTitle", "Đặt hàng thành công — Bincom");
        model.addAttribute("metaDescription", "Cảm ơn bạn đã mua hàng! Đơn hàng của bạn đã được nhận và đang xử lý tại Bincom.");

        List<Map<String, String>> breadcrumbs = new ArrayList<>();
        Map<String, String> bc = new LinkedHashMap<>();
        bc.put("name", "Đặt hàng thành công");
        bc.put("url", request.getContextPath() + "/checkout/success");
        breadcrumbs.add(bc);
        model.addAttribute("breadcrumbs", breadcrumbs);

        return "customer/order-success";
    }

    @PostMapping("/apply-coupon")
    @ResponseBody
    public Map<String, Object> applyCoupon(
            @RequestParam String couponCode,
            @RequestParam BigDecimal orderAmount) {
        Map<String, Object> resp = new HashMap<>();
        try {
            BigDecimal discount = couponService.calculateDiscount(couponCode, orderAmount);
            resp.put("success",  true);
            resp.put("discount", discount);
            resp.put("message",  "Áp dụng mã giảm giá thành công!");
        } catch (Exception e) {
            resp.put("success", false);
            resp.put("message", e.getMessage());
        }
        return resp;
    }

    @SuppressWarnings("unchecked")
    private Map<String, CartItem> getCart(HttpSession session) {
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute(CART_SESSION_KEY);
        return cart != null ? cart : new LinkedHashMap<>();
    }
}
