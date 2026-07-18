package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;

    // Setter for dependency injection
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("BookRepository injected into BookService.");
    }

    public void displayBooks() {
        System.out.println("BookService: displaying books...");
        bookRepository.findAllBooks();
    }
}