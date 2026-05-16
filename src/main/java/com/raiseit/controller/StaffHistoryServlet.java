package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.model.Complaint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class StaffHistoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int staffId = (int) session.getAttribute("userId");
            ComplaintDAO complaintDAO = new ComplaintDAO();
            List<Complaint> history = complaintDAO.getResolvedComplaintsByStaffWithMessageCount(staffId);
            request.setAttribute("history", history);
            request.getRequestDispatcher("/WEB-INF/views/staff/history.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
