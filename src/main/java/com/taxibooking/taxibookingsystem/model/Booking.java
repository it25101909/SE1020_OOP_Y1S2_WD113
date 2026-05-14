package com.taxibooking.taxibookingsystem.model;

import com.taxibooking.taxibookingsystem.util.FileSerializable;

/**
 * Booking model representing a taxi booking
 * Contains all booking details for CSV persistence
 */
public class Booking implements FileSerializable {

    private String bookingId;
    private String userId;                  // Passenger ID
    private String driverId;
    private String pickupLocation;
    private String dropLocation;
    private String bookingType;            // Instant, Scheduled
    private String scheduledTime;          // "Now" or timestamp
    private String status;                 // Pending, Accepted, Completed, Cancelled
    private double fare;
    private String requestedVehicleType;   // Tuk, Mini, Sedan
    private String requestedCooperation;   // Zip SL, None, etc.
    private String verificationCode;       // 4-digit code for security
    private String paymentMethod;          // Cash, Card

    // Default Constructor
    public Booking() {
    }

    // Full Constructor (12 fields)
    public Booking(String bookingId, String userId, String driverId,
                   String pickupLocation, String dropLocation,
                   String bookingType, String scheduledTime,
                   String status, double fare,
                   String requestedVehicleType, String requestedCooperation,
                   String verificationCode, String paymentMethod) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.driverId = driverId;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.bookingType = bookingType;
        this.scheduledTime = scheduledTime;
        this.status = status;
        this.fare = fare;
        this.requestedVehicleType = requestedVehicleType;
        this.requestedCooperation = requestedCooperation;
        this.verificationCode = verificationCode;
        this.paymentMethod = paymentMethod;
    }

    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    // Alias for passenger ID
    public String getPassengerId() {
        return userId;
    }

    public void setPassengerId(String passengerId) {
        this.userId = passengerId;
    }

    public String getDriverId() {
        return driverId != null ? driverId : "Unassigned";
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDropLocation() {
        return dropLocation;
    }

    public void setDropLocation(String dropLocation) {
        this.dropLocation = dropLocation;
    }

    public String getBookingType() {
        return bookingType;
    }

    public void setBookingType(String bookingType) {
        this.bookingType = bookingType;
    }

    public String getScheduledTime() {
        return scheduledTime;
    }

    public void setScheduledTime(String scheduledTime) {
        this.scheduledTime = scheduledTime;
    }

    public String getStatus() {
        return status != null ? status : "Pending";
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getFare() {
        return fare;
    }

    public void setFare(double fare) {
        this.fare = fare;
    }

    public String getRequestedVehicleType() {
        return requestedVehicleType;
    }

    public void setRequestedVehicleType(String requestedVehicleType) {
        this.requestedVehicleType = requestedVehicleType;
    }

    public String getRequestedCooperation() {
        return requestedCooperation;
    }

    public void setRequestedCooperation(String requestedCooperation) {
        this.requestedCooperation = requestedCooperation;
    }

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }

    public String getPaymentMethod() {
        return paymentMethod != null ? paymentMethod : "Cash";
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    /**
     * Convert booking to CSV format
     * Format: bookingId,userId,driverId,pickup,drop,type,time,status,fare,vehicleType,cooperation
     */
    public String toCSV() {
        return bookingId + "," + userId + "," + getDriverId() + "," +
                pickupLocation + "," + dropLocation + "," +
                bookingType + "," + scheduledTime + "," +
                getStatus() + "," + fare + "," +
                requestedVehicleType + "," + requestedCooperation + "," +
                (verificationCode != null ? verificationCode : "0000") + "," +
                getPaymentMethod();
    }

    @Override
    public String toString() {
        return "Booking{" +
                "bookingId='" + bookingId + '\'' +
                ", userId='" + userId + '\'' +
                ", driverId='" + driverId + '\'' +
                ", pickup='" + pickupLocation + '\'' +
                ", drop='" + dropLocation + '\'' +
                ", status='" + status + '\'' +
                ", fare=" + fare +
                '}';
    }
}
