package com.ecommerce.util;

/**
 * Utility for resolving product image URLs for use in HTML {@code <img>} tags.
 *
 * <p><strong>Design principle:</strong> This class returns the raw URL as-is for
 * server-relative paths (e.g. {@code /uploads/...}) and lets the browser—together
 * with JSP {@code onerror} handlers—deal with any 404 fallback. This avoids
 * brittle filesystem probing that breaks across environments (IDE, CLI Tomcat,
 * Docker, cloud), since {@code user.dir} differs between deployment modes.
 *
 * <p>The only special case is blank/null input (→ {@code null}) and inline
 * {@code data:} URIs (passed through unchanged, never prefixed with context path).
 */
public final class ImageUrlHelper {

    private ImageUrlHelper() { /* utility class — do not instantiate */ }

    /**
     * Resolves a stored image URL so it is safe to use directly as an HTML
     * {@code src} attribute <em>without</em> prepending the servlet context path.
     *
     * <table>
     *   <tr><th>Input</th><th>Result</th></tr>
     *   <tr><td>{@code null} or blank</td><td>{@code null} — view renders CSS placeholder</td></tr>
     *   <tr><td>{@code data:image/...}</td><td>returned as-is (inline Base64)</td></tr>
     *   <tr><td>{@code /uploads/...}</td><td>returned as-is — browser loads it; JSP onerror handles 404</td></tr>
     *   <tr><td>any other URL</td><td>returned as-is (absolute, CDN, etc.)</td></tr>
     * </table>
     *
     * @param rawUrl value stored in the database; may be {@code null}
     * @return a ready-to-use URL, or {@code null} if no image is available
     */
    public static String resolve(String rawUrl) {
        if (rawUrl == null || rawUrl.isBlank()) {
            return null;
        }
        // data: URIs and all other URLs (uploads, CDN, absolute) — pass through unchanged
        return rawUrl;
    }
}
