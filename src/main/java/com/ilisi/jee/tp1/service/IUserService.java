package com.ilisi.jee.tp1.service;

import com.ilisi.jee.tp1.beans.User;

import java.util.Collection;

public interface IUserService {
    void addUser(User u) throws Exception;
    Collection<User> listUsers() throws Exception;
    void deleteUser(int id) throws Exception;
    void updateUser(int id, User u) throws Exception;
    User getUserById(int id) throws Exception;
}
