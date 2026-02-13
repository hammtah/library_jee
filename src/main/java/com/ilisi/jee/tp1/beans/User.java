package com.ilisi.jee.tp1.beans;

public class User {
    private int id;
    private String name;
    private String cin;
    private String phone;

    public User() {
    }
    public User(int id) {
        this.id = id;
    }

    public User(int id, String name, String cin) {
        this.id = id;
        this.name = name;
        this.cin = cin;
    }

    public User(int id, String name, String cin, String phone) {
        this.id = id;
        this.name = name;
        this.cin = cin;
        this.phone = phone;
    }

    public User(String name, String cin) {
        this.name = name;
        this.cin = cin;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", cin='" + cin + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}
