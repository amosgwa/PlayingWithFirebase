//
//  LibraryTableViewController.swift
//  bookFirebase
//
//  Created by Amos Gwa on 11/16/16.
//  Copyright © 2016 Amos Gwa. All rights reserved.
//

import UIKit
import Firebase

class LibraryTableViewController: UITableViewController {

    var Books: [book] = [] {
        didSet {
            print("Books count in UITableView \(Books.count)")
            
            for i in 0..<Books.count{
                Books[i].printBook()
            }
            
            if Books.count > 0 {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addMoreBookPressed(_ sender: UIBarButtonItem) {
        generateDummy()
        //libraryTableView.reloadData()
    }
    
    @IBOutlet var libraryTableView: UITableView!
    
    func generateDummy(){
        let bookDummy = book()
        bookDummy.author = "Amos"
        bookDummy.title = "Hello"
        bookDummy.year = "2000"
        Books.append(bookDummy)
    }
    
    var isAdd = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookSegue" {
            let detailVC = segue.destination as! BookDetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            detailVC.isAdd = false
            detailVC.bookDetail = Books[indexPath.row]
        } else if segue.identifier == "addSegue" {
            let detailVC = segue.destination as! BookDetailViewController
            
            detailVC.isAdd = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateDummy()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        database.setupDBListeners()
        database.ref.observe(.value, with: { (snapshot) -> Void in
            for child in snapshot.children {
                self.Books.append(database.convertSnapshotToBookObj(child as! FIRDataSnapshot))
            }
            
            
            print("book UITABle")
            print(self.Books)
            // self.tableView.insertRows(at: [IndexPath(row: self.Books.count-1, section: self.kSectionComments)], with: UITableViewRowAnimation.automatic)
        })
        
        //Populate the table with data.
        //database.populateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> bookTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! bookTableViewCell
        
        cell.titleLabel?.text = Books[indexPath.row].title
        cell.authorLabel?.text = Books[indexPath.row].author
        print("Calling Cell")
        
        return cell
    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Books.count
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
