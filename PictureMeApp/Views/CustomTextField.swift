//
//  CustomTextField.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/4/21.
//

import UIKit


class CustomTextField: UITextField{
    
    // Custom Init
     init(placeholder: String) {
         super.init(frame: .zero)
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
