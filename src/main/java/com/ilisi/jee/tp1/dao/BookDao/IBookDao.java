package com.ilisi.jee.tp1.dao.BookDao;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.exception.DaoException;

import java.util.Collection;

public interface IBookDao {
    public void save(Book b) throws DaoException;
    public Collection<Book> getAll() throws DaoException;
    public Book get(int id) throws DaoException;
    public void update(int id, Book b) throws DaoException;
    public void delete(int id) throws DaoException;
}
