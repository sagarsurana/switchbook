//
//  LoginViewController.swift
//  switchBook
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
        _ = authUI!.authViewController()
        login.layer.cornerRadius = 10
        login.clipsToBounds = true
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
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("signed in")
                self.performSegue(withIdentifier: "loginIdentifier", sender: self)
            }
        }
    }
    
    @IBAction func BackToSignUp(_ sender: Any) {
        performSegue(withIdentifier: "BackToSignUp", sender: self)
    }
    
}
