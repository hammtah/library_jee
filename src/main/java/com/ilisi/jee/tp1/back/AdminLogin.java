package com.ilisi.jee.tp1.back;

import java.io.IOException;

import com.ilisi.jee.tp1.beans.Admin;
import com.ilisi.jee.tp1.service.admin.IAdminService;
import com.ilisi.jee.tp1.service.book.IBookService;
import com.ilisi.jee.tp1.utility.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class AdminLogin extends HttpServlet {
    private IAdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = (IAdminService) getServletContext().getAttribute("AdminService");
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        try {
//            adminService.addAdmin("taha", "taha");
//            adminService.addAdmin("admin", "admin");
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//            throw new RuntimeException(e);
//        }
            if(SessionUtil.getAdmin(request) != null){
                response.sendRedirect(request.getContextPath() + "/admin");
            }
            request.getServletContext().getRequestDispatcher("/WEB-INF/admin/AdminLogin.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            Admin admin = adminService.login(username, password);
            SessionUtil.saveAdmin(request, admin);
            response.sendRedirect(request.getContextPath() + "/admin");
        } catch (Exception e) {
            request.setAttribute("error", "Invalid username or password");
            request.getServletContext().getRequestDispatcher("/WEB-INF/admin/AdminLogin.jsp").forward(request, response);
        }
    }
}