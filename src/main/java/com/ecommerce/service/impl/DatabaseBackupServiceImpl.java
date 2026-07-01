package com.ecommerce.service.impl;

import com.ecommerce.service.DatabaseBackupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.*;

import java.util.ArrayList;
import java.util.List;

@Service
public class DatabaseBackupServiceImpl implements DatabaseBackupService, org.springframework.beans.factory.InitializingBean, org.springframework.beans.factory.DisposableBean {

    @Autowired
    private DataSource dataSource;

    private static final String BACKUP_FILE_NAME = "database_setup.sql";

    @Override
    public void afterPropertiesSet() throws Exception {
        // Automatically check and import database if empty on startup
        try {
            importDatabaseIfNeeded();
        } catch (Exception e) {
            System.err.println("Error seeding database: " + e.getMessage());
        }
    }

    @Override
    public synchronized void importDatabaseIfNeeded() {
        try (Connection conn = dataSource.getConnection()) {
            // Check if users table exists and has data
            boolean databaseHasData = false;
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users")) {
                if (rs.next() && rs.getInt(1) > 0) {
                    databaseHasData = true;
                }
            } catch (SQLException e) {
                // Table doesn't exist yet, which is expected on initial setup
            }

            if (databaseHasData) {
                System.out.println("Bincom: Database already has data. Skipping import.");
                return;
            }

            try (InputStream is = getBackupInputStream()) {
                if (is == null) {
                    System.out.println("Bincom: No database backup file found to seed. Skipping auto-import.");
                    return;
                }

                System.out.println("Bincom: Database is empty. Loading backup stream to seed...");

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                    StringBuilder sb = new StringBuilder();
                    String line;
                    try (Statement stmt = conn.createStatement()) {
                        stmt.execute("SET FOREIGN_KEY_CHECKS = 0;");
                        while ((line = reader.readLine()) != null) {
                            // Skip comments and empty lines
                            if (line.trim().startsWith("--") || line.trim().startsWith("/*") || line.trim().isEmpty()) {
                                continue;
                            }
                            sb.append(line).append("\n");
                            // If statement ends with semicolon, execute it
                            if (line.trim().endsWith(";")) {
                                String sql = sb.toString().trim();
                                // Remove trailing semicolon for JDBC execute
                                if (sql.endsWith(";")) {
                                    sql = sql.substring(0, sql.length() - 1);
                                }
                                if (!sql.isEmpty()) {
                                    try {
                                        stmt.execute(sql);
                                    } catch (SQLException ex) {
                                        System.err.println("Bincom Seed Error: " + sql + " -> " + ex.getMessage());
                                    }
                                }
                                sb.setLength(0);
                            }
                        }
                        stmt.execute("SET FOREIGN_KEY_CHECKS = 1;");
                    }
                }
                System.out.println("Bincom: Database seed completed successfully.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public synchronized void exportDatabase() {
        List<File> targetFiles = getBackupFilesToWrite();
        System.out.println("Bincom: Exporting database to target files: " + targetFiles);
        try (Connection conn = dataSource.getConnection()) {
            StringWriter sw = new StringWriter();
            try (BufferedWriter writer = new BufferedWriter(sw)) {
                writer.write("-- Auto-generated Database Backup\n");
                writer.write("SET FOREIGN_KEY_CHECKS = 0;\n\n");

                String[] tables = {
                    "roles", "users", "user_roles", "categories", "products", 
                    "inventory", "product_images", "orders", "order_items", "payments", "reviews", "coupons"
                };

                for (String table : tables) {
                    // Check if table exists
                    try {
                        DatabaseMetaData meta = conn.getMetaData();
                        try (ResultSet rs = meta.getTables(null, null, table, null)) {
                            if (!rs.next()) {
                                continue; // Skip if table doesn't exist
                            }
                        }
                    } catch (Exception e) {
                        continue;
                    }

                    writer.write("-- Dumping structure and data for table `" + table + "`\n");
                    writer.write("DROP TABLE IF EXISTS `" + table + "`;\n");

                    // Get table creation SQL using SHOW CREATE TABLE
                    try (Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SHOW CREATE TABLE `" + table + "`")) {
                        if (rs.next()) {
                            String createTableSql = rs.getString(2);
                            writer.write(createTableSql + ";\n\n");
                        }
                    } catch (SQLException e) {
                        continue;
                    }

                    // Dump data
                    try (Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM `" + table + "`")) {
                        ResultSetMetaData rsmd = rs.getMetaData();
                        int columnCount = rsmd.getColumnCount();

                        boolean hasData = false;
                        while (rs.next()) {
                            if (!hasData) {
                                writer.write("INSERT INTO `" + table + "` VALUES \n");
                                hasData = true;
                            } else {
                                writer.write(",\n");
                            }

                            writer.write("(");
                            for (int i = 1; i <= columnCount; i++) {
                                Object value = rs.getObject(i);
                                if (value == null) {
                                    writer.write("NULL");
                                } else if (value instanceof Number || value instanceof Boolean) {
                                    writer.write(value.toString());
                                } else {
                                    // Escape string quotes
                                    String strValue = value.toString().replace("\\", "\\\\").replace("'", "\\'");
                                    writer.write("'" + strValue + "'");
                                }
                                if (i < columnCount) {
                                    writer.write(",");
                                }
                            }
                            writer.write(")");
                        }
                        if (hasData) {
                            writer.write(";\n\n");
                        }
                    }
                }

                writer.write("SET FOREIGN_KEY_CHECKS = 1;\n");
                writer.flush();
            }

            String sqlContent = sw.toString();

            for (File targetFile : targetFiles) {
                // Ensure parent directories exist
                File parent = targetFile.getParentFile();
                if (parent != null && !parent.exists()) {
                    parent.mkdirs();
                }
                try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(
                        new FileOutputStream(targetFile), StandardCharsets.UTF_8))) {
                    bw.write(sqlContent);
                    bw.flush();
                    System.out.println("Bincom: Successfully wrote backup to " + targetFile.getAbsolutePath());
                } catch (IOException e) {
                    System.err.println("Bincom: Failed to write backup to " + targetFile.getAbsolutePath() + ": " + e.getMessage());
                }
            }
            System.out.println("Bincom: Database backup completed successfully.");
        } catch (Exception e) {
            System.err.println("Bincom: Error exporting database: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() throws Exception {
        System.out.println("Bincom: Application shutting down. Triggering final database backup...");
        try {
            exportDatabase();
        } catch (Exception e) {
            System.err.println("Bincom: Error during shutdown backup: " + e.getMessage());
        }
    }

    private InputStream getBackupInputStream() throws FileNotFoundException {
        // Try reading from classpath first (ideal for Render/packaged WAR)
        InputStream is = DatabaseBackupServiceImpl.class.getResourceAsStream("/database_setup.sql");
        if (is != null) {
            System.out.println("Bincom: Loading database backup from classpath resource /database_setup.sql");
            return is;
        }

        // Fallback: search for database_setup.sql in project root or current directory
        String userDirStr = System.getProperty("user.dir");
        File current = new File(userDirStr);
        while (current != null && current.isDirectory()) {
            File pom = new File(current, "pom.xml");
            if (pom.exists()) {
                File backup = new File(current, "database_setup.sql");
                if (backup.exists()) {
                    System.out.println("Bincom: Loading database backup from project root: " + backup.getAbsolutePath());
                    return new FileInputStream(backup);
                }
            }
            current = current.getParentFile();
        }

        File fallback = new File(userDirStr, "database_setup.sql");
        if (fallback.exists()) {
            System.out.println("Bincom: Loading database backup from working directory: " + fallback.getAbsolutePath());
            return new FileInputStream(fallback);
        }

        return null;
    }

    private List<File> getBackupFilesToWrite() {
        List<File> files = new ArrayList<>();
        String userDirStr = System.getProperty("user.dir");
        File current = new File(userDirStr);
        File projectRoot = null;
        while (current != null && current.isDirectory()) {
            File pom = new File(current, "pom.xml");
            if (pom.exists()) {
                projectRoot = current;
                break;
            }
            current = current.getParentFile();
        }

        if (projectRoot != null) {
            // Write to project root database_setup.sql
            files.add(new File(projectRoot, "database_setup.sql"));
            // Write to src/main/resources/database_setup.sql
            File srcResources = new File(projectRoot, "src/main/resources");
            if (srcResources.exists() && srcResources.isDirectory()) {
                files.add(new File(srcResources, "database_setup.sql"));
            }
        } else {
            // Fallback to user.dir
            files.add(new File(userDirStr, "database_setup.sql"));
        }
        return files;
    }
}
