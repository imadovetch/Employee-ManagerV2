package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Aplyment;
import GE.model.Offre;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import utils.ResponseHandler;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;
@WebServlet(urlPatterns = {
        "/AddAplyment",
        "/ModifyAplyment/*",
        "/GetAplyments"
})


@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10,  // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AplymentController extends HttpServlet {
    EmployeeDAO<Aplyment> aplymentDAO = new EmployeeDAO<>(Aplyment.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // Get the file part (cv)
            Part cvPart = request.getPart("cv");
            String cvFileName = Paths.get(cvPart.getSubmittedFileName()).getFileName().toString();

            // Define the folder where CVs will be saved
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir(); // Create the uploads directory if it doesn't exist
            }

            // Save the uploaded CV to the server
            String cvFilePath = uploadPath + File.separator + cvFileName;
            cvPart.write(cvFilePath); // This saves the file

            // Get other form fields
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String lettremotivation = request.getParameter("lettremotivation");
            Long offreId = Long.parseLong(request.getParameter("offreId"));
            Aplyment.Status status = Aplyment.Status.valueOf(request.getParameter("status").toUpperCase());
            LocalDate applyDate = LocalDate.now();

            // Create the new Aplyment object
            Aplyment newAplyment = new Aplyment(offreId, name, email, status, applyDate, cvFilePath, lettremotivation);

            // Save the new application
            aplymentDAO.save(newAplyment);

            // Send a success response
            ResponseHandler.sendResponse(response, newAplyment.toString(), HttpServletResponse.SC_CREATED);
        } catch (Exception e) {
            // Handle file upload and parsing errors
            ResponseHandler.sendResponse(response, "Error: " + e.getMessage(), HttpServletResponse.SC_BAD_REQUEST);
            e.printStackTrace();
        }
    }


    @Override
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String idStr = request.getPathInfo();
        if (idStr == null || idStr.length() < 2) { // Ensure id is valid
            ResponseHandler.sendResponse(response, "ID is required to update an Aplyment.", HttpServletResponse.SC_BAD_REQUEST);
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
            String statusStr = jsonObject.get("status").getAsString(); // Assuming you are updating the status

            if (statusStr == null || statusStr.trim().isEmpty()) {
                ResponseHandler.sendResponse(response, "Status is required to update an Aplyment.", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            try {
                long id = Long.parseLong(idStr);
                Aplyment aplymentToUpdate = aplymentDAO.findById(id);
                if (aplymentToUpdate != null) {
                    Aplyment.Status newStatus = Aplyment.Status.valueOf(statusStr.toUpperCase());
                    aplymentToUpdate.setStatus(newStatus);
                    aplymentDAO.update(aplymentToUpdate, id);
                    ResponseHandler.sendResponse(response, "Aplyment updated successfully.", HttpServletResponse.SC_OK);


                    if (aplymentToUpdate.getStatus() == Aplyment.Status.ACCEPTED) {
                        EmployeeDAO<Offre> OffreDAO = new EmployeeDAO<>(Offre.class);

                       new AuthController().register(aplymentToUpdate.getEmail(), aplymentToUpdate.getName(), OffreDAO.findById(aplymentToUpdate.getOffreId()).getType()); // mn b3d khdem b bean

                    }
                } else {
                    ResponseHandler.sendResponse(response, "Aplyment not found.", HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                ResponseHandler.sendResponse(response, "Invalid ID format.", HttpServletResponse.SC_BAD_REQUEST);
            } catch (IllegalArgumentException e) {
                ResponseHandler.sendResponse(response, "Invalid status value. Please provide a valid status.", HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (JsonParseException e) {
            ResponseHandler.sendResponse(response, "Error parsing JSON data: " + e.getMessage(), HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            ResponseHandler.sendResponse(response, "An error occurred: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(); // Optional: log the stack trace for debugging purposes
        } finally {
            br.close(); // Close the BufferedReader
        }
    }


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id"); // Optional: to fetch a specific aplyment

        if (idStr == null || idStr.trim().isEmpty()) {
            List<Aplyment> aplyments = aplymentDAO.fetchAll();
            ResponseHandler.sendResponse(response, aplyments.toString(), HttpServletResponse.SC_OK);
        } else {
            try {
                long id = Long.parseLong(idStr);
                Aplyment aplyment = aplymentDAO.findById(id); // Fetch an aplyment by ID

                if (aplyment != null) {
                    ResponseHandler.sendResponse(response, aplyment.toString(), HttpServletResponse.SC_OK);
                } else {
                    ResponseHandler.sendResponse(response, "Aplyment not found.", HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                ResponseHandler.sendResponse(response, "Invalid ID format.", HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}



