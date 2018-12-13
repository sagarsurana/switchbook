//
//  ProfileViewController.swift
//  switchBook

import UIKit
import FirebaseDatabase
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var books: [String] = []
    var userBook : String = ""
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var profileAge: UILabel!
    @IBOutlet weak var switchedBookName: UILabel!
    @IBOutlet weak var list: UITableView!
    var currentEmail = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: ",")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
        list.delegate = self
        list.dataSource = self
        currentEmail = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: ",")
        let userData = Database.database().reference().child("users").child(currentEmail!)
        userData.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value!)
            guard let userDict = snapshot.value as? [String:Any] else {
                print("errrorrr")
                return
            }
            self.profileName.text = userDict["name"] as? String
            self.age.text = userDict["age"] as? String
            
            if (userDict["books"] != nil) {
                print(userDict["books"])
                self.books = userDict["books"] as! [String]
            }
            self.list.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row]
        cell.textLabel?.textColor = UIColor(red:0.90, green:0.37, blue:0.33, alpha:1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addBook(_ sender: Any) {
        if((userInput.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Incorrect Details", message: "The field is empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if (userInput.text! != nil) {
                userBook = userInput.text!
                let ref = Database.database().reference().child("users")
                ref.child(currentEmail!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let val = snapshot.value as! [String:Any]
                    var allBooks: [String:String] = [:]
                    var databaseBooks: [String] = []
                    
                    var count = 0
                    if (val["books"] != nil) {
                        print(val["books"])
                        databaseBooks = val["books"] as! [String]
                        for book in databaseBooks {
                            allBooks[String(count)] = book
                            count += 1
                        }
                    }
                    allBooks[String(count)] = self.userBook
                    ref.child(self.currentEmail!).updateChildValues(["books":allBooks])
                    self.books.append(self.userBook)
                    self.list.reloadData()
                    self.userInput.text = ""
                })
            }
        }
    }
}
