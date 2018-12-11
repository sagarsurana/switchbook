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
        let ref = Database.database().reference()
        let groupData = ref.child("groups").childByAutoId()
        let userData = ref.child("users")
        groupID = groupData.key!
        let currentEmail = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: ",")
        print(currentEmail)
        var personDict: [String: Bool] = [(currentEmail)!:false]
        for personEmail in persons {
            let emailChanged = personEmail.replacingOccurrences(of: ".", with: ",")
            personDict[emailChanged] = false
            var groupArray: [String] = []
            userData
                .child(emailChanged)
                .observeSingleEvent(of: .value, with: { (snapshot) in
                    print(snapshot.value!)
                    guard let userDict = snapshot.value as? [String:Any] else {
                        print("errrorrr")
                        return
                    }
                    if userDict["groups"] != nil {
                        groupArray = userDict["groups"] as! [String]
                    }
                    groupArray.append(self.groupID)
                    print(groupArray)
                })
            let current = ref.child("user").child(emailChanged)
            let values = [
                "groups": "groupArray"
            ]
            current.setValue(values)
        }
        groupData.setValue(["members": personDict, "name": addName.text!, "date": Date().timeIntervalSince1970])
        performSegue(withIdentifier: "groupAdded", sender: self)
    }
    
    @IBAction func addPerson(_ sender: Any) {
        persons.append(person.text ?? "")
        tableView.insertRows(at: [IndexPath(row: persons.count - 1, section: 0)], with: .automatic)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        addPerson.layer.cornerRadius = 10
        addPerson.clipsToBounds = true
    }
}
