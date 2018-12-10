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
    var groupID : String = ""
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()


        
//        ref.child("groups").child("group_name").setValue(groups)
//        self.ref.child("users").child(users.uid).setValue(["members": "member1"])
        
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
        
        groupData.setValue(["members": "", "name": cell.textLabel?.text as Any, "date": NSDate().timeIntervalSince1970])
        
        groupID = groupData.key!
        
        groupData.child("members").setValue("member1")
        
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


// create the ref to the database in one spot and then export that var value to see in the others - create a var value for ref.child("group").child(autoid?????)
// then set value in different spots - timestamp when group is created, the group members, the group name, the list of books,
// understand how to update the database - if a group is deleted!!
