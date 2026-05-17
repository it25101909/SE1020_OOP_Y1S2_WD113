package com.taxibooking.taxibookingsystem.controller;

import com.taxibooking.taxibookingsystem.model.*;
import com.taxibooking.taxibookingsystem.service.BookingService;
import com.taxibooking.taxibookingsystem.service.UserService;
import com.taxibooking.taxibookingsystem.service.DriverService;
import com.taxibooking.taxibookingsystem.service.CompanyService;
import com.taxibooking.taxibookingsystem.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.time.LocalTime;
import java.time.Duration;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Controller for Booking operations
 * Handles booking creation, viewing, and management
 */
@Controller
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private UserService userService;

    @Autowired
    private DriverService driverService;

    @Autowired
    private CompanyService companyService;

    @Autowired
    private VehicleService vehicleService;

    // ==================== PASSENGER BOOKING ====================

    @GetMapping("/select-company")
    public String selectCompany(HttpSession session, Model model) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Passenger".equalsIgnoreCase(user.getRole())) {
            return "redirect:/login";
        }

        List<Company> companies = companyService.getAll();
        model.addAttribute("companies", companies);
        return "bookings/selectCompany";
    }

    @GetMapping("/book-taxi")
    public String showBookingForm(HttpSession session, Model model) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        if (!"Passenger".equalsIgnoreCase(user.getRole())) {
            return "redirect:/home";
        }

        List<Company> companies = companyService.getAll();
        model.addAttribute("user", user);
        model.addAttribute("companies", companies);
        
        return "bookings/booking";
    }

    @GetMapping("/api/check-availability")
    @ResponseBody
    public Map<String, Object> checkAvailability(@RequestParam(required = false) String companyId) {
        Map<String, Object> response = new HashMap<>();
        
        if (companyId == null || companyId.isEmpty() || "none".equals(companyId)) {
            response.put("anyAvailable", true);
            Map<String, Boolean> avail = new HashMap<>();
            avail.put("Tuk", true); avail.put("Moto", true);
            avail.put("Mini", true); avail.put("Sedan", true);
            avail.put("Premium", true); avail.put("Van", true);
            avail.put("Luxury", true);
            response.put("availability", avail);
            return response;
        }

        List<Vehicle> fleet = vehicleService.getVehiclesByOwnerId(companyId);
        List<Booking> activeBookings = bookingService.getAll().stream()
                .filter(b -> companyId.equals(b.getRequestedCooperation()) && 
                            ("Accepted".equalsIgnoreCase(b.getStatus()) || "Started".equalsIgnoreCase(b.getStatus())))
                .collect(Collectors.toList());

        Map<String, Integer> totalVehicles = new HashMap<>();
        Map<String, Integer> busyVehicles = new HashMap<>();
        
        for (Vehicle v : fleet) {
            totalVehicles.put(v.getType(), totalVehicles.getOrDefault(v.getType(), 0) + 1);
        }
        for (Booking b : activeBookings) {
            busyVehicles.put(b.getRequestedVehicleType(), busyVehicles.getOrDefault(b.getRequestedVehicleType(), 0) + 1);
        }

        Map<String, Boolean> availability = new HashMap<>();
        boolean anyAvailable = false;
        String[] types = {"Tuk", "Moto", "Mini", "Sedan", "Premium", "Van", "Luxury"};
        
        for (String type : types) {
            int total = totalVehicles.getOrDefault(type, 0);
            int busy = busyVehicles.getOrDefault(type, 0);
            boolean isAvail = total > busy;
            availability.put(type, isAvail);
            if (isAvail) anyAvailable = true;
        }

        response.put("availability", availability);
        response.put("anyAvailable", anyAvailable);
        return response;
    }

    @PostMapping("/create-booking")
    public String createBooking(@RequestParam String pickupLocation,
                                @RequestParam String dropLocation,
                                @RequestParam String vehicleType,
                                @RequestParam String bookingType,
                                @RequestParam(defaultValue = "Now") String scheduledTime,
                                @RequestParam(defaultValue = "None") String cooperation,
                                @RequestParam(defaultValue = "10.0") double distance,
                                @RequestParam(defaultValue = "0.0") double fare,
                                @RequestParam(defaultValue = "Cash") String paymentMethod,
                                HttpSession session,
                                Model model) {

        Person passenger = (Person) session.getAttribute("loggedInUser");
        if (passenger == null) {
            return "redirect:/login";
        }

        // Sanitize locations to remove commas (which break CSV storage)
        String safePickup = pickupLocation.replace(",", ";");
        String safeDrop = dropLocation.replace(",", ";");

        String bookingId = "B-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        String verificationCode = String.format("%04d", new Random().nextInt(10000));

        // Use the fare calculated by the UI if possible, otherwise fall back to service calculation
        double finalFare = (fare > 0) ? fare : bookingService.calculateFare(vehicleType, distance);

        Booking booking = new Booking(
                bookingId,
                passenger.getId(),
                "Unassigned",
                safePickup,
                safeDrop,
                bookingType,
                "Scheduled".equalsIgnoreCase(bookingType) ? scheduledTime : "Now",
                "Pending",
                finalFare,
                vehicleType,
                cooperation,
                verificationCode,
                paymentMethod
        );

        bookingService.add(booking);

        return "redirect:/myBookings?status=created";
    }

    @GetMapping("/myBookings")
    public String viewMyBookings(HttpSession session, Model model) {
        Person passenger = (Person) session.getAttribute("loggedInUser");
        if (passenger == null) {
            return "redirect:/login";
        }

        List<Booking> myBookings = bookingService.getBookingsByUserId(passenger.getId());
        model.addAttribute("bookings", myBookings);
        model.addAttribute("user", passenger);

        return "bookings/myBookings";
    }

    @PostMapping("/cancel-booking/{bookingId}")
    public String cancelBooking(@PathVariable String bookingId, HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        Booking booking = bookingService.getById(bookingId);
        if (booking != null && booking.getUserId().equals(user.getId())) {
            String currentStatus = booking.getStatus();
            
            // LOGIC: If ride has already STARTED, passenger must pay full price.
            // If ride is just PENDING or ACCEPTED (driver coming), it's free.
            if ("Started".equalsIgnoreCase(currentStatus)) {
                // Keep the fare as is, just mark cancelled
                bookingService.updateBookingStatus(bookingId, "Cancelled-Paid");
            } else {
                // Free cancellation
                booking.setFare(0.0);
                booking.setStatus("Cancelled");
                bookingService.update(booking);
            }
        }

        return "redirect:/myBookings?status=cancelled";
    }

    // ==================== DRIVER TASK MANAGEMENT ====================

    @GetMapping("/tasks")
    public String viewTasks(HttpSession session, Model model) {
        Person person = (Person) session.getAttribute("loggedInUser");
        if (person == null) {
            return "redirect:/login";
        }

        String role = person.getRole();
        if (!"Driver".equalsIgnoreCase(role) && !"Company".equalsIgnoreCase(role)) {
            return "redirect:/home";
        }

        List<Booking> allPendingBookings = bookingService.getPendingBookings();
        System.out.println("[DEBUG] Total pending bookings: " + allPendingBookings.size());

        List<Booking> matchingBookings;
        String driverVehicleType = null;

        // FETCH ACTIVE BOOKINGS FOR THIS USER
        List<Booking> myRides = bookingService.getBookingsByDriverId(person.getId());
        
        List<Booking> myScheduledRides = myRides.stream()
                .filter(b -> "Accepted".equalsIgnoreCase(b.getStatus()) && "Scheduled".equalsIgnoreCase(b.getBookingType()))
                .collect(Collectors.toList());
        
        boolean hasAnyActiveAssignment = myRides.stream()
                .anyMatch(b -> "Accepted".equalsIgnoreCase(b.getStatus()) || "Started".equalsIgnoreCase(b.getStatus()));
        
        boolean currentlyInRide = myRides.stream().anyMatch(b -> "Started".equalsIgnoreCase(b.getStatus()));

        if ("Driver".equalsIgnoreCase(role)) {
            Driver driver = (Driver) person;
            Driver freshDriver = driverService.getById(driver.getId());
            if (freshDriver != null) {
                driver = freshDriver;
                session.setAttribute("loggedInUser", driver);
            }

            // FILTERING LOGIC FOR INDIVIDUAL DRIVER:
            final Driver fDriver = driver;
            final String vType = driver.getVehicleType();

            matchingBookings = allPendingBookings.stream()
                    .filter(b -> {
                        // 1. Vehicle type check
                        if (vType != null && !vType.equalsIgnoreCase(b.getRequestedVehicleType())) return false;
                        
                        // 2. Company preference check
                        String preferred = b.getRequestedCooperation();
                        if (preferred != null && !"none".equals(preferred) && !preferred.isEmpty()) {
                            if (!preferred.equals(fDriver.getCompanyName())) return false;
                        }

                        // 3. LOCKING LOGIC:
                        // If it's an "Instant" request, hide it if I have ANY active assignment
                        if ("Instant".equalsIgnoreCase(b.getBookingType()) && hasAnyActiveAssignment) return false;

                        // 4. 6-Hour Scheduled Rule
                        if ("Scheduled".equalsIgnoreCase(b.getBookingType())) {
                            // Can only have max 2 scheduled rides
                            if (myScheduledRides.size() >= 2) return false;
                            
                            // Must have 6 hour gap with ALL other rides (including the current Instant one)
                            for (Booking existing : myRides) {
                                if ("Accepted".equalsIgnoreCase(existing.getStatus()) || "Started".equalsIgnoreCase(existing.getStatus())) {
                                    String existingTime = "Scheduled".equalsIgnoreCase(existing.getBookingType()) ? existing.getScheduledTime() : "Now";
                                    if (!isTimeGapValid(existingTime, b.getScheduledTime(), 6)) return false;
                                }
                            }
                        }
                        return true;
                    })
                    .collect(Collectors.toList());

            model.addAttribute("driver", driver);
            model.addAttribute("driverVehicleType", vType);

        } else {
            // ROLE: Company
            final String companyId = person.getId();
            List<Vehicle> fleet = vehicleService.getVehiclesByOwnerId(companyId);
            Set<String> ownedTypes = fleet.stream().map(Vehicle::getType).collect(Collectors.toSet());

            matchingBookings = allPendingBookings.stream()
                    .filter(b -> {
                        // 1. Must own this vehicle type
                        if (!ownedTypes.contains(b.getRequestedVehicleType())) return false;

                        // 2. Preference check
                        String preferred = b.getRequestedCooperation();
                        if (preferred != null && !"none".equals(preferred) && !preferred.isEmpty()) {
                            if (!companyId.equals(preferred)) return false;
                        }

                        // 3. Instant Ride Limit for Company (Applied per vehicle type availability)
                        if ("Instant".equalsIgnoreCase(b.getBookingType())) {
                            long activeOfType = myRides.stream()
                                    .filter(r -> ("Accepted".equalsIgnoreCase(r.getStatus()) || "Started".equalsIgnoreCase(r.getStatus())) 
                                                 && b.getRequestedVehicleType().equals(r.getRequestedVehicleType()))
                                    .count();
                            long totalOfType = fleet.stream().filter(v -> b.getRequestedVehicleType().equals(v.getType())).count();
                            if (activeOfType >= totalOfType) return false;
                        }

                        // 4. 6-Hour Scheduled Rule
                        if ("Scheduled".equalsIgnoreCase(b.getBookingType())) {
                            if (myScheduledRides.size() >= 10) return false; // Companies can handle more, but still apply gap per driver if we had driver assignments
                            // For now, apply same logic or keep it open for company dispatch
                        }
                        return true;
                    })
                    .collect(Collectors.toList());
        }

        // Reminders and Notes
        if (hasAnyActiveAssignment) {
            model.addAttribute("availabilityNote", "🔒 Task List Locked: Finish your current assignment to see more 'Now' requests.");
        }

        if (!myScheduledRides.isEmpty()) {
            String times = myScheduledRides.stream().map(Booking::getScheduledTime).collect(Collectors.joining(", "));
            model.addAttribute("reminder", "📌 Upcoming Scheduled Rides: " + times);
        }

        model.addAttribute("availableBookings", matchingBookings);
        model.addAttribute("myBookings", myRides);

        return "bookings/task";
    }

    private boolean isTimeGapValid(String time1, String time2, int hoursGap) {
        try {
            if ("Now".equalsIgnoreCase(time1) || "Now".equalsIgnoreCase(time2)) return true;
            LocalTime t1 = LocalTime.parse(time1);
            LocalTime t2 = LocalTime.parse(time2);
            long diff = Math.abs(Duration.between(t1, t2).toHours());
            return diff >= hoursGap;
        } catch (Exception e) {
            return true; 
        }
    }

    @PostMapping("/accept-booking/{bookingId}")
    public String acceptBooking(@PathVariable String bookingId, HttpSession session) {
        Person driver = (Person) session.getAttribute("loggedInUser");
        if (driver == null) {
            return "redirect:/login";
        }

        Booking booking = bookingService.getById(bookingId);
        if (booking == null) return "redirect:/tasks?error=not_found";

        // Server-side validation for Scheduled 6-hour rule
        if ("Scheduled".equalsIgnoreCase(booking.getBookingType())) {
            List<Booking> myAccepted = bookingService.getBookingsByDriverId(driver.getId());
            List<Booking> myScheduled = myAccepted.stream()
                    .filter(b -> "Accepted".equalsIgnoreCase(b.getStatus()) && "Scheduled".equalsIgnoreCase(b.getBookingType()))
                    .collect(Collectors.toList());

            for (Booking existing : myScheduled) {
                if (!isTimeGapValid(existing.getScheduledTime(), booking.getScheduledTime(), 6)) {
                    return "redirect:/tasks?error=time_conflict";
                }
            }
        }

        bookingService.assignDriver(bookingId, driver.getId());
        return "redirect:/tasks?status=accepted";
    }

    @PostMapping("/start-booking/{bookingId}")
    public String startBooking(@PathVariable String bookingId, 
                               @RequestParam String code,
                               HttpSession session, 
                               Model model) {
        Person driver = (Person) session.getAttribute("loggedInUser");
        if (driver == null) {
            return "redirect:/login";
        }

        Booking booking = bookingService.getById(bookingId);
        if (booking != null && driver.getId().equals(booking.getDriverId())) {
            if (booking.getVerificationCode().equals(code)) {
                bookingService.updateBookingStatus(bookingId, "Started");
                return "redirect:/tasks?status=started";
            } else {
                return "redirect:/tasks?error=invalid_code";
            }
        }

        return "redirect:/tasks?error=not_found";
    }

    @PostMapping("/complete-booking/{bookingId}")
    public String completeBooking(@PathVariable String bookingId, HttpSession session) {
        Person driver = (Person) session.getAttribute("loggedInUser");
        if (driver == null) {
            return "redirect:/login";
        }

        Booking booking = bookingService.getById(bookingId);
        if (booking != null && driver.getId().equals(booking.getDriverId())) {
            bookingService.updateBookingStatus(bookingId, "Completed");
        }

        return "redirect:/tasks?status=completed";
    }

    // ==================== ADMIN VIEW ====================

    @GetMapping("/all-bookings")
    public String viewAllBookings(HttpSession session, Model model) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        List<Booking> allBookings = bookingService.getAll();
        model.addAttribute("bookings", allBookings);
        model.addAttribute("user", user);

        return "bookings/bookingList";
    }

    @PostMapping("/update-booking-status")
    public String updateBookingStatus(@RequestParam String bookingId,
                                      @RequestParam String status,
                                      HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        bookingService.updateBookingStatus(bookingId, status);

        return "redirect:/all-bookings?status=updated";
    }

    @PostMapping("/delete-booking/{bookingId}")
    public String deleteBooking(@PathVariable String bookingId, HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        bookingService.delete(bookingId);

        return "redirect:/all-bookings?status=deleted";
    }
}
