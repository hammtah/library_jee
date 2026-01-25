package com.ilisi.jee.tp1.validation;

import com.ilisi.jee.tp1.exception.ValidationException;

public class BookInputValidator {
    public static void isValidTitle(String title) throws ValidationException{
        if( title == null || title.trim().isEmpty() || title.length() > 100)
            throw new ValidationException("Invalid Title");
    }

    public static void isValidAuthor(String author) throws ValidationException{
        if( author == null || author.trim().isEmpty() || author.length() > 100)
            throw new ValidationException("Invalid Author");
    }

    public static void isValidPrice(String priceStr) throws ValidationException{
        try {
            double price = Double.parseDouble(priceStr);
            if(price < 0)
                throw new ValidationException("Price should be greater than 0");
        } catch (NumberFormatException e) {
            throw new ValidationException("Invalid Price");
        }
    }
    public static void isValidYear(String yearStr) throws ValidationException{
        try {
            int year = Integer.parseInt(yearStr);
            if(year <= 0 || year > java.time.Year.now().getValue())
                throw new ValidationException("Invalid Year");
        } catch (NumberFormatException e) {
            throw new ValidationException("Invalid Year");
        }
    }
    public static void isValidStock(String stockStr) throws ValidationException{
        try {
            int stock = Integer.parseInt(stockStr);
            if( stock < 0)
            throw new ValidationException("Stock must be greater or equal to 0");
        } catch (NumberFormatException e) {
            throw new ValidationException("Invalid Stock");
        }
    }
    public static void isValidIsbn(String isbn) throws ValidationException{
        if(isbn == null || isbn.trim().isEmpty() || isbn.length() > 20)
            throw new ValidationException("Invalid Isbn");
    }
    public static void validateCreate(String title, String author, String priceStr, String yearStr, String stockStr, String isbn) throws ValidationException{
        isValidTitle(title) ;
        isValidAuthor(author) ;
        isValidPrice(priceStr) ;
        isValidYear(yearStr) ;
        isValidStock(stockStr) ;
        isValidIsbn(isbn);
    }
}
