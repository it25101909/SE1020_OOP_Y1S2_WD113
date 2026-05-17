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
}
