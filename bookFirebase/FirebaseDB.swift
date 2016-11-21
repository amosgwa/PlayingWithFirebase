//
//  FirebaseDB.swift
//  bookFirebase
//
//  Created by Amos Gwa on 11/16/16.
//  Copyright © 2016 Amos Gwa. All rights reserved.
//

import Foundation
import Firebase

class FirebaseDB : LibraryTableViewController {
    let ref = FIRDatabase.database().reference()
    
    struct K {
        static let bookKey = "Book"
        static let titleKey = "Title"
        static let authorKey = "Author"
        static let yearKey = "Year"
        static let summaryKey = "Summary"
    }
    
    func populateData() {
        print("populating data")
        ref.observe(.value, with: { snapshot in
            for item in snapshot.children {
                // Load each snapshot
                let book = self.convertSnapshotToBookObj(item as! FIRDataSnapshot)
                self.Books.append(book)
            }
            
            //self.libraryTableView.reloadData()
        })
    }
    
    func addBook(_ book: book) {
        // always start with the top level-node
        // grab its child named “Book”, or create it if needed
        // add a child node of “Book” with where node key = book.id
        // set the value for the key to a dictionary
        
        print("Adding")
        book.printBook()
        
        ref.child(K.bookKey).child(book.id).setValue(
            [K.titleKey: book.title,
             K.authorKey: book.author,
             K.yearKey: book.year,
             K.summaryKey: book.summary
            ])
    }
    
    func removeBook(_ id: String) {
        ref.child(K.bookKey).child(id).removeValue()
    }
    
    func updateBook(_ book: book) {
        ref.child(K.bookKey).child(book.id).updateChildValues(
            [K.titleKey: book.title,
             K.authorKey: book.author,
             K.yearKey: book.year,
             K.summaryKey: book.summary
            ])
    }
    
    /**
     Convert a FIRDataSnapshot object to a Book object.
     Parameters: accepts a FIRDataSnapshot that
     contains a single child node of Book
     Returns: a Book object created from the FIRDataSnapshot data
     **/
    func convertSnapshotToBookObj(_ snap: FIRDataSnapshot) -> book {
        let bookResult = book()
        
        let bookValues = snap.value as! [String : AnyObject]
        // pull out the book id
        // this is the name of the node, not in the node content
        let id = snap.key
        // pull out the other properties
        // make sure the key actually exists before using it,
        // something like...
        bookResult.author = bookValues[K.authorKey] == nil ? "" : bookValues[K.authorKey]! as! String
        bookResult.id = id
        bookResult.summary = bookValues[K.summaryKey] == nil ? "" : bookValues[K.summaryKey]! as! String
        bookResult.title = bookValues[K.titleKey] == nil ? "" : bookValues[K.titleKey]! as! String
        bookResult.year = bookValues[K.yearKey] == nil ? "" : bookValues[K.yearKey]! as! String
        
        // TODO: repeat for each property in Book
        // TODO: return a book object with the properties set
        return bookResult
    }
    
    // Setup observers that perform a closure each time a book is added,
    // removed, or changed
    func setupDBListeners() {
        print("Listening")
        // listen for new books added
        // also, let’s make sure it returns each book in order by title
        ref.child(K.bookKey)
            .queryOrdered(byChild: K.titleKey)
            .observe(.childAdded, with: { (snapshot) in
                let book = self.convertSnapshotToBookObj(snapshot)
                
                // Check if the current array already contains the book with the id.
                let index = self.findBook(book_id: book.id);
                
                print("Printing added book")
                book.printBook()
                
                // Make sure that the book is a new book.
                // Otherwise update the old one.
                if index < 0 {
                    self.Books.append(book)
                } else {
                    self.updateBook(book)
                }
                
                print("Books size : \(self.Books.count)")
             //self.libraryTableView.reloadData()                // TODO: insert Book obj into the local Book array
                // TODO: reload the tableview (you may need a delegate)
            })
        
        // listen for changes in book data
        ref.child(K.bookKey)
            .observe(.childChanged, with: { (snapshot) in
                let book = self.convertSnapshotToBookObj(snapshot)
                
                let index = self.findBook(book_id: book.id);
                
                // Make sure that the index is updated. Otherwise, add this book as a new book.
                if index < 0 {
                    self.addBook(book)
                } else {
                    self.Books[index] = book
                }
                //self.libraryTableView.reloadData()
                // TODO: update the correct Book in your array
                // TODO: reload the tableview
            })
        // listen for books removed
        ref.child(K.bookKey)
            .observe(.childRemoved, with: { (snapshot) in
                
                let book = self.convertSnapshotToBookObj(snapshot)
                
                let index = self.findBook(book_id: book.id);
                
                // Make sure that the index is updated. Otherwise, add this book as a new book.
                if index > 0 {
                    self.Books.remove(at: index)
                    //self.libraryTableView.reloadData()
                }
                               // TODO: remove the proper book from the array
                // TODO: update the tableview
            })
    }
    
    func findBook(book_id: String) -> Int {
        for i in 0..<self.Books.count {
            if self.Books[i].id == book_id{
                return i
            }
        }
        return -1
    }
}

let database = FirebaseDB()
