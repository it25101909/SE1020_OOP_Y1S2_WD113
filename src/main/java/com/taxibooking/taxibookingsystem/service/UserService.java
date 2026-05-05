package com.taxibooking.taxibookingsystem.service;

import com.taxibooking.taxibookingsystem.model.Passenger;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for Passenger operations. 
 * Inherits from BaseFileService to handle file CRUD.
 */
@Service
public class UserService extends BaseFileService<Passenger> {

    private static final String FILE_PATH = "data/users.txt";

    @Override
    protected String getFilePath() { return FILE_PATH; }

    @Override
    protected String getId(Passenger p) { return p.getId(); }

    /**
     * Method Overriding: Custom parsing for Passenger
     */
    @Override
    protected Passenger parseLine(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 7) {
                return new Passenger(
                        parts[0].trim(), parts[1].trim(), parts[2].trim(), 
                        parts[3].trim(), parts[4].trim(), parts[6].trim(),
                        parts.length >= 8 ? parts[7].trim() : "Not Set",
                        parts.length >= 9 ? parts[8].trim() : "N/A"
                );
            }
        } catch (Exception e) {}
        return null;
    }

    // --- Specialized Methods ---

    public Passenger login(String email, String password) {
        return getAll().stream()
                .filter(u -> u.getEmail().equals(email) && u.getPassword().equals(password))
                .findFirst().orElse(null);
    }

    public List<Passenger> searchUsers(String query) {
        if (query == null || query.trim().isEmpty()) return getAll();
        String q = query.toLowerCase();
        return getAll().stream()
                .filter(u -> u.getName().toLowerCase().contains(q) || u.getEmail().toLowerCase().contains(q))
                .collect(Collectors.toList());
    }

    public boolean emailExists(String email) {
        return getAll().stream().anyMatch(u -> u.getEmail().equalsIgnoreCase(email));
    }
}