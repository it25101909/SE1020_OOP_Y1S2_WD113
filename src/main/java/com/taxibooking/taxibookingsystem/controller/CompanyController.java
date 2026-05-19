// Student ID: IT25101909
package com.taxibooking.taxibookingsystem.controller;


import com.taxibooking.taxibookingsystem.model.Company;
import com.taxibooking.taxibookingsystem.model.Person;
import com.taxibooking.taxibookingsystem.model.Vehicle;
import com.taxibooking.taxibookingsystem.service.CompanyService;
import com.taxibooking.taxibookingsystem.service.VehicleService;
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

    @Autowired(required = false)
    private VehicleService vehicleService;

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
        if (vehicleService != null) {
            for (int i = 0; i < count; i++) {
                String vId = "V-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
                
                // Generate a unique, random plate number matching the Sri Lankan format (e.g., CAB-1234)
                String plateNumber;
                do {
                    char c1 = (char) ('A' + (int)(Math.random() * 26));
                    char c2 = (char) ('A' + (int)(Math.random() * 26));
                    char c3 = (char) ('A' + (int)(Math.random() * 26));
                    int number = (int)(Math.random() * 9000) + 1000;
                    plateNumber = "" + c1 + c2 + c3 + "-" + number;
                } while (vehicleService.isPlateNumberTaken(plateNumber, null));

                Vehicle v = new Vehicle(vId, ownerId, plateNumber, type + " Vehicle", type);
                vehicleService.add(v);
            }
        }
    }

    // ==================== FLEET MANAGEMENT ====================

    @GetMapping("/fleet")
    public String viewFleet(HttpSession session, Model model) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Company".equals(user.getRole())) {
            return "redirect:/login";
        }

        List<Vehicle> fleet = new ArrayList<>();
        if (vehicleService != null) {
            boolean setupDone = Boolean.TRUE.equals(session.getAttribute("setupDone"));
            if (!setupDone) {
                List<Vehicle> existing = vehicleService.getVehiclesByOwnerId(user.getId());
                if (existing.isEmpty()) {
                    return "redirect:/company/setup";
                } else {
                    session.setAttribute("setupDone", true);
                }
            }
            fleet = vehicleService.getVehiclesByOwnerId(user.getId());
        }

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

        String vId = "V-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        Vehicle vehicle = new Vehicle(vId, user.getId(), plateNumber, modelName, type);
        if (vehicleService != null) {
            vehicleService.add(vehicle);
        }

        return "redirect:/company/fleet?status=added";
    }

    @PostMapping("/remove-vehicle/{vehicleId}")
    public String removeVehicle(@PathVariable String vehicleId, HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Company".equals(user.getRole())) {
            return "redirect:/login";
        }

        if (vehicleService != null) {
            vehicleService.delete(vehicleId);
        }
        return "redirect:/company/fleet?status=removed";
    }

    @PostMapping("/edit-vehicle/{vehicleId}")
    public String editVehicle(@PathVariable String vehicleId,
                              @RequestParam String plateNumber,
                              @RequestParam String modelName,
                              HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null || !"Company".equals(user.getRole())) {
            return "redirect:/login";
        }
        if (vehicleService != null) {
            Vehicle vehicle = vehicleService.getById(vehicleId);
            if (vehicle != null && vehicle.getOwnerId().equals(user.getId())) {
                vehicle.setPlateNumber(plateNumber);
                vehicle.setModel(modelName);
                vehicleService.update(vehicle);
            }
        }
        return "redirect:/company/fleet?status=updated";
    }
}
