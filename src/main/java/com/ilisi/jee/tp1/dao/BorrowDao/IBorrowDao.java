package com.ilisi.jee.tp1.dao.BorrowDao;

import com.ilisi.jee.tp1.beans.Borrow;
import com.ilisi.jee.tp1.exception.DaoException;

import java.util.Collection;

public interface IBorrowDao {
    void save(Borrow b) throws DaoException;
    Collection<Borrow> getAll() throws DaoException;
    Borrow get(int id) throws DaoException;
    void update(int id, Borrow b) throws DaoException;
    void delete(int id) throws DaoException;
    Collection<Borrow> getNotReturnedBorrowsByBookId(int bookId) throws DaoException;
    Collection<Borrow> getByUserId(int userId) throws DaoException;
}
