//
//  GroupTableViewController.swift
//  SwitchBook
//
//  Created by applemac on 12/2/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GroupTableViewController: UITableViewController {
    
    var groups = ["Family", "Friends", "Club"];
    var groupID = String()
    var ref: DatabaseReference!
    var mem = String()
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = groups[indexPath.row]
        
        let groupData = ref.child("users").ref.childByAutoId()
        
        groupData.setValue(["members": "", "name": cell.textLabel?.text as Any, "date": ServerValue.timestamp()])
        
        groupID = groupData.key!
        
//        if email account is created in Auth {
//              if email is already in members {
//                  error {
//                  print("Member already in group")
//                  return }
//              } else {
//                  add email to the group
//        groupData.updateChildValues(["members" : mem])
//        } else {
//                  error {
//                  print("Email does not exist")
//                  return }
//    }
        
        groupData.updateChildValues(["members" : mem])
        
        return cell
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Create a variable that you want to send
        let gID = self.groupID
        
        // Create a new variable to store the instance
        let destinationVC : SignViewController = segue.destination as! SignViewController
        destinationVC.gID = groupID
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "groupDetail", sender: self)
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
// field boolean - either matched or not matched group ID in members make that a key - the email value will be true or false - whether it chosen or not - true is when its chosen -
