package GE.controller;

import GE.DAO.EmployeeDAO;
import GE.model.Logs;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/GetLogs"})
public class LogsController extends HttpServlet {

    private final EmployeeDAO<Logs> logsDAO = new EmployeeDAO<>(Logs.class);
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set request and response encoding to UTF-8 and content type to JSON
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Fetch all logs from the database
            List<Logs> logsList = logsDAO.fetchAll();

            // Convert the logs list to JSON using Gson
            String jsonResponse = gson.toJson(logsList);

            // Write the JSON response
            response.getWriter().write(jsonResponse);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();

            // Send error response if any exception occurs
            response.getWriter().write("{\"error\": \"Internal Server Error. Unable to process the request.\"}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
