//
//  UserService.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import Firebase

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
}
