package com.ecommerce.util;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Component
public class FileUploadUtil {

    @Autowired
    private ServletContext servletContext;

    private static final String UPLOAD_DIR = "/uploads/";

    public String uploadFile(MultipartFile file, String subDirectory) {
        try {
            byte[] fileBytes = file.getBytes();
            String contentType = file.getContentType();
            String base64Content = java.util.Base64.getEncoder().encodeToString(fileBytes);
            return "data:" + contentType + ";base64," + base64Content;
        } catch (IOException e) {
            throw new RuntimeException("Lỗi upload file: " + e.getMessage(), e);
        }
    }

    public void deleteFile(String filePath) {
        if (filePath == null || filePath.isEmpty() || filePath.startsWith("data:")) return;
        try {
            String realPath = servletContext.getRealPath(filePath);
            if (realPath != null) {
                Files.deleteIfExists(Paths.get(realPath));
            }
            // Also delete from source directory if present
            try {
                String webappRoot = servletContext.getRealPath("/");
                if (webappRoot != null) {
                    File rootDir = new File(webappRoot);
                    File current = rootDir;
                    while (current != null) {
                        File srcWebapp = new File(current, "src/main/webapp");
                        if (srcWebapp.exists() && srcWebapp.isDirectory()) {
                            File srcFile = new File(srcWebapp, filePath.replace(UPLOAD_DIR, "uploads/"));
                            if (srcFile.exists()) {
                                srcFile.delete();
                            }
                            break;
                        }
                        current = current.getParentFile();
                    }
                }
            } catch (Exception devEx) {
                // Ignore
            }
        } catch (IOException e) {
            // Log the error but don't throw
        }
    }

    public boolean isValidImageFile(MultipartFile file) {
        if (file == null || file.isEmpty()) return false;
        String contentType = file.getContentType();
        return contentType != null && (
            contentType.equals("image/jpeg") ||
            contentType.equals("image/png") ||
            contentType.equals("image/gif") ||
            contentType.equals("image/webp")
        );
    }
}
