package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Offre;
import GE.model.Rh;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.LocalDateAdapter;
import utils.ResponseHandler;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {
        "/AddOffre",
        "/ModifyOffre/*",
        "/DeleteOffre/*",
        "/GetOffres"
})
public class OffreController extends HttpServlet {
    EmployeeDAO<Offre> offreDAO = new EmployeeDAO<>(Offre.class);
    EmployeeDAO<Rh> RhDAO = new EmployeeDAO<>(Rh.class);
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Long RequestSender = 1L;

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

            Offre newOffre = new Offre(RequestSender,LocalDate.now(), jobType, status, description);

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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, new LocalDateAdapter()) // Register the custom LocalDate adapter
                .create();


        String idStr = request.getParameter("senderid");


        if (idStr == null || idStr.trim().isEmpty()) {
            // Fetch all offers if senderid is not provided (this should not happen due to the filter)
            List<Offre> offres = offreDAO.fetchAll();
            List<Map<String, Object>> offresWithRhDetails = new ArrayList<>();

            // Fetch RH data and add to each Offre
            offres.forEach(offre -> {
                Rh rh = RhDAO.findById((long) offre.getCreatorid()); // Assuming `creatorid` is stored in `getCreatorId()`

                // Create a map to hold Offre details and RH details
                Map<String, Object> offreWithRh = new HashMap<>();
                offreWithRh.put("offre", offre); // Add the Offre object itself

                // If RH details are available, add them to the map
                if (rh != null) {
                    offreWithRh.put("rhName", rh.getName());
                    offreWithRh.put("rhEmail", rh.getEmail());
                    offreWithRh.put("rhPhone", rh.getPhoneNumber());
                }

                offresWithRhDetails.add(offreWithRh); // Add the map to the list
            });

            // Convert the list of offers with RH details to JSON
            String jsonResponse = gson.toJson(offresWithRhDetails);
            ResponseHandler.sendResponse(response, jsonResponse, HttpServletResponse.SC_OK);

        } else {
            try {
                // Fetch offers filtered by creatorid
                List<Offre> offres = offreDAO.fetchWhere("Creatorid", idStr);
                if (!offres.isEmpty()) {
                    // Convert list of offers with RH details to JSON
                    String jsonResponse = gson.toJson(offres);
                    ResponseHandler.sendResponse(response, jsonResponse, HttpServletResponse.SC_OK);
                } else {
                    ResponseHandler.sendResponse(response, "{\"message\": \"Offre not found.\"}", HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                ResponseHandler.sendResponse(response, "{\"message\": \"Invalid ID format.\"}", HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }



}
