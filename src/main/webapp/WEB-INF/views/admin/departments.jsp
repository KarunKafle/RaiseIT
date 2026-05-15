<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Departments - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users">Users</a>
            <a href="${pageContext.request.contextPath}/admin/complaints">Complaints</a>
            <a href="${pageContext.request.contextPath}/admin/departments" class="active">Departments</a>
            <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Manage Departments</h1>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <div class="form-container">
            <h2>
                <c:choose>
                    <c:when test="${not empty editDepartment}">Edit Department</c:when>
                    <c:otherwise>Add Department</c:otherwise>
                </c:choose>
            </h2>
            <form method="post" action="${pageContext.request.contextPath}/admin/departments">
                <input type="hidden" name="action" value="${not empty editDepartment ? 'update' : 'add'}">
                <c:if test="${not empty editDepartment}">
                    <input type="hidden" name="id" value="${editDepartment.id}">
                </c:if>
                <div class="form-group">
                    <label for="name">Department Name</label>
                    <input type="text" id="name" name="name" value="${editDepartment.name}" required>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="3">${editDepartment.description}</textarea>
                </div>
                <button type="submit" class="btn-primary">
                    <c:choose>
                        <c:when test="${not empty editDepartment}">Update Department</c:when>
                        <c:otherwise>Add Department</c:otherwise>
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
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="department" items="${departments}">
                    <tr>
                        <td>${department.id}</td>
                        <td>${department.name}</td>
                        <td>${department.description}</td>
                        <td>
                            <a class="btn-secondary" href="${pageContext.request.contextPath}/admin/departments?editId=${department.id}">Edit</a>
                            <form method="post" action="${pageContext.request.contextPath}/admin/departments" style="display:inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${department.id}">
                                <button type="submit" class="btn-delete" onclick="return confirm('Delete this department?')">Delete</button>
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
