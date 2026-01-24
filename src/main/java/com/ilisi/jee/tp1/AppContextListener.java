package com.ilisi.jee.tp1;

import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;
import com.ilisi.jee.tp1.service.BookService;
import com.ilisi.jee.tp1.service.IBookService;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class AppContextListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent sce) {
        IBookDao bookDao = new BookDao();
        IBookService bookService = new BookService(bookDao);
        sce.getServletContext().setAttribute("BookService", bookService);
    }
}
