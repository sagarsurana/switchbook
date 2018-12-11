//
//  ProfileViewController.swift
//  switchBook

import UIKit
import FirebaseDatabase
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var ref: DatabaseReference!
    public var books: [String] = []
    var userBook : String = ""
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var profileAge: UILabel!
    @IBOutlet weak var switchedBookName: UILabel!
    @IBOutlet weak var list: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
        list.delegate = self
        list.dataSource = self
        let currentEmail = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: ",")
        let userData = Database.database().reference().child("users").child(currentEmail!)
            userData.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value!)
                guard let userDict = snapshot.value as? [String:Any] else {
                    print("errrorrr")
                    return
                }
                self.profileName.text = userDict["name"] as? String
                self.age.text = userDict["age"] as? String
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
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
//            ref = Database.database().reference()
            userBook = userInput.text ?? ""
            books.append(userBook)
            list.insertRows(at: [IndexPath(row: books.count - 1, section: 0)], with: .automatic)
        }
        
        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
            // Create a variable that you want to send
            let bookList = books
            
            // Create a new variable to store the instance
            let destinationVC : SignViewController = segue.destination as! SignViewController
            destinationVC.book = bookList
        }

        
        
            
//            ref.child("users").child("user_information").setValue(["List": userInput.text])

         // API NOT WORKING!
            
//            let m  = userInput.text?.replacingOccurrences(of: " ", with: "")
//            let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=" + m!)!
//            let urlRequest = URLRequest(url: url)
//
//            // set up the session
//            let config = URLSessionConfiguration.default
//            let session = URLSession(configuration: config)
//
//            // make the request
//            let task = session.dataTask(with: urlRequest) {
//                (data, response, error) in
//                // check for any errors
//                guard error == nil else {
//                    let alert = UIAlertController(title: "Incorrect Details", message: "No such book found", preferredStyle: UIAlertController.Style.alert)
//
//                    // add an action (button)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//                    // show the alert
//                    self.present(alert, animated: true, completion: nil)
//                    return;
//                }
//                // make sure we got data
//                guard let responseData = data else {
//                    let alert = UIAlertController(title: "Fatal Error", message: "Bad Getaway", preferredStyle: UIAlertController.Style.alert)
//
//                    // add an action (button)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//                    // show the alert
//                    self.present(alert, animated: true, completion: nil)
//                    return;
//                }
//                do {
//                    guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
//                        as? [String: Any] else {
//                            let alert = UIAlertController(title: "Incorrect Details", message: "Couldn't convert data", preferredStyle: UIAlertController.Style.alert)
//
//                            // add an action (button)
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//                            // show the alert
//                            self.present(alert, animated: true, completion: nil)
//                            return;
//
//                    }
//                } catch  {
//                    let alert = UIAlertController(title: "Incorrect Details", message: "Couldn't convert data", preferredStyle: UIAlertController.Style.alert)
//
//                    // add an action (button)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//                    // show the alert
//                    self.present(alert, animated: true, completion: nil)
//                    return;
//                }
//            }
//            task.resume()

        
    }
}
