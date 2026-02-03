<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create User | Goodreads Style</title>
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@700&family=Lato:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --gr-bg: #F4F1EA;
            --gr-brown: #382110;
            --gr-green: #377458;
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

        .container {
            background: #ffffff;
            width: 100%;
            max-width: 400px;
            padding: 30px;
            border: 1px solid var(--gr-border);
            border-radius: 4px;
        }

        h2 {
            font-family: 'Merriweather', serif;
            font-size: 22px;
            color: var(--gr-brown);
            margin-bottom: 20px;
            border-bottom: 1px solid var(--gr-border);
            padding-bottom: 10px;
        }

        /* Error Popup Style from earlier */
        .error-popup {
            background-color: #fff2f2;
            border: 1px solid #d00;
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .error-icon {
            background: #d00;
            color: white;
            border-radius: 50%;
            width: 16px;
            height: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            font-weight: bold;
        }

        .error-popup p {
            margin: 0;
            font-size: 13px;
            color: #333;
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
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .input-field:focus {
            outline: none;
            border-color: var(--gr-green);
        }

        .submit-btn {
            width: 100%;
            background-color: var(--gr-green);
            color: white;
            border: 1px solid var(--gr-dark-green);
            padding: 12px;
            border-radius: 3px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background-color: var(--gr-dark-green);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: #00635d;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Add New User</h2>

    <%-- Error handling --%>
    <c:if test="${not empty error}">
        <div class="error-popup">
            <div class="error-icon">!</div>
            <p>${error}</p>
        </div>
    </c:if>


    <c:if test="${empty user}">
    <form action="${pageContext.request.contextPath}/users" method="POST">
        <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" class="input-field" placeholder="e.g. Jean Doe" required>
        </div>

        <div class="form-group">
            <label for="cin">CIN (ID Card Number)</label>
            <input type="text" id="cin" name="cin" class="input-field" placeholder="e.g. AB123456" required>
        </div>

        <button type="submit" class="submit-btn">Create Account</button>
    </form>
    </c:if>
    <c:if test="${not empty user}">
        <form action="${pageContext.request.contextPath}/users?action=update&id=${user.id}" method="POST">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" class="input-field" placeholder="e.g. Jean Doe" required value="${user.name}">
            </div>

            <div class="form-group">
                <label for="cin">CIN (ID Card Number)</label>
                <input type="text" id="cin" name="cin" class="input-field" placeholder="e.g. AB123456" required value="${user.cin}">
            </div>

            <button type="submit" class="submit-btn">Update</button>
        </form>
    </c:if>
    <a href="${pageContext.request.contextPath}/login" class="back-link">Return to Login</a>
</div>

</body>
</html>