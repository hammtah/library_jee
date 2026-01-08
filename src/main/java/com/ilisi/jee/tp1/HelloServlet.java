package com.ilisi.jee.tp1;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/first")
public class HelloServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if(request.getAttribute("passed") == null ) {
            request.setAttribute("msg", "Vous êtes dans la servlet principale.");
            request.getRequestDispatcher("/second").forward(request, response);
        }
        else {
            request.setAttribute("msg", request.getAttribute("msg")+"\nDe retour dans la servlet principale.");
        }
        response.getWriter().println(request.getAttribute("msg"));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}