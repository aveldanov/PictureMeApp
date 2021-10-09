//
//  ImageUploader.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/8/21.
//

import Foundation
import Firebase


struct ImageUploader{
    static func uploadImage(image: UIImage, completion: @escaping (String)->Void){
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else{
            return
        }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        ref.putData(imageData, metadata: nil) { metedata, error in
            if let error = error{
                print("Debug:  Failed to load image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else {
                    return
                }
                completion(imageUrl)
                
            }
        }
        
        
        
    }
    
    
}



