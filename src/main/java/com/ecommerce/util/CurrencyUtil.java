package com.ecommerce.util;

import java.text.NumberFormat;
import java.util.Locale;

public final class CurrencyUtil {

    private CurrencyUtil() {}

    private static final NumberFormat VN_FORMAT = NumberFormat.getInstance(new Locale("vi", "VN"));

    public static String formatVND(java.math.BigDecimal amount) {
        if (amount == null) return "0₫";
        return VN_FORMAT.format(amount) + "₫";
    }

    public static String formatVND(long amount) {
        return VN_FORMAT.format(amount) + "₫";
    }
}
