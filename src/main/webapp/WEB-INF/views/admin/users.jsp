<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.raiseit.model.User, java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <button class="hamburger-btn" type="button" onclick="document.body.classList.toggle('sidebar-open')">☰ Menu</button>
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="active">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/complaints">Manage Complaints</a>
            <a href="${pageContext.request.contextPath}/admin/departments">Manage Departments</a>
            <a href="${pageContext.request.contextPath}/admin/categories">Manage Categories</a>
            <a href="${pageContext.request.contextPath}/admin/reports">Reports</a>
            <a href="${pageContext.request.contextPath}/admin/contacts">Contact Inquiries</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Manage Users</h1>
        </div>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.role}</td>
                        <td>
                            <span class="badge badge-${user.status}">${user.status}</span>
                        </td>
                        <td>
                            <c:if test="${user.status == 'pending'}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline">
                                    <input type="hidden" name="userId" value="${user.id}">
                                    <input type="hidden" name="action" value="approve">
                                    <button type="submit" class="btn-approve">Approve</button>
                                </form>
                            </c:if>
                            <c:if test="${user.status == 'active'}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline">
                                    <input type="hidden" name="userId" value="${user.id}">
                                    <input type="hidden" name="action" value="suspend">
                                    <button type="submit" class="btn-suspend">Suspend</button>
                                </form>
                            </c:if>
                            <c:if test="${user.role != 'admin'}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline">
                                    <input type="hidden" name="userId" value="${user.id}">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="btn-delete" onclick="return confirm('Delete this user?')">Delete</button>
                                </form>
                            </c:if>
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
