//
//  AuthService.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/8/21.
//

import UIKit
import Firebase


struct AuthCredentials{
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
    
}

struct AuthService{
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    
    
    
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping (Error?)->Void){
        
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error{
                    print("[AuthService] ImageUploaderError", error.localizedDescription)
                    return
                }
                // generated by Firebase:
                guard let uid = result?.user.uid else {
                    return
                }
                
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageURL": imageURL,
                                           "uid": uid,
                                           "username": credentials.username
                ]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
                
            }
        }
    }
    
    
}
