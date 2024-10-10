package GE.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "logs")
public class Logs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "type", nullable = false)
    private String type;

    @Column(name = "description", nullable = false)
    private String description;

    @Column(name = "logged_for") // Changed from 'for' to 'logged_for'
    private String loggedFor;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date", nullable = false)
    private Date date;

    // Constructors
    public Logs() {}

    public Logs(String type, String description, String forField, Date date) {
        this.type = type;
        this.description = description;
        this.loggedFor = forField;
        this.date = date;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getForField() {
        return loggedFor;
    }

    public void setForField(String forField) {
        this.loggedFor = forField;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
