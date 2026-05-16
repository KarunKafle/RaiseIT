<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Inquiries - RaiseIT</title>
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
            <a href="${pageContext.request.contextPath}/admin/departments">Departments</a>
            <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
            <a href="${pageContext.request.contextPath}/admin/reports">Reports</a>
            <a href="${pageContext.request.contextPath}/admin/contacts" class="active">Contact Inquiries</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Contact Inquiries</h1>
        </div>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Message</th>
                    <th>Submitted</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty inquiries}">
                        <tr>
                            <td colspan="6" style="text-align:center;">No inquiries yet.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="inquiry" items="${inquiries}">
                            <tr>
                                <td>${inquiry.id}</td>
                                <td>${inquiry.name}</td>
                                <td>${inquiry.email}</td>
                                <td>${inquiry.phone}</td>
                                <td style="white-space: normal; min-width: 260px;">${inquiry.message}</td>
                                <td>${inquiry.submittedAt}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
