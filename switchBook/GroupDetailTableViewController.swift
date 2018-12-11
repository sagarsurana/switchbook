//
//  GroupDetailTableViewController.swift
//  SwitchBook
//
//  Created by applemac on 12/2/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit
//import FirebaseDatabase

class GroupDetailTableViewController: UITableViewController {

    var members : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = members[indexPath.row]
        
        return cell
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Create a variable that you want to send
        var mem = members
        
        // Create a new variable to store the instance
        let destinationVC : GroupTableViewController = segue.destination as! GroupTableViewController
        destinationVC.members = mem
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            members.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
