<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Directory | Goodreads Style</title>
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@700&family=Lato:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --gr-bg: #F4F1EA;
            --gr-brown: #382110;
            --gr-green: #377458;
            --gr-text: #333333;
            --gr-border: #D8D8D8;
            --gr-table-header: #f9f7f2;
        }

        body {
            font-family: "Lato", "Helvetica Neue", Helvetica, Arial, sans-serif;
            background-color: var(--gr-bg);
            color: var(--gr-text);
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }

        .list-container {
            background: #ffffff;
            width: 100%;
            max-width: 800px;
            padding: 30px;
            border: 1px solid var(--gr-border);
            border-radius: 4px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 20px;
            border-bottom: 1px solid var(--gr-border);
            padding-bottom: 10px;
        }

        h2 {
            font-family: 'Merriweather', serif;
            font-size: 22px;
            color: var(--gr-brown);
            margin: 0;
        }

        .add-link {
            font-size: 14px;
            color: #00635d;
            text-decoration: none;
            font-weight: bold;
        }

        .add-link:hover {
            text-decoration: underline;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th {
            background-color: var(--gr-table-header);
            font-family: 'Merriweather', serif;
            font-size: 14px;
            color: var(--gr-brown);
            text-align: left;
            padding: 12px;
            border-bottom: 2px solid var(--gr-border);
        }

        td {
            padding: 12px;
            font-size: 14px;
            border-bottom: 1px solid #eee;
        }

        tr:nth-child(even) {
            background-color: #fafafa;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .empty-msg {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }

        .badge {
            font-family: monospace;
            background: #eee;
            padding: 2px 6px;
            border-radius: 3px;
            color: #555;
        }
    </style>
</head>
<body>

<div class="list-container">
    <div class="header-flex">
        <h2>Library Members</h2>
        <a href="${pageContext.request.contextPath}/users?action=form" class="add-link">+ Add New User</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>CIN</th>
            <th>Phone</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%-- Iterating over the 'users' list provided by the request --%>
        <c:forEach items="${users}" var="user">
            <tr>
                <td><strong>${user.name}</strong></td>
                <td><span class="badge">${user.cin}</span></td>
                <td><span class="badge">${user.phone}</span></td>
                <td><a class="badge" href="${pageContext.request.contextPath}/users?action=form&id=${user.id}" style="margin-right:8px">Update</a>
                <a class="badge" href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}" style="margin-right:8px">Delete</a>
                <a class="badge" href="${pageContext.request.contextPath}/users?action=getById&id=${user.id}">Details</a></td>
            </tr>
        </c:forEach>

        <%-- Show message if list is empty --%>
        <c:if test="${empty users}">
            <tr>
                <td colspan="2" class="empty-msg">No users found in the database.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/admin" class="add-link" style="display:block;margin-top:16px;">← Back to Admin Panel</a>
</div>

</body>
</html>