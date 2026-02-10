package com.ilisi.jee.tp1.service.book;


import com.ilisi.jee.tp1.beans.Book;
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
    public boolean isDelayed(com.ilisi.jee.tp1.beans.Borrow b) {
        if (b == null || b.getBorrowDate() == null) return false;
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(b.getBorrowDate());
        cal.add(java.util.Calendar.DAY_OF_YEAR, com.ilisi.jee.tp1.service.borrow.IBorrowService.maxBorrowDays);
        java.util.Date due = cal.getTime();
        if(b.getReturnDate() != null){
            return b.getReturnDate().after(due);
        } else {
            java.util.Date now = new java.util.Date();
            return now.after(due);
        }
    }
}
