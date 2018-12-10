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
    
    var persons : [String] = []
    
    @IBAction func addGroup(_ sender: Any) {
        
    }
    
    @IBAction func addPerson(_ sender: Any) {
        persons.append(person.text ?? "")
        
        tableView.insertRows(at: [IndexPath(row: persons.count - 1, section: 0)], with: .automatic)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var person: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addPerson.layer.cornerRadius = 10
        addPerson.clipsToBounds = true
    }
}
