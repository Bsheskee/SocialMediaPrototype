//
//  RegisterVC.swift
//  SocialMedia
//
//  Created by bartek on 17/12/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class SignupVC: UIViewController {
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        guard let firstName = firstNameTextfield.text,
              let lastName = lastNameTextfield.text,
              let email = emailTextfield.text,
              let password = passwordTextfield.text,
              let repeatPassword = repeatPasswordTextfield.text else {
            return
            //TODO: user feedback- not all forms were filled
        }
        let signupFormModel = SignupFormRequestModel(firstName: firstName, lastName: lastName, email: email, password: password, repeatPassword: repeatPassword)
        
        let signupService = SignupService()

        signupService.signup(withForm: signupFormModel) { response, error in
            if let error = error {
                print("Signup error: \(error)")
                //TODO: Alert
            } else if let response = response {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
                print("Signup successful with response: \(response)")
            }
            
        }
    }
}
