package GE.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Inheritance(strategy = InheritanceType.JOINED) // Inheritance strategy
@Table(name = "users") // Table name in the database
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true)
    private String name;

    @Column(nullable = false)
    private int salaire;

    @Column(nullable = true)
    private Integer abscenceDays;

    @Column(nullable = true)
    private Integer congeDays;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = true)
    private LocalDate birthDate;

    @Column(nullable = true)
    private String phoneNumber;

    @Column(nullable = true)
    private String adresse;

    // Default constructor
    public User() {
    }

    // Parameterized constructor
    public User(String name, int salaire, Integer abscenceDays, Integer congeDays, String email, String password, LocalDate birthDate, String phoneNumber, String adresse) {
        this.name = name;
        this.salaire = salaire;
        this.abscenceDays = abscenceDays;
        this.congeDays = congeDays;
        this.email = email;
        this.password = password;
        this.birthDate = birthDate;
        this.phoneNumber = phoneNumber;
        this.adresse = adresse;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSalaire() {
        return salaire;
    }

    public void setSalaire(int salaire) {
        this.salaire = salaire;
    }

    public Integer getAbscenceDays() {
        return abscenceDays;
    }

    public void setAbscenceDays(Integer abscenceDays) {
        this.abscenceDays = abscenceDays;
    }

    public Integer getCongeDays() {
        return congeDays;
    }

    public void setCongeDays(Integer congeDays) {
        this.congeDays = congeDays;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
}
