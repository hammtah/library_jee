package com.ilisi.jee.tp1;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.ilisi.jee.tp.beans.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/book")
public class BookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> books = new ArrayList<Book>();
        BooksGenerator.generateBooks(books);
        request.getServletContext().setAttribute("books", books);
        request.getRequestDispatcher("/Books.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}