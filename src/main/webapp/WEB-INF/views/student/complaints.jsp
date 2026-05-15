<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Complaints - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/student/search">Search</a>
            <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/complaints" class="active">My Complaints</a>
            <a href="${pageContext.request.contextPath}/student/submit">Submit Complaint</a>
            <a href="${pageContext.request.contextPath}/student/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>My Complaints</h1>
            <a href="${pageContext.request.contextPath}/student/submit" class="btn-primary">Submit New</a>
        </div>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Reference</th>
                    <th>Title</th>
                    <th>Category</th>
                    <th>Priority</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Thread</th>
                    <th>Feedback</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty complaints}">
                        <tr>
                            <td colspan="8" style="text-align:center;">No complaints submitted yet.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="complaint" items="${complaints}">
                            <tr>
                                <td>${complaint.referenceNumber}</td>
                                <td>${complaint.title}</td>
                                <td>${complaint.categoryName}</td>
                                <td>
                                    <span class="badge badge-${complaint.priority}">${complaint.priority}</span>
                                </td>
                                <td>
                                    <span class="badge badge-${complaint.status}">${complaint.status}</span>
                                </td>
                                <td>${complaint.createdAt}</td>
                                <td>
                                    <a class="btn-secondary" href="${pageContext.request.contextPath}/thread?complaintId=${complaint.id}">View Thread</a>
                                </td>
                                <td>
                                    <c:if test="${complaint.status == 'resolved'}">
                                        <a class="btn-secondary" href="${pageContext.request.contextPath}/feedback?complaintId=${complaint.id}">Leave Feedback</a>
                                    </c:if>
                                    <c:if test="${complaint.status != 'resolved'}">
                                        <span style="color:#6b7280;">Not Available</span>
                                    </c:if>
                                </td>
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
