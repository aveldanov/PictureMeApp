//
//  ProfileHeader.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import UIKit

class ProfileHeader: UICollectionReusableView{
    
     //MARK: Properties
    static let identifier = "ProfileHeader"
    
     //MARK: Lifecycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
