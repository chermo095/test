//
//  RegisterViewController.swift
//
//
//  Created by Angela Yu on 21/10/2019.
//  
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    let ac = UIAlertController(title: self.title, message: "\(e.localizedDescription)", preferredStyle: .alert)    // pop up  об ошибке
                    ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    self.present(ac, animated: true)
                } else {
                    //Navigate to CoffeeList
                    self.performSegue(withIdentifier: "RegisterToCoffee", sender: self)
                }
            }
        
        }
    }
    
}
