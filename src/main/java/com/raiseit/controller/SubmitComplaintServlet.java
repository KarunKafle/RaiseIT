package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.dao.CategoryDAO;
import com.raiseit.model.Complaint;
import com.raiseit.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles complaint submission for students.
 */
@WebServlet("/student/submit")
public class SubmitComplaintServlet extends HttpServlet {

    /**
     * Loads complaint categories and forwards to the submit form.
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CategoryDAO categoryDAO = new CategoryDAO();
            request.setAttribute("categories", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/views/student/submit.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Validates input and creates a new complaint record.
     * @param request the HTTP request with form data
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String categoryIdStr = request.getParameter("categoryId");
        String priority = request.getParameter("priority");
        String anonymousStr = request.getParameter("isAnonymous");

        if (title == null || title.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            try {
                CategoryDAO categoryDAO = new CategoryDAO();
                request.setAttribute("categories", categoryDAO.getAllCategories());
            } catch (SQLException e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/views/student/submit.jsp")
                    .forward(request, response);
            return;
        }

        try {
            Complaint complaint = new Complaint();
            complaint.setUserId(user.getId());
            complaint.setTitle(title.trim());
            complaint.setDescription(description.trim());
            complaint.setCategoryId(Integer.parseInt(categoryIdStr));
            complaint.setPriority(priority);
            complaint.setAnonymous(anonymousStr != null);
            complaint.setStatus("submitted");

            ComplaintDAO complaintDAO = new ComplaintDAO();
            String refNumber = complaintDAO.submitComplaint(complaint);

            session.setAttribute("successMessage", "Complaint submitted! Reference: " + refNumber);
            response.sendRedirect(request.getContextPath() + "/student/complaints");
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
