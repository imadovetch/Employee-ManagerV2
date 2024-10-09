package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Rh;

import java.security.SecureRandom;
import java.util.Random;

public class WorkerController {
    EmployeeDAO<Rh> rhDAO = new EmployeeDAO<>(Rh.class);

    public int register(String email, String name) {

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
            return -1; // Registration failed
        }

        return 0;  // Registration successful
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

    // Placeholder method for sending the mail (skipping for now)
    public void sendMailWithPass(String email, String password) {
        // Logic for sending email with password will go here in the future
        // Skip for now
    }
}
