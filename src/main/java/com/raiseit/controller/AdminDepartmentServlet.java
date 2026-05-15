package com.raiseit.controller;

import com.raiseit.dao.DepartmentDAO;
import com.raiseit.model.Department;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminDepartmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DepartmentDAO departmentDAO = new DepartmentDAO();
            List<Department> departments = departmentDAO.getAllDepartments();
            request.setAttribute("departments", departments);

            String editId = request.getParameter("editId");
            if (editId != null && !editId.trim().isEmpty()) {
                int id = Integer.parseInt(editId);
                Department editDepartment = departmentDAO.getDepartmentById(id);
                request.setAttribute("editDepartment", editDepartment);
            }

            request.getRequestDispatcher("/WEB-INF/views/admin/departments.jsp")
                    .forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String idParam = request.getParameter("id");

        if (action == null || action.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/departments");
            return;
        }

        try {
            DepartmentDAO departmentDAO = new DepartmentDAO();

            if ("add".equals(action)) {
                if (name == null || name.trim().isEmpty()) {
                    request.setAttribute("error", "Department name is required.");
                    doGet(request, response);
                    return;
                }
                Department department = new Department();
                department.setName(name.trim());
                department.setDescription(description != null ? description.trim() : null);
                departmentDAO.addDepartment(department);
            } else if ("update".equals(action)) {
                if (idParam == null || idParam.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/admin/departments");
                    return;
                }
                if (name == null || name.trim().isEmpty()) {
                    request.setAttribute("error", "Department name is required.");
                    request.setAttribute("editDepartment", departmentDAO.getDepartmentById(Integer.parseInt(idParam)));
                    doGet(request, response);
                    return;
                }
                Department department = new Department();
                department.setId(Integer.parseInt(idParam));
                department.setName(name.trim());
                department.setDescription(description != null ? description.trim() : null);
                departmentDAO.updateDepartment(department);
            } else if ("delete".equals(action)) {
                if (idParam != null && !idParam.trim().isEmpty()) {
                    departmentDAO.deleteDepartment(Integer.parseInt(idParam));
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/departments");
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
