<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ilisi.jee.tp1.service.book.BookService" %>
<%@ page import="com.ilisi.jee.tp1.beans.Book" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.ilisi.jee.tp1.service.book.BookService" %>
<%
//    BookService bookService = new BookService();
//    Collection<Book> books = null;
//    try {
//        books = bookService.getAllBooks();
//    } catch (SQLException e) {
//        e.printStackTrace();
//    }
    Collection<Book> books = (Collection<Book>) request.getAttribute("books");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel • Library</title>
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
            --admin: #2563eb;
            --admin-hover: #1d4ed8;
            --success: #059669;
            --success-hover: #047857;
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
            /*max-width: 800px;*/
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
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
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
        .breadcrumb {
            font-size: 14px;
            color: var(--text-muted);
            font-style: italic;
        }
        .actions {
            display: flex;
            gap: 12px;
        }
        .btn {
            appearance: none;
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            padding: 8px 16px;
            border-radius: var(--radius-sm);
            font-weight: bold;
            cursor: pointer;
            transition: all .2s ease;
            font-family: inherit;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }
        .btn:hover { 
            box-shadow: var(--shadow-hover); 
            transform: translateY(-1px);
            background-color: var(--surface-muted);
        }
        .btn:focus-visible { 
            outline: 2px solid var(--focus); 
            outline-offset: 2px; 
        }
        .btn.secondary {
            background: var(--surface-muted);
            border-color: var(--border);
        }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            width: 100%;
            /*max-width: 600px;*/
            text-align: center;
        }

        .admin-content {
            padding: 48px 32px;
        }

        .admin-title {
            font-size: 28px;
            font-weight: bold;
            color: var(--text);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .admin-subtitle {
            font-size: 16px;
            color: var(--text-muted);
            margin-bottom: 40px;
            line-height: 1.5;
        }

        .create-book-section {
            margin-bottom: 32px;
            display: flex;
            justify-content: center;
        }

        .create-button {
            appearance: none;
            border: 2px solid var(--success);
            background: linear-gradient(135deg, var(--success), var(--success-hover));
            color: white;
            padding: 8px 16px;
            border-radius: var(--radius);
            font-weight: bold;
            cursor: pointer;
            transition: all .3s ease;
            font-family: inherit;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
            position: relative;
            overflow: hidden;
            display: flex;
            width: max-content;
            margin-bottom: 1em;
            margin-left: auto;
        }

        .create-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.6s;
        }

        .create-button:hover::before {
            left: 100%;
        }

        .create-button:hover { 
            background: linear-gradient(135deg, var(--success-hover), #065f46); 
            box-shadow: var(--shadow-hover); 
            transform: translateY(-2px);
        }

        .books-table-container {
            width: 100%;
            overflow-x: auto;
            border-radius: var(--radius);
            border: 1px solid var(--border);
            background: var(--surface);
        }

        .books-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        .books-table th,
        .books-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }

        .books-table th {
            background: var(--surface-muted);
            font-weight: bold;
            color: var(--text);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .books-table tr:hover {
            background: var(--bg);
        }

        .books-table tr:last-child td {
            border-bottom: none;
        }

        .book-cover {
            width: 40px;
            height: 60px;
            object-fit: cover;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border);
        }

        .book-title {
            font-weight: bold;
            color: var(--text);
            margin-bottom: 4px;
        }

        .book-author {
            color: var(--text-muted);
            font-style: italic;
            font-size: 12px;
        }

        .book-actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 6px 12px;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            text-decoration: none;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            transition: all .2s ease;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .action-btn.edit {
            background: var(--admin);
            color: white;
            border-color: var(--admin);
        }

        .action-btn.edit:hover {
            background: var(--admin-hover);
            transform: translateY(-1px);
        }

        .action-btn.delete {
            background: #dc2626;
            color: white;
            border-color: #dc2626;
        }

        .action-btn.delete:hover {
            background: #b91c1c;
            transform: translateY(-1px);
        }

        .no-books {
            text-align: center;
            padding: 48px 24px;
            color: var(--text-muted);
        }

        .no-books-icon {
            width: 64px;
            height: 64px;
            margin: 0 auto 16px;
            opacity: 0.5;
        }

        .book-price {
            font-weight: bold;
            color: var(--success);
        }

        .book-stock {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: bold;
        }

        .book-stock.in-stock {
            background: #dcfce7;
            color: #166534;
        }

        .book-stock.low-stock {
            background: #fef3c7;
            color: #92400e;
        }

        .book-stock.out-of-stock {
            background: #fee2e2;
            color: #991b1b;
        }

        @media (max-width: 768px) {
            .container {
                padding: 16px;
            }
            .admin-content {
                padding: 32px 24px;
            }
            .admin-options {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            .admin-button {
                min-height: 160px;
                padding: 28px 20px;
            }
            .admin-icon {
                width: 40px;
                height: 40px;
            }
            .admin-main {
                font-size: 17px;
            }
            .admin-sub {
                font-size: 13px;
            }
            .page-header-inner {
                flex-direction: column;
                align-items: stretch;
                text-align: center;
            }
            .actions {
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .admin-button {
                min-height: 140px;
                padding: 24px 16px;
            }
            .admin-title {
                font-size: 24px;
                flex-direction: column;
                gap: 8px;
            }
        }
    </style>
</head>
<body>
<header class="page-header">
    <div class="page-header-inner">
        <div class="page-title">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z"/>
                <path d="M9 12l2 2 4-4"/>
            </svg>
            <h1>Admin Panel</h1>
        </div>
        <div class="breadcrumb">Library System › Administration</div>
        <div class="actions">
            <a href="${pageContext.request.contextPath}/book" class="btn secondary">← Back to Navigation</a>
        </div>
    </div>
</header>

<main class="container">
    <div class="card">
        <div class="admin-content">
<%--            <h2 class="admin-title">--%>
<%--                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">--%>
<%--                    <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z"/>--%>
<%--                    <path d="M9 12l2 2 4-4"/>--%>
<%--                </svg>--%>
<%--                Book Management--%>
<%--            </h2>--%>
<%--            <p class="admin-subtitle">Manage your library's book collection</p>--%>

<%--            <div class="create-book-section">--%>
                <a href="${pageContext.request.contextPath}/create" class="create-button">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M12 5v14"/>
                        <path d="M5 12h14"/>
                    </svg>
                    Create New Book
                </a>
<%--            </div>--%>

            <%
                if (books != null && !books.isEmpty()) {
            %>
            <div class="books-table-container">
                <table class="books-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cover</th>
                            <th>Title & Author</th>
                            <th>ISBN</th>
                            <th>Genre</th>
                            <th>Year</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Book book : books) {
                                String stockClass = "";
                                if (book.getStock() == 0) {
                                    stockClass = "out-of-stock";
                                } else if (book.getStock() < 5) {
                                    stockClass = "low-stock";
                                } else {
                                    stockClass = "in-stock";
                                }
                        %>
                        <tr>
                            <td><strong><%= book.getId() %></strong></td>
                            <td>
                                <img src="<%= book.getImg() != null ? book.getImg() : "/images/placeholder-book.png" %>" 
                                     alt="<%= book.getTitle() %>" 
                                     class="book-cover"
                                     >
                            </td>
                            <td>
                                <div class="book-title"><%= book.getTitle() %></div>
                                <div class="book-author">by <%= book.getAuthor() %></div>
                            </td>
                            <td><%= book.getIsbn() %></td>
                            <td><%= book.getGenre() %></td>
                            <td><%= book.getYear() %></td>
                            <td class="book-price">$<%= String.format("%.2f", book.getPrice()) %></td>
                            <td>
                                <span class="book-stock <%= stockClass %>">
                                    <%= book.getStock() %> 
                                    <%= book.getStock() == 1 ? "copy" : "copies" %>
                                </span>
                            </td>
                            <td>
                                <div class="book-actions">
                                    <a href="${pageContext.request.contextPath}/update?id=<%= book.getId() %>" class="action-btn edit">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                                        </svg>
                                        Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/delete?id=<%= book.getId() %>"
                                       class="action-btn delete"
                                       onclick="return confirm('Are you sure you want to delete this book?')">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="3,6 5,6 21,6"/>
                                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
                                            <line x1="10" y1="11" x2="10" y2="17"/>
                                            <line x1="14" y1="11" x2="14" y2="17"/>
                                        </svg>
                                        Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
                } else {
            %>
            <div class="no-books">
                <svg class="no-books-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20"/>
                    <path d="M16 8V6H8v2"/>
                    <path d="M8 18h8"/>
                </svg>
                <h3>No Books Found</h3>
                <p>There are no books in the library yet. Click "Create New Book" to add your first book.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
</main>

</body>
</html>
