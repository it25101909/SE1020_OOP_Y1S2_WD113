package com.taxibooking.taxibookingsystem.model;

public class Driver extends Person {
    private String licenseNumber;
    private boolean isAvailable;
    private String companyName;
    private String vehicleType;
    private String plateNumber;

    public Driver() {
        super();
    }

    public Driver(String id, String name, String email, String phone, String password,
                  String licenseNumber, boolean isAvailable, String companyName, String vehicleType, String plateNumber) {
        super(id, name, email, phone, password);
        this.licenseNumber = licenseNumber;
        this.isAvailable = isAvailable;
        this.companyName = companyName;
        this.vehicleType = vehicleType;
        this.plateNumber = plateNumber;
    }

    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { this.isAvailable = available; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public String getPlateNumber() { return plateNumber; }
    public void setPlateNumber(String plateNumber) { this.plateNumber = plateNumber; }

    @Override
    public String getRole() {
        return "Driver";
    }

    @Override
    public String toCSV() {
        return getId() + "," + getName() + "," + getEmail() + "," + getPhone() + "," + getPassword() + "," +
                getRole() + "," + licenseNumber + "," + isAvailable + "," + companyName + "," + vehicleType + "," + plateNumber;
    }

    @Override
    public String toString() {
        return toCSV();
    }
}
