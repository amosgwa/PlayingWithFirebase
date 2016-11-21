//
//  BookDetailViewController.swift
//  bookFirebase
//
//  Created by Amos Gwa on 11/16/16.
//  Copyright © 2016 Amos Gwa. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookDetail =  book()
    var isAdd = false
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var summaryField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // If update just parse in the fields with details
        if !isAdd {
            button.setTitle("Update", for: UIControlState.normal)
            updateFields()
        } else {
            //Update the button text
            button.setTitle("Add", for: UIControlState.normal)
        }
        
        
    }
    
    func populateDataFields(){
        bookDetail.author = authorField.text!
        bookDetail.year = yearField.text!
        bookDetail.title = titleField.text!
        bookDetail.summary = summaryField.text!
    }

    @IBAction func onPressedUpdate(_ sender: UIButton) {
        populateDataFields()
        bookDetail.printBook()
        
        if isAdd {
            database.addBook(bookDetail)
        } else {
            database.updateBook(bookDetail)
        }
    }
    
    func updateFields(){
        yearField.text = bookDetail.year
        authorField.text = bookDetail.author
        titleField.text = bookDetail.title
        summaryField.text = bookDetail.summary
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
