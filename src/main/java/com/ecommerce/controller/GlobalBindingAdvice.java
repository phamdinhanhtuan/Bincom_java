package com.ecommerce.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;

import java.math.BigDecimal;

/**
 * Applies global data-binding rules to every {@code @Controller} in the
 * application.
 *
 * <ul>
 *   <li>Trims leading/trailing whitespace from all {@code String} parameters
 *       and converts blank strings to {@code null}.</li>
 *   <li>Allows numeric form fields ({@link BigDecimal}, {@link Integer},
 *       {@link Long}, {@link Double}) to be submitted as empty strings without
 *       throwing a {@code TypeMismatchException}; empty values are bound as
 *       {@code null} instead.</li>
 * </ul>
 */
@ControllerAdvice
public class GlobalBindingAdvice {

    @InitBinder
    public void configureBinding(WebDataBinder binder) {
        // Trim strings; empty string → null
        binder.registerCustomEditor(String.class,
                new StringTrimmerEditor(/* emptyAsNull= */ true));

        // Allow blank numeric inputs → null (avoids TypeMismatchException)
        binder.registerCustomEditor(BigDecimal.class,
                new CustomNumberEditor(BigDecimal.class, /* allowEmpty= */ true));
        binder.registerCustomEditor(Integer.class,
                new CustomNumberEditor(Integer.class, /* allowEmpty= */ true));
        binder.registerCustomEditor(Long.class,
                new CustomNumberEditor(Long.class, /* allowEmpty= */ true));
        binder.registerCustomEditor(Double.class,
                new CustomNumberEditor(Double.class, /* allowEmpty= */ true));
    }
}
