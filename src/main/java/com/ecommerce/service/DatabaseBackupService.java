package com.ecommerce.service;

public interface DatabaseBackupService {
    void exportDatabase();
    void importDatabaseIfNeeded();
    void importDatabase(boolean force) throws Exception;
}
