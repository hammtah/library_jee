package com.ilisi.jee.tp1.dao.BookDao;


import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.exception.DaoException;
import com.ilisi.jee.tp1.utility.Connection;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

public class BookDao implements IBookDao{

    public BookDao(){
        try (java.sql.Connection conn = com.ilisi.jee.tp1.utility.Connection.getConnection();
             java.sql.Statement stmt = conn.createStatement()) {
            String sql = "CREATE TABLE IF NOT EXISTS BOOKS (" +
                    "nb INTEGER,"+
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "isbn TEXT, " +
                    "title TEXT, " +
                    "author TEXT, " +
                    "genre TEXT, " +
                    "year INTEGER, " +
                    "price REAL, " +
                    "description TEXT, " +
                    "img TEXT," +
                    "stock INTEGER)";
            stmt.execute(sql);
        } catch (SQLException e) {
            System.err.println("Error initializing database table: " + e.getMessage());
        }

    }
    @Override
    public void save(Book b) throws DaoException {
        String saveSql = "INSERT INTO books (img, nb, year, isbn, genre, price, description, title, author, stock) \n" +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        try(var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(saveSql);

            pst.setString(1, b.getImg());
            pst.setInt(2, 0);
            pst.setInt(3, b.getYear());
            pst.setString(4, b.getIsbn());
            pst.setString(5, b.getGenre());
            pst.setFloat(6, b.getPrice());
            pst.setString(7, b.getDescription());
            pst.setString(8, b.getTitle());
            pst.setString(9, b.getAuthor());
            pst.setInt(10, b.getStock());

            pst.executeUpdate();
        }catch (SQLException e){
            throw new DaoException("Error saving book to DB: ", e);
        }
    }

    @Override
    public Collection<Book> getAll() throws DaoException {
        String getSql = "SELECT * FROM books;";
        ArrayList<Book> books = new ArrayList<>();
        try(var conn = Connection.getConnection()) {
            var st = conn.createStatement();
            var res = st.executeQuery(getSql);
            while (res.next()) {
                var book = new Book(
                        res.getInt("year"),
                        res.getString("isbn"),
                        res.getString("genre"),
                        res.getFloat("price"),
                        res.getString("description"),
                        res.getString("title"),
                        res.getString("author"),
                        res.getString("img"),
                        res.getInt("stock")
                );
                book.setId(res.getInt("id"));
                books.add(book);
            }
        }catch(SQLException e){
            throw new DaoException("Error retrieving books from DB: ", e);
        }
        return books;
    }

    public Book get(int id) throws DaoException{
        String getString = "SELECT * FROM books WHERE id = ?";
        Book b;
        try(var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(getString);
            pst.setInt(1, id);
            var res = pst.executeQuery();
            res.next();
            b = new Book(
                    res.getInt("year"),
                    res.getString("isbn"),
                    res.getString("genre"),
                    res.getFloat("price"),
                    res.getString("description"),
                    res.getString("title"),
                    res.getString("author"),
                    res.getString("img"),
                    res.getInt("stock")
            );
            b.setId(res.getInt("id"));
        }catch (SQLException e){
            throw new DaoException("Error retrieving book from DB: ", e);
        }
        return b;
    }

    public void update(int id, Book b) throws DaoException {
        String updateString = "UPDATE books SET img=?, nb=?, year=?, isbn=?, genre=?, price=?, description=?, title=?, author=?, stock=? WHERE id=?";
        try(var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(updateString);
            pst.setString(1, b.getImg());
            pst.setInt(2, b.getNb());
            pst.setInt(3, b.getYear());
            pst.setString(4, b.getIsbn());
            pst.setString(5, b.getGenre());
            pst.setFloat(6, b.getPrice());
            pst.setString(7, b.getDescription());
            pst.setString(8, b.getTitle());
            pst.setString(9, b.getAuthor());
            pst.setInt(10, b.getStock());
            pst.setInt(11, id);
            pst.executeUpdate();
        }catch (SQLException e){
            throw new DaoException("Error updating book to DB", e);
        }
    }

    @Override
    public void delete(int id) throws DaoException {
        String deleteSql = "DELETE FROM books WHERE id = ?";
        try(var conn = Connection.getConnection()) {
            var pst = conn.prepareStatement(deleteSql);
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (SQLException e) {
            throw new DaoException("Error deleting book from DB",e);
        }
    }

}
