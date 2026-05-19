package com.raiseit.controller;

import com.raiseit.dao.ContactDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Shows contact inquiries to admin users.
 */
public class AdminContactServlet extends HttpServlet {

    /**
     * Loads all contact inquiries for the admin view.
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ContactDAO contactDAO = new ContactDAO();
            request.setAttribute("inquiries", contactDAO.getAllInquiries());
            request.getRequestDispatcher("/WEB-INF/views/admin/contact_inquiries.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
