package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/staff/complaints")
public class StaffComplaintsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            ComplaintDAO complaintDAO = new ComplaintDAO();
            request.setAttribute("complaints", complaintDAO.getComplaintsAssignedToStaff(user.getId()));
            request.getRequestDispatcher("/WEB-INF/views/staff/complaints.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String complaintIdStr = request.getParameter("complaintId");
        String action = request.getParameter("action");

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            ComplaintDAO complaintDAO = new ComplaintDAO();

            switch (action) {
                case "inprogress":
                    complaintDAO.updateComplaintStatus(complaintId, "in_progress");
                    break;
                case "resolve":
                    complaintDAO.updateComplaintStatus(complaintId, "resolved");
                    break;
            }
            response.sendRedirect(request.getContextPath() + "/staff/complaints");
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}