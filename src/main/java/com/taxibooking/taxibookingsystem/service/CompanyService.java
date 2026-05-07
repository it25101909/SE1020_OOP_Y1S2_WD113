package com.taxibooking.taxibookingsystem.service;

import com.taxibooking.taxibookingsystem.model.Company;
import org.springframework.stereotype.Service;

/**
 * Service for Company operations.
 * Inherits from BaseFileService.
 */
@Service
public class CompanyService extends BaseFileService<Company> {

    private static final String FILE_PATH = "data/users.txt"; // Companies are also in users.txt

    @Override
    protected String getFilePath() { return FILE_PATH; }

    @Override
    protected String getId(Company c) { return c.getId(); }

    @Override
    protected Company parseLine(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 6 && "Company".equals(parts[5].trim())) {
                return new Company(parts[0].trim(), parts[1].trim(), parts[2].trim(), parts[3].trim(), parts[4].trim());
            }
        } catch (Exception e) {}
        return null;
    }

    public Company login(String email, String password) {
        return getAll().stream()
                .filter(c -> c.getEmail().equals(email) && c.getPassword().equals(password))
                .findFirst().orElse(null);
    }
}
