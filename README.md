# Demo — Book Store Web Application

A Java EE (Jakarta EE) web application for managing books, users, borrows, and admin operations. Built as a servlet-based MVC project with SQLite persistence.

## Features

- **Books**: Browse, view details, create, update, and delete books
- **Users**: User list, details, and forms
- **Admin**: Admin login and logout with session management
- **Borrow / Cart**: Borrow management and shopping cart
- **Chat**: Real-time chat via `/chat`
- **Localization**: French (fr) and English (us) via context parameter

## Tech Stack

- **Java 25** with **Maven**
- **Jakarta Servlet 6**, **JSP/JSTL**
- **Jakarta MVC**
- **SQLite** (JDBC) for persistence
- **jBCrypt** for password hashing
- **Jackson** for JSON

## Project Structure

```
src/main/
├── java/com/ilisi/jee/tp1/
│   ├── back/           # Servlets (Book, User, Admin, Chat, Borrow, Cart, etc.)
│   ├── beans/          # Domain models (Book, User, Admin, Borrow)
│   ├── dao/            # Data access (BookDao, UserDao, AdminDao, BorrowDao)
│   ├── service/        # Business logic (Book, User, Admin, Borrow services)
│   ├── filters/        # Auth filter
│   ├── listener/       # AppContextListener (service wiring)
│   ├── utility/        # Session, DB connection
│   ├── validation/     # Input validation
│   └── exception/      # Custom exceptions
└── webapp/
    ├── WEB-INF/        # JSPs, web.xml
    │   ├── admin/      # Admin login view
    │   ├── user/       # User views
    │   └── views/borrow/
    ├── Books.jsp       # Book list
    ├── Cart.jsp
    ├── admin.jsp
    └── index.jsp
```

## Requirements

- **JDK 25** (or compatible)
- **Maven 3.6+**

## Build & Run

### Build the WAR

```bash
mvn clean package
```

The WAR file is generated in `target/demo-1.0-SNAPSHOT.war`.

### Deploy

Deploy the WAR to a Jakarta EE 6–compatible servlet container (e.g. Tomcat 10+, Jetty 11+). The app uses:

- **SQLite**: ensure the database file (e.g. `identifier.sqlite`) is writable by the server or configure its path in your code/config.
- **Context parameter `lang`**: set in `web.xml` (e.g. `fr` or `us`) for UI language.

### Default entry

The welcome file is `/book`, so the app opens on the book list.

## Main Endpoints

| Path      | Description        |
|----------|--------------------|
| `/book`  | Book list / details (with `?isbn=...`) |
| `/chat`  | Chat               |
| Admin and other servlets are mapped in `WEB-INF/web.xml`. |

## Configuration

- **Language**: In `web.xml`, `<context-param>` `lang` — `fr` or `us`.
- **Database**: SQLite JDBC URL and path are defined in the DAO/connection utility (e.g. `identifier.sqlite` in the project).

## License

Project for educational use (JEE TP1).
