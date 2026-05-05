package com.taxibooking.taxibookingsystem.model;

import com.taxibooking.taxibookingsystem.util.FileSerializable;

public abstract class Person implements FileSerializable {
    private String id;
    private String name;
    private String email;
    private String phone;
    private String password;

    public Person() {}

    public Person(String id, String name, String email, String phone, String password) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // Polymorphic method
    public abstract String getRole();

    @Override
    public abstract String toCSV();
}
