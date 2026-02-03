package com.ilisi.jee.tp1.back;

import java.io.IOException;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.exception.Book.BookServiceException;
import com.ilisi.jee.tp1.exception.ValidationException;
import com.ilisi.jee.tp1.service.book.IBookService;
import com.ilisi.jee.tp1.validation.BookInputValidator;
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
        String titleStr = request.getParameter("title");
        String authorStr = request.getParameter("author");
        String priceStr = request.getParameter("price");
        String yearStr = request.getParameter("year");
        String stockStr = request.getParameter("stock");
        String isbnStr = request.getParameter("isbn");
        String imgStr = request.getParameter("img");
        String descriptionStr = request.getParameter("description");
        String genreStr = request.getParameter("genre");
        String driveUrlStr = request.getParameter("driveUrl");

        try {
            BookInputValidator.validateCreate(titleStr, authorStr, priceStr, yearStr, stockStr, isbnStr);
            Book b = new Book(
                    Integer.parseInt(yearStr),
                    isbnStr,
                    genreStr,
                    Float.parseFloat(priceStr),
                    descriptionStr,
                    titleStr,
                    authorStr,
                    imgStr,
                    Integer.parseInt(stockStr),
                    driveUrlStr != null && !driveUrlStr.trim().isEmpty() ? driveUrlStr.trim() : null
            );
             bookService.save(b);
        } catch (BookServiceException e) {
            System.out.println(e.getMessage());
            request.setAttribute("error", "Error creating book");
            request.getServletContext().getRequestDispatcher("/WEB-INF/CreateBook.jsp").forward(request, response);
        }catch (ValidationException ve){
            System.out.println(ve.getMessage());
            request.setAttribute("error",ve.getMessage());
            request.getServletContext().getRequestDispatcher("/WEB-INF/CreateBook.jsp").forward(request, response);
        }
        response.sendRedirect(request.getContextPath()+ "/book");
    }
}