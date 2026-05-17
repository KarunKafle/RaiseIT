<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <button class="hamburger-btn" type="button" onclick="document.body.classList.toggle('sidebar-open')">☰ Menu</button>
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users">Users</a>
            <a href="${pageContext.request.contextPath}/admin/complaints">Complaints</a>
            <a href="${pageContext.request.contextPath}/admin/departments">Departments</a>
            <a href="${pageContext.request.contextPath}/admin/categories" class="active">Categories</a>
            <a href="${pageContext.request.contextPath}/admin/reports">Reports</a>
            <a href="${pageContext.request.contextPath}/admin/contacts">Contact Inquiries</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Manage Categories</h1>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <div class="form-container">
            <h2>
                <c:choose>
                    <c:when test="${not empty editCategory}">Edit Category</c:when>
                    <c:otherwise>Add Category</c:otherwise>
                </c:choose>
            </h2>
            <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                <input type="hidden" name="action" value="${not empty editCategory ? 'update' : 'add'}">
                <c:if test="${not empty editCategory}">
                    <input type="hidden" name="id" value="${editCategory.id}">
                </c:if>
                <div class="form-group">
                    <label for="name">Category Name</label>
                    <input type="text" id="name" name="name" value="${editCategory.name}" required>
                </div>
                <div class="form-group">
                    <label for="departmentId">Department</label>
                    <select id="departmentId" name="departmentId" required>
                        <option value="">Select Department</option>
                        <c:forEach var="department" items="${departments}">
                            <option value="${department.id}" ${editCategory.departmentId == department.id ? 'selected' : ''}>
                                ${department.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn-primary">
                    <c:choose>
                        <c:when test="${not empty editCategory}">Update Category</c:when>
                        <c:otherwise>Add Category</c:otherwise>
                    </c:choose>
                </button>
            </form>
        </div>

        <div class="table-container" style="margin-top: 24px;">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="category" items="${categories}">
                    <tr>
                        <td>${category.id}</td>
                        <td>${category.name}</td>
                        <td>${category.departmentName}</td>
                        <td>
                            <a class="btn-secondary" href="${pageContext.request.contextPath}/admin/categories?editId=${category.id}">Edit</a>
                            <form method="post" action="${pageContext.request.contextPath}/admin/categories" style="display:inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${category.id}">
                                <button type="submit" class="btn-delete" onclick="return confirm('Delete this category?')">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
