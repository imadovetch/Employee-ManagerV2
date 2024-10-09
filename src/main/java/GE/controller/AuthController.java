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

    public int register(String email, String name,String Type) {

        String password = generateRandomPassword(8);


        Rh newRh = new Rh();
        newRh.setEmail(email);
        newRh.setName(name);
        newRh.setPassword(password);

        try {
            rhDAO.save(newRh);
            System.out.println("Rh employee registered successfully.");
            // Optionally, you can call sendMailWithPass(email, password) here once it's implemented
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
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

        // Check for Employee
        Employee employee = employeeDAO.findByEmail(email);
        out.write(employee.toString());
        out.write(employeeDAO.fetchAll().toString());
        if (employee != null && employee.getPassword().equals(password)) {
            // Login successful, return employee ID and type
            out.write("{\"id\": " + employee.getId() + ", \"type\": \"Employee\"}");
            return;
        }

        // Check for Rh
        Rh rh = rhDAO.findByEmail(email);
        if (rh != null && rh.getPassword().equals(password)) {
            // Login successful, return Rh ID and type
            out.write("{\"id\": " + rh.getId() + ", \"type\": \"Rh\"}");
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
