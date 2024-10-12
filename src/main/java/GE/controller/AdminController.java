package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.User;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonParseException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.ResponseHandler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

@WebServlet(urlPatterns = {"/GetUsersForAdmin", "/ModifyUserAdmin"})
public class AdminController extends HttpServlet {

    private EmployeeDAO<User> userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new EmployeeDAO<>(User.class);
    }

    // Handle GET request to fetch users
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch the list of users from the database
            List<User> users = userDAO.fetchAll();

            // Set the response content type to JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Start constructing the JSON response using StringBuilder
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{\"users\":[");

            for (int i = 0; i < users.size(); i++) {
                User user = users.get(i);

                jsonResponse.append("{")
                        .append("\"id\":").append(user.getId() != null ? user.getId() : "\"N/A\"").append(",")
                        .append("\"name\":").append(user.getName() != null ? "\"" + user.getName() + "\"" : "\"N/A\"").append(",")
                        .append("\"email\":").append(user.getEmail() != null ? "\"" + user.getEmail() + "\"" : "\"N/A\"").append(",")
                        .append("\"childs\":").append(user.getChildsnmbr() ).append(",")
                        .append("\"phoneNumber\":").append(user.getPhoneNumber() != null ? "\"" + user.getPhoneNumber() + "\"" : "\"N/A\"").append(",")
                        .append("\"adresse\":").append(user.getAdresse() != null ? "\"" + user.getAdresse() + "\"" : "\"N/A\"").append(",")
                        .append("\"salaire\":").append(user.getSalaire())
                        .append("}");

                // Add a comma between objects if it's not the last element
                if (i < users.size() - 1) {
                    jsonResponse.append(",");
                }
            }

            // Close the JSON array and object
            jsonResponse.append("]}");

            // Write the JSON response to the output
            response.getWriter().write(jsonResponse.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching users");
        }
    }


    // Handle PUT request to modify a user
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String idStr = request.getPathInfo();
        if (idStr == null || idStr.length() < 2) {
            ResponseHandler.sendResponse(response, "ID is required to update the user.", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        idStr = idStr.substring(1); // Remove leading slash

        StringBuilder sb = new StringBuilder();
        BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));

        try {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            String jsonData = sb.toString();
            JsonObject jsonObject = JsonParser.parseString(jsonData).getAsJsonObject();

            // Extract updated fields from the JSON input
            String address = jsonObject.has("adresse") ? jsonObject.get("adresse").getAsString() : null;
            String phoneNumber = jsonObject.has("phoneNumber") ? jsonObject.get("phoneNumber").getAsString() : null;
            Integer childsNumber = jsonObject.has("childsnmbr") ? jsonObject.get("childsnmbr").getAsInt() : null;
            ResponseHandler.sendResponse(response, address + phoneNumber + childsNumber, HttpServletResponse.SC_BAD_REQUEST);

            if (address == null && phoneNumber == null && childsNumber == null) {
                ResponseHandler.sendResponse(response, "At least one field (address, phone number, number of children) must be provided.", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            try {
                long userId = Long.parseLong(idStr);
                User existingUser = userDAO.findById(userId);
                if (existingUser != null) {
                    // Update fields if they are provided in the request
                    if (address != null) {
                        existingUser.setAdresse(address);
                    }
                    if (phoneNumber != null) {
                        existingUser.setPhoneNumber(phoneNumber);
                    }
                    if (childsNumber != null) {
                        existingUser.setChildsnmbr(childsNumber);
                    }

                    userDAO.update(existingUser, userId);
                    ResponseHandler.sendResponse(response, "User updated successfully.", HttpServletResponse.SC_OK);
                } else {
                    ResponseHandler.sendResponse(response, "User not found.", HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                ResponseHandler.sendResponse(response, "Invalid ID format.", HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (JsonParseException e) {
            ResponseHandler.sendResponse(response, "Error parsing JSON data: " + e.getMessage(), HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            ResponseHandler.sendResponse(response, "An error occurred: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(); // Optional for debugging purposes
        } finally {
            br.close(); // Close the BufferedReader
        }
    }

}
