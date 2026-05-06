<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    String rememberedEmail = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("rememberedEmail")) {
                rememberedEmail = cookie.getValue();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-card">
        <div class="auth-header">
            <h1>Raise<span>IT</span></h1>
            <p>Sign in to your account</p>
        </div>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="<%= rememberedEmail %>" placeholder="Enter your email" required/>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required/>
            </div>
            <div class="form-group checkbox-group">
                <input type="checkbox" name="rememberMe" id="rememberMe">
                <label for="rememberMe">Remember Me</label>
            </div>
            <button type="submit" class="btn-primary">Sign In</button>
        </form>
        <div class="auth-footer">
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register Here</a></p>
        </div>
    </div>
</div>
</body>
</html>