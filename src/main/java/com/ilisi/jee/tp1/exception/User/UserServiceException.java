package com.ilisi.jee.tp1.exception.User;

public class UserServiceException extends RuntimeException {
    public UserServiceException(String message, Throwable cause) {
        super(message, cause);
    }
    public UserServiceException(String message) {
        super(message);
    }
}
