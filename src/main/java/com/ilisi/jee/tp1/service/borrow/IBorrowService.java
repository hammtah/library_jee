package com.ilisi.jee.tp1.service.borrow;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.beans.Borrow;
import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.exception.DaoException;

import java.util.Collection;

public interface IBorrowService {
        int maxBorrowDays = 7;
        void borrowBook(int userId, int bookId) throws Exception;
        void returnBook(int borrowId) throws Exception;
    void save(Borrow b) throws DaoException;
    Collection<Borrow> getAll() throws DaoException;
    Collection<Book> getAllBooks() throws DaoException;
    Collection<User> getAllUsers() throws DaoException;
//    Borrow get(int id) throws DaoException;
//    void update(int id, Borrow b) throws DaoException;
//    void delete(int id) throws DaoException;
}
