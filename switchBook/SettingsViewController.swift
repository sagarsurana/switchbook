//
//  SettingsViewController.swift
//  switchBook
//
//  Created by Sagar Surana on 12/8/18.
//  Copyright © 2018 AviralSharma. All rights reserved.
//

import UIKit
import FirebaseUI

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "signedOutIdentifier", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
}
