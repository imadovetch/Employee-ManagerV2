package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Employee;
import GE.model.Rh;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Random;
@WebServlet(urlPatterns = {
        "/",
        "/login",
})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        request.getRequestDispatcher("WEB-INF/RhUi/index.jsp").forward(request, response);

    }


    EmployeeDAO<Rh> rhDAO = new EmployeeDAO<>(Rh.class);
    EmployeeDAO<Employee> EmployeeDAO = new EmployeeDAO<>(Employee.class);

    public int register(String email, String name,String Type) {

        String password = generateRandomPassword(8);

        if(Type.equals("Employee")){


            Employee newEmployee = new Employee();
            newEmployee.setEmail(email);
            newEmployee.setName(name);
            newEmployee.setPassword(password);

            try {
                EmployeeDAO.save(newEmployee);
                System.out.println("imaaaaddd employee registered successfully.");
                // Optionally, you can call sendMailWithPass(email, password) here once it's implemented
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }


        }else if(Type.equals("Rh")){


            Rh newRh = new Rh();
            newRh.setEmail(email);
            newRh.setName(name);
            newRh.setPassword(password);

            try {
                rhDAO.save(newRh);
                System.out.println("imaaad Rh employee registered successfully.");
                // Optionally, you can call sendMailWithPass(email, password) here once it's implemented
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        }

        return 0;
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Set response type to JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Extract email and password from the form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check if email and password are provided
        if (email == null || password == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"message\": \"Email and password must be provided.\"}");
            return;
        }

        // Create DAO instances
        EmployeeDAO<Employee> employeeDAO = new EmployeeDAO<>(Employee.class);
        EmployeeDAO<Rh> rhDAO = new EmployeeDAO<>(Rh.class);

        try {
            Employee employee = employeeDAO.findByEmail(email,"Employee");


            if (employee != null && employee.getPassword().equals(password)) {
                out.write("{\"id\": " + employee.getId() + ", \"type\": \"Employee\"}");
                return;
            }

            Rh rh = rhDAO.findByEmail(email,"Rh");
            System.out.println(rh.toString());
            if (rh != null && rh.getPassword().equals(password)) {

                out.write("{\"id\": " + rh.getId() + ", \"type\": \"Rh\"}");
                return;
            }

        } catch (Exception e) {
            // Handle any exceptions that occur during the login process
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"message\": \"An error occurred while processing your request.\"}");
            return;
        }

        // If we reach this point, login failed
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        out.write("{\"message\": \"Invalid email or password.\"}");
    }

    private String generateRandomPassword(int length) {
        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < length; i++) {
            password.append(chars.charAt(random.nextInt(chars.length())));
        }

        return password.toString();
    }


    public void sendMailWithPass(String email, String password) {

    }
}
