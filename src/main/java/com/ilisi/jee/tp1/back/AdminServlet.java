package com.ilisi.jee.tp1.back;

import java.io.IOException;
import java.util.Collection;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.exception.Book.BookServiceException;
import com.ilisi.jee.tp1.service.book.IBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private IBookService bookService;

    @Override
    public void init() throws ServletException {
        bookService = (IBookService) getServletContext().getAttribute("BookService");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Collection<Book> books = bookService.getAll();
            request.setAttribute("books", books);
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        } catch (BookServiceException e) {
            System.out.println(e.getMessage());
            request.setAttribute("error", "Error loading books ");
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String isbn = request.getParameter("isbn");
            // TODO: Implement delete functionality when /delete endpoint is available
            request.setAttribute("message", "Delete functionality will be available soon");
        }

        // Redirect back to admin page to refresh the list
        response.sendRedirect(request.getContextPath() + "/admin");
    }
}
