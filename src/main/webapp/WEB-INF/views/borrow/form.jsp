<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
    String mode = (String) request.getAttribute("mode");
    if (mode == null) mode = "create";
    boolean editing = "edit".equalsIgnoreCase(mode);
    com.ilisi.jee.tp1.beans.Borrow b = (com.ilisi.jee.tp1.beans.Borrow) request.getAttribute("borrow");
    String pageTitle = editing ? "Edit Borrow" : "New Borrow";
    String actionUrl = ctx + "/borrow?action=" + (editing ? "update" : "create");
    java.text.SimpleDateFormat iso = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    String borrowDateStr = (b != null && b.getBorrowDate() != null) ? iso.format(b.getBorrowDate()) : "";
    String returnDateStr = (b != null && b.getReturnDate() != null) ? iso.format(b.getReturnDate()) : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= pageTitle %></title>
    <style>
        body { font-family: system-ui, Arial, sans-serif; margin: 24px; color: #1f2937; }
        .card { max-width: 720px; background: #fff; padding: 20px; border: 1px solid #e5e7eb; border-radius: 12px; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        label { font-weight: 600; color: #374151; display: block; margin-bottom: 6px; }
        input, select { width: 100%; padding: 10px 12px; border: 1px solid #d1d5db; border-radius: 8px; }
        .actions { margin-top: 16px; display: flex; gap: 8px; }
        .btn { padding: 10px 14px; border-radius: 8px; border: 1px solid #d1d5db; text-decoration: none; }
        .btn.primary { background: #111827; color: #fff; border-color: #111827; }
        .btn.secondary { background: #fff; color: #111827; }
        .help { color: #6b7280; font-size: 12px; }
    </style>
</head>
<body>
<h1><%= pageTitle %></h1>
<div class="card">
    <form method="post" action="<%= actionUrl %>">
        <% if (editing && b != null) { %>
            <input type="hidden" name="id" value="<%= b.getBorrowId() %>"/>
        <% } %>

        <div class="row">
            <div>
                <label for="bookId">Book ID</label>
                <input id="bookId" name="bookId" type="number" min="1" required value="<%= b != null && b.getBook() != null ? b.getBook().getId() : "" %>"/>
                <div class="help">Specify the book ID.</div>
            </div>
            <div>
                <label for="userId">User ID</label>
                <input id="userId" name="userId" type="number" min="1" required value="<%= b != null && b.getUser() != null ? b.getUser().getId() : "" %>"/>
                <div class="help">Specify the user ID.</div>
            </div>
        </div>

        <div class="row" style="margin-top: 12px;">
            <div>
                <label for="borrowDate">Borrow Date</label>
                <input id="borrowDate" name="borrowDate" type="datetime-local" value="<%= borrowDateStr %>"/>
                <div class="help">Optional. Defaults to now.</div>
            </div>
            <div>
                <label for="returnDate">Return Date</label>
                <input id="returnDate" name="returnDate" type="datetime-local" value="<%= returnDateStr %>"/>
                <div class="help">Optional. Only set if already returned.</div>
            </div>
        </div>

        <div style="margin-top: 12px;">
            <label for="status">Status</label>
            <select id="status" name="status">
                <%
                    String status = b != null && b.getStatus() != null ? b.getStatus() : "borrowed";
                %>
                <option value="borrowed" <%= "borrowed".equalsIgnoreCase(status) ? "selected" : "" %>>Borrowed</option>
                <option value="returned" <%= "returned".equalsIgnoreCase(status) ? "selected" : "" %>>Returned</option>
            </select>
        </div>

        <div class="actions">
            <button class="btn primary" type="submit"><%= editing ? "Update" : "Create" %></button>
            <a class="btn secondary" href="<%= ctx %>/borrow?action=list">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
