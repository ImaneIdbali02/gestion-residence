package com.imane.residence.gestion_residence.exceptions;

public class InvalidDataException extends RuntimeException{
    public InvalidDataException(String message) {
        super(message);
    }

    public InvalidDataException(String message, Throwable cause) {

        super(message, cause);
    }
}
