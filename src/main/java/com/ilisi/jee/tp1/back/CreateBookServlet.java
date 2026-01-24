package com.ilisi.jee.tp1.back;

import java.io.IOException;
import java.sql.SQLException;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;
import com.ilisi.jee.tp1.exception.Book.BookServiceException;
import com.ilisi.jee.tp1.service.IBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/create")
public class CreateBookServlet extends HttpServlet {
    private IBookService bookService;

    @Override
    public void init() throws ServletException {
        bookService = (IBookService) getServletContext().getAttribute("BookService");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("Create book");
        request.getServletContext().getRequestDispatcher("/WEB-INF/CreateBook.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Book b = new Book(
                    Integer.parseInt(request.getParameter("year")),
                    request.getParameter("isbn"),
                    request.getParameter("genre"),
                    Float.parseFloat(request.getParameter("price")),
                    request.getParameter("description"),
                    request.getParameter("title"),
                    request.getParameter("author"),
                request.getParameter("img"),
                    Integer.parseInt(request.getParameter("stock"))
            );
             bookService.save(b);
        } catch (BookServiceException e) {
            System.out.println(e.getMessage());
            request.setAttribute("error", "Error creating book " );
            request.getServletContext().getRequestDispatcher("/WEB-INF/CreateBook.jsp").forward(request, response);
        }
        response.sendRedirect(request.getContextPath()+ "/book");
    }
}