//
//  ProfileViewController.swift
//  switchBook

import UIKit

class ProfileViewController: UIViewController {
    public var books: [String]?
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var list: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBook(_ sender: Any) {
        if((userInput.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Incorrect Details", message: "The field is empty", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else {
            let m  = userInput.text?.replacingOccurrences(of: " ", with: "")
            let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=" + m!)!
            let urlRequest = URLRequest(url: url)
            
            // set up the session
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            // make the request
            let task = session.dataTask(with: urlRequest) {
                (data, response, error) in
                // check for any errors
                guard error == nil else {
                    let alert = UIAlertController(title: "Incorrect Details", message: "No such book found", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    return;
                }
                // make sure we got data
                guard let responseData = data else {
                    let alert = UIAlertController(title: "Fatal Error", message: "Bad Getaway", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    return;
                }
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                        as? [String: Any] else {
                            let alert = UIAlertController(title: "Incorrect Details", message: "Couldn't convert data", preferredStyle: UIAlertController.Style.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                            return;
                            
                    }
                } catch  {
                    let alert = UIAlertController(title: "Incorrect Details", message: "Couldn't convert data", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    return;
                }
            }
            task.resume()
        }
    }
}
