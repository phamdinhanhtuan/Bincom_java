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
            String uploadPath = servletContext.getRealPath(UPLOAD_DIR + subDirectory);
            if (uploadPath == null) {
                String userDir = System.getProperty("user.dir");
                File current = new File(userDir);
                File srcWebapp = null;
                while (current != null) {
                    File testDir = new File(current, "src/main/webapp");
                    if (testDir.exists() && testDir.isDirectory()) {
                        srcWebapp = testDir;
                        break;
                    }
                    current = current.getParentFile();
                }
                if (srcWebapp != null) {
                    uploadPath = new File(srcWebapp, "uploads/" + subDirectory).getAbsolutePath();
                } else {
                    uploadPath = System.getProperty("java.io.tmpdir") + UPLOAD_DIR + subDirectory;
                }
            }
            File dir = new File(uploadPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }

            String uniqueFileName = UUID.randomUUID().toString() + extension;
            Path filePath = Paths.get(uploadPath, uniqueFileName);
            Files.write(filePath, file.getBytes());

            // Write to project source directory to persist between NetBeans clean/rebuilds
            try {
                String webappRoot = servletContext.getRealPath("/");
                if (webappRoot != null) {
                    File rootDir = new File(webappRoot);
                    File current = rootDir;
                    while (current != null) {
                        File srcWebapp = new File(current, "src/main/webapp");
                        if (srcWebapp.exists() && srcWebapp.isDirectory()) {
                            File srcUploads = new File(srcWebapp, "uploads/" + subDirectory);
                            if (!srcUploads.exists()) {
                                srcUploads.mkdirs();
                            }
                            Path srcFilePath = Paths.get(srcUploads.getAbsolutePath(), uniqueFileName);
                            Files.write(srcFilePath, file.getBytes());
                            break;
                        }
                        current = current.getParentFile();
                    }
                }
            } catch (Exception devEx) {
                // Ignore errors writing to source folder in production
            }

            return UPLOAD_DIR + subDirectory + "/" + uniqueFileName;
        } catch (IOException e) {
            throw new RuntimeException("Lỗi upload file: " + e.getMessage(), e);
        }
    }

    public void deleteFile(String filePath) {
        if (filePath == null || filePath.isEmpty()) return;
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
