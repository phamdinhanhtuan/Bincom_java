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

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @org.springframework.web.bind.annotation.InitBinder
    public void initBinder(org.springframework.web.bind.WebDataBinder binder) {
        // Trim strings and convert empty strings to null
        binder.registerCustomEditor(String.class, new org.springframework.beans.propertyeditors.StringTrimmerEditor(true));
        
        // Convert empty number fields to null instead of throwing TypeMismatchException
        binder.registerCustomEditor(java.math.BigDecimal.class, 
            new org.springframework.beans.propertyeditors.CustomNumberEditor(java.math.BigDecimal.class, true));
        binder.registerCustomEditor(Integer.class, 
            new org.springframework.beans.propertyeditors.CustomNumberEditor(Integer.class, true));
        binder.registerCustomEditor(Long.class, 
            new org.springframework.beans.propertyeditors.CustomNumberEditor(Long.class, true));
        binder.registerCustomEditor(Double.class, 
            new org.springframework.beans.propertyeditors.CustomNumberEditor(Double.class, true));
    }

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public String handleMaxSizeException(MaxUploadSizeExceededException exc, 
                                         RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request) {
        redirectAttributes.addFlashAttribute("error", "Kích thước file tải lên vượt quá giới hạn cho phép (tối đa 10MB)!");
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        return "redirect:/admin/products";
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView handleGenericException(Exception ex, HttpServletRequest request) {
        log.error("Error at {}: {}", request.getRequestURI(), ex.getMessage(), ex);
        ModelAndView mav = new ModelAndView("error/500");
        mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        return mav;
    }
}
