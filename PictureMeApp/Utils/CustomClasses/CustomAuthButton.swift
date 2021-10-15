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
        setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        backgroundColor = .systemBlue.withAlphaComponent(0.3)
        layer.cornerRadius = 5
        setHeight(50)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

