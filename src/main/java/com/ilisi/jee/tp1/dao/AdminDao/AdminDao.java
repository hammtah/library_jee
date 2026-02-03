package com.ilisi.jee.tp1.dao.AdminDao;

import com.ilisi.jee.tp1.beans.Admin;
import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.exception.DaoException;
import com.ilisi.jee.tp1.utility.Connection;

import java.sql.SQLException;

public class AdminDao implements IAdminDao{
    public Admin findByUserName(String username)  throws DaoException{
        String getString = "SELECT * FROM admin WHERE username = ?";
        Admin admin;
        try(var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(getString);
            pst.setString(1, username);
            var res = pst.executeQuery();
            res.next();
            admin = new Admin(
                    res.getInt("admin_id"),
                    res.getString("username"),
                    res.getString("password_hash")
            );
        }catch (SQLException e){
            throw new DaoException("Error finding admin: ", e);
        }
        return admin;
    }
    public void createAdmin(String username, String passwordHash) throws DaoException{
        String insertString = "INSERT INTO admin (username, password_hash) VALUES (?, ?);";
        try(var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(insertString);
            pst.setString(1, username);
            pst.setString(2, passwordHash);
            pst.executeUpdate();
        }catch (SQLException e){
            throw new DaoException("Error creating admin: ", e);
        }
    }
}
