//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
        
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
               if let e = error {
                   print(e.localizedDescription)
                   let ac = UIAlertController(title: self.title, message: "\(e.localizedDescription)", preferredStyle: .alert)    // pop up  об ошибке
                   ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                   self.present(ac, animated: true)
               } else {
                   //Navigate to CoffeeList
                   self.performSegue(withIdentifier: "LoginToCoffee", sender: self)
               }
          // ...
            }
        }
    }
}
