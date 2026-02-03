package com.ilisi.jee.tp1.service.user;

import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.dao.UserDao.IUserDao;
import com.ilisi.jee.tp1.exception.DaoException;
import com.ilisi.jee.tp1.exception.User.UserServiceException;

import java.util.Collection;
import java.util.Objects;

public class UserService implements IUserService {

    private final IUserDao userDao;

    public UserService(IUserDao userDao) {
        this.userDao = Objects.requireNonNull(userDao, "userDao must not be null");
    }

    @Override
    public void addUser(User u) throws UserServiceException {
        try {
            userDao.save(u);
        } catch (DaoException e) {
            throw new UserServiceException("Failed to add user", e);
        }
    }

    @Override
    public Collection<User> listUsers() throws UserServiceException {
        try {
            return userDao.getAll();
        } catch (DaoException e) {
            throw new UserServiceException("Failed to list users", e);
        }
    }

    @Override
    public void deleteUser(int id) throws UserServiceException {
        try {
            userDao.delete(id);
        } catch (DaoException e) {
            throw new UserServiceException("Failed to delete user", e);
        }
    }

    @Override
    public void updateUser(int id, User u) throws UserServiceException {
        try {
            userDao.update(id, u);
        } catch (DaoException e) {
            throw new UserServiceException("Failed to update user", e);
        }
    }

    @Override
    public User getUserById(int id) throws UserServiceException {
        try {
            return userDao.get(id);
        } catch (DaoException e) {
            throw new UserServiceException("Failed to get user by id", e);
        }
    }
}
