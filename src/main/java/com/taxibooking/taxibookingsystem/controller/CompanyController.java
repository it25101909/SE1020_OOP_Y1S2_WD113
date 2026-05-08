package com.taxibooking.taxibookingsystem.controller;

import com.taxibooking.taxibookingsystem.model.Company;
import com.taxibooking.taxibookingsystem.model.Person;
import com.taxibooking.taxibookingsystem.model.Vehicle;
import com.taxibooking.taxibookingsystem.service.CompanyService;
// import com.taxibooking.taxibookingsystem.service.VehicleService; // TODO: Missing service to be uploaded by other team members
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/company")
public class CompanyController {

    // @Autowired(required = false)
    // private VehicleService vehicleService; // TODO: Uncomment when VehicleService is uploaded

    @Autowired
    private CompanyService companyService;

    // ==================== SETUP WIZARD ====================

    @GetMapping("/setup")
    public String showSetup(HttpSession session, Model model) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Company".equals(user.getRole())) {
            return "redirect:/login";
        }
        model.addAttribute("company", user);
        return "company/setup";
    }

    @PostMapping("/setup")
    public String completeSetup(@RequestParam(defaultValue = "0") int tukCount,
                                @RequestParam(defaultValue = "0") int motoCount,
                                @RequestParam(defaultValue = "0") int miniCount,
                                @RequestParam(defaultValue = "0") int sedanCount,
                                @RequestParam(defaultValue = "0") int premiumCount,
                                @RequestParam(defaultValue = "0") int vanCount,
                                @RequestParam(defaultValue = "0") int luxuryCount,
                                HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Company".equals(user.getRole())) {
            return "redirect:/login";
        }

        addVehicles(user.getId(), "Tuk", tukCount);
        addVehicles(user.getId(), "Moto", motoCount);
        addVehicles(user.getId(), "Mini", miniCount);
        addVehicles(user.getId(), "Sedan", sedanCount);
        addVehicles(user.getId(), "Premium", premiumCount);
        addVehicles(user.getId(), "Van", vanCount);
        addVehicles(user.getId(), "Luxury", luxuryCount);

        session.setAttribute("setupDone", true);
        return "redirect:/company/fleet?status=setup_complete";
    }

    private void addVehicles(String ownerId, String type, int count) {
        // TODO: This logic currently does nothing because VehicleService is missing.
        /*
        for (int i = 0; i < count; i++) {
            String vId = "V-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            Vehicle v = new Vehicle(vId, ownerId, "AUTO-" + (i + 1), type + " Vehicle", type);
            if (vehicleService != null) vehicleService.add(v);
        }
        */
    }

    // ==================== FLEET MANAGEMENT ====================

    @GetMapping("/fleet")
    public String viewFleet(HttpSession session, Model model) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Company".equals(user.getRole())) {
            return "redirect:/login";
        }

        List<Vehicle> fleet = new ArrayList<>();
        /*
        if (vehicleService != null) {
            fleet = vehicleService.getVehiclesByOwnerId(user.getId());
        }
        */

        model.addAttribute("fleet", fleet);
        model.addAttribute("company", user);
        return "company/fleet";
    }

    @PostMapping("/add-vehicle")
    public String addVehicle(@RequestParam String plateNumber,
                             @RequestParam String modelName,
                             @RequestParam String type,
                             HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Company".equals(user.getRole())) {
            return "redirect:/login";
        }

        /*
        String vId = "V-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        Vehicle vehicle = new Vehicle(vId, user.getId(), plateNumber, modelName, type);
        if (vehicleService != null) vehicleService.add(vehicle);
        */

        return "redirect:/company/fleet?status=added";
    }

    @PostMapping("/remove-vehicle/{vehicleId}")
    public String removeVehicle(@PathVariable String vehicleId, HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Company".equals(user.getRole())) {
            return "redirect:/login";
        }

        // if (vehicleService != null) vehicleService.delete(vehicleId);
        return "redirect:/company/fleet?status=removed";
    }
}
