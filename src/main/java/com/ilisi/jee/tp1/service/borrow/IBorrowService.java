package com.ilisi.jee.tp1.service.borrow;

public interface IBorrowService {
        int maxBorrowDays = 7;
        void borrowBook(int userId, int bookId) throws Exception;
        void returnBook(int borrowId) throws Exception;
}
