//
//  GroupTableViewController.swift
//  SwitchBook
//
//  Created by applemac on 12/2/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import UserNotifications
import Firebase

class GroupTableViewController: UITableViewController {
    
    @IBOutlet weak var addGroup: UIBarButtonItem!
    var groups : [String:String] = [:]
    var groupNames : [String] = []
    var groupIDs : [String] = []
    var groupID = String()
    var ref: DatabaseReference!
    var members : [String] = []
    var row = -1
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        let currentEmail = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: ",")
        let userData = ref.child("users").child(currentEmail!)
        if (userData.child("groups") != nil) {
            userData.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value!)
                guard let userDict = snapshot.value as? [String:Any] else {
                    print("Error")
                    return
                }
                self.groups = userDict["groups"] as! [String:String]
                for (key, value) in self.groups {
                    self.groupIDs.append(key)
                    self.groupNames.append(value)
                }
                print(self.groups)
                self.tableView.reloadData()
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(groupNames)
        var groupName = cell.textLabel?.text = groupNames[indexPath.row]
        cell.textLabel?.textColor = UIColor(red:0.90, green:0.37, blue:0.33, alpha:1.0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        performSegue(withIdentifier: "groupDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "groupDetail") {
            let destination = segue.destination as! GroupDetailTableViewController
            print(row)
            print(groupIDs)
            destination.groupID = groupIDs[row]
            destination.groupName = groupNames[row]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
