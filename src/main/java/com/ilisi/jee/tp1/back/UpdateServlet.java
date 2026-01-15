package com.ilisi.jee.tp1.back;

import java.io.IOException;
import java.sql.SQLException;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/update")
public class UpdateServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if(idParam == null) throw new ServletException("Id missing");
        IBookDao bookDao = new BookDao();
        Book b;
        try {
            b = bookDao.get(Integer.parseInt(idParam));
            request.setAttribute("b", b);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        request.getServletContext().getRequestDispatcher("/WEB-INF/UpdateBook.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if(idParam == null || idParam.isEmpty()) throw new ServletException("Id missing");

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
        IBookDao bookDao = new BookDao();
        try {
            bookDao.update(Integer.parseInt(idParam), b);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        response.sendRedirect(request.getContextPath()+ "/book");
    }
}