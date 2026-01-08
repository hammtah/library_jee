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
import jakarta.servlet.http.HttpSession;
@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Book>cartItems = new ArrayList<Book>();
        ArrayList<Book> books = (ArrayList<Book>) request.getServletContext().getAttribute("books");
        for(Book b: books){
          if(request.getSession().getAttribute(b.getIsbn()) != null) {
              cartItems.add(b);
              cartItems.get(cartItems.size()-1).setNb(Integer.parseInt(request.getSession().getAttribute(b.getIsbn()).toString()));
          }
        }
        cartItems.sort((b1, b2)->b2.getNb()-b1.getNb());//Descending order
        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/Cart.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String isbn = request.getParameter("isbn");
        int nb = Integer.parseInt(request.getParameter("nb").toString());
        HttpSession session = request.getSession();
        int oldNb = 0;
        if(session.getAttribute(isbn)!= null) oldNb = Integer.parseInt(session.getAttribute(isbn).toString());
        session.setAttribute(isbn, oldNb + nb);
        response.sendRedirect("book");
    }
}