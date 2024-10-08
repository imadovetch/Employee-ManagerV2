import GE.DAO.EmployeeDAO;
import GE.model.Aplyment;
import GE.model.Offre;
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        EmployeeDAO<Aplyment> aplymentDAO = new EmployeeDAO<>(Aplyment.class);

        // Create a new Aplyment instance
        Aplyment.Status status = Aplyment.Status.valueOf("PENDING");
        LocalDate applyDate = LocalDate.now(); // Set current date as apply date

        Aplyment newAplyment = new Aplyment(1L, "name", "email", status, applyDate);
        aplymentDAO.save(newAplyment);

        System.out.println("Offre inserted successfully!");
    }
}
