package com.ilisi.jee.tp1.dao.UserDao;

import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.exception.DaoException;
import com.ilisi.jee.tp1.utility.Connection;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

public class UserDao implements IUserDao {

    @Override
    public void save(User u) throws DaoException {
        String sql = "INSERT INTO users (name, cin) VALUES (?, ?);";
        try (var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(sql);
            pst.setString(1, u.getName());
            pst.setString(2, u.getCin());
            pst.executeUpdate();
        } catch (SQLException e) {
            throw new DaoException("Error creating user: ", e);
        }
    }

    @Override
    public Collection<User> getAll() throws DaoException {
        String sql = "SELECT user_id, name, cin FROM users;";
        var resCollection = new ArrayList<User>();
        try (var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(sql);
            var rs = pst.executeQuery();
            while (rs.next()) {
                resCollection.add(new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("cin")
                ));
            }
        } catch (SQLException e) {
            throw new DaoException("Error fetching users: ", e);
        }
        return resCollection;
    }

    @Override
    public User get(int id) throws DaoException {
        String sql = "SELECT user_id, name, cin FROM users WHERE user_id = ?;";
        try (var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            var rs = pst.executeQuery();
            if (!rs.next()) return null;
            return new User(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("cin")
            );
        } catch (SQLException e) {
            throw new DaoException("Error fetching user by id: ", e);
        }
    }

    @Override
    public void update(int id, User u) throws DaoException {
        String sql = "UPDATE users SET name = ?, cin = ? WHERE user_id = ?;";
        try (var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(sql);
            pst.setString(1, u.getName());
            pst.setString(2, u.getCin());
            pst.setInt(3, id);
            pst.executeUpdate();
        } catch (SQLException e) {
            throw new DaoException("Error updating user: ", e);
        }
    }

    @Override
    public void delete(int id) throws DaoException {
        String sql = "DELETE FROM users WHERE user_id = ?;";
        try (var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (SQLException e) {
            throw new DaoException("Error deleting user: ", e);
        }
    }
}
