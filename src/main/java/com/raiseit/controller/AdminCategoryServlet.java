package com.raiseit.controller;

import com.raiseit.dao.CategoryDAO;
import com.raiseit.dao.DepartmentDAO;
import com.raiseit.model.Category;
import com.raiseit.model.Department;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Manages complaint categories for admin users.
 */
public class AdminCategoryServlet extends HttpServlet {

    /**
     * Loads categories and departments for the admin view.
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CategoryDAO categoryDAO = new CategoryDAO();
            DepartmentDAO departmentDAO = new DepartmentDAO();

            List<Category> categories = categoryDAO.getAllCategories();
            List<Department> departments = departmentDAO.getAllDepartments();
            request.setAttribute("categories", categories);
            request.setAttribute("departments", departments);

            String editId = request.getParameter("editId");
            if (editId != null && !editId.trim().isEmpty()) {
                int id = Integer.parseInt(editId);
                Category editCategory = categoryDAO.getCategoryById(id);
                request.setAttribute("editCategory", editCategory);
            }

            request.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp")
                    .forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Handles add, update, and delete actions for categories.
     * @param request the HTTP request with action data
     * @param response the HTTP response
     * @throws ServletException if forwarding fails
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String departmentIdParam = request.getParameter("departmentId");
        String idParam = request.getParameter("id");

        if (action == null || action.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        try {
            CategoryDAO categoryDAO = new CategoryDAO();

            if ("add".equals(action)) {
                if (name == null || name.trim().isEmpty() || departmentIdParam == null || departmentIdParam.trim().isEmpty()) {
                    request.setAttribute("error", "Category name and department are required.");
                    doGet(request, response);
                    return;
                }
                Category category = new Category();
                category.setName(name.trim());
                category.setDepartmentId(Integer.parseInt(departmentIdParam));
                categoryDAO.addCategory(category);
            } else if ("update".equals(action)) {
                if (idParam == null || idParam.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/admin/categories");
                    return;
                }
                if (name == null || name.trim().isEmpty() || departmentIdParam == null || departmentIdParam.trim().isEmpty()) {
                    request.setAttribute("error", "Category name and department are required.");
                    request.setAttribute("editCategory", categoryDAO.getCategoryById(Integer.parseInt(idParam)));
                    doGet(request, response);
                    return;
                }
                Category category = new Category();
                category.setId(Integer.parseInt(idParam));
                category.setName(name.trim());
                category.setDepartmentId(Integer.parseInt(departmentIdParam));
                categoryDAO.updateCategory(category);
            } else if ("delete".equals(action)) {
                if (idParam != null && !idParam.trim().isEmpty()) {
                    categoryDAO.deleteCategory(Integer.parseInt(idParam));
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
