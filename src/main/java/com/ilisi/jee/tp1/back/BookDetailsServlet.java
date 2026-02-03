package com.ilisi.jee.tp1.back;

import java.io.IOException;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.exception.Book.BookServiceException;
import com.ilisi.jee.tp1.service.book.IBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/details")
public class BookDetailsServlet extends HttpServlet {
    private IBookService bookService;

    @Override
    public void init() {
        bookService = (IBookService) getServletContext().getAttribute("BookService");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing id parameter");
            return;
        }
        try {
            Book b = bookService.get(Integer.parseInt(idParam));
            if (b == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
                return;
            }
            request.setAttribute("b", b);
        } catch (BookServiceException e) {
            request.setAttribute("error", "Error loading book: " + e.getMessage());
        }
        request.getServletContext().getRequestDispatcher("/WEB-INF/BookDetails.jsp").forward(request, response);
    }
}
