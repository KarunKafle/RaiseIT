<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assigned Complaints - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/staff/complaints" class="active">My Assigned</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Assigned Complaints</h1>
        </div>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Reference</th>
                    <th>Title</th>
                    <th>Student</th>
                    <th>Category</th>
                    <th>Priority</th>
                    <th>Status</th>
                    <th>Actions</th>
                    <th>Thread</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty complaints}">
                        <tr>
                            <td colspan="8" style="text-align:center;">No complaints assigned yet.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="complaint" items="${complaints}">
                            <tr>
                                <td>${complaint.referenceNumber}</td>
                                <td>${complaint.title}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${complaint.anonymous}">Anonymous</c:when>
                                        <c:otherwise>${complaint.studentName}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${complaint.categoryName}</td>
                                <td><span class="badge badge-${complaint.priority}">${complaint.priority}</span></td>
                                <td><span class="badge badge-${complaint.status}">${complaint.status}</span></td>
                                <td>
                                    <c:if test="${complaint.status == 'assigned'}">
                                        <form method="post" action="${pageContext.request.contextPath}/staff/complaints" style="display:inline">
                                            <input type="hidden" name="complaintId" value="${complaint.id}">
                                            <input type="hidden" name="action" value="inprogress">
                                            <button type="submit" class="btn-approve">Start</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${complaint.status == 'in_progress'}">
                                        <form method="post" action="${pageContext.request.contextPath}/staff/complaints" style="display:inline">
                                            <input type="hidden" name="complaintId" value="${complaint.id}">
                                            <input type="hidden" name="action" value="resolve">
                                            <button type="submit" class="btn-approve">Resolve</button>
                                        </form>
                                    </c:if>
                                </td>
                                <td>
                                    <a class="btn-secondary" href="${pageContext.request.contextPath}/thread?complaintId=${complaint.id}">View Thread</a>
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
