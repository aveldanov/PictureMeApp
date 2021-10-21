//
//  Constants.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import Firebase


let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
