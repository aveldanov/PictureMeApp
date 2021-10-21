//
//  UploadPostController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/14/21.
//

import UIKit


class UploadPostController: UIViewController{
    
     //MARK: Properties
    
//    var selectedImage: UIImage? {
//        didSet{
//            photoImageView.image = selectedImage
//        }
//    }
//    var selectedImage: UIImage
    
    init(selectedImage: UIImage){
        self.photoImageView.image = selectedImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    private lazy var captionTextView: CustomInputTextView = {
        let textView = CustomInputTextView()
        textView.placeholderText = "Enter caption..."
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    
     //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    
     //MARK: Helpers
    
    
    private func configureUI(){
        
        view.backgroundColor = .white
        
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapShare))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 16,
                               paddingLeft: 12,
                               paddingRight: 12,
                               height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: view.rightAnchor, paddingBottom: -8, paddingRight: 12)
        
        

        
    }
    
    
    private func checkMaxLength(_ textView: UITextView){
        
        if (textView.text.count) > 100 {
            textView.deleteBackward()
            
        }
        
    }
    
    
     //MARK: Actions
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func didTapShare(){
        
        print("[UploadPostController] didTapShare")
//        PostService.uploadPost(caption: captionTextView.text)
        
        
        
    }
    
}


 //MARK: UITextViewDelegate

extension UploadPostController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
        
        
        // Use NotificationCenter instead
//        captionTextView.placeholderLabel.isHidden = !captionTextView.text.isEmpty
    }
    
    
    
}
