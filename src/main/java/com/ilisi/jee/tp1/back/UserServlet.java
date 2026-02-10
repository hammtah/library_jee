package com.ilisi.jee.tp1.back;

import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.dao.UserDao.UserDao;
import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BorrowDao.BorrowDao;
import com.ilisi.jee.tp1.exception.DaoException;
import com.ilisi.jee.tp1.service.borrow.BorrowService;
import com.ilisi.jee.tp1.service.borrow.IBorrowService;
import com.ilisi.jee.tp1.service.user.IUserService;
import com.ilisi.jee.tp1.service.user.UserService;
import com.ilisi.jee.tp1.exception.User.UserServiceException;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "UserServlet", urlPatterns = {"/users"})
public class UserServlet extends HttpServlet {

    private static final String USER_SERVICE_CTX_KEY = "UserService";

    private IUserService userService;
    private IBorrowService borrowService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext ctx = config.getServletContext();
        Object svc = ctx.getAttribute(USER_SERVICE_CTX_KEY);
        if (svc instanceof IUserService) {
            this.userService = (IUserService) svc;
        } else {
            this.userService = new UserService(new UserDao());
            ctx.setAttribute(USER_SERVICE_CTX_KEY, this.userService);
        }
        this.borrowService = new BorrowService(new BookDao(), new BorrowDao(), new UserDao());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "getById": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    var user = userService.getUserById(id);
                    req.setAttribute("user", user);
                    var borrows = borrowService.getByUserId(id);
                    int delayedCount = borrowService.countDelayedBorrowsByUser(id);
                    req.setAttribute("borrows", borrows);
                    req.setAttribute("delayedBorrowCount", delayedCount);
                    req.getRequestDispatcher("/WEB-INF/user/UserDetails.jsp").forward(req, resp);
                    break;
                }
                case "form": {
                    String idStr = req.getParameter("id");
                    if (idStr != null) {
                        int id = Integer.parseInt(idStr);
                        var user = userService.getUserById(id);
                        req.setAttribute("user", user);
                    }
                    req.getRequestDispatcher("/WEB-INF/user/UserForm.jsp").forward(req, resp);
                    break;
                }
                case "delete": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    userService.deleteUser(id);
                    resp.sendRedirect(req.getContextPath()+"/users");
                    break;
                }
                case "update": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    var user = userService.getUserById(id);
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/WEB-INF/user/UserForm.jsp").forward(req, resp);
                    break;
                }
                case "list":
                default: {
                    var users = userService.listUsers();
                    req.setAttribute("users", users);
                    req.getRequestDispatcher("/WEB-INF/user/UserList.jsp").forward(req, resp);
                    break;
                }
            }
        } catch (UserServiceException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/user/UserList.jsp").forward(req, resp);
        } catch (DaoException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/user/UserList.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid or missing numeric id");
            req.getRequestDispatcher("/WEB-INF/user/UserList.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        if (action == null) action = "add";

        try {
            switch (action) {
                case "update": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    User u = readUserFromRequest(req);
                    userService.updateUser(id, u);
                    break;
                }
                case "delete": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    userService.deleteUser(id);
                    break;
                }
                case "add":
                default: {
                    User u = readUserFromRequest(req);
                    userService.addUser(u);
                    break;
                }
            }
            resp.sendRedirect(req.getContextPath() + "/users?action=list");
        } catch (UserServiceException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/user/UserForm.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid or missing numeric id");
            req.getRequestDispatcher("/WEB-INF/user/UserForm.jsp").forward(req, resp);
        }catch(Exception e){
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/user/UserForm.jsp").forward(req, resp);

        }
    }

    private User readUserFromRequest(HttpServletRequest req) throws Exception{
        String name = req.getParameter("name").trim();
        String cin = req.getParameter("cin").trim();
        if(name.isEmpty() || cin.isEmpty()) throw new Exception("Name and Cin should not be empty");
        return new User(name, cin);
        }
}
