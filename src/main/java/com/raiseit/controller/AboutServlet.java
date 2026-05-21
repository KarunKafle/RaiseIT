package com.raiseit.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Serves the About page for public visitors.
 */
@WebServlet("/About")
public class AboutServlet extends HttpServlet {

    /**
     * Forwards the request to the About view.
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/about.jsp")
                .forward(request, response);
    }
}
