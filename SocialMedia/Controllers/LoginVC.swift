//
//  LoginVC.swift
//  SocialMedia
//
//  Created by bartek on 17/12/2023.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                // ...
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    //Navigate to the ChatVC
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }

}
