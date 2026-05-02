package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.dao.UserDAO;
import com.raiseit.model.Complaint;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/complaints")
public class AdminComplaintServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ComplaintDAO complaintDAO = new ComplaintDAO();
            UserDAO userDAO = new UserDAO();
            List<Complaint> complaints = complaintDAO.getAllComplaints();
            request.setAttribute("complaints", complaints);
            request.setAttribute("staffList", userDAO.getStaffUsers());
            request.getRequestDispatcher("/WEB-INF/views/admin/complaints.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String complaintIdStr = request.getParameter("complaintId");

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            ComplaintDAO complaintDAO = new ComplaintDAO();

            switch (action) {
                case "assign":
                    String staffIdStr = request.getParameter("staffId");
                    if (staffIdStr != null && !staffIdStr.isEmpty()) {
                        int staffId = Integer.parseInt(staffIdStr);
                        complaintDAO.assignComplaintToStaff(complaintId, staffId);
                    }
                    break;
                case "resolve":
                    complaintDAO.updateComplaintStatus(complaintId, "resolved");
                    break;
                case "close":
                    complaintDAO.updateComplaintStatus(complaintId, "closed");
                    break;
                case "delete":
                    complaintDAO.deleteComplaint(complaintId);
                    break;
            }
            response.sendRedirect(request.getContextPath() + "/admin/complaints");
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}