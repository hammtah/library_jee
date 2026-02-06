package com.ilisi.jee.tp1.service.borrow;

import com.ilisi.jee.tp1.beans.Book;
import com.ilisi.jee.tp1.beans.Borrow;
import com.ilisi.jee.tp1.beans.User;
import com.ilisi.jee.tp1.dao.BookDao.IBookDao;
import com.ilisi.jee.tp1.dao.BorrowDao.IBorrowDao;
import com.ilisi.jee.tp1.dao.UserDao.IUserDao;

import java.util.Date;

public class BorrowService implements IBorrowService{
    private IBookDao bookDao;
    private IBorrowDao borrowDao;
    private IUserDao userDao;
    public BorrowService(IBookDao bookDao, IBorrowDao borrowDao, IUserDao userDao){
        this.bookDao = bookDao;
        this.borrowDao = borrowDao;
        this.userDao = userDao;
    }
    public boolean isAvailable(int bookId) throws Exception{
        Book b = bookDao.get(bookId);
        int nbBorrowed = borrowDao.getNotReturnedBorrowsByBookId(bookId).size();
        return b.getStock() > nbBorrowed;
    }
    @Override
    public void borrowBook(int userId, int bookId) throws Exception {
        if(!isAvailable(bookId)) throw new Exception("Book is not available for borrowing");
        borrowDao.save(new Borrow(new Book(bookId), new User(userId), new Date(), "borrowed", null));
    }
    public void returnBook(int borrowId) throws Exception {
        Borrow b = borrowDao.get(borrowId);
        b.setStatus("returned");
        b.setReturnDate(new Date());
        borrowDao.update(borrowId, b);
    }
}
