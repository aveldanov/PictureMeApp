//
//  Post.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/21/21.
//

import FirebaseFirestore


struct Post{
    
    var caption: String
    var likes: Int
    let imageURL: String
    let ownerUID: String
    let timestamp: Timestamp
    let postID: String
    
    
    // postID is not part of dic because of Firebase structure
    init(postID: String, dict: [String: Any]){
        self.postID = postID
        self.caption = dict["caption"] as? String ?? ""
        self.likes = dict["likes"] as? Int ?? 0
        self.imageURL = dict["imageURL"] as? String ?? ""
        self.ownerUID = dict["ownerUID"] as? String ?? ""
        self.timestamp = dict["timestamp"] as? Timestamp ?? Timestamp()
    }
    
    
}
