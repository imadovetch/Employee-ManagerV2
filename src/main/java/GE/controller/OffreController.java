package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Offre;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.ResponseHandler;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.time.LocalDate;
import java.util.List;
@WebServlet(urlPatterns = {
        "/AddOffre",
        "/ModifyOffre/*",
        "/DeleteOffre/*",
        "/GetOffres"
})
public class OffreController extends HttpServlet {
    EmployeeDAO<Offre> offreDAO = new EmployeeDAO<>(Offre.class);

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String description = request.getParameter("description");
        String jobType = request.getParameter("jobType");
        String statusStr = request.getParameter("status");

        if (description == null || description.trim().isEmpty() ||
                jobType == null || jobType.trim().isEmpty() ||
                statusStr == null || statusStr.trim().isEmpty()) {

            ResponseHandler.sendResponse(response, "All fields are required: description, jobType, and status.", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            Offre.Status status = Offre.Status.valueOf(statusStr.toUpperCase());

            Offre newOffre = new Offre(LocalDate.now(), jobType, status, description);

            offreDAO.save(newOffre);

            ResponseHandler.sendResponse(response, newOffre.toString(), HttpServletResponse.SC_CREATED);

        } catch (IllegalArgumentException e) {
            ResponseHandler.sendResponse(response, "Invalid status value. Please provide a valid status.", HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    @Override
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");


        String idStr = request.getPathInfo();
        idStr = idStr.substring(1);

        StringBuilder sb = new StringBuilder();
        String line;
        BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));

        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        String jsonData = sb.toString();
        JsonObject jsonObject = JsonParser.parseString(jsonData).getAsJsonObject();

        String statusStr  = jsonObject.get("status").getAsString();


        if (idStr == null || idStr.trim().isEmpty() || statusStr == null || statusStr.trim().isEmpty()) {
            ResponseHandler.sendResponse(response, "ID and status are required to update an Offre.id-" + idStr + "sts" + statusStr, HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Offre.Status status = Offre.Status.valueOf(statusStr.toUpperCase());

            Offre offreToUpdate = offreDAO.findById((long) id);
            if (offreToUpdate != null) {
                offreToUpdate.setStatus(status);
                offreDAO.update(offreToUpdate, (long) id);
                ResponseHandler.sendResponse(response, "Offre updated successfully.", HttpServletResponse.SC_OK);
            } else {
                ResponseHandler.sendResponse(response, "Offre not found.", HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (NumberFormatException e) {
            ResponseHandler.sendResponse(response, "Invalid ID format.", HttpServletResponse.SC_BAD_REQUEST);
        } catch (IllegalArgumentException e) {
            ResponseHandler.sendResponse(response, "Invalid status value. Please provide a valid status.", HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    @Override
    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String idStr = request.getPathInfo();
        idStr = idStr.substring(1);


        if (idStr == null || idStr.trim().isEmpty()) {
            ResponseHandler.sendResponse(response, "ID is required to delete an Offre.", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            offreDAO.delete((long) id); // Assuming the delete method takes an ID
            ResponseHandler.sendResponse(response, "Offre deleted successfully.", HttpServletResponse.SC_OK);

        } catch (NumberFormatException e) {
            ResponseHandler.sendResponse(response, "Invalid ID format.", HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id"); // Optional: to fetch a specific offre

        if (idStr == null || idStr.trim().isEmpty()) {
            List<Offre> offres = offreDAO.fetchAll();
          //  String jsonResponse = new Gson().toJson(offres);
//            ResponseHandler.sendResponse(response, jsonResponse, HttpServletResponse.SC_OK);
//            response.getWriter().write(jsonResponse);
            ResponseHandler.sendResponse(response, offres.toString() ,HttpServletResponse.SC_OK);
        } else {
            try {
                int id = Integer.parseInt(idStr);
                Offre offre = offreDAO.findById((long) id); // Fetch an offre by ID

                if (offre != null) {
                    ResponseHandler.sendResponse(response, offre.toString(), HttpServletResponse.SC_OK);
                } else {
                    ResponseHandler.sendResponse(response, "Offre not found.", HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                ResponseHandler.sendResponse(response, "Invalid ID format.", HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}
