//
//  ProfileViewController.swift
//  switchBook
//
//  Created by Aviral Sharma on 11/28/18.
//  Copyright © 2018 AviralSharma. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    public var books: [String]?
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    //this toolbar will allow ypu to go to different view
    //controllers such as the group view controller, add review
    //controller, send message controller etc
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var list: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //run a query that returns all the booksliked by the user so that we can display that in the UIScrollView when the page is loaded.
        // WE HAVE THE BOOKS PARAMETER FOR THAT
        
        // Do any additional setup after loading the view.
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
                // parse the result as JSON, since that's what the API provides
                do {
                    //json format:
                    /*
                     {
                     "kind": "books#volumes",
                     "totalItems": 2231,
                     "items": [
                     {
                     "kind": "books#volume",
                     "id": "0rOWtgEACAAJ",
                     "etag": "Diw5JbJr6LE",
                     "selfLink": "https://www.googleapis.com/books/v1/volumes/0rOWtgEACAAJ",
                     "volumeInfo": {
                     "title": "Harry Potter: A History of Magic",
                     "authors": [
                     "British Library"
                     ],
 */
                    //let title = responseData["items"] as? [[String:Any]]
                    
                    //WE NEED TO ACCESS THE TITLE FIELD INSIDE VOULMEINFO
                    //WHICH IS INSIDE ITEMS WHICH IS AN ARRAY. SO WE NEED THE
                    //FIRST ELEMENT OF ITEM ITEM[0]
                    // DONT KNOW HOW TO ACCESS THIS< SOMEONE PLEASE DO IT
                    guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                        as? [String: Any] else {
                            let alert = UIAlertController(title: "Incorrect Details", message: "Couldn't convert data", preferredStyle: UIAlertController.Style.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                            return;
                            
                    }
                    /*
                    let temp = todo["items"]
                    let subTemp = temp![0].volumeInfpo.title DOESNT WORK
                    
                    */
                    //AFTER ACCESSING THE TITLE OF THE FIRST RESULT INDEX 0
                    //ADD IT TO THE SCROLL VIEW CONTROLLER
                    
                    /*
                     Suppose you get the field title, add it to the array
 
                     books?.append(title)
 
                     list.contentSize = CGSize(width: 200, height: books!.count * 26)
                     
                     for (index, item) in books!.enumerated() {
                     
                     let label = UILabel(frame: CGRect(x: 0, y: index * 26, width: 200, height: 21))
                     label.text = item
                     list.addSubview(label)
                     
                     }
 
 
 */

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
