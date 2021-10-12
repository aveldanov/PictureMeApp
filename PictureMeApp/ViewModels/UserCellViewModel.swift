//
//  UserCellViewModel.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/11/21.
//

import UIKit

struct UserCellViewModel{
    
    private let user: User
    // in model we had it as String in the VM - converted to URL
    var profileImageURL: URL?{
        return URL(string: user.profileImageURL)
    }
    
    var username: String{
        return user.username
    }
    
    var fullname: String{
        return user.fullname
    }
    
    
    init(user: User){
        self.user = user
    }
}
