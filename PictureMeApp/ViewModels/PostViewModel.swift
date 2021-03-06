//
//  PostViewModel.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/21/21.
//

import Foundation


struct PostViewModel{
    private let post: Post
    
    var imageURL: URL?{
        return URL(string: post.imageURL)
    }
    
    var caption: String{
        return post.caption
    }
    
    var likes: Int{
        return post.likes
    }
    
    var userProfileImageURL: URL?{
        return URL(string: post.ownerImageURL)
    }
    
    var username: String{
        return post.onwerUsername
    }
    
    var likesLabelText: String{
        if post.likes != 1{
            return "\(post.likes) likes"
        }else{
            return "\(post.likes) like"
        }
        
    }
    
    init(post: Post){
        self.post = post
    }
    
    
}
