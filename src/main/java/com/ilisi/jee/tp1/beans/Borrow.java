package com.ilisi.jee.tp1.beans;

import java.util.Date;

public class Borrow {
    private int borrowId;
    private Book book;
    private User user;
    private Date borrowDate;
    private String status;
    private Date returnDate;
    public Borrow() {}

    public Borrow(int borrowId, Book book, User user, Date borrowDate, String status, Date returnDate) {
        this.borrowId = borrowId;
        this.book = book;
        this.user = user;
        this.borrowDate = borrowDate;
        this.status = status;
        this.returnDate = returnDate;
    }

    public Borrow(Book book, User user, Date borrowDate, String status, Date returnDate) {
        this.book = book;
        this.user = user;
        this.borrowDate = borrowDate;
        this.status = status;
        this.returnDate = returnDate;
    }

    public int getBorrowId() {
        return borrowId;
    }

    public void setBorrowId(int borrowId) {
        this.borrowId = borrowId;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }
}
