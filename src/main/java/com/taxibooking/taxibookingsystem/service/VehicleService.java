package com.taxibooking.taxibookingsystem.service;

import com.taxibooking.taxibookingsystem.model.Vehicle;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for Vehicle operations.
 * Inherits from BaseFileService.
 */
@Service
public class VehicleService extends BaseFileService<Vehicle> {

    private static final String FILE_PATH = "data/vehicles.txt";

    @Override
    protected String getFilePath() { return FILE_PATH; }

    @Override
    protected String getId(Vehicle v) { return v.getVehicleId(); }

    @Override
    protected Vehicle parseLine(String line) {
        try {
            String[] p = line.split(",");
            if (p.length >= 5) {
                return new Vehicle(p[0].trim(), p[1].trim(), p[2].trim(), p[3].trim(), p[4].trim());
            }
        } catch (Exception e) {}
        return null;
    }

    public List<Vehicle> getVehiclesByOwnerId(String ownerId) {
        return getAll().stream().filter(v -> v.getOwnerId().equals(ownerId)).collect(Collectors.toList());
    }

    public boolean isPlateNumberTaken(String plateNumber, String excludeVehicleId) {
        return getAll().stream().anyMatch(v -> 
            v.getPlateNumber().equalsIgnoreCase(plateNumber) && 
            (excludeVehicleId == null || !v.getVehicleId().equals(excludeVehicleId))
        );
    }

    public void validateVehicle(Vehicle vehicle) {
        if (vehicle.getPlateNumber() == null || vehicle.getPlateNumber().trim().isEmpty()) {
            throw new IllegalArgumentException("License plate cannot be empty");
        }
        
        // Basic validation for Sri Lankan license plates (e.g. ABC-1234, WP ABC-1234, 123-4567)
        // Accepts letters/numbers/spaces followed by a dash or space, and ends with 4 digits.
        if (!vehicle.getPlateNumber().matches("^[A-Za-z0-9\\s]+[-\\s]\\d{4}$")) {
            throw new IllegalArgumentException("Invalid license plate format. Expected format like 'ABC-1234' or 'WP ABC-1234'");
        }
    }

    @Override
    public void add(Vehicle item) {
        validateVehicle(item);
        if (isPlateNumberTaken(item.getPlateNumber(), null)) {
            throw new IllegalArgumentException("License plate " + item.getPlateNumber() + " is already registered.");
        }
        super.add(item);
    }

    @Override
    public void update(Vehicle updatedItem) {
        validateVehicle(updatedItem);
        if (isPlateNumberTaken(updatedItem.getPlateNumber(), updatedItem.getVehicleId())) {
            throw new IllegalArgumentException("License plate " + updatedItem.getPlateNumber() + " is already registered by another vehicle.");
        }
        super.update(updatedItem);
    }
}
