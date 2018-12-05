//
//  SignViewController.swift
//  switchBook
//
//  Created by Aviral Sharma on 11/28/18.
//  Copyright © 2018 AviralSharma. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var retypedPassword: UITextField!
    
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var zip: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var haveAccount: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func haveAccount(_ sender: Any) {
        performSegue(withIdentifier: "signLogin", sender: self)
    }
    
    @IBAction func accountCreate(_ sender: Any) {
        if((name.text?.isEmpty)! || (email.text?.isEmpty)! || (password.text?.isEmpty)! || (retypedPassword.text?.isEmpty)! || (age.text?.isEmpty)! || (address.text?.isEmpty)! || (zip.text?.isEmpty)! || (userName.text?.isEmpty)!) {
            //one of the fields is empty
            
                
                // create the alert
                let alert = UIAlertController(title: "Incorrect Details", message: "One of the fields is empty", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            
        } else if(!(password.text)!.elementsEqual((retypedPassword.text)!)) {
            //typed and retyped password do not match
            
                
                // create the alert
                let alert = UIAlertController(title: "Password incorrect", message: "The passwords dont match", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            
        } else if(strlen(zip.text) < 5) {
            //incorrect zipcode
           
                
                // create the alert
                let alert = UIAlertController(title: "Incorrect zip code", message: "The zip code is wrong", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            
        } else {
            //BEFORE LESE THISIS WILL BE AN ELSE IF
            //ANOTHER QUERY NEEDS TO BE RU HERE TO PUT EVERYTHING IN THE DATABSE AND
            //ONE MOR ECHECK HAS TO BE MADE MAKING SURE SUCH A USERNAME OR PASSWORD ISNOT ALREADY PRESENT IN THE DATABASE OTHERWISE THEY HAVE TO THINK OF A NEW PASSWORD
            /*
 
             LOGIC FOR THAT
             RUN QUERY TO SEE IF USERNAME ADN PASSWORD EXISTS LIKE
             SELECT COUNT(USERNAME)
             FROM LOGINTABLE
             WHERE PASSWORD  = (password.text)!
             
             
             
             IF THE COUNT IS GRETAER THAN 0, THIS ALREADY EXISTS
             SAME LOGIC FOR USERNAME
             
             ALERT WHICH WILL BE SHOWN UPON  THIS
             
             let alert = UIAlertController(title: "PASSWORD EXITS", message: "TPLEASE CHOOSE ANOTHER PASSWORD", preferredStyle: UIAlertController.Style.alert)
             
             // add an action (button)
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             
             // show the alert
             self.present(alert, animated: true, completion: nil)
             
             
             SELECT COUNT(USERNAME)
             FROM LOGINTABLE
             WHERE PASSWORD  = (username.text)!
             
             
             ALERT WHICH WILL BE SHOWN UPON  THIS
             
             let alert = UIAlertController(title: "USERNAME EXITS", message: "TPLEASE CHOOSE ANOTHER USERNAME", preferredStyle: UIAlertController.Style.alert)
             
             // add an action (button)
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             
             // show the alert
             self.present(alert, animated: true, completion: nil)
             
             
             ELSE GO TO PROFILE PAGE WITH SEGUE CARRYING INFO  : USERNAME
             */
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
