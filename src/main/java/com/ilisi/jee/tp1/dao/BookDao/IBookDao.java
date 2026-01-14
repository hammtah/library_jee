package com.ilisi.jee.tp1.dao.BookDao;

import com.ilisi.jee.tp1.beans.Book;

import java.sql.SQLException;
import java.util.Collection;

public interface IBookDao {
    public void save(Book b) throws SQLException;
    public Collection<Book> getAll() throws SQLException;
    public Book get(String isbn) throws SQLException;
    public void update(String isbn, Book b) throws SQLException;
}
