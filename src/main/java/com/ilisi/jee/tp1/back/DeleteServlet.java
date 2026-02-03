package com.ilisi.jee.tp1.back;

import com.ilisi.jee.tp1.exception.Book.BookServiceException;
import com.ilisi.jee.tp1.service.book.IBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/delete")
public class DeleteServlet extends HttpServlet {
    private IBookService bookService;

    @Override
    public void init() throws ServletException {
        bookService = (IBookService) getServletContext().getAttribute("BookService");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if(idParam == null || idParam.isEmpty()){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing id parameter");
            return;
        }
        try {
            bookService.delete(Integer.parseInt(idParam));
        } catch (BookServiceException e) {
            System.out.println(e.getMessage());
            request.setAttribute("error","Error deleting book");
        }
        response.sendRedirect(request.getContextPath() + "/book");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

