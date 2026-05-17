package com.taxibooking.taxibookingsystem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String index() {
        return "index"; // loads WEB-INF/views/index.jsp
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact"; // loads WEB-INF/views/contact.jsp
    }
}
