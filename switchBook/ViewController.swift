//
//  ViewController.swift
//  switchBook

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var sign: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                // User is signed in.
                if let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                    self.present(tabViewController, animated: false, completion: nil)
                }
            }
        }
        logo.image = UIImage(named: "logo")
        
        self.login.layer.cornerRadius = 10
        self.login.clipsToBounds = true
    }

    @IBAction func loginPage(_ sender: Any) {
        performSegue(withIdentifier: "loginPage", sender: self)
    }
    
    @IBAction func signInPage(_ sender: Any) {
        performSegue(withIdentifier: "signPage", sender: self)
    }
}

