//
//  SignupService.swift
//  SocialMedia
//
//  Created by bartek on 22/12/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignupService {
    
    var signupResult: AuthDataResult?
    
    func signup(withForm formModel: SignupFormRequestModel, completion: @escaping (AuthDataResult?, SignupErrors?) -> Void) {
        Auth.auth().createUser(withEmail: formModel.email, password: formModel.password) { authResult, error in if let e = error {
            print(e.localizedDescription)
            
            if let nsError = error as NSError? {
                print("Firestore error code:", nsError.code)
                print("Firestore error domain:", nsError.domain)
                completion(nil, .invalidResponse)
            }
        } else {
            if let authResult = authResult {
                let uid = authResult.user.uid
                let email = authResult.user.email
                let userName = formModel.firstName
                let userLastName = formModel.lastName
                
                let userDetails = [
                    "uid": uid,
                    "email": email,
                    "userName": userName,
                    "userLastName": userLastName
                ]
                let db = Firestore.firestore()
                db.collection(K.FStore.usersCollection).document(uid).setData(userDetails as [String : Any]) { error in
                    if let error = error {
                        print("error creating userDetails document: \(error)")
                        completion(nil, .invalidResponse)
                    } else {
                        print("Successfully added user details to usersCollection")
                        self.signupResult = authResult
                        completion(authResult, nil)
                    }
                }
            }
        }
        }
    }
}
