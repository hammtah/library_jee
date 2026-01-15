package com.ilisi.jee.tp1.back;

import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete")
public class DeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String isbn = request.getParameter("isbn");
        if(isbn == null || isbn.isEmpty()){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing isbn parameter");
            return;
        }
        IBookDao bookDao = new BookDao();
        try {
            bookDao.delete(isbn);
        } catch (SQLException e) {
            throw new ServletException("Error deleting book: " + e.getMessage(), e);
        }
        response.sendRedirect(request.getContextPath() + "/book");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

