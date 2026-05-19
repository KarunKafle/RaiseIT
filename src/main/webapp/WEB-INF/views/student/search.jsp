<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Complaints - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <button class="hamburger-btn" type="button" onclick="document.body.classList.toggle('sidebar-open')">☰ Menu</button>
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/student/search" class="active">Search</a>
            <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/complaints">My Complaints</a>
            <a href="${pageContext.request.contextPath}/student/submit">Submit Complaint</a>
            <a href="${pageContext.request.contextPath}/faq">FAQ</a>
            <a href="${pageContext.request.contextPath}/student/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Search Complaints</h1>
        </div>
        <div class="form-container">
            <form method="get" action="${pageContext.request.contextPath}/student/search">
                <div class="form-group form-group-inline" style="display:flex; gap:10px;">
                    <input type="text" name="keyword" value="${keyword}"
                           placeholder="Search by title, reference number or keyword"
                           style="flex:1;">
                    <button type="submit" class="btn-primary">Search</button>
                </div>
            </form>
        </div>
        <c:if test="${not empty keyword}">
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
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty complaints}">
                            <tr>
                                <td colspan="6" style="text-align:center;">No complaints found for "${keyword}"</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="complaint" items="${complaints}">
                                <tr>
                                    <td>${complaint.referenceNumber}</td>
                                    <td>${complaint.title}</td>
                                    <td>${complaint.categoryName}</td>
                                    <td><span class="badge badge-${complaint.priority}">${complaint.priority}</span></td>
                                    <td><span class="badge badge-${complaint.status}">${complaint.status}</span></td>
                                    <td>${complaint.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>
