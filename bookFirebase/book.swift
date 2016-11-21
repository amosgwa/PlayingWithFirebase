//
//  book.swift
//  bookFirebase
//
//  Created by Amos Gwa on 11/16/16.
//  Copyright © 2016 Amos Gwa. All rights reserved.
//

import Foundation

class book {
    var id = UUID().uuidString
    var title = String()
    var author = String()
    var summary = String()
    var year = String()
    
    func printBook(){
        print("Book id : \(self.id), title : \(self.title), author : \(self.author), year : \(self.year), summary : \(self.summary)")
    }
}
