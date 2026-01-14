<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Navigation • Library</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        :root {
            --bg: #F4F1EA;
            --surface: #ffffff;
            --surface-muted: #EEEAE2;
            --text: #382110;
            --text-muted: #636363;
            --text-light: #666666;
            --border: #DCD6CC;
            --primary: #382110;
            --primary-hover: #58371F;
            --focus: #8B7355;
            --danger: #dc2626;
            --shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 4px 12px rgba(0, 0, 0, 0.15);
            --radius: 8px;
            --radius-sm: 6px;
        }

        * { box-sizing: border-box; }
        html, body { height: 100%; }
        body {
            margin: 0;
            font-family: "Merriweather", Georgia, "Times New Roman", serif;
            color: var(--text);
            background-color: var(--bg);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 24px 16px 60px;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .page-header {
            position: sticky;
            top: 0;
            z-index: 1000;
            background: var(--bg);
            padding: 24px 0 16px;
            border-bottom: 2px solid var(--border);
        }
        .page-header-inner {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
        }
        .page-title {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .page-title h1 {
            margin: 0;
            font-size: 32px;
            font-weight: bold;
            color: var(--text);
            text-align: center;
        }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            width: 100%;
            max-width: 480px;
            text-align: center;
        }

        .navigation-content {
            padding: 48px 32px;
        }

        .navigation-title {
            font-size: 24px;
            font-weight: bold;
            color: var(--text);
            margin-bottom: 16px;
        }

        .navigation-subtitle {
            font-size: 16px;
            color: var(--text-muted);
            margin-bottom: 40px;
            line-height: 1.5;
        }

        .navigation-options {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .nav-button {
            appearance: none;
            border: 2px solid var(--border);
            background: var(--surface);
            color: var(--text);
            padding: 20px 24px;
            border-radius: var(--radius);
            font-weight: bold;
            cursor: pointer;
            transition: all .3s ease;
            font-family: inherit;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
            font-size: 18px;
            min-height: 80px;
            position: relative;
            overflow: hidden;
        }

        .nav-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .nav-button:hover::before {
            left: 100%;
        }

        .nav-button:hover { 
            box-shadow: var(--shadow-hover); 
            transform: translateY(-2px);
            background-color: var(--surface-muted);
            border-color: var(--focus);
        }

        .nav-button:focus-visible { 
            outline: 2px solid var(--focus); 
            outline-offset: 2px; 
        }

        .nav-button.admin {
            background: linear-gradient(135deg, var(--primary), var(--primary-hover));
            color: white;
            border-color: var(--primary);
        }

        .nav-button.admin:hover { 
            background: linear-gradient(135deg, var(--primary-hover), #4A3D28); 
            border-color: var(--primary-hover);
            transform: translateY(-3px);
        }

        .nav-button.home {
            background: linear-gradient(135deg, var(--surface), var(--surface-muted));
            border-color: var(--border);
        }

        .nav-button.home:hover {
            background: linear-gradient(135deg, var(--surface-muted), #E8E4DC);
        }

        .nav-icon {
            width: 28px;
            height: 28px;
            flex-shrink: 0;
        }

        .nav-text {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 4px;
        }

        .nav-main {
            font-size: 18px;
            font-weight: bold;
        }

        .nav-sub {
            font-size: 14px;
            opacity: 0.8;
            font-weight: normal;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .container {
                padding: 16px;
            }
            .navigation-content {
                padding: 32px 24px;
            }
            .nav-button {
                font-size: 16px;
                padding: 18px 20px;
                min-height: 70px;
            }
            .nav-icon {
                width: 24px;
                height: 24px;
            }
            .nav-main {
                font-size: 16px;
            }
            .nav-sub {
                font-size: 13px;
            }
        }

        @media (max-width: 480px) {
            .navigation-options {
                gap: 16px;
            }
            .nav-button {
                flex-direction: column;
                text-align: center;
                gap: 12px;
                padding: 24px 16px;
            }
            .nav-text {
                align-items: center;
            }
        }
    </style>
</head>
<body>
<header class="page-header">
    <div class="page-header-inner">
        <div class="page-title">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20"/>
                <path d="M9 10h6"/>
                <path d="M9 14h6"/>
            </svg>
            <h1>Library System</h1>
        </div>
    </div>
</header>

<main class="container">
    <div class="card">
        <div class="navigation-content">
            <h2 class="navigation-title">Welcome to the Library</h2>
            <p class="navigation-subtitle">Choose your destination to continue exploring our digital library system</p>

            <div class="navigation-options">
                <a href="${pageContext.request.contextPath}/admin.jsp" class="nav-button admin">
                    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z"/>
                        <path d="M9 12l2 2 4-4"/>
                    </svg>
                    <div class="nav-text">
                        <span class="nav-main">Admin Panel</span>
                        <span class="nav-sub">Manage books, users, and system settings</span>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/book" class="nav-button home">
                    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                        <polyline points="9,22 9,12 15,12 15,22"/>
                    </svg>
                    <div class="nav-text">
                        <span class="nav-main">Home Page</span>
                        <span class="nav-sub">Browse books and explore the catalog</span>
                    </div>
                </a>
            </div>
        </div>
    </div>
</main>

</body>
</html>
