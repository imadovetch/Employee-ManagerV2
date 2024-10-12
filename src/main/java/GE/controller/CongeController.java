package GE.controller;


import GE.DAO.EmployeeDAO;
//import GE.model.Employee;
import GE.model.*;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.ResponseHandler;

import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import java.io.IOException;
import java.util.Date;
import java.util.List;
@WebServlet(urlPatterns = {

        "/AskForConge",

})
public class CongeController extends HttpServlet {
    //    private final EmployeeDAO employeeDAO = new EmployeeDAO();
//
    EmployeeDAO<User> offreDAO = new EmployeeDAO<>(User.class);
    EmployeeDAO<Rh> RhDAO = new EmployeeDAO<>(Rh.class);
    EmployeeDAO<Offre> offrerDAO = new EmployeeDAO<>(Offre.class);
    EmployeeDAO<Logs> LogsDAO = new EmployeeDAO<>(Logs.class);


    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String id = request.getParameter("senderid");

            User emp = offreDAO.findById(Long.valueOf(id));
            if (emp == null) {
                ResponseHandler.sendResponse(response, "No user found", HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Get the conge days, handling the case where it might be null
            Integer congeDays = emp.getCongeDays();
            if (congeDays == null) {
                congeDays = 0; // Default value if null
            }

            // Check if conge days have reached the limit
            if (congeDays >= 15) {
                ResponseHandler.sendResponse(response, "Reached the limit", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            // Increment conge days by 1
            emp.setCongeDays(congeDays + 1);

            // Update the employee in the database
            boolean updateSuccess = offreDAO.update(emp, emp.getId());
            Logs log = new Logs();
            log.setType("Conge");
            log.setDescription("Conge booked for id : : " + id);
            log.setDate(new Date());
            LogsDAO.save(log);
            if (updateSuccess) {
                ResponseHandler.sendResponse(response, "Conge days incremented successfully", HttpServletResponse.SC_OK);
            } else {
                ResponseHandler.sendResponse(response, "Failed to update conge days", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

            System.out.println(emp);
        } catch (NumberFormatException e) {
            // Handle cases where ID conversion fails
            ResponseHandler.sendResponse(response, "Invalid ID format", HttpServletResponse.SC_BAD_REQUEST);
            e.printStackTrace();
        } catch (Exception e) {
            // Catch any other exceptions
            ResponseHandler.sendResponse(response, "An error occurred: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }





}