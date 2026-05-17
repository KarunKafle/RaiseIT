package com.raiseit.controller;

import com.raiseit.dao.ComplaintDAO;
import com.raiseit.dao.ReportDAO;
import com.raiseit.model.StatItem;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ComplaintDAO complaintDAO = new ComplaintDAO();
            ReportDAO reportDAO = new ReportDAO();

            List<StatItem> statusStats = complaintDAO.getComplaintCountsByStatus();
            List<StatItem> priorityStats = complaintDAO.getComplaintCountsByPriority();
            List<StatItem> departmentStats = reportDAO.getComplaintCountsByDepartment();
            List<StatItem> staffResolvedStats = reportDAO.getResolvedCountsByStaff();

            request.setAttribute("statusStats", statusStats);
            request.setAttribute("priorityStats", priorityStats);
            request.setAttribute("departmentStats", departmentStats);
            request.setAttribute("staffResolvedStats", staffResolvedStats);

            request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
