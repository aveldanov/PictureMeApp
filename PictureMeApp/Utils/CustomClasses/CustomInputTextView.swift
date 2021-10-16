//
//  CustomInputTextView.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/14/21.
//

import UIKit


class CustomInputTextView: UITextView{
     //MARK: Properties
    
    var placeholderText: String? {
        didSet{
            
            placeholderLabel.text = placeholderText
        }
    }
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    
     //MARK: Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        backgroundColor = .white
        textColor = .black
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
     //MARK: Action
    
    @objc private func handleTextDidChange(){
        placeholderLabel.isHidden = !text.isEmpty
        
        
    }
}

