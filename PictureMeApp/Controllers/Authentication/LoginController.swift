//
//  LoginController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit

protocol AuthProtocolDelegate: AnyObject{
    
    func authDidComplete()
    
}


class LoginController: UIViewController{
    
    //MARK: Properties
    
    private var viewModel = LoginViewModel()
    
    weak var delegate: AuthProtocolDelegate?
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "PictureMe"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    private let loginButton: UIButton = {
        let button = CustomAuthButton(placeholder: "Login", type: .system)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        return button
    }()
    
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Signup")
        button.addTarget(self, action: #selector(handleShowSignup), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: Actions
    
    @objc private func handleShowSignup(){
        
        let vc = RegistrationController()
        vc.delegate = delegate
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func textDidChange(sender: UITextField){
        
        if sender == emailTextField{
            viewModel.email = sender.text
        }else{
            viewModel.passowrd = sender.text
        }

        updateForm()
    }
    
    
    @objc private func handleLogin(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("[LoginController] failed to log in \(error.localizedDescription)")
                return
            }
            
            print("[LoginController] Successfully logged in")
            
            self.delegate?.authDidComplete()
            
        }
    }
    
    
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationsObservers()
    }
    
    
    
    //MARK: Helpers
    
    func configureUI(){
        configureGradientLayer()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 320)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    
    
    // textField Observers for text change
   private func configureNotificationsObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }    
}



 //MARK: FormViewModel

extension LoginController: FormViewModelProtocol{
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
//        loginButton.isEnabled = viewModel.formIsValid
    }
}
