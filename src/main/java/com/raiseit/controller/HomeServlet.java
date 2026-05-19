package com.raiseit.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = null;
        if (session != null) {
            role = (String) session.getAttribute("userRole");
        }

        if (role != null) {
            if ("admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?warning=logout_required");
            } else if ("staff".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/staff/dashboard?warning=logout_required");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard?warning=logout_required");
            }
            return;
        }

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
