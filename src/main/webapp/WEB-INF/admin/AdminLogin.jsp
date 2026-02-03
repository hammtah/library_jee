<%--
  Created by IntelliJ IDEA.
  User: taha
  Date: 2/3/26
  Time: 10:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | Goodreads</title>
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@700&family=Lato:wght@400;700&display=swap" rel="stylesheet">
    <style>
        /* Goodreads Aesthetic Variables */
        :root {
            --gr-bg: #F4F1EA;       /* The iconic tan background */
            --gr-brown: #382110;    /* Header text */
            --gr-green: #377458;    /* Primary button */
            --gr-dark-green: #2b5a44;
            --gr-text: #333333;
            --gr-border: #D8D8D8;
        }

        body {
            font-family: "Lato", "Helvetica Neue", Helvetica, Arial, sans-serif;
            background-color: var(--gr-bg);
            color: var(--gr-text);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-card {
            background: #ffffff;
            width: 100%;
            max-width: 350px;
            padding: 25px 30px;
            border: 1px solid var(--gr-border);
            border-radius: 4px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .login-header h2 {
            font-family: 'Merriweather', serif;
            font-size: 20px;
            color: var(--gr-brown);
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: 700;
            font-size: 13px;
            margin-bottom: 5px;
        }

        .input-field {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 14px;
            box-sizing: border-box; /* Ensures padding doesn't break width */
        }

        .input-field:focus {
            outline: none;
            border-color: #999;
            box-shadow: 0 0 4px rgba(0,0,0,0.1);
        }

        /* Password Toggle Styling */
        .password-container {
            position: relative;
        }

        .toggle-btn {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            font-size: 11px;
            color: #00635d;
            cursor: pointer;
            text-transform: uppercase;
            font-weight: bold;
        }

        /* The Button */
        .login-btn {
            width: 100%;
            background-color: var(--gr-green);
            color: white;
            border: 1px solid var(--gr-dark-green);
            padding: 10px;
            border-radius: 3px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 5px;
        }

        .login-btn:hover {
            background-color: var(--gr-dark-green);
        }

        .signup-footer {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eeeeee;
            text-align: center;
            font-size: 14px;
        }

        .signup-footer a {
            color: #00635d;
            text-decoration: none;
        }

        .signup-footer a:hover {
            text-decoration: underline;
        }
        .error-popup {
            background-color: #fff2f2;
            border: 1px solid #d00;
            border-radius: 4px;
            padding: 12px;
            margin-bottom: 20px;
            animation: fadeIn 0.3s ease-in;
        }

        .error-content {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .error-icon {
            background: #d00;
            color: white;
            font-weight: bold;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            flex-shrink: 0;
        }

        .error-popup p {
            color: #333;
            font-size: 13px;
            margin: 0;
            font-weight: 400;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-5px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <h2>Sign in to Goodreads</h2>
    </div>
    <%-- Check if the 'error' attribute exists in the request/session --%>
    <c:if test="${not empty error}">
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <span class="error-icon">!</span>
                <p>${error}</p>
            </div>
        </div>
    </c:if>
    <form action="login" method="POST">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" class="input-field" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <div class="password-container">
                <input type="password" id="password" name="password" class="input-field" required>
                <button type="button" class="toggle-btn" id="passwordToggle">Show</button>
            </div>
        </div>

        <button type="submit" class="login-btn">Sign in</button>
    </form>

    <div class="signup-footer">
        Not a member? <a href="signup.jsp">Sign up</a>
    </div>
</div>

<script>
    const passwordToggle = document.getElementById('passwordToggle');
    const passwordInput = document.getElementById('password');

    passwordToggle.addEventListener('click', () => {
        const isPassword = passwordInput.type === 'password';
        passwordInput.type = isPassword ? 'text' : 'password';
        passwordToggle.textContent = isPassword ? 'Hide' : 'Show';
    });
</script>
</body>
</html>