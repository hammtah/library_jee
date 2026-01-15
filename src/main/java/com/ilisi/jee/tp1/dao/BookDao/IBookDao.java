package com.ilisi.jee.tp1.dao.BookDao;

import com.ilisi.jee.tp1.beans.Book;

import java.sql.SQLException;
import java.util.Collection;

public interface IBookDao {
    public void save(Book b) throws SQLException;
    public Collection<Book> getAll() throws SQLException;
    public Book get(int id) throws SQLException;
    public void update(int id, Book b) throws SQLException;
    public void delete(int id) throws SQLException;
}
