package GE.Middlwares;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/*")
public class Auth implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String token = ((HttpServletRequest) request).getHeader("token");

        // Create a wrapper to append senderid=1 for all requests
        httpRequest = new HttpServletRequestWrapper(httpRequest) {
            @Override
            public String getParameter(String name) {
                if ("senderid".equals(name)) {
                    return token != null ? token : null;
                }
                return super.getParameter(name);
            }
        };

        // Continue with the filter chain
        chain.doFilter(httpRequest, httpResponse);
    }

    @Override
    public void destroy() {
        // Cleanup code, if needed
    }
}
