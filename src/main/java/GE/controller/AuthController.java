package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Rh;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Random;
@WebServlet(urlPatterns = {
        "/",
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
