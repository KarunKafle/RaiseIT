<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ - RaiseIT</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .faq-card {
            background: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 18px;
            margin-bottom: 14px;
        }
        .faq-q {
            font-weight: 700;
            margin-bottom: 8px;
        }
        .faq-a {
            color: var(--text-light);
            line-height: 1.6;
        }
        .faq-actions {
            margin-top: 12px;
        }
        .wishlist-card {
            background: #f8fafc;
            border: 1px dashed var(--border);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 20px;
        }
        .wishlist-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            padding: 8px 0;
            border-bottom: 1px solid var(--border);
        }
        .wishlist-item:last-child { border-bottom: none; }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-brand">RaiseIT</div>
        <nav>
            <c:choose>
                <c:when test="${sessionScope.userRole == 'student'}">
                    <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/student/complaints">My Complaints</a>
                    <a href="${pageContext.request.contextPath}/student/submit">Submit Complaint</a>
                    <a href="${pageContext.request.contextPath}/faq" class="active">FAQ</a>
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/about">About</a>
                    <a href="${pageContext.request.contextPath}/contact">Contact</a>
                    <a href="${pageContext.request.contextPath}/faq" class="active">FAQ</a>
                    <a href="${pageContext.request.contextPath}/login">Login</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
    <div class="main-content">
        <div class="page-header">
            <h1>Frequently Asked Questions</h1>
        </div>

        <c:if test="${sessionScope.userRole == 'student'}">
            <div class="wishlist-card">
                <h2 style="font-size:1rem; margin-bottom: 10px;">Saved FAQs</h2>
                <c:choose>
                    <c:when test="${empty wishlist}">
                        <p style="color: var(--text-light);">No saved questions yet.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="q" items="${wishlist}">
                            <div class="wishlist-item">
                                <span>${q}</span>
                                <form method="post" action="${pageContext.request.contextPath}/faq" style="margin:0;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="question" value="${q}">
                                    <button type="submit" class="btn-delete">Remove</button>
                                </form>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <div class="faq-card">
            <div class="faq-q">How do I register an account?</div>
            <div class="faq-a">Click Register on the login page and fill in your details. After admin approval, you can log in and submit complaints.</div>
            <c:if test="${sessionScope.userRole == 'student'}">
                <div class="faq-actions">
                    <form method="post" action="${pageContext.request.contextPath}/faq">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="question" value="How do I register an account?">
                        <button type="submit" class="btn-secondary">Save</button>
                    </form>
                </div>
            </c:if>
        </div>

        <div class="faq-card">
            <div class="faq-q">How do I submit a complaint?</div>
            <div class="faq-a">Go to Submit Complaint, choose a category and priority, and describe the issue. You will receive a reference number.</div>
            <c:if test="${sessionScope.userRole == 'student'}">
                <div class="faq-actions">
                    <form method="post" action="${pageContext.request.contextPath}/faq">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="question" value="How do I submit a complaint?">
                        <button type="submit" class="btn-secondary">Save</button>
                    </form>
                </div>
            </c:if>
        </div>

        <div class="faq-card">
            <div class="faq-q">What do the complaint statuses mean?</div>
            <div class="faq-a">Submitted = received, Assigned = sent to staff, In Progress = being handled, Resolved = resolved, Closed = finalized.</div>
            <c:if test="${sessionScope.userRole == 'student'}">
                <div class="faq-actions">
                    <form method="post" action="${pageContext.request.contextPath}/faq">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="question" value="What do the complaint statuses mean?">
                        <button type="submit" class="btn-secondary">Save</button>
                    </form>
                </div>
            </c:if>
        </div>

        <div class="faq-card">
            <div class="faq-q">Can I submit a complaint anonymously?</div>
            <div class="faq-a">Yes. Select the anonymous option while submitting your complaint. Staff will not see your identity.</div>
            <c:if test="${sessionScope.userRole == 'student'}">
                <div class="faq-actions">
                    <form method="post" action="${pageContext.request.contextPath}/faq">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="question" value="Can I submit a complaint anonymously?">
                        <button type="submit" class="btn-secondary">Save</button>
                    </form>
                </div>
            </c:if>
        </div>

        <div class="faq-card">
            <div class="faq-q">How do I communicate with staff about my complaint?</div>
            <div class="faq-a">Open your complaint thread and use the reply box to send a message to the assigned staff member.</div>
            <c:if test="${sessionScope.userRole == 'student'}">
                <div class="faq-actions">
                    <form method="post" action="${pageContext.request.contextPath}/faq">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="question" value="How do I communicate with staff about my complaint?">
                        <button type="submit" class="btn-secondary">Save</button>
                    </form>
                </div>
            </c:if>
        </div>

        <div class="faq-card">
            <div class="faq-q">How do I leave feedback after resolution?</div>
            <div class="faq-a">Once your complaint is resolved, click Leave Feedback in your complaint list or thread to rate the resolution.</div>
            <c:if test="${sessionScope.userRole == 'student'}">
                <div class="faq-actions">
                    <form method="post" action="${pageContext.request.contextPath}/faq">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="question" value="How do I leave feedback after resolution?">
                        <button type="submit" class="btn-secondary">Save</button>
                    </form>
                </div>
            </c:if>
        </div>

        <div class="faq-card">
            <div class="faq-q">Why can't I log in?</div>
            <div class="faq-a">If your account is pending approval or suspended, you cannot log in. Contact admin if needed.</div>
            <c:if test="${sessionScope.userRole == 'student'}">
                <div class="faq-actions">
                    <form method="post" action="${pageContext.request.contextPath}/faq">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="question" value="Why can't I log in?">
                        <button type="submit" class="btn-secondary">Save</button>
                    </form>
                </div>
            </c:if>
        </div>

        <div class="faq-card">
            <div class="faq-q">Who do I contact for technical support?</div>
            <div class="faq-a">Use the Contact page to send a message and the support team will respond.</div>
            <c:if test="${sessionScope.userRole == 'student'}">
                <div class="faq-actions">
                    <form method="post" action="${pageContext.request.contextPath}/faq">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="question" value="Who do I contact for technical support?">
                        <button type="submit" class="btn-secondary">Save</button>
                    </form>
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
