//
//  PostService.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/20/21.
//

import UIKit
import Firebase
import FirebaseFirestore


struct PostService{
    // FirestoreCompletion - alies created earlier "(Error?)->Void"
    static func uploadPost(caption: String, image: UIImage, completion: @escaping (FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        ImageUploader.uploadImage(image: image) { imageURL in
            let data: [String:Any] = [
                        "caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageURL": imageURL,
                        "ownerUID": uid
                        ]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    
    
    static func fetchPosts(){
        COLLECTION_POSTS.getDocuments{(snapshot,error) in
            
        }
    }
    
    
    
}
