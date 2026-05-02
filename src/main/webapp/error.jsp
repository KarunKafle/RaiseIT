<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-card">
        <div class="auth-header">
            <h1>Raise<span>IT</span></h1>
            <p>Something went wrong</p>
        </div>
        <div class="alert alert-error">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "An unexpected error occurred." %>
        </div>
        <a href="${pageContext.request.contextPath}/login" class="btn-primary" style="text-align:center; display:block;">Go Back to Login</a>
    </div>
</div>
</body>
</html>