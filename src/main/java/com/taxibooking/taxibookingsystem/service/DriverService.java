package com.taxibooking.taxibookingsystem.service;

import com.taxibooking.taxibookingsystem.model.Driver;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for Driver operations.
 * Inherits from BaseFileService.
 */
@Service
public class DriverService extends BaseFileService<Driver> {

    private static final String FILE_PATH = "data/drivers.txt";

    @Override
    protected String getFilePath() { return FILE_PATH; }

    @Override
    protected String getId(Driver d) { return d.getId(); }

    @Override
    protected Driver parseLine(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 11) {
                return new Driver(
                    parts[0], parts[1], parts[2], parts[3], parts[4],
                    parts[6], Boolean.parseBoolean(parts[7]), parts[8], parts[9], parts[10]
                );
            }
        } catch (Exception e) {}
        return null;
    }

    public Driver login(String email, String password) {
        return getAll().stream()
                .filter(d -> d.getEmail().equals(email) && d.getPassword().equals(password))
                .findFirst().orElse(null);
    }

    public List<Driver> getAvailableDrivers() {
        return getAll().stream().filter(Driver::isAvailable).collect(Collectors.toList());
    }
}
