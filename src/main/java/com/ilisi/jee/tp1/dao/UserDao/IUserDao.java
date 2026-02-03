package com.ilisi.jee.tp1.dao.UserDao;

import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.exception.DaoException;

import java.util.Collection;

public interface IUserDao {
    void save(User u) throws DaoException;
    Collection<User> getAll() throws DaoException;
    User get(int id) throws DaoException;
    void update(int id, User u) throws DaoException;
    void delete(int id) throws DaoException;
}
