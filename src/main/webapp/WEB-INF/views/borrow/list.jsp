<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%! 
    java.text.SimpleDateFormat _fmt = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String fmt(java.util.Date d){ return d == null ? "" : _fmt.format(d); }
%>
<%
    String ctx = request.getContextPath();
    String error = (String) request.getAttribute("error");
    java.util.Collection<com.ilisi.jee.tp1.beans.Borrow> borrows =
            (java.util.Collection<com.ilisi.jee.tp1.beans.Borrow>) request.getAttribute("borrows");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Borrow Management</title>
    <style>
        body { font-family: system-ui, Arial, sans-serif; margin: 24px; color: #1f2937; }
        header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; }
        .btn { display: inline-block; padding: 8px 14px; border-radius: 8px; text-decoration: none; border: 1px solid #d1d5db; background: #111827; color: #fff; }
        .btn.secondary { background: #fff; color: #111827; }
        .btn.danger { background: #b91c1c; color: #fff; border-color: #b91c1c; }
        .btn.warn { background: #F59E0B; color: #111827; border-color: #D97706; }
        table { border-collapse: collapse; width: 100%; background: #fff; }
        th, td { padding: 10px 12px; border-bottom: 1px solid #e5e7eb; text-align: left; vertical-align: middle; }
        th { background: #f9fafb; font-weight: 600; color: #374151; }
        .status { padding: 2px 8px; border-radius: 9999px; font-size: 12px; display: inline-block; }
        .status.borrowed { background: #dbeafe; color: #1d4ed8; }
        .status.returned { background: #dcfce7; color: #166534; }
        .actions form { display: inline; margin: 0 2px; }
        .error { padding: 10px 12px; background: #fee2e2; border: 1px solid #fecaca; color: #991b1b; border-radius: 8px; margin-bottom: 12px; }
        .empty { padding: 24px; text-align: center; color: #6b7280; }
    </style>
</head>
<body>
<header>
    <h1>Borrow Management</h1>
    <a class="btn" href="<%=ctx%>/borrow?action=new">New Borrow</a>
</header>

<% if (error != null && !error.isBlank()) { %>
    <div class="error"><%= error %></div>
<% } %>

<div class="table">
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Book</th>
            <th>User</th>
            <th>Borrowed At</th>
            <th>Status</th>
            <th>Returned At</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (borrows == null || borrows.isEmpty()) { %>
            <tr><td colspan="7" class="empty">No borrow records found.</td></tr>
        <% } else { 
               for (com.ilisi.jee.tp1.beans.Borrow b : borrows) { %>
            <tr>
                <td><%= b.getBorrowId() %></td>
                <td><%= b.getBook() != null ? b.getBook().getTitle() : ("#" + (b.getBook() != null ? b.getBook().getId() : "")) %></td>
                <td><%= b.getUser() != null ? b.getUser().getName() : ("#" + (b.getUser() != null ? b.getUser().getId() : "")) %></td>
                <td><%= fmt(b.getBorrowDate()) %></td>
                <td>
                    <span class="status <%= (b.getStatus() == null ? "" : b.getStatus()).toLowerCase() %>">
                        <%= b.getStatus() == null ? "borrowed" : b.getStatus() %>
                    </span>
                </td>
                <td><%= fmt(b.getReturnDate()) %></td>
                <td class="actions">
                    <a class="btn secondary" href="<%=ctx%>/borrow?action=edit&id=<%= b.getBorrowId() %>">Edit</a>
                    <% if (!"returned".equalsIgnoreCase(b.getStatus())) { %>
                        <form method="post" action="<%=ctx%>/borrow?action=return" onsubmit="return confirm('Mark as returned?');">
                            <input type="hidden" name="id" value="<%= b.getBorrowId() %>"/>
                            <button class="btn warn" type="submit">Return</button>
                        </form>
                    <% } %>
                    <form method="post" action="<%=ctx%>/borrow?action=delete" onsubmit="return confirm('Delete this record?');">
                        <input type="hidden" name="id" value="<%= b.getBorrowId() %>"/>
                        <button class="btn danger" type="submit">Delete</button>
                    </form>
                </td>
            </tr>
        <%   } 
           } %>
        </tbody>
    </table>
</div>
</body>
</html>
