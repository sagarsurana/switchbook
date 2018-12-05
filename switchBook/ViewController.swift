//
//  ViewController.swift
//  switchBook
//
//  Created by Aviral Sharma on 11/27/18.
//  Copyright © 2018 AviralSharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var sign: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logo.image = UIImage(named: "logo")
    }

    @IBAction func loginPage(_ sender: Any) {
        performSegue(withIdentifier: "loginPage", sender: self)
    }
    
    @IBAction func signInPage(_ sender: Any) {
        performSegue(withIdentifier: "signPage", sender: self)
    }
    
}

