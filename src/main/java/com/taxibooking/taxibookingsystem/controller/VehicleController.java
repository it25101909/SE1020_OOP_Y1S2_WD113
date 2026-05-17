package com.taxibooking.taxibookingsystem.controller;

import com.taxibooking.taxibookingsystem.model.Vehicle;
import com.taxibooking.taxibookingsystem.service.VehicleService;
import com.taxibooking.taxibookingsystem.service.DriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

    @Autowired
    private DriverService driverService;

    @GetMapping("/vehicles")
    public String showVehicleManagement(Model model) {
        model.addAttribute("vehicles", vehicleService.getAll());
        model.addAttribute("drivers", driverService.getAll());
        return "vehicles/vehicleManage"; // Folder/File
    }

    @PostMapping("/addVehicle")
    public String addVehicle(@ModelAttribute Vehicle vehicle) {
        String id = "V-" + UUID.randomUUID().toString().substring(0, 5);
        vehicle.setVehicleId(id);
        vehicleService.add(vehicle);
        return "redirect:/vehicles";
    }
}
