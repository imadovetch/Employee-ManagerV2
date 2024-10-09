package GE.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "employees")
public class Employee extends User {

    @Column(nullable = true)
    private String position;

    @Column(nullable = true)
    private String department;

    // Default constructor
    public Employee() {
    }

    // Parameterized constructor
    public Employee(String name, int salaire, Integer abscenceDays, Integer congeDays, String email, String password, LocalDate birthDate, String phoneNumber, String adresse, String position, String department) {
        super(name, salaire, abscenceDays, congeDays, email, password, birthDate, phoneNumber, adresse); // Calling User class constructor
        this.position = position;
        this.department = department;
    }

    // Getters and Setters for new fields
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }
}
