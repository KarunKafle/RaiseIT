package com.raiseit.controller;

import com.raiseit.dao.ContactDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class AdminContactServlet extends HttpServlet {

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
