package com.ilisi.jee.tp1.utility;

import java.sql.DriverManager;
import java.sql.SQLException;

public class Connection {
    public static String connectionString = "jdbc:sqlite:aa.sqlite";

    public static java.sql.Connection getConnection() throws SQLException {
        return DriverManager.getConnection(connectionString);
    }
}
