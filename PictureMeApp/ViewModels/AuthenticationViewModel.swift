//
//  AuthenticationViewModel.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/6/21.
//

import UIKit


protocol FormViewModelProtocol{
    func updateForm()
}


protocol AuthenticationViewModelProtocol{
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}


struct LoginViewModel: AuthenticationViewModelProtocol{
   
    // 1
    var email: String?
    var passowrd: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && passowrd?.isEmpty == false
    }
    
    // 2
    var buttonBackgroundColor: UIColor{
        return formIsValid ? .systemBlue : .systemBlue.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor{
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}


struct RegistrationViewModel: AuthenticationViewModelProtocol{

    var email: String?
    var passowrd: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && passowrd?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor{
        return formIsValid ? .systemBlue : .systemBlue.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor{
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }    
}
