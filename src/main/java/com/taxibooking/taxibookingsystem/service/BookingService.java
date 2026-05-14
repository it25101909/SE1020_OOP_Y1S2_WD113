package com.taxibooking.taxibookingsystem.service;

import com.taxibooking.taxibookingsystem.model.Booking;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for Booking operations.
 * Inherits from BaseFileService.
 */
@Service
public class BookingService extends BaseFileService<Booking> {

    private static final String FILE_PATH = "data/bookings.txt";

    @Override
    protected String getFilePath() { return FILE_PATH; }

    @Override
    protected String getId(Booking b) { return b.getBookingId(); }

    @Override
    protected Booking parseLine(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 12) {
                return new Booking(
                    parts[0].trim(), parts[1].trim(), parts[2].trim(),
                    parts[3].trim(), parts[4].trim(), parts[5].trim(),
                    parts[6].trim(), parts[7].trim(), Double.parseDouble(parts[8].trim()),
                    parts[9].trim(), parts[10].trim(), parts[11].trim(),
                    parts.length >= 13 ? parts[12].trim() : "Cash"
                );
            }
        } catch (Exception e) {}
        return null;
    }

    // --- Method Overloading Examples ---

    /**
     * Overload 1: Standard fare calculation
     */
    public double calculateFare(String type, double dist) {
        double rate = type.equalsIgnoreCase("sedan") ? 120 : (type.equalsIgnoreCase("mini") ? 80 : 50);
        return 100 + (dist * rate);
    }

    /**
     * Overload 2: Fare calculation with custom discount
     */
    public double calculateFare(String type, double dist, double discountPercent) {
        double original = calculateFare(type, dist);
        return original * (1 - (discountPercent / 100.0));
    }

    // --- Specialized Methods ---

    public List<Booking> getBookingsByUserId(String userId) {
        return getAll().stream().filter(b -> b.getUserId().equals(userId)).collect(Collectors.toList());
    }

    public List<Booking> getBookingsByDriverId(String driverId) {
        return getAll().stream().filter(b -> driverId.equals(b.getDriverId())).collect(Collectors.toList());
    }

    public List<Booking> getPendingBookings() {
        return getAll().stream().filter(b -> "Pending".equalsIgnoreCase(b.getStatus()) || "Unassigned".equals(b.getDriverId())).collect(Collectors.toList());
    }

    public void updateBookingStatus(String id, String status) {
        Booking b = getById(id);
        if (b != null) {
            b.setStatus(status);
            update(b);
        }
    }

    public void assignDriver(String bookingId, String driverId) {
        Booking booking = getById(bookingId);
        if (booking != null) {
            booking.setDriverId(driverId);
            booking.setStatus("Accepted");
            update(booking);
        }
    }
}
