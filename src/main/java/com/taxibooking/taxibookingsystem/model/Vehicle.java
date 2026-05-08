package com.taxibooking.taxibookingsystem.model;

import com.taxibooking.taxibookingsystem.util.FileSerializable;

public class Vehicle implements FileSerializable {
    private String vehicleId;
    private String ownerId;
    private String plateNumber;
    private String model;
    private String type; // e.g., Tuk, Mini, Sedan, etc.

    public Vehicle() {}

    public Vehicle(String vehicleId, String ownerId, String plateNumber, String model, String type) {
        this.vehicleId = vehicleId;
        this.ownerId = ownerId;
        this.plateNumber = plateNumber;
        this.model = model;
        this.type = type;
    }

    // Getters and Setters
    public String getVehicleId() { return vehicleId; }
    public void setVehicleId(String vehicleId) { this.vehicleId = vehicleId; }
    public String getOwnerId() { return ownerId; }
    public void setOwnerId(String ownerId) { this.ownerId = ownerId; }
    public String getPlateNumber() { return plateNumber; }
    public void setPlateNumber(String plateNumber) { this.plateNumber = plateNumber; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    @Override
    public String getRole() { return "Vehicle"; }

    @Override
    public String toCSV() {
        return vehicleId + "," + ownerId + "," + plateNumber + "," + model + "," + type;
    }

    @Override
    public String toString() {
        return toCSV();
    }
}
