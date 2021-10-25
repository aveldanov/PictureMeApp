//
//  FeedCell.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit

class FeedCell: UICollectionViewCell{
    
     //MARK: Properties
    
    static let identifier = "FeedCell"
    
    var viewModel: PostViewModel?{
        didSet{
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
//        imageView.image = #imageLiteral(resourceName: "venom-7")
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    // lazy button as we are call it before init. Otherwise would have to put addTarget to Init
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
//        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
        return button
    }()
    
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor  = .black
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor  = .black
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor  = .black
        return button
    }()
    
    
    private let likesLabel: UILabel = {
        let label = UILabel()
//        label.text = "1 like"
        label.textColor = .systemGray6
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
//        label.text = "Some test caption label"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    
    
     //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        //make sure to add after the postImageView as we are anchoring to it
        configureActionButtons()
        
        
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        profileImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//    }
    
    
     //MARK: Actions
    
    @objc func didTapUserName(){
        
        debugPrint("didTapUserName()")
        
    }
    
    
     //MARK: Helper
    
    func configureActionButtons(){
        
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
        
    }
    
    
    func configure(){
        guard let viewModel = viewModel else{
            return
        }
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageURL)
        
        profileImageView.sd_setImage(with: viewModel.userProfileImageURL)
        usernameButton.setTitle(viewModel.username, for: .normal)
    }
    
}
