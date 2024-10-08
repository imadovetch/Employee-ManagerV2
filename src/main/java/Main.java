import GE.DAO.EmployeeDAO;
import GE.model.Offre;
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        EmployeeDAO<Offre> offreDAO = new EmployeeDAO<>(Offre.class);

        // Create a new Offre instance
        Offre newOffre = new Offre(LocalDate.now(), "Full-time", Offre.Status.LIVE,"");

        // Save the Offre to the database
        offreDAO.save(newOffre);

        System.out.println("Offre inserted successfully!");
    }
}
