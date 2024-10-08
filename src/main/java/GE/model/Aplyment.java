package GE.model;

import jakarta.persistence.Table;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "aplyments") // Table name in the database
public class Aplyment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "offre_id", nullable = false)
    private Long offreId;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "email", nullable = false)
    private String email;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private Status status;

    @Column(name = "apply_date", nullable = false)
    private LocalDate applyDate;


    public Aplyment( Long offreId, String name, String email, Status status, LocalDate applyDate) {

        this.offreId = offreId;
        this.name = name;
        this.email = email;
        this.status = status;
        this.applyDate = applyDate;
    }


    public Aplyment() {

    }

    // Enum for application status
    public enum Status {
        RECUM,      // Received
        ENCOURS,    // In progress
        ACCEPTED,   // Accepted
        REJECTED    // Rejected
    }


    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getOffreId() {
        return offreId;
    }

    public void setOffreId(Long offreId) {
        this.offreId = offreId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public LocalDate getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(LocalDate applyDate) {
        this.applyDate = applyDate;
    }

    @Override
    public String toString() {
        return "Aplyment{" +
                "id=" + id +
                ", offreId=" + offreId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", status=" + status +
                ", applyDate=" + applyDate +
                '}';
    }
}
