//
//  RegistrationController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit


class RegistrationController: UIViewController{
    
     //MARK: Properties
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white //changed from the default blue PNG
        return button
    }()
    
    
    private let emailTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    //Shorten version of Properties declaration. When parameters are default
    private let fullnameTextField: UITextField = CustomTextField(placeholder: "Fullname")
    
    private let usernameTextField: UITextField = CustomTextField(placeholder: "Username")
    
    private let signupButton: UIButton = {
        let button = CustomAuthButton(placeholder: "Sign Up", type: .system)
        return button
    }()

    
     //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
     //MARK: Helpers
   private func configureUI(){
        configureGradientLayer()
       
       view.addSubview(plusPhotoButton)
       plusPhotoButton.centerX(inView: view)
       plusPhotoButton.setDimensions(height: 140, width: 140)
       plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)

       let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, signupButton])
       stack.axis = .vertical
       stack.spacing = 20
       
       
       view.addSubview(stack)
       stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
       
       
    }
    
    
}
