import GE.DAO.EmployeeDAO;
import GE.model.Aplyment;
import GE.model.Employee;
import GE.model.Offre;
import GE.model.Rh;

import java.time.LocalDate;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        EmployeeDAO<Employee> aplymentDAO = new EmployeeDAO<>(Employee.class);
        // Create new Rh object, filling in attributes from the User class and rhSubname
        Employee newRh = new Employee();
        newRh.setName("John Doe");
//        newRh.setSalaire(5000);
//        newRh.setAbscenceDays(2);
//        newRh.setCongeDays(5);
        newRh.setEmail("john11.doe@example.com");
        newRh.setPassword("password123");
//        newRh.setBirthDate(LocalDate.of(1990, 5, 20));
//        newRh.setPhoneNumber("123456789");
//        newRh.setAdresse("123 Main St");
//        newRh.setRhSubname("HR Manager"); // Rh-specific attribute

        // Save the new Rh object to the database
        aplymentDAO.save(newRh);
//        System.out.println("Offre inserted successfully!");
//
//        System.out.println(aplymentDAO.fetchAll());
//
        //List<Rh> aplyments = aplymentDAO.fetchAll();
//        Rh rb = aplymentDAO.findByEmail("john.doe@example.com","Rh");
//        System.out.println("ID: " + rb.getId());
//        System.out.println("Name: " + rb.getName());
//        System.out.println("Status: " + rb.getEmail());
//        System.out.println("Start Date: " + rb.getRhSubname());
//        System.out.println("End Date: " + rb.getBirthDate());
//        System.out.println("Email: " + rb.getEmail());
//        // Add more fields to print as needed
//        System.out.println("----------------------");

    }
}
