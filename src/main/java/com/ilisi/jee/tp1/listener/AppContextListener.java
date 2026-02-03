package com.ilisi.jee.tp1.listener;

import com.ilisi.jee.tp1.dao.AdminDao.AdminDao;
import com.ilisi.jee.tp1.dao.AdminDao.IAdminDao;
import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;
import com.ilisi.jee.tp1.service.admin.AdminService;
import com.ilisi.jee.tp1.service.admin.IAdminService;
import com.ilisi.jee.tp1.service.book.BookService;
import com.ilisi.jee.tp1.service.book.IBookService;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class AppContextListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent sce) {
        IBookDao bookDao = new BookDao();
        IAdminDao adminDao = new AdminDao();
        IBookService bookService = new BookService(bookDao);
        IAdminService adminService = new AdminService(adminDao);
        sce.getServletContext().setAttribute("BookService", bookService);
        sce.getServletContext().setAttribute("AdminService", adminService);
    }
}
