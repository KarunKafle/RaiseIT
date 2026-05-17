package com.raiseit.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Checks requests to make sure users are logged in before viewing
 * protected pages, and redirects to login if needed.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    /**
     * Initializes the filter when the server starts.
     * @param filterConfig the filter configuration
     * @throws ServletException if the filter cannot be initialized
     */
    public void init(FilterConfig filterConfig) throws ServletException {}

    /**
     * Allows public pages through and checks session roles for protected paths.
     * @param request the incoming servlet request
     * @param response the outgoing servlet response
     * @param chain the filter chain to continue processing
     * @throws IOException if a redirect or response fails
     * @throws ServletException if the next filter or servlet fails
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        boolean isPublicPath = path.equals("/") ||
                path.equals("/login") ||
                path.equals("/register") ||
                path.equals("/about") ||
                path.equals("/contact") ||
                path.equals("/faq") ||
                path.startsWith("/css/") ||
                path.startsWith("/images/") ||
                path.equals("/error");

        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);

        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("userRole");
        String redirectTo = httpRequest.getContextPath();

        if (path.startsWith("/admin/") && !"admin".equals(role)) {
            httpResponse.sendRedirect(redirectTo + "/login");
            return;
        }

        if (path.startsWith("/staff/") && !"staff".equals(role) && !"admin".equals(role)) {
            httpResponse.sendRedirect(redirectTo + "/login");
            return;
        }

        if (path.startsWith("/student/") && !"student".equals(role)) {
            httpResponse.sendRedirect(redirectTo + "/login");
            return;
        }

        if (path.startsWith("/thread") && !("admin".equals(role) || "staff".equals(role) || "student".equals(role))) {
            httpResponse.sendRedirect(redirectTo + "/login");
            return;
        }

        chain.doFilter(request, response);
    }

    /**
     * Cleans up filter resources when the server shuts down.
     */
    public void destroy() {}
}
