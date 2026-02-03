package com.ilisi.jee.tp1.dao.AdminDao;

import com.ilisi.jee.tp1.beans.Admin;
import com.ilisi.jee.tp1.exception.DaoException;

public interface IAdminDao {
    public Admin findByUserName(String username) throws DaoException;
    public void createAdmin(String username, String passwordHash) throws DaoException;
}
