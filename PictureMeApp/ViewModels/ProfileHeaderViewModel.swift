//
//  ProfileHeaderViewModel.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import UIKit


struct ProfileHeaderViewModel{
    
    let user: User
    
    var fullname: String{
        return user.fullname
    }
    
    var profileImageURL: URL?{
        return URL(string: user.profileImageURL)
    }
    
    var followButtonText: String{
        if user.isCurrentUser{
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor{
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    init(user: User){
        self.user = user
    }
}
