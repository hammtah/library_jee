package com.ilisi.jee.tp1.service;


import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.dao.BookDao.BookDao;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;
import com.ilisi.jee.tp1.exception.Book.BookServiceException;
import com.ilisi.jee.tp1.exception.DaoException;
import java.util.Collection;

public class BookService implements IBookService{
    IBookDao bookDao;
    public BookService(IBookDao ibookDao){
        bookDao = ibookDao;
    }
    public void save(Book b) throws BookServiceException{
        try{
            bookDao.save(b);
        } catch (DaoException e) {
            System.out.println(e.getMessage());
            throw new BookServiceException("Cannot save book");
        }
    }
    public Collection<Book> getAll() throws BookServiceException{
        try{
            return bookDao.getAll();
        } catch (DaoException e) {
            System.out.println(e.getMessage());
            throw new BookServiceException("Cannot retrieve books");
        }
    }
    public Book get(int id) throws BookServiceException{
        try{
            return bookDao.get(id);
        } catch (DaoException e) {
            System.out.println(e.getMessage());
            throw new BookServiceException("Cannot retrieve book");
        }
    }
    public void update(int id, Book b) throws BookServiceException{
        try{
            bookDao.update(id, b);
        } catch (DaoException e) {
            System.out.println(e.getMessage());
            throw new BookServiceException("Cannot update book");
        }
    }
    public void delete(int id) throws BookServiceException{
        try{
            bookDao.delete(id);
        } catch (DaoException e) {
            System.out.println(e.getMessage());
            throw new BookServiceException("Cannot delete book");
        }
    }
}
