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
        
        
    }
    
    
    
     //MARK: Helpers
    
    
    private func configureUI(){
        
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        
    }
    
    
     //MARK: Actions
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
        
    }
    
}
