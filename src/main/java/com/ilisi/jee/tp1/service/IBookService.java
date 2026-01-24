package com.ilisi.jee.tp1.service;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.exception.Book.BookServiceException;
import com.ilisi.jee.tp1.exception.DaoException;

import java.util.Collection;

public interface IBookService {
    public void save(Book b) throws BookServiceException;
    public Collection<Book> getAll() throws BookServiceException;
    public Book get(int id) throws BookServiceException;
    public void update(int id, Book b) throws BookServiceException;
    public void delete(int id) throws BookServiceException;
}
