//
//  ProfileCell.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import UIKit

class ProfileCell: UICollectionViewCell{
    
    //MARK: Properties
    static let identifier = "ProfileCell"
    
     //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
