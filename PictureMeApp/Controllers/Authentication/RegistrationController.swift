//
//  RegistrationController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit


class RegistrationController: UIViewController{
    
    //MARK: Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white //changed from the default blue PNG
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    
    
    private let emailTextField: UITextField = {
        let textField = CustomAuthTextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = CustomAuthTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    //Shorten version of Properties declaration. When parameters are default
    private let fullnameTextField: UITextField = CustomAuthTextField(placeholder: "Fullname")
    
    private let usernameTextField: UITextField = CustomAuthTextField(placeholder: "Username")
    
    private let signupButton: UIButton = {
        let button = CustomAuthButton(placeholder: "Sign Up", type: .system)
        return button
    }()
    
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Login")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: Actions
    
    @objc private func handleShowLogin(){
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func textDidChange(sender: UITextField){
        
        if sender == emailTextField{
            viewModel.email = sender.text
        }else{
            viewModel.passowrd = sender.text
        }
        
        switch sender{
        case emailTextField:
            viewModel.email = sender.text
        case passwordTextField:
            viewModel.passowrd = sender.text
        case fullnameTextField:
            viewModel.fullname = sender.text
        case usernameTextField:
            viewModel.username = sender.text
        default:
            fatalError("[RegistrationController] No ViewModel")
            break
        }
        updateForm()
    }
    
    
    @objc private func handleProfilePhotoSelect(){
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationsObservers()
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
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    private func configureNotificationsObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}


//MARK: FormViewModel

extension RegistrationController: FormViewModelProtocol{
    func updateForm() {
        signupButton.backgroundColor = viewModel.buttonBackgroundColor
        signupButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signupButton.isEnabled = viewModel.formIsValid
    }
}


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    
    
    
}
