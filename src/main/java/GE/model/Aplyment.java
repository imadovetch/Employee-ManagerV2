package GE.model;

import jakarta.persistence.Table;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "aplyments")
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

    public String getCvpath() {
        return cvpath;
    }

    public void setCvpath(String cvpath) {
        this.cvpath = cvpath;
    }

    @Column(name = "apply_date", nullable = false)
    private LocalDate applyDate;

    @Column(name = "cvpath", nullable = false)
    private String cvpath;

    public String getLettremotivation() {
        return lettremotivation;
    }

    public void setLettremotivation(String lettremotivation) {
        this.lettremotivation = lettremotivation;
    }

    @Column(name = "lettremotivation", nullable = false)
    private String lettremotivation;


    public Aplyment( Long offreId, String name, String email, Status status, LocalDate applyDate,String cvpath , String lettremotivation) {
        this.lettremotivation = lettremotivation;
        this.cvpath = cvpath;
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
        PENDING,    // In progress
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
