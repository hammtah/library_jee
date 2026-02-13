package com.ilisi.jee.tp1.back;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.beans.Borrow;
import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BorrowDao.BorrowDao;
import com.ilisi.jee.tp1.dao.BorrowDao.IBorrowDao;
import com.ilisi.jee.tp1.dao.UserDao.UserDao;
import com.ilisi.jee.tp1.exception.DaoException;
import com.ilisi.jee.tp1.service.IUserService;
import com.ilisi.jee.tp1.service.UserService;
import com.ilisi.jee.tp1.service.book.BookService;
import com.ilisi.jee.tp1.service.book.IBookService;
import com.ilisi.jee.tp1.service.borrow.BorrowService;
import com.ilisi.jee.tp1.service.borrow.IBorrowService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Locale;

@WebServlet(name = "BorrowServlet", urlPatterns = {"/borrow"})
public class BorrowServlet extends HttpServlet {

    private IBorrowService borrowService;
    private IBookService bookService;
    private IUserService userService;
    @Override
    public void init() throws ServletException {
        super.init();
        this.borrowService = new BorrowService(new BookDao(), new BorrowDao(), new UserDao());
        this.bookService = new BookService(new BookDao());
        this.userService = new UserService(new UserDao());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = reqParam(request, "action", "list");

        try {
            // For any view that shows the borrow form we need the list of books and users
            if ("new".equalsIgnoreCase(action) || "edit".equalsIgnoreCase(action)) {
                request.setAttribute("books", bookService.getAll());
                request.setAttribute("users", userService.listUsers());
            }

            switch (action) {
                case "new" -> {
                    request.setAttribute("mode", "create");
                    forward(request, response, "/WEB-INF/views/borrow/form.jsp");
                }
                case "edit" -> {
                    int id = parseIntOrDefault(request.getParameter("id"), -1);
                    if (id <= 0) {
                        request.setAttribute("error", "Invalid borrow id");
                        list(request, response);
                        return;
                    }
//                    Borrow b = borrowService.get(id);
//                    if (b == null) {
//                        request.setAttribute("error", "Borrow not found");
//                        list(request, response);
//                        return;
//                    }
//                    request.setAttribute("borrow", b);
                    request.setAttribute("mode", "edit");
                    forward(request, response, "/WEB-INF/views/borrow/form.jsp");
                }
//                case "list":
                default -> list(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            try {
                list(request, response);
            } catch (DaoException ex) {
                request.setAttribute("error", e.getMessage());
            }
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, DaoException {
        Collection<Borrow> borrows = borrowService.getAll();
        request.setAttribute("borrows", borrows);
        forward(request, response, "/WEB-INF/views/borrow/list.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String action = reqParam(request, "action", "");

        try {
            switch (action) {
                case "create" -> handleCreate(request, response);
                case "update" -> handleUpdate(request, response);
                case "delete" -> handleDelete(request, response);
                case "return" -> handleReturn(request, response);
                default -> response.sendRedirect(request.getContextPath() + "/borrow?action=list");
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            try {
                list(request, response);
            } catch (DaoException ex) {
                throw new ServletException(ex);
            }
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int bookId = parseIntOrDefault(request.getParameter("bookId"), 0);
        int userId = parseIntOrDefault(request.getParameter("userId"), 0);
//        String status = emptyToNull(request.getParameter("status"));
//        Date borrowDate = parseDateOrNull(request.getParameter("borrowDate"));

        borrowService.borrowBook(userId,bookId);
        response.sendRedirect(request.getContextPath() + "/borrow?action=list");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws DaoException, IOException {
        int id = parseIntOrDefault(request.getParameter("id"), -1);
        if (id <= 0) {
            response.sendRedirect(request.getContextPath() + "/borrow?action=list");
            return;
        }
        int bookId = parseIntOrDefault(request.getParameter("bookId"), 0);
        int userId = parseIntOrDefault(request.getParameter("userId"), 0);
        String status = emptyToNull(request.getParameter("status"));
        Date borrowDate = parseDateOrNull(request.getParameter("borrowDate"));
        Date returnDate = parseDateOrNull(request.getParameter("returnDate"));

        Borrow b = new Borrow(
                new Book(bookId),
                new User(userId),
                borrowDate,
                status,
                returnDate
        );
//        borrowDao.update(id, b);
        response.sendRedirect(request.getContextPath() + "/borrow?action=list");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws DaoException, IOException {
        int id = parseIntOrDefault(request.getParameter("id"), -1);
        if (id > 0) {
//            borrowDao.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/borrow?action=list");
    }

    private void handleReturn(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = parseIntOrDefault(request.getParameter("id"), -1);
        if (id > 0) {
            borrowService.returnBook(id);
        }
        response.sendRedirect(request.getContextPath() + "/borrow?action=list");
    }

    private static String reqParam(HttpServletRequest req, String name, String def) {
        String v = req.getParameter(name);
        return v == null || v.isBlank() ? def : v;
    }

    private static int parseIntOrDefault(String s, int def) {
        try {
            return s == null ? def : Integer.parseInt(s.trim());
        } catch (NumberFormatException e) {
            return def;
        }
    }

    private static String emptyToNull(String s) {
        return (s == null || s.isBlank()) ? null : s.trim();
    }

    private static Date parseDateOrNull(String s) {
        if (s == null || s.isBlank()) return null;
        String[] patterns = {
                "yyyy-MM-dd'T'HH:mm",
                "yyyy-MM-dd HH:mm",
                "yyyy-MM-dd"
        };
        for (String p : patterns) {
            try {
                return new SimpleDateFormat(p, Locale.ENGLISH).parse(s.trim());
            } catch (ParseException ignored) {
            }
        }
        return null;
    }

    private static void forward(HttpServletRequest request, HttpServletResponse response, String viewPath) throws ServletException, IOException {
        request.getRequestDispatcher(viewPath).forward(request, response);
    }
}
