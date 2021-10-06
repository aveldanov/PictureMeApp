//
//  CustomAuthButton.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/5/21.
//

import UIKit

class CustomAuthButton: UIButton{
    
    init(placeholder: String, type: UIButton.ButtonType) {
        super.init(frame: .zero)
        
        
        setTitle(placeholder, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemBlue
        layer.cornerRadius = 5
        setHeight(50)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

