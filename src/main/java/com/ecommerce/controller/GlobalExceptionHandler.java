package com.ecommerce.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * Centralized exception handling for all controllers.
 *
 * <p>Data-binding configuration ({@code @InitBinder}) lives in the companion
 * class {@link GlobalBindingAdvice} to keep this class focused on a single
 * concern.
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * Redirects back to the referring page with a user-friendly error message
     * when the uploaded file exceeds the configured size limit.
     */
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public String handleMaxUploadSize(MaxUploadSizeExceededException ex,
                                      RedirectAttributes redirectAttributes,
                                      HttpServletRequest request) {
        log.warn("Upload size exceeded: {}", ex.getMessage());
        redirectAttributes.addFlashAttribute("error",
                "Kích thước file tải lên vượt quá giới hạn cho phép (tối đa 10MB)!");

        String referer = request.getHeader("Referer");
        return (referer != null && !referer.isBlank())
                ? "redirect:" + referer
                : "redirect:/admin/products";
    }

    /**
     * Catch-all handler that renders a 500 error view and logs the full
     * stack trace for diagnostics.
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView handleUnexpected(Exception ex, HttpServletRequest request) {
        log.error("Unhandled error at [{}]: {}", request.getRequestURI(), ex.getMessage(), ex);
        ModelAndView mav = new ModelAndView("error/500");
        mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        return mav;
    }
}
