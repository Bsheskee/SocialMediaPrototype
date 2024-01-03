//
//  UsersVC.swift
//  SocialMedia
//
//  Created by bartek on 19/12/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UsersVC: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    let db = Firestore.firestore()
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")

        loadUsers()
        print("users.count = \(users.count)")
    }
    
    private func loadUsers() {
        db.collection(K.FStore.usersCollection)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        let data = document.data()
                        print("data = \(data)")
                        if let userEmail = data[K.FStore.userEmail] as? String,
                           let userName = data[K.FStore.userName] as? String {
                            let userPhoto = UIImage(named: "Brian Harrison")
                            let user = User(name: userName, email: userEmail, photo: userPhoto)
                            self.users.append(user)
                        }
                    }
                    self.usersTableView.reloadData()
                }
            }
    }
    
    
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        do {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let welcomeVC = storyboard.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC {
                self.navigationController?.pushViewController(welcomeVC, animated: true)
                try Auth.auth().signOut()
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
}

extension UsersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        cell.userName.text = users[indexPath.row].name
        cell.designablePhoto.userPhoto = users[indexPath.row].photo
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let chatVC = ChatVC()
        chatVC.loadMessages(for: user)
        
        self.navigationController?.pushViewController(ChatVC(), animated: true)
        
        usersTableView.deselectRow(at: indexPath, animated: true)
    }
    
}
