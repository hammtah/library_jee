package com.ilisi.jee.tp1.dao.BorrowDao;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.beans.Borrow;
import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.exception.DaoException;
import com.ilisi.jee.tp1.utility.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

public class BorrowDao implements IBorrowDao {

    @Override
    public void save(Borrow b) throws DaoException {
        // If borrow_date is null we set it to now so we don't override the DB default with NULL
        // If status is null we default to 'borrowed' (as per schema default)
        String sql = "INSERT INTO borrow (book_id, user_id, borrow_date, status, return_date) VALUES (?, ?, ?, ?, ?);";
        try (var conn = Connection.getConnection();
             var ps = conn.prepareStatement(sql)) {
            if (b.getBook() == null || b.getUser() == null) {
                throw new DaoException("Borrow must reference a non-null Book and User", null);
            }
            ps.setInt(1, b.getBook().getId());
            ps.setInt(2, b.getUser().getId());

            Date bd = b.getBorrowDate() != null ? b.getBorrowDate() : new Date();
            ps.setTimestamp(3, new Timestamp(bd.getTime()));

            String status = b.getStatus() != null ? b.getStatus() : "borrowed";
            ps.setString(4, status);

            setTimestampOrNull(ps, 5, b.getReturnDate());

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DaoException("Error saving borrow record: ", e);
        }
    }

    @Override
    public Collection<Borrow> getAll() throws DaoException {
        String sql = """
            SELECT 
                b.borrow_id, b.book_id, b.user_id, b.borrow_date, b.status, b.return_date,
                bk.id AS bk_id, bk.img, bk.nb, bk.year, bk.isbn, bk.genre, bk.price, bk.description, bk.title, bk.author, bk.stock, bk.drive_url,
                u.user_id AS u_id, u.name, u.cin
            FROM borrow b
            JOIN books bk ON b.book_id = bk.id
            JOIN users u ON b.user_id = u.user_id
            ORDER BY b.borrow_date DESC
        """;

        var result = new ArrayList<Borrow>();
        try (var conn = Connection.getConnection();
             var ps = conn.prepareStatement(sql);
             var rs = ps.executeQuery()) {
            while (rs.next()) {
                result.add(mapBorrow(rs));
            }
        } catch (SQLException e) {
            throw new DaoException("Error retrieving borrow list: ", e);
        }
        return result;
    }

    @Override
    public Borrow get(int id) throws DaoException {
        String sql = """
            SELECT 
                b.borrow_id, b.book_id, b.user_id, b.borrow_date, b.status, b.return_date,
                bk.id AS bk_id, bk.img, bk.nb, bk.year, bk.isbn, bk.genre, bk.price, bk.description, bk.title, bk.author, bk.stock, bk.drive_url,
                u.user_id AS u_id, u.name, u.cin
            FROM borrow b
            JOIN books bk ON b.book_id = bk.id
            JOIN users u ON b.user_id = u.user_id
            WHERE b.borrow_id = ?
        """;
        try (var conn = Connection.getConnection();
             var ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (var rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return mapBorrow(rs);
            }
        } catch (SQLException e) {
            throw new DaoException("Error retrieving borrow by id: ", e);
        }
    }

    @Override
    public void update(int id, Borrow b) throws DaoException {
        String sql = "UPDATE borrow SET book_id = ?, user_id = ?, borrow_date = ?, status = ?, return_date = ? WHERE borrow_id = ?;";
        try (var conn = Connection.getConnection();
             var ps = conn.prepareStatement(sql)) {
            if (b.getBook() == null || b.getUser() == null) {
                throw new DaoException("Borrow must reference a non-null Book and User", null);
            }
            ps.setInt(1, b.getBook().getId());
            ps.setInt(2, b.getUser().getId());
            if (b.getBorrowDate() == null) {
                // Preserve existing timestamp if caller didn't provide a value
                // but since we can't read it easily here, we set current time to avoid NULL
                ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            } else {
                ps.setTimestamp(3, new Timestamp(b.getBorrowDate().getTime()));
            }
            ps.setString(4, b.getStatus() != null ? b.getStatus() : "borrowed");
            setTimestampOrNull(ps, 5, b.getReturnDate());
            ps.setInt(6, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DaoException("Error updating borrow record: ", e);
        }
    }

    @Override
    public void delete(int id) throws DaoException {
        String sql = "DELETE FROM borrow WHERE borrow_id = ?;";
        try (var conn = Connection.getConnection();
             var ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DaoException("Error deleting borrow record: ", e);
        }
    }

    private static void setTimestampOrNull(PreparedStatement ps, int index, Date value) throws SQLException {
        if (value == null) {
            ps.setNull(index, Types.TIMESTAMP);
        } else {
            ps.setTimestamp(index, new Timestamp(value.getTime()));
        }
    }

    private static Borrow mapBorrow(ResultSet rs) throws SQLException {
        // Map Book
        Book book = new Book(
                rs.getInt("year"),
                rs.getString("isbn"),
                rs.getString("genre"),
                rs.getFloat("price"),
                rs.getString("description"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("img"),
                rs.getInt("stock"),
                rs.getString("drive_url")
        );
        book.setId(rs.getInt("bk_id"));

        // Map User
        User user = new User(
                rs.getInt("u_id"),
                rs.getString("name"),
                rs.getString("cin")
        );

        // Map Borrow
        Timestamp bd = rs.getTimestamp("borrow_date");
        Timestamp rd = rs.getTimestamp("return_date");
        return new Borrow(
                rs.getInt("borrow_id"),
                book,
                user,
                bd != null ? new Date(bd.getTime()) : null,
                rs.getString("status"),
                rd != null ? new Date(rd.getTime()) : null
        );
    }
}
