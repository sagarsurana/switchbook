//
//  AddGroupViewController.swift
//  SwitchBook
//
//  Created by applemac on 12/2/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
//        let userData = ref.child("users")
//            .child(Auth.auth().currentUser!.uid)
//            .child("Advertisements")
//            .queryOrderedByKey()
//            .observeSingleEvent(of: .value, with: { snapshot in
//
//                guard let dict = snapshot.value as? [String:Any] else {
//                    print("Error")
//                    return
//                }
//                let imageAd = dict["imageAd"] as? String
//                let priceAd = dict["priceAd"] as? String
//            })
        groupID = groupData.key!
        var personDict: [String: Bool] = [:]
        for person in persons {
            personDict[person] = false
            
            
        }
        //TODO: ADD Intial Notficiation Date Here AS Date not timestamp
        groupData.setValue(["members": personDict, "name": addName.text!, "date": Date().timeIntervalSince1970])
        // ServerValue.timestamp()]
        
        
        
        
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
        performSegue(withIdentifier: "groupAdded", sender: self)
    }
    
    @IBAction func addPerson(_ sender: Any) {
        persons.append(person.text ?? "")
        tableView.insertRows(at: [IndexPath(row: persons.count - 1, section: 0)], with: .automatic)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addPerson.layer.cornerRadius = 10
        addPerson.clipsToBounds = true
    }
}
