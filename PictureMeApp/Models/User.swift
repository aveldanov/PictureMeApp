//
//  User.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import Foundation
import Firebase

struct User{
    
    let email: String
    let fullname: String
    let profileImageURL: String
    let uid: String
    let username: String
    
    var isFollowed: Bool = false
    
    var stats: UserStats
    
    //checking if current uid == to the uid see above...
    var isCurrentUser: Bool{
        return Auth.auth().currentUser?.uid == uid
    }
    
    //parsing Dictionary recieved from Firebase
    
    init(dict: [String: Any]){
        self.email = dict["email"] as? String ?? ""
        self.fullname = dict["fullname"] as? String ?? ""
        self.profileImageURL = dict["profileImageURL"] as? String ?? ""
        self.uid = dict["uid"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        self.stats = UserStats(followers: 0, following: 0)
    }
    
}

struct UserStats{
    var followers: Int
    var following: Int
//    let posts: Int
    
}
