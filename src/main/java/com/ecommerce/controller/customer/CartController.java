package com.ecommerce.controller.customer;

import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.*;

@Controller
@RequestMapping("/cart")
public class CartController {

    private static final String CART_SESSION_KEY = "CART";

    @Autowired private ProductService productService;

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        Map<Long, CartItem> cart = getCart(session);
        BigDecimal subtotal = cart.values().stream()
            .map(CartItem::getTotalPrice)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal shippingFee = subtotal.compareTo(new BigDecimal("500000")) >= 0
            ? BigDecimal.ZERO : new BigDecimal("30000");

        model.addAttribute("cartItems",   cart.values());
        model.addAttribute("subtotal",    subtotal);
        model.addAttribute("shippingFee", shippingFee);
        model.addAttribute("total",       subtotal.add(shippingFee));
        return "customer/cart";
    }

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCart(
            @RequestParam Long productId,
            @RequestParam(defaultValue = "1") int quantity,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();
        try {
            Product product = productService.findById(productId)
                .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));

            if (product.getInventory() == null || product.getInventory().getAvailableQuantity() < quantity) {
                response.put("success", false);
                response.put("message", "Sản phẩm không đủ hàng");
                return ResponseEntity.ok(response);
            }

            Map<Long, CartItem> cart = getCart(session);
            if (cart.containsKey(productId)) {
                cart.get(productId).incrementQuantity(quantity);
            } else {
                CartItem item = new CartItem(
                    productId,
                    product.getName(),
                    product.getThumbnailUrl(),
                    product.getEffectivePrice(),
                    quantity
                );
                cart.put(productId, item);
            }
            session.setAttribute(CART_SESSION_KEY, cart);

            response.put("success",   true);
            response.put("message",   "Đã thêm vào giỏ hàng!");
            response.put("cartCount", cart.values().stream().mapToInt(CartItem::getQuantity).sum());
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/update")
    public String updateCart(@RequestParam Long productId,
                             @RequestParam int quantity,
                             HttpSession session,
                             RedirectAttributes redirectAttrs) {
        Map<Long, CartItem> cart = getCart(session);
        if (quantity <= 0) {
            cart.remove(productId);
        } else {
            CartItem item = cart.get(productId);
            if (item != null) item.setQuantity(quantity);
        }
        session.setAttribute(CART_SESSION_KEY, cart);
        return "redirect:/cart";
    }

    @PostMapping("/remove")
    public String removeFromCart(@RequestParam Long productId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttrs) {
        Map<Long, CartItem> cart = getCart(session);
        cart.remove(productId);
        session.setAttribute(CART_SESSION_KEY, cart);
        redirectAttrs.addFlashAttribute("message", "Đã xóa sản phẩm khỏi giỏ hàng.");
        return "redirect:/cart";
    }

    @PostMapping("/clear")
    public String clearCart(HttpSession session) {
        session.removeAttribute(CART_SESSION_KEY);
        return "redirect:/cart";
    }

    @GetMapping("/count")
    @ResponseBody
    public ResponseEntity<Integer> getCartCount(HttpSession session) {
        Map<Long, CartItem> cart = getCart(session);
        int count = cart.values().stream().mapToInt(CartItem::getQuantity).sum();
        return ResponseEntity.ok(count);
    }

    @SuppressWarnings("unchecked")
    private Map<Long, CartItem> getCart(HttpSession session) {
        Map<Long, CartItem> cart = (Map<Long, CartItem>) session.getAttribute(CART_SESSION_KEY);
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute(CART_SESSION_KEY, cart);
        }
        return cart;
    }
}
