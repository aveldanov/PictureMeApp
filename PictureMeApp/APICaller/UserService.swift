//
//  UserService.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import Firebase

// simplify the type for completion
typealias FirestoreCompletion = (Error?)->Void

struct UserService{
    static func fetchUser(completion: @escaping(User)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dict = snapshot?.data() else{
                return
            }
            let user = User(dict: dict)
            completion(user)
        }
    }
    
    
    static func fetchUsers(completion: @escaping([User])->Void){
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else{
                return
            }
            let users = snapshot.documents.map{User(dict: $0.data())}
            completion(users)
        }
        
    }
    
    static func followUser(uid: String, completion: @escaping (FirestoreCompletion)){
        guard let currentUID = Auth.auth().currentUser?.uid else{
            return
        }
        
        // An empty Dict as all we need is userID
        COLLECTION_FOLLOWING.document(currentUID).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(uid).setData([:], completion: completion)
        }
    }
    
    static func unfollowUser(uid: String, completion: @escaping (FirestoreCompletion)){
        
    }
}
