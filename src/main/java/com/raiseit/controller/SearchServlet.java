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

@WebServlet("/student/search")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String keyword = request.getParameter("keyword");

        if (keyword != null && !keyword.trim().isEmpty()) {
            try {
                ComplaintDAO complaintDAO = new ComplaintDAO();
                request.setAttribute("complaints",
                        complaintDAO.searchComplaints(user.getId(), keyword.trim()));
                request.setAttribute("keyword", keyword.trim());
            } catch (SQLException e) {
                request.setAttribute("error", e.getMessage());
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/student/search.jsp")
                .forward(request, response);
    }
}