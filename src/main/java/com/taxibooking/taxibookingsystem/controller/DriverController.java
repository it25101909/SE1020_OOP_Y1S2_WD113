package com.taxibooking.taxibookingsystem.controller;

import com.taxibooking.taxibookingsystem.model.Driver;
import com.taxibooking.taxibookingsystem.model.Company;
import com.taxibooking.taxibookingsystem.model.Vehicle;
import com.taxibooking.taxibookingsystem.service.DriverService;
import com.taxibooking.taxibookingsystem.service.CompanyService;
import com.taxibooking.taxibookingsystem.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
@RequestMapping("/drivers")
public class DriverController {

    @Autowired
    private DriverService driverService;

    @Autowired
    private CompanyService companyService;

    @Autowired
    private VehicleService vehicleService;

    @GetMapping
    public String getAllDrivers(Model model) {
        model.addAttribute("drivers", driverService.getAll());
        return "drivers/driver-list";
    }

    @GetMapping("/register")
    public String showRegisterForm() {
        return "drivers/register";
    }

    @PostMapping("/register")
    public String registerDriver(@RequestParam String accountType,
                                 @RequestParam String name,
                                 @RequestParam String email,
                                 @RequestParam String phone,
                                 @RequestParam String password,
                                 @RequestParam(required = false) String licenseNumber,
                                 @RequestParam(required = false) String vehicleType,
                                 @RequestParam(required = false) String plateNumber) {

        if ("Company".equalsIgnoreCase(accountType)) {
            String id = "C-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            Company company = new Company(id, name, email, phone, password);
            companyService.add(company);
        } else {
            String id = "D-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            Driver driver = new Driver(id, name, email, phone, password,
                    licenseNumber, true, "Independent", vehicleType, plateNumber);
            driverService.add(driver);
        }
        return "redirect:/login?success=registered";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Driver driver = driverService.getById(id);
        if (driver == null) {
            return "redirect:/drivers";
        }
        model.addAttribute("driver", driver);
        return "drivers/edit";
    }

    @PostMapping("/edit/{id}")
    public String updateDriver(@PathVariable String id,
                               @RequestParam String name,
                               @RequestParam String email,
                               @RequestParam String phone,
                               @RequestParam String password,
                               @RequestParam String licenseNumber,
                               @RequestParam String companyName,
                               @RequestParam String vehicleType,
                               @RequestParam String plateNumber,
                               @RequestParam(defaultValue = "false") boolean isAvailable) {

        Driver updatedDriver = new Driver(id, name, email, phone, password,
                licenseNumber, isAvailable, companyName, vehicleType, plateNumber);
        driverService.update(updatedDriver);
        return "redirect:/drivers";
    }

    @GetMapping("/delete/{id}")
    public String deleteDriver(@PathVariable String id) {
        driverService.delete(id);
        return "redirect:/drivers";
    }
}
