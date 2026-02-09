<%@ page contentType="text/html; charset=UTF-8" language="java"
        import="java.util.Collection,com.ilisi.jee.tp1.beans.Book,com.ilisi.jee.tp1.beans.User" %>
<%
    String ctx = request.getContextPath();
    String mode = (String) request.getAttribute("mode");
    if (mode == null) mode = "create";
    boolean editing = "edit".equalsIgnoreCase(mode);
    com.ilisi.jee.tp1.beans.Borrow b = (com.ilisi.jee.tp1.beans.Borrow) request.getAttribute("borrow");
    Collection<Book> books = (Collection<Book>) request.getAttribute("books");
    Collection<User> users = (Collection<User>) request.getAttribute("users");
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
    <title><%= pageTitle %> | Library</title>
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

        * { box-sizing: border-box; }

        body {
            font-family: "Lato", "Helvetica Neue", Helvetica, Arial, sans-serif;
            background-color: var(--gr-bg);
            color: var(--gr-text);
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 16px;
        }

        .shell {
            background: #ffffff;
            width: 100%;
            max-width: 640px;
            border: 1px solid var(--gr-border);
            border-radius: 4px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            padding: 24px 28px 28px;
        }

        h1 {
            font-family: 'Merriweather', serif;
            font-size: 22px;
            color: var(--gr-brown);
            margin: 0 0 8px 0;
        }

        .subtitle {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px 16px;
        }

        .form-grid.full {
            grid-template-columns: 1fr;
        }

        .field {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 700;
            font-size: 13px;
            margin-bottom: 5px;
            color: var(--gr-brown);
        }

        input,
        select {
            width: 100%;
            padding: 9px 10px;
            border-radius: 3px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: var(--gr-green);
        }

        .help {
            margin-top: 4px;
            font-size: 12px;
            color: #777;
        }

        .actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn {
            padding: 9px 16px;
            border-radius: 3px;
            border: 1px solid transparent;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-primary {
            background-color: var(--gr-green);
            color: #fff;
            border-color: var(--gr-dark-green);
        }

        .btn-primary:hover {
            background-color: var(--gr-dark-green);
        }

        .btn-secondary {
            background-color: #fff;
            color: #00635d;
            border-color: #ccc;
        }

        .btn-secondary:hover {
            text-decoration: underline;
        }

        @media (max-width: 640px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="shell">
    <h1><%= pageTitle %></h1>
    <div class="subtitle">
        Link a reader to a book and track when it is borrowed and returned.
    </div>

    <form method="post" action="<%= actionUrl %>">
        <% if (editing && b != null) { %>
        <input type="hidden" name="id" value="<%= b.getBorrowId() %>"/>
        <% } %>

        <div class="form-grid">
            <div class="field">
                <label for="bookId">Book</label>
                <select id="bookId" name="bookId" required>
                    <option value="">-- Select a book --</option>
                    <%
                        Integer selectedBookId = (b != null && b.getBook() != null) ? b.getBook().getId() : null;
                        if (books != null) {
                            for (Book book : books) {
                                boolean selected = selectedBookId != null && selectedBookId == book.getId();
                    %>
                    <option value="<%= book.getId() %>" <%= selected ? "selected" : "" %>>
                        <%= book.getTitle() %>
                    </option>
                    <%
                            }
                        }
                    %>
                </select>
                <div class="help">Choose the book by its title (ID is submitted automatically).</div>
            </div>
            <div class="field">
                <label for="userId">User</label>
                <select id="userId" name="userId" required>
                    <option value="">-- Select a user --</option>
                    <%
                        Integer selectedUserId = (b != null && b.getUser() != null) ? b.getUser().getId() : null;
                        if (users != null) {
                            for (User u : users) {
                                boolean selected = selectedUserId != null && selectedUserId == u.getId();
                    %>
                    <option value="<%= u.getId() %>" <%= selected ? "selected" : "" %>>
                        <%= u.getName() %> (<%= u.getCin() %>)
                    </option>
                    <%
                            }
                        }
                    %>
                </select>
                <div class="help">Choose the borrower by name (ID is submitted automatically).</div>
            </div>
        </div>

        <div class="form-grid" style="margin-top: 14px;">
            <div class="field">
                <label for="borrowDate">Borrow Date</label>
                <input id="borrowDate" name="borrowDate" type="datetime-local" value="<%= borrowDateStr %>"/>
                <div class="help">Optional. Leave empty to default to now.</div>
            </div>
            <div class="field">
                <label for="returnDate">Return Date</label>
                <input id="returnDate" name="returnDate" type="datetime-local" value="<%= returnDateStr %>"/>
                <div class="help">Optional. Fill when the book is returned.</div>
            </div>
        </div>

        <div class="form-grid full" style="margin-top: 14px;">
            <div class="field">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <%
                        String status = b != null && b.getStatus() != null ? b.getStatus() : "borrowed";
                    %>
                    <option value="borrowed" <%= "borrowed".equalsIgnoreCase(status) ? "selected" : "" %>>Borrowed</option>
                    <option value="returned" <%= "returned".equalsIgnoreCase(status) ? "selected" : "" %>>Returned</option>
                </select>
                <div class="help">Choose whether the book is currently out or already returned.</div>
            </div>
        </div>

        <div class="actions">
            <a class="btn btn-secondary" href="<%= ctx %>/borrow?action=list">Cancel</a>
            <button class="btn btn-primary" type="submit">
                <%= editing ? "Save changes" : "Create borrow record" %>
            </button>
        </div>
    </form>
</div>
</body>
</html>
