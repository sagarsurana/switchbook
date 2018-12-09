//
//  LoginViewController.swift
//  switchBook
//
//  Created by Aviral Sharma on 11/28/18.
//  Copyright © 2018 AviralSharma. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var forgot: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self as? FUIAuthDelegate
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        _ = authUI!.authViewController()
    }
    
    @IBAction func forgot(_ sender: Any) {
        performSegue(withIdentifier: "forgot", sender: self)
    }
    
    @IBAction func loginAuthentication(_ sender: Any) {
        if((emailInput.text?.isEmpty)! || (passwordInput.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Incorrect Details", message: "One of the fields is empty", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!) { (user, error) in
                // [START_EXCLUDE]
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("signed in")
                self.performSegue(withIdentifier: "loginIdentifier", sender: self)
            }
        }
        //else if command to check if uch a user exists or not
        /*
            if(userDoesntExist or passWordDoesntExist ) //database stuff- query would have to be run
         let alert = UIAlertController(title: "Incorrect Details", message: "Username or password doesnt exist", preferredStyle: UIAlertController.Style.alert)
         
         // add an action (button)
         alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
         
         // show the alert
         self.present(alert, animated: true, completion: nil)
 
 
 
         else perform seague and go to the profile page. ALso pass the userName along with
         the seague as that will allow us to make further queries and display stuff
         on the profile page
         */
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
