<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/complaints">My Complaints</a>
            <a href="${pageContext.request.contextPath}/student/submit" class="active">Submit Complaint</a>
            <a href="${pageContext.request.contextPath}/student/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Submit a Complaint</h1>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <div class="form-container">
            <form method="post" action="${pageContext.request.contextPath}/student/submit">
                <div class="form-group">
                    <label>Title</label>
                    <input type="text" name="title" placeholder="Brief title of your complaint" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="categoryId" required>
                        <option value="">Select a category</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}">${category.departmentName} - ${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Priority</label>
                    <select name="priority">
                        <option value="low">Low</option>
                        <option value="medium" selected>Medium</option>
                        <option value="high">High</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="6" placeholder="Describe your complaint in detail" required></textarea>
                </div>
                <div class="form-group checkbox-group">
                    <input type="checkbox" name="isAnonymous" id="isAnonymous">
                    <label for="isAnonymous">Submit anonymously</label>
                </div>
                <button type="submit" class="btn-primary">Submit Complaint</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>