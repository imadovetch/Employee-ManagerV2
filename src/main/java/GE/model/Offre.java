package GE.model;

import jakarta.persistence.Table;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "offres")
public class Offre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-generated primary key
    private Long id;

    // Type of the offer (e.g., full-time, part-time)
    @Column(name = "description", nullable = false)
    private String description;


    // Date when the offer was published
    @Column(name = "publication_date", nullable = false)
    private LocalDate publicationDate;

    // Type of the offer (e.g., full-time, part-time)
    @Column(name = "type", nullable = false)
    private String type;

    // Status of the offer, which can be either 'live' or 'ended'
    @Column(name = "status", nullable = false)
    @Enumerated(EnumType.STRING)
    private Status status;

    // Enum to define status options: live or ended
    public enum Status {
        LIVE, ENDED
    }

    // Constructors
    public Offre() {
    }

    public Offre(Long Creatorid,LocalDate publicationDate, String type, Status status,String description) {
        this.Creatorid = Creatorid;
        this.description = description;
        this.publicationDate = publicationDate;
        this.type = type;
        this.status = status;
    }
    @Column(name = "Creatorid", nullable = false)
    private Long Creatorid;

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public Long getCreatorid() {
        return Creatorid;
    }

    public void setCreatorid(Long id) {
        this.Creatorid = Creatorid;
    }
    public LocalDate getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(LocalDate publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getType() {
        return type;
    }


    public void setType(String type) {
        this.type = type;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
    @Override
    public String toString() {
        return "Offre{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", publicationDate=" + publicationDate +
                ", type='" + type + '\'' +
                ", status=" + status +
                '}';
    }
}
