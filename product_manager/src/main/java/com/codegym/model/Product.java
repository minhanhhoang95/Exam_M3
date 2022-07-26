package com.codegym.model;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

public class Product {
    private int id;
    private String title;
    private double price;
    private int quantity;
    private String color;
    private String description;
    private int category;

    public Product(){

    }

    public Product(int id, String title, double price, int quantity, String color, String description, int category) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.quantity = quantity;
        this.color = color;
        this.description = description;
        this.category = category;
    }

    public Product(String title, double price, int quantity, String color, String description, int category) {
        this.title = title;
        this.price = price;
        this.quantity = quantity;
        this.color = color;
        this.description = description;
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
@NotEmpty(message = "Please don't it blank")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    @Min(value = 1 , message = " > 0")
    @Max(value = 1000000 , message = " < 999999")
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    @Min(value = 1 , message = " > 0")
    @Max(value = 1000000 , message = " < 999999")
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "product{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", color='" + color + '\'' +
                ", description='" + description + '\'' +
                ", category=" + category +
                '}';
    }
}
