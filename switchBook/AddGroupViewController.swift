//
//  AddGroupViewController.swift
//  SwitchBook
//
//  Created by applemac on 12/2/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit
import FirebaseDatabase 
import Firebase

class AddGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addPerson: UIButton!
    @IBOutlet weak var addGroupButton: UIButton!
    @IBOutlet weak var addName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var person: UITextField!
    var persons : [String] = []
    var groupID = ""
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        addPerson.layer.cornerRadius = 10
        addPerson.clipsToBounds = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = persons[indexPath.row]
        cell.textLabel?.textColor = UIColor(red:0.90, green:0.37, blue:0.33, alpha:1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            persons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup(_ sender: Any) {
        if (((addName.text?.isEmpty)!)) {
            let alert = UIAlertController(title: "Group Name Empty", message: "Please enter a valid group name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let groupData = ref.child("groups").childByAutoId()
            let userData = ref.child("users")
            groupID = groupData.key!
            let currentEmail = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: ",")
            var personDict: [String: Bool] = [(currentEmail)!:false]
            var personMatched : [String:Bool] = [(currentEmail)!:false]
            var groupMembers = persons
            groupMembers.append(currentEmail!)
            for personEmail in groupMembers {
                let emailChanged = personEmail.replacingOccurrences(of: ".", with: ",")
                personMatched[emailChanged] = false
                personDict[emailChanged] = false
                var groupArray: [String:String] = [:]
                userData
                    .child(emailChanged)
                    .observeSingleEvent(of: .value, with: { (snapshot) in
                        print(snapshot.value!)
                        guard let userDict = snapshot.value as? [String:Any] else {
                            print("Error")
                            return
                        }
                        if userDict["groups"] != nil {
                            groupArray = userDict["groups"] as! [String:String]
                        }
                        groupArray[self.groupID] = self.addName.text
                        print(groupArray)
                        print(userDict)
                        let current = userData.child(emailChanged)
                        current.updateChildValues(["groups" : groupArray])
                    })
            }
            groupData.setValue(["members": personDict, "sendermatched":personMatched, "name": addName.text!, "date": Date().timeIntervalSince1970])
        }
    }
    
    @IBAction func addPerson(_ sender: Any) {
        persons.append(person.text ?? "")
        tableView.insertRows(at: [IndexPath(row: persons.count - 1, section: 0)], with: .automatic)
    }
}
