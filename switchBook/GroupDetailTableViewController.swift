//
//  GroupDetailTableViewController.swift
//  SwitchBook
//
//  Created by applemac on 12/2/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class GroupDetailTableViewController: UITableViewController {
    
    var membersName : [String] = []
    var members : [String:Bool] = [:]
    var groupName = ""
    var ref: DatabaseReference!
    var groupID : String = ""
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        self.title = groupName
        print("details")
        let groupData = ref.child("groups").child(groupID)
        
        //queuing requests
        let myGroup = DispatchGroup()
        groupData.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value!)
            guard let userDict = snapshot.value as? [String:Any] else {
                print("Error")
                return
            }
            self.members = userDict["members"] as! [String:Bool]
            let allUsers = self.ref.child("users")
            for (key, _) in self.members {
                myGroup.enter() //lock
                allUsers
                    .child(key)
                    .observeSingleEvent(of: .value, with: { (snapshot) in
                        print(snapshot.value!)
                        guard let userDict = snapshot.value as? [String:Any] else {
                            print("Error")
                            return
                        }
                        self.membersName.append(userDict["name"] as! String)
                        myGroup.leave() //unlock
                    })
            }
            myGroup.notify(queue: .main) {
                print("done")
                self.tableView.reloadData()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = membersName[indexPath.row]
        cell.textLabel?.textColor = UIColor(red:0.90, green:0.37, blue:0.33, alpha:1.0)
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            membersName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
