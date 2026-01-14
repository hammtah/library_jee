package com.ilisi.jee.tp1.controller;


import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;

import java.sql.SQLException;
import java.util.Collection;

public class BookController {
    IBookDao bookDao;
    public BookController(){
        bookDao = new BookDao();
    }
    public void addBook(int year, String isbn, String genre, float price, String description, String title, String author, String img) throws SQLException {
        Book b = new Book(year, isbn, genre, price, description, title, author, img) ;
        new BookDao().save(b);
    }

    public Collection<Book> getAllBooks() throws SQLException {
        return bookDao.getAll();
    }
}
