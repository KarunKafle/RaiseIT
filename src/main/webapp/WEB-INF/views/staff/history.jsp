<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Response History - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/staff/complaints">My Assigned</a>
            <a href="${pageContext.request.contextPath}/staff/history" class="active">Response History</a>
            <a href="${pageContext.request.contextPath}/staff/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Response History</h1>
        </div>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Reference</th>
                    <th>Title</th>
                    <th>Student Name</th>
                    <th>Category</th>
                    <th>Date Resolved</th>
                    <th>Messages Exchanged</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty history}">
                        <tr>
                            <td colspan="6" style="text-align:center;">No resolved complaints yet.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="complaint" items="${history}">
                            <tr>
                                <td>${complaint.referenceNumber}</td>
                                <td>${complaint.title}</td>
                                <td>${complaint.studentName}</td>
                                <td>${complaint.categoryName}</td>
                                <td>${complaint.createdAt}</td>
                                <td>${complaint.messageCount}</td>
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
