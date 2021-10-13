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
    
    var numberOfFollowers: Int{
        return user.stats.followers
    }
    
    var numberOfFollowing: Int{
        return user.stats.following
    }
    
    var numberOfPosts: Int{
        return 0
    }
    
    
    var followButtonBackgroundColor: UIColor{
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor{
        return user.isCurrentUser ? .black : .white        
    }
    
    
    init(user: User){
        self.user = user
    }
}
