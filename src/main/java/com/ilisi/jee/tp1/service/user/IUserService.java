package com.ilisi.jee.tp1.service.user;

import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.exception.User.UserServiceException;

import java.util.Collection;

public interface IUserService {
    void addUser(User u) throws UserServiceException;
    Collection<User> listUsers() throws UserServiceException;
    void deleteUser(int id) throws UserServiceException;
    void updateUser(int id, User u) throws UserServiceException;
    User getUserById(int id) throws UserServiceException;
}
