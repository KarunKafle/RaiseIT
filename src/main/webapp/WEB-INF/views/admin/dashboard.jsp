<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.raiseit.model.Complaint" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - RaiseIT</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav class="navbar">
  <a class="navbar-brand" href="#">Raise<span>IT</span></a>
  <ul class="navbar-links">
    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/complaints">Complaints</a></li>
    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
  </ul>
</nav>

<div class="dashboard-wrapper">
  <aside class="sidebar">
    <ul class="sidebar-menu">
      <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/complaints">Manage Complaints</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/departments">Departments</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/reports">Reports</a></li>
    </ul>
  </aside>

  <main class="main-content">
    <div class="page-header">
      <h2>Welcome, <%= session.getAttribute("userFullName") %></h2>
    </div>

    <div class="stats-grid">
      <div class="stat-card">
        <h3>${totalComplaints}</h3>
        <p>Total Complaints</p>
      </div>
      <div class="stat-card">
        <h3>${pendingComplaints}</h3>
        <p>Pending Review</p>
      </div>
      <div class="stat-card">
        <h3>${inProgressComplaints}</h3>
        <p>In Progress</p>
      </div>
      <div class="stat-card">
        <h3>${resolvedComplaints}</h3>