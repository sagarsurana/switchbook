//
//  ProfileViewController.swift
//  switchBook

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row]
        cell.textLabel?.textColor = UIColor(red:0.90, green:0.37, blue:0.33, alpha:1.0)
        return cell
    }
    
    public var books: [String] = []
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var profileAge: UILabel!
        
    @IBOutlet weak var switchedBookName: UILabel!
    @IBOutlet weak var list: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
        list.delegate = self
        list.dataSource = self
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
            books.append(userInput.text ?? "")
            list.insertRows(at: [IndexPath(row: books.count - 1, section: 0)], with: .automatic)
            
            
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
}
