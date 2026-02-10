<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%! 
    java.text.SimpleDateFormat _fmt = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String fmt(java.util.Date d){ return d == null ? "" : _fmt.format(d); }
    boolean isDelayed(com.ilisi.jee.tp1.beans.Borrow b) {
        if (b == null || b.getBorrowDate() == null) return false;
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(b.getBorrowDate());
        cal.add(java.util.Calendar.DAY_OF_YEAR, com.ilisi.jee.tp1.service.borrow.IBorrowService.maxBorrowDays);
        java.util.Date due = cal.getTime();
        if(b.getReturnDate() != null){
            return b.getReturnDate().after(due);
        } else {
            java.util.Date now = new java.util.Date();
            return now.after(due);
        }
    }
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
    <title>Borrow Management | Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@700&family=Lato:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --gr-bg: #F4F1EA;
            --gr-brown: #382110;
            --gr-green: #377458;
            --gr-dark-green: #2b5a44;
            --gr-text: #333333;
            --gr-border: #D8D8D8;
            --gr-table-header: #f9f7f2;
            --badge-blue: #2563eb;
            --badge-blue-bg: #dbeafe;
            --badge-green: #15803d;
            --badge-green-bg: #dcfce7;
            --badge-gray: #4b5563;
            --badge-gray-bg: #e5e7eb;
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
            /*max-width: 960px;*/
            max-width: 1100px;
            border: 1px solid var(--gr-border);
            border-radius: 4px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            padding: 24px 28px 28px;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            border-bottom: 1px solid var(--gr-border);
            padding-bottom: 12px;
        }

        h1 {
            font-family: 'Merriweather', serif;
            font-size: 22px;
            color: var(--gr-brown);
            margin: 0;
        }

        .header-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .btn {
            display: inline-block;
            padding: 8px 14px;
            border-radius: 3px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            border: 1px solid transparent;
        }

        .btn-primary {
            background-color: var(--gr-green);
            color: #fff;
            border-color: var(--gr-dark-green);
        }

        .btn-primary:hover {
            background-color: var(--gr-dark-green);
        }

        .btn-link {
            background: transparent;
            color: #00635d;
            border-color: transparent;
        }

        .btn-link:hover {
            text-decoration: underline;
        }

        .error {
            background-color: #fff2f2;
            border: 1px solid #d00;
            border-radius: 4px;
            padding: 10px 12px;
            margin-bottom: 16px;
            font-size: 13px;
        }

        .table-wrapper {
            margin-top: 8px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 4px;
        }

        th {
            background-color: var(--gr-table-header);
            font-family: 'Merriweather', serif;
            font-size: 14px;
            color: var(--gr-brown);
            text-align: left;
            padding: 10px 12px;
            border-bottom: 2px solid var(--gr-border);
            white-space: nowrap;
        }

        td {
            padding: 10px 12px;
            font-size: 14px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        tr:nth-child(even) {
            background-color: #fafafa;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .status-pill {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 700;
        }

        .status-borrowed {
            background-color: var(--badge-blue-bg);
            color: var(--badge-blue);
        }

        .status-returned {
            background-color: var(--badge-green-bg);
            color: var(--badge-green);
        }

        .status-unknown {
            background-color: var(--badge-gray-bg);
            color: var(--badge-gray);
        }

        .inline-actions form {
            display: inline;
            margin: 0 2px;
        }

        .inline-link {
            font-size: 13px;
            color: #00635d;
            text-decoration: none;
            margin-right: 6px;
        }

        .inline-link:hover {
            text-decoration: underline;
        }

        .danger-link {
            color: #b12704;
        }

        .empty {
            text-align: center;
            padding: 28px 8px;
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
<div class="shell">
    <header>
        <h1>Borrow Management</h1>
        <div class="header-actions">
            <a class="btn btn-link" href="<%=ctx%>/admin">← Back to Admin Panel</a>
            <a class="btn btn-primary" href="<%=ctx%>/borrow?action=new">Record New Borrow</a>
        </div>
    </header>

    <% if (error != null && !error.isBlank()) { %>
    <div class="error"><%= error %></div>
    <% } %>

    <div class="table-wrapper">
        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Book</th>
                <th>User</th>
                <th>Borrowed At</th>
                <th>Status</th>
                <th>Delay</th>
                <th>Returned At</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (borrows == null || borrows.isEmpty()) { %>
            <tr><td colspan="7" class="empty">No borrow records found.</td></tr>
            <% } else {
                for (com.ilisi.jee.tp1.beans.Borrow b : borrows) {
                    String status = "unknown";
                       if(b.getBorrowDate() != null){
                           status = "borrowed";
                       }
                       if(b.getReturnDate() != null){
                           status = "returned";
                       }
                       String css;
                       if ("returned".equalsIgnoreCase(status)) {
                           css = "status-returned";
                       } else if ("borrowed".equalsIgnoreCase(status)) {
                           css = "status-borrowed";
                       } else {
                           css = "status-unknown";
                       }
            %>
            <tr>
                <td><span class="badge">#<%= b.getBorrowId() %></span></td>
                <td><%= b.getBook() != null ? b.getBook().getTitle() : ("Book #" + (b.getBook() != null ? b.getBook().getId() : "")) %></td>
                <td><%= b.getUser() != null ? b.getUser().getName() : ("User #" + (b.getUser() != null ? b.getUser().getId() : "")) %></td>
                <td><%= fmt(b.getBorrowDate()) %></td>
                <td>
                    <span class="status-pill <%= css %>">
                        <%= status %>
                    </span>
                </td>
                <td>
                    <% if (isDelayed(b)) { %>
                        <span style="color:#b12704;font-weight:700;">Delayed</span>
                    <% } else if(!"returned".equalsIgnoreCase(status)){ %>
                        <span style="color:#4b5563;font-size:12px;">...</span>
                    <% } else{ %>
                        <span style="color:#25ac37;font-size:12px;">On Time</span>
                    <% } %>
                </td>
                <td><%= fmt(b.getReturnDate()) %></td>
                <td class="inline-actions">
<%--                    <a class="inline-link" href="<%=ctx%>/borrow?action=edit&id=<%= b.getBorrowId() %>">Edit</a>--%>
                    <% if (!"returned".equalsIgnoreCase(status)) { %>
                    <form method="post" action="<%=ctx%>/borrow?action=return" onsubmit="return confirm('Mark this borrow as returned?');">
                        <input type="hidden" name="id" value="<%= b.getBorrowId() %>"/>
                        <button type="submit" class="inline-link" style="background:none;border:none;padding:0;">Mark returned</button>
                    </form>
                    <% } %>
<%--                    <form method="post" action="<%=ctx%>/borrow?action=delete" onsubmit="return confirm('Delete this borrow record?');">--%>
<%--                        <input type="hidden" name="id" value="<%= b.getBorrowId() %>"/>--%>
<%--                        <button type="submit" class="inline-link danger-link" style="background:none;border:none;padding:0;">Delete</button>--%>
<%--                    </form>--%>
                </td>
            </tr>
            <%   }
               } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
