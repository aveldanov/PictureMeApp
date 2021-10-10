//
//  User.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import Foundation


struct User{
    
    let email: String
    let fullname: String
    let profileImageURL: String
    let uid: String
    let username: String
    
    //parsing Dictionary recieved from Firebase
    
    init(dict: [String: Any]){
        self.email = dict["email"] as? String ?? ""
        self.fullname = dict["fullname"] as? String ?? ""
        self.profileImageURL = dict["profileImageURL"] as? String ?? ""
        self.uid = dict["uid"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
    }
    
}
