package com.ilisi.jee.tp1.filters;

import com.ilisi.jee.tp1.utility.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin", "/create", "/update", "/delete"})
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        boolean loggedIn = SessionUtil.getAdmin(request) != null;

        if (loggedIn) {
            chain.doFilter(req, res); // allow
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
