//
//  UploadPostController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/14/21.
//

import UIKit


class UploadPostController: UIViewController{
    
     //MARK: Properties
    
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    private let captionTextView: UITextView = {
        let textView = UITextView()
        
        
        return textView
    }()
    
    
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
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.topAnchor)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12,  height: 64)
        
    }
    
    
     //MARK: Actions
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func didTapShare(){
        
        print("[UploadPostController] didTapShare")
        
    }
    
}
