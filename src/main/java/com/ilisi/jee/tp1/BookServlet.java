package com.ilisi.jee.tp1;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.ilisi.jee.tp.beans.Book;
import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/book")
public class BookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        var lang = request.getServletContext().getInitParameter("lang");
        String title = "";
        switch (lang){
            case "us":
                title = "Buy your preferred book :)";
                break;
            case "fr":
                title = "Acheter vos livres préferés :)";
                break;
        }
        request.setAttribute("title", title);
        //        List<Book> books = new ArrayList<Book>();
//        BooksGenerator.generateBooks(books);
        var isbn = request.getParameter("isbn");
        if(isbn != null && (Integer.parseInt(isbn) > 0) ){
            request.getServletContext().getRequestDispatcher("/WEB-INF/BookDetails.jsp").forward(request, response);
        }
        IBookDao bookDao = new BookDao();
        Collection<Book> books = null;
        try {
            books = bookDao.getAll();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        request.getServletContext().setAttribute("books", books);
        request.getRequestDispatcher("/Books.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}