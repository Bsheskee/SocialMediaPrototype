//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by bartek on 06/06/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

struct K {
    static let appName = "SocialMedia"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToMain"
    static let loginSegue = "LoginToMain"
    
    struct BrandColors {
        static let accent = "Accent"
        static let accent2 = "Accent2"
    }
    
    struct FStore {
        static let usersCollection = "users"
        static let chatCollection = "chat"
        static let feedCollection = "feed"
        static let userEmail = "email"
        static let userName = "userName"
        static let messageField = "message"
        static let dateField = "date"
    }
}
