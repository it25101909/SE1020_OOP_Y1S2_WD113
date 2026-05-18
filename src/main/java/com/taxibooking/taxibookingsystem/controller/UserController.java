package com.taxibooking.taxibookingsystem.controller;

import com.taxibooking.taxibookingsystem.model.Passenger;
import com.taxibooking.taxibookingsystem.model.Driver;
import com.taxibooking.taxibookingsystem.model.Person;
import com.taxibooking.taxibookingsystem.model.Company;
import com.taxibooking.taxibookingsystem.service.UserService;
import com.taxibooking.taxibookingsystem.service.DriverService;
import com.taxibooking.taxibookingsystem.service.CompanyService;
import com.taxibooking.taxibookingsystem.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.UUID;

/**
 * Controller for Passenger and general Person operations
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private DriverService driverService;

    @Autowired
    private CompanyService companyService;

    @Autowired
    private VehicleService vehicleService;

    // ==================== REGISTRATION ====================

    @GetMapping("/register")
    public String showRegistrationPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam String name,
            @RequestParam String email,
            @RequestParam String phone,
            @RequestParam String password,
            @RequestParam(defaultValue = "Regular") String userType,
            Model model) {

        if (userService.emailExists(email)) {
            model.addAttribute("error", "Email already exists");
            return "register";
        }

        String id = "P-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        Passenger newPassenger = new Passenger(id, name, email, phone, password, userType);
        userService.add(newPassenger);

        return "redirect:/login?success=registered";
    }

    // ==================== LOGIN & LOGOUT ====================

    @GetMapping("/login")
    public String showLoginPage(@RequestParam(required = false) String success,
            @RequestParam(required = false) String status,
            Model model) {
        if ("registered".equals(success)) {
            model.addAttribute("message", "Registration successful! Please login.");
        }
        if ("deleted".equals(status)) {
            model.addAttribute("message", "Account deleted successfully.");
        }
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        // Check passengers first
        Person loggedInPerson = userService.login(email, password);

        // If not a passenger, check drivers
        if (loggedInPerson == null) {
            loggedInPerson = driverService.login(email, password);
        }

        // If not a driver, check companies
        if (loggedInPerson == null) {
            loggedInPerson = companyService.login(email, password);
        }

        if (loggedInPerson != null) {
            session.setAttribute("loggedInUser", loggedInPerson);
            return "redirect:/home";
        }

        model.addAttribute("error", "Invalid email or password");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?status=loggedout";
    }

    // ==================== DASHBOARD ====================

    @GetMapping("/home")
    public String showDashboard(HttpSession session, Model model) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        // Company setup check
        if ("Company".equalsIgnoreCase(user.getRole())) {
            boolean setupDone = Boolean.TRUE.equals(session.getAttribute("setupDone"));
            if (!setupDone) {
                if (vehicleService.getVehiclesByOwnerId(user.getId()).isEmpty()) {
                    return "redirect:/company/setup";
                } else {
                    session.setAttribute("setupDone", true);
                }
            }
        }

        model.addAttribute("loggedInUser", user); // Ensure JSP gets it
        return "home";
    }

    // ==================== PROFILE MANAGEMENT ====================

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        // Refresh passenger from file to get card details
        if ("Passenger".equalsIgnoreCase(user.getRole())) {
            Passenger p = userService.getById(user.getId());
            session.setAttribute("loggedInUser", p);
            model.addAttribute("user", p);
        } else {
            model.addAttribute("user", user);
        }

        return "users/profile";
    }

    @PostMapping("/update-payment")
    public String updatePayment(@RequestParam String cardNumber,
            @RequestParam String cardExpiry,
            HttpSession session) {
        Person currentUser = (Person) session.getAttribute("loggedInUser");
        if (currentUser != null && "Passenger".equalsIgnoreCase(currentUser.getRole())) {
            Passenger p = (Passenger) currentUser;
            p.setCardNumber(cardNumber);
            p.setCardExpiry(cardExpiry);
            userService.update(p);
            session.setAttribute("loggedInUser", p);
        }
        return "redirect:/profile?status=payment_updated";
    }

    @PostMapping("/update-profile")
    public String updateProfile(@RequestParam String name,
            @RequestParam String phone,
            @RequestParam String email,
            @RequestParam(required = false) String licenseNumber,
            @RequestParam(required = false) String companyName,
            HttpSession session,
            Model model) {
        Person currentUser = (Person) session.getAttribute("loggedInUser");

        if (currentUser != null) {
            currentUser.setName(name);
            currentUser.setPhone(phone);
            currentUser.setEmail(email);

            if (currentUser instanceof Passenger) {
                userService.update((Passenger) currentUser);
            } else if (currentUser instanceof Driver) {
                Driver driver = (Driver) currentUser;
                if (licenseNumber != null && !licenseNumber.isEmpty()) {
                    driver.setLicenseNumber(licenseNumber);
                }
                if (companyName != null && !companyName.isEmpty()) {
                    driver.setCompanyName(companyName);
                }
                driverService.update(driver);
            } else if (currentUser instanceof Company) {
                companyService.update((Company) currentUser);
            }
            session.setAttribute("loggedInUser", currentUser);
            model.addAttribute("message", "Profile updated successfully");
        }

        return "redirect:/profile?status=updated";
    }

    // Note: /vehicle-profile moved to DriverController if it existed, or handled
    // there.

    // ==================== ADMIN OPERATIONS ====================

    @GetMapping("/view-users")
    public String viewAllUsers(Model model, HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        List<Passenger> allUsers = userService.getAll();
        model.addAttribute("allUsers", allUsers);
        model.addAttribute("currentUser", user);

        return "users/user-list";
    }

    @GetMapping("/search-users")
    public String searchUsers(@RequestParam String query,
            Model model,
            HttpSession session) {
        Person user = (Person) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        List<Passenger> searchResults = userService.searchUsers(query);
        model.addAttribute("allUsers", searchResults);
        model.addAttribute("searchQuery", query);
        model.addAttribute("currentUser", user);

        return "users/user-list";
    }

    @GetMapping("/edit-user/{id}")
    public String showEditUser(@PathVariable String id, Model model, HttpSession session) {
        Person currentUser = (Person) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        Passenger userToEdit = userService.getById(id);
        if (userToEdit != null) {
            model.addAttribute("user", userToEdit);
            return "users/edit";
        }

        return "redirect:/view-users";
    }

    @PostMapping("/update-user")
    public String updateUser(@RequestParam String id,
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String phone,
            HttpSession session) {
        Person currentUser = (Person) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        Passenger userToUpdate = userService.getById(id);
        if (userToUpdate != null) {
            userToUpdate.setName(name);
            userToUpdate.setEmail(email);
            userToUpdate.setPhone(phone);
            userService.update(userToUpdate);
        }

        return "redirect:/view-users?status=updated";
    }

    @PostMapping("/delete-account")
    public String deleteAccount(HttpSession session) {
        Person currentUser = (Person) session.getAttribute("loggedInUser");

        if (currentUser != null) {
            if (currentUser instanceof Passenger) {
                userService.delete(currentUser.getId());
            } else if (currentUser instanceof Driver) {
                driverService.delete(currentUser.getId());
            } else if (currentUser instanceof Company) {
                companyService.delete(currentUser.getId());
            }
            session.invalidate();
        }

        return "redirect:/login?status=deleted";
    }

    @PostMapping("/delete-user/{id}")
    public String deleteUser(@PathVariable String id, HttpSession session) {
        Person currentUser = (Person) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        userService.delete(id);
        return "redirect:/view-users?status=deleted";
    }
}
