//
//  UploadPostController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/14/21.
//

import UIKit


class UploadPostController: UIViewController{
    
     //MARK: Properties
    
     //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    
     //MARK: Helpers
    
    
    private func configureUI(){
        
        view.backgroundColor = .blue
        
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapShare))
        
    }
    
    
     //MARK: Actions
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func didTapShare(){
        
        print("[UploadPostController] didTapShare")
        
    }
    
}
