package utils;

import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ResponseHandler {

    public static void sendResponse(HttpServletResponse response, String message, int status) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json;charset=UTF-8");
        String jsonResponse = new Gson().toJson(message);
        response.getWriter().write(jsonResponse);
    }
}
