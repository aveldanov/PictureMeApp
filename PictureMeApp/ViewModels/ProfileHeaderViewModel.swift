//
//  ProfileHeaderViewModel.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import Foundation


struct ProfileHeaderViewModel{
    
    let user: User
    
    var fullname: String{
        return user.fullname
    }
    
    var profileImageURL: URL?{
        return URL(string: user.profileImageURL)
    }
    
    init(user: User){
        self.user = user
    }
}
