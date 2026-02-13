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
    com.ilisi.jee.tp1.beans.User user = (com.ilisi.jee.tp1.beans.User) request.getAttribute("user");
    java.util.Collection<com.ilisi.jee.tp1.beans.Borrow> borrows =
            (java.util.Collection<com.ilisi.jee.tp1.beans.Borrow>) request.getAttribute("borrows");
    Integer delayedBorrowCount = (Integer) request.getAttribute("delayedBorrowCount");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Details | Library</title>
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
            max-width: 1000px;
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

        .user-summary {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .user-main {
            flex: 1;
        }

        .user-main h2 {
            margin: 0 0 4px 0;
            font-size: 20px;
            color: var(--gr-brown);
        }

        .user-main .cin-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 3px;
            background: #eee;
            font-family: monospace;
            font-size: 13px;
        }

        .user-main .phone-badge {
            display: inline-block;
            margin-top: 6px;
            padding: 2px 8px;
            border-radius: 3px;
            background: #e0f2fe;
            font-family: monospace;
            font-size: 13px;
            color: #0369a1;
        }

        .user-stats {
            text-align: right;
            min-width: 220px;
        }

        .user-stats .stat-label {
            font-size: 12px;
            text-transform: uppercase;
            color: #666;
        }

        .user-stats .stat-value {
            font-size: 18px;
            font-weight: 700;
        }

        .user-stats .delayed {
            color: #b12704;
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
        <h1>User Details</h1>
        <div class="header-actions">
            <a class="btn btn-link" href="<%=ctx%>/users?action=list">← Back to Users</a>
            <a class="btn btn-primary" href="<%=ctx%>/borrow?action=new">Record New Borrow</a>
        </div>
    </header>

    <% if (error != null && !error.isBlank()) { %>
    <div class="error"><%= error %></div>
    <% } %>

    <div class="user-summary">
        <div class="user-main">
            <% if (user != null) { %>
                <h2><%= user.getName() %></h2>
                <div>
                    CIN:
                    <span class="cin-badge"><%= user.getCin() %></span>
                </div>
                <div>
                    Phone:
                    <span class="phone-badge"><%= user.getPhone() %></span>
                </div>
            <% } %>
        </div>
        <div class="user-stats">
            <div>
                <div class="stat-label">Total Borrows</div>
                <div class="stat-value"><%= borrows != null ? borrows.size() : 0 %></div>
            </div>
            <div style="margin-top:8px;">
                <div class="stat-label">Delayed Borrows</div>
                <div class="stat-value delayed">
                    <%= delayedBorrowCount != null ? delayedBorrowCount : 0 %>
                </div>
            </div>
        </div>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Book</th>
                <th>Borrowed At</th>
                <th>Status</th>
                <th>Delay</th>
                <th>Returned At</th>
            </tr>
            </thead>
            <tbody>
            <% if (borrows == null || borrows.isEmpty()) { %>
            <tr><td colspan="6" class="empty">This user has no borrow history.</td></tr>
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
                <td>#<%= b.getBorrowId() %></td>
                <td><%= b.getBook() != null ? b.getBook().getTitle() : ("Book #" + (b.getBook() != null ? b.getBook().getId() : "")) %></td>
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
            </tr>
            <%   }
               } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
