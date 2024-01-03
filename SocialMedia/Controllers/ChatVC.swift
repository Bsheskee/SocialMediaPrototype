//
//  ChatVC.swift
//  SocialMedia
//
//  Created by bartek on 17/12/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatVC: UIViewController {

    @IBOutlet var messageView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    override var inputAccessoryView: UIView? {
        return messageView
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageTextfield.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let messageViewHeight = messageView.frame.height
//
//        tableView.contentInset.bottom = messageViewHeight
//        tableView.scrollIndicatorInsets.bottom = messageViewHeight
        
//        title = K.appName
        navigationItem.hidesBackButton = true
        self.tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
//        loadMessages()
    }
    
    
    func loadMessages(for user: User?) {
        
        if let user = user {
            db.collection(K.FStore.chatCollection)
                .whereField(K.FStore.userEmail, isEqualTo: user.email)
                .order(by: K.FStore.dateField)
                .addSnapshotListener { querySnapshot, error in
                    
                    self.messages = []
                    
                    if let e = error {
                        print("There was an issue retreiving data from firestore. \(e)")
                    } else {
                        if let snapshotDocuments = querySnapshot?.documents {
                            for doc in snapshotDocuments {
                                let data = doc.data()
                                if let messageSender = data[K.FStore.userEmail] as? String, let messageBody = data[K.FStore.messageField] as? String {
                                    let newMessage = Message(sender: messageSender, body: messageBody)
                                    self.messages.append(newMessage)
                                    print("Successfully loaded data from Firestore")
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                    }
                                    
                                }
                            }
                        }
                    }
                }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.chatCollection).addDocument(data: [K.FStore.userEmail: messageSender, K.FStore.messageField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
        }
    }
    

}

extension ChatVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text =  messages[indexPath.row].body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.accent2)
        }
        ///This is a message from another sender.
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.accent)
        }
        return cell
    }
}

extension ChatVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

}
