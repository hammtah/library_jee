package com.ilisi.jee.tp1.dao.BookDao;


import com.ilisi.jee.tp.beans.Book;
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
                    "img TEXT)";
            stmt.execute(sql);
        } catch (SQLException e) {
            System.err.println("Error initializing database table: " + e.getMessage());
        }

    }
    @Override
    public void save(Book b) throws SQLException {
        var conn = Connection.getConnection();
        var pst = conn.prepareStatement("INSERT INTO books (img, nb, year, isbn, genre, price, description, title, author) \n" +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);");

        pst.setString(1, b.getImg());
        pst.setInt(2, 0);
        pst.setInt(3, b.getYear());
        pst.setString(4, b.getIsbn());
        pst.setString(5, b.getGenre());
        pst.setFloat(6, b.getPrice());
        pst.setString(7, b.getDescription());
        pst.setString(8, b.getTitle());
        pst.setString(9, b.getAuthor());
//        pst.setInt(10, b.getStock());


        pst.executeUpdate();
        conn.close();
    }

    @Override
    public Collection<Book> getAll() throws SQLException {
        ArrayList<Book> books = new ArrayList<>();
        var conn = Connection.getConnection();
        var st = conn.createStatement();
        var res = st.executeQuery("SELECT * FROM books;");
        while(res.next()){
            var book = new Book(
                    res.getInt("year"),
                    res.getString("isbn"),
                    res.getString("genre"),
                    res.getFloat("price"),
                    res.getString("description"),
                    res.getString("title"),
                    res.getString("author"),
                    res.getString("img")
//                    res.getString("stock")
            );
            books.add(book);
        }
        conn.close();

        return books;
    }

    public Book get(String isbn) throws SQLException{
        String getString = "SELECT * FROM books WHERE isbn = ?";
        var conn = Connection.getConnection();
        var pst = conn.prepareStatement(getString);
        pst.setString(1, isbn);
        var res = pst.executeQuery();
        res.next();
        Book b = new Book(
                res.getInt("year"),
                res.getString("isbn"),
                res.getString("genre"),
                res.getFloat("price"),
                res.getString("description"),
                res.getString("title"),
                res.getString("author"),
                res.getString("img")
        );
        conn.close();
        return b;
    }

    public void update(String id, Book b) throws SQLException {
        String updateString = "UPDATE books SET img=?, nb=?, year=?, genre=?, price=?, description=?, title=?, author=? WHERE isbn=?";
        var conn = Connection.getConnection();
        var pst = conn.prepareStatement(updateString);
        pst.setString(1, b.getImg());
        pst.setInt(2, b.getNb());
        pst.setInt(3, b.getYear());
        pst.setString(4, b.getGenre());
        pst.setFloat(5, b.getPrice());
        pst.setString(6, b.getDescription());
        pst.setString(7, b.getTitle());
        pst.setString(8, b.getAuthor());
        pst.setString(9, b.getIsbn());
        pst.executeUpdate();
        conn.close();
    }


}
