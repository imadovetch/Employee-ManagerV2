package GE.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "rh")
public class Rh extends User {

    @Column(nullable = true)
    private String rhSubname;

    // Default constructor
    public Rh() {
    }

    // Parameterized constructor
    public Rh(String name, int salaire, Integer abscenceDays, Integer congeDays, String email, String password, LocalDate birthDate, String phoneNumber, String adresse, String rhSubname) {
        super(name, salaire, abscenceDays, congeDays, email, password, birthDate, phoneNumber, adresse);
        this.rhSubname = rhSubname;
    }

    // Getters and Setters
    public String getRhSubname() {
        return rhSubname;
    }

    public void setRhSubname(String rhSubname) {
        this.rhSubname = rhSubname;
    }
}
