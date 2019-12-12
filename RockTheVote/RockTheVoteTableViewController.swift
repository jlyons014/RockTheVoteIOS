//
//  RockTheVoteTableViewController.swift
//  RockTheVote
//
//  Created by Lyons, Joseph John on 12/12/19.
//  Copyright © 2019 Lyons, Joseph John. All rights reserved.
//

import UIKit
import CoreData

class RockTheVoteTableViewController: UITableViewController {

     // create a reference to a context
       let context = (UIApplication.shared.delegate as!
           AppDelegate).persistentContainer.viewContext

       // create an array of ShoppingList entities
       var votes = [Vote] ()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // call the load shopping lists methods
           loadVotes()
       }
       
       // fetch ShoppingLists from core data
       func loadVotes() {
           
           // create an instance of a fetchRequest so that
           // shoppingLists ca nbe fethed from core data
           let request: NSFetchRequest<Vote> = Vote.fetchRequest()
           
           do {
               // use contex to execute a fetch request to fetch ShoppingLists
               // from core data, store the fetched ShoppingLists in our array
               votes = try context.fetch(request)
           } catch {
               print("Error fetching Votes from Core Data!")
           }
           
           // reload the fetched data in the Table View Controller
           tableView.reloadData()
       }

       // save shoppingList entity
       func saveVotes () {
           do {
               // use context to save ShoppingLists into Core Data
               try context.save()
           } catch {
               print("Error saving Votes to Core Data!")
           }
           
           // reload the data in the Table View Controller
           tableView.reloadData()
           
       }

    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        var songTextField = UITextField()
        var nameTextField = UITextField()
        
        // create an instance of a shoppingList entity
        let newVote = Vote(context: self.context)
        
        // get name, store, and date input by the user and store them in ShoppingList entity
        newVote.songTitle = songTextField.text!
        newVote.voterName = nameTextField.text!
        newVote.vote = true
        
        
        // add shoppingList entity into array
        self.votes.append(newVote)
        
        // save ShoppingLists into core data
        self.saveVotes()
    }
    
    @IBAction func dislikeButtonPressed(_ sender: UIButton) {
        var songTextField = UITextField()
        var nameTextField = UITextField()
        
        // create an instance of a shoppingList entity
        let newVote = Vote(context: self.context)
        
        // get name, store, and date input by the user and store them in ShoppingList entity
        newVote.songTitle = songTextField.text!
        newVote.voterName = nameTextField.text!
        newVote.vote = false
        
        
        // add shoppingList entity into array
        self.votes.append(newVote)
        
        // save ShoppingLists into core data
        self.saveVotes()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return votes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoteCell", for: indexPath)

        // Configure the cell...
        let vote = votes[indexPath.row]
        cell.textLabel?.text = vote.songTitle!
        cell.detailTextLabel?.text = vote.voterName!

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
