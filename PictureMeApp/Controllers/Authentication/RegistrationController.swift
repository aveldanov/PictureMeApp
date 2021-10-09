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
    
    private var profileImage: UIImage? // when we open the screen value does not exist therefore - optional
    
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
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
    
    @objc private func handleSignUp(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        guard let profileImage = self.profileImage else {return}

        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.registerUser(withCredentials: credentials) { error in
            if let error = error {
                print("[RegistrationController] ImageUploaderError")
                return
            }
            print("Successfully registered")

        }
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationsObservers()
        
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
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
//        signupButton.isEnabled = viewModel.formIsValid
    }
}


 //MARK: UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else{
            return
        }
        
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal) //ensure the image form is original
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
