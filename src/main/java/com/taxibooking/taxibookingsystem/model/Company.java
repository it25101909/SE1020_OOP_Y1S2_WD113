package com.taxibooking.taxibookingsystem.model;

public class Company extends Person {

    public Company() {
        super();
    }

    public Company(String id, String name, String email, String phone, String password) {
        super(id, name, email, phone, password);
    }

    @Override
    public String getRole() {
        return "Company";
    }

    @Override
    public String toCSV() {
        return getId() + "," + getName() + "," + getEmail() + "," + getPhone() + "," + getPassword() + "," + getRole();
    }

    @Override
    public String toString() {
        return toCSV();
    }
}
