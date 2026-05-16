<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>404 - Page Not Found | RaiseIT</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *{margin:0;padding:0;box-sizing:border-box;}
    :root{
      --indigo:#5b52e8;
      --indigo-dark:#4338ca;
      --indigo-deeper:#2d2780;
      --white:#ffffff;
      --text:#1a1a2e;
      --text-light:#6d6a93;
    }
    body{
      font-family:'DM Sans',sans-serif;
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      background:linear-gradient(145deg,#1e1960 0%,#2d2780 45%,#4c3db8 100%);
      color:var(--white);
      overflow:hidden;
      padding:32px 16px;
    }
    .bg-orb{
      position:absolute;
      width:340px;
      height:340px;
      border-radius:50%;
      background:rgba(91,82,232,0.18);
      filter:blur(6px);
      top:-120px;
      right:-80px;
    }
    .bg-orb.secondary{
      width:260px;
      height:260px;
      bottom:-100px;
      left:-80px;
      top:auto;
      background:rgba(139,92,246,0.2);
    }
    .card{
      position:relative;
      z-index:2;
      width:min(640px, 100%);
      background:rgba(255,255,255,0.1);
      border:1px solid rgba(255,255,255,0.2);
      border-radius:24px;
      padding:48px 40px;
      backdrop-filter:blur(20px);
      box-shadow:0 24px 60px rgba(0,0,0,0.25);
      text-align:center;
    }
    .logo{
      font-family:'Syne',sans-serif;
      font-size:20px;
      font-weight:800;
      letter-spacing:0.5px;
      color:rgba(255,255,255,0.9);
      margin-bottom:18px;
    }
    .logo span{color:#c4bfff;}
    .status{
      font-family:'Syne',sans-serif;
      font-size:clamp(56px,8vw,88px);
      font-weight:800;
      color:#ffffff;
      letter-spacing:-1px;
    }
    .title{
      font-family:'Syne',sans-serif;
      font-size:clamp(22px,3.4vw,30px);
      font-weight:700;
      margin:10px 0 14px;
    }
    .desc{
      color:rgba(255,255,255,0.7);
      font-size:15px;
      line-height:1.7;
      max-width:440px;
      margin:0 auto 28px;
    }
    .actions{
      display:flex;
      gap:12px;
      justify-content:center;
      flex-wrap:wrap;
    }
    .btn-primary{
      padding:12px 24px;
      border:none;
      border-radius:10px;
      background:linear-gradient(135deg,#6c63f5,#8b5cf6);
      color:white;
      font-size:14px;
      font-weight:600;
      text-decoration:none;
      transition:transform 0.2s, box-shadow 0.2s;
      box-shadow:0 10px 24px rgba(108,99,245,0.4);
    }
    .btn-primary:hover{transform:translateY(-1px);box-shadow:0 14px 32px rgba(108,99,245,0.5);}
    .btn-secondary{
      padding:12px 22px;
      border-radius:10px;
      border:1.5px solid rgba(255,255,255,0.35);
      color:white;
      text-decoration:none;
      font-size:14px;
      font-weight:500;
      background:rgba(255,255,255,0.08);
      transition:background 0.2s, border-color 0.2s;
    }
    .btn-secondary:hover{background:rgba(255,255,255,0.16);border-color:rgba(255,255,255,0.55);}
  </style>
</head>
<body>
  <div class="bg-orb"></div>
  <div class="bg-orb secondary"></div>
  <div class="card">
    <div class="logo">Raise<span>IT</span></div>
    <div class="status">404</div>
    <div class="title">Page Not Found</div>
    <p class="desc">The page you requested does not exist or may have been moved. Use the options below to get back on track.</p>
    <div class="actions">
      <a href="${pageContext.request.contextPath}/" class="btn-primary">Back to Home</a>
      <a href="${pageContext.request.contextPath}/login" class="btn-secondary">Go to Login</a>
    </div>
  </div>
</body>
</html>
