import GE.DAO.EmployeeDAO;
import GE.model.Aplyment;
import GE.model.Offre;
import GE.model.Rh;

import java.time.LocalDate;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        EmployeeDAO<Rh> aplymentDAO = new EmployeeDAO<>(Rh.class);
        // Create new Rh object, filling in attributes from the User class and rhSubname
//        Rh newRh = new Rh();
//        newRh.setName("John Doe");
//        newRh.setSalaire(5000);
//        newRh.setAbscenceDays(2);
//        newRh.setCongeDays(5);
//        newRh.setEmail("john.doe@example.com");
//        newRh.setPassword("password123");
//        newRh.setBirthDate(LocalDate.of(1990, 5, 20));
//        newRh.setPhoneNumber("123456789");
//        newRh.setAdresse("123 Main St");
//        newRh.setRhSubname("HR Manager"); // Rh-specific attribute
//
//        // Save the new Rh object to the database
//        aplymentDAO.save(newRh);
        System.out.println("Offre inserted successfully!");

        System.out.println(aplymentDAO.fetchAll());

        List<Rh> aplyments = aplymentDAO.fetchAll();

        for (Rh aplyment : aplyments) {
            System.out.println("ID: " + aplyment.getId());
            System.out.println("Name: " + aplyment.getName());
            System.out.println("Status: " + aplyment.getEmail());
            System.out.println("Start Date: " + aplyment.getRhSubname());
            System.out.println("End Date: " + aplyment.getBirthDate());
            System.out.println("Email: " + aplyment.getEmail());
            // Add more fields to print as needed
            System.out.println("----------------------");
        }

    }
}
