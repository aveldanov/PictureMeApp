//
//  ProfileHeader.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/9/21.
//

import UIKit
import SDWebImage
// since no API calls in view -> we need a protocol to delegate the action

protocol ProfileHeaderProtocolDelegate: AnyObject{
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
}




class ProfileHeader: UICollectionReusableView{
    
     //MARK: Properties
    static let identifier = "ProfileHeader"
    
    var viewModel: ProfileHeaderViewModel?{
        didSet{
            configure()
//            print(viewModel?.user.stats,"UOOOOOOOOOOOOOOO")
        }
    }
    
    weak var delegate: ProfileHeaderProtocolDelegate?
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "venom-7")
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
//        label.text = "Anton V"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading...", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    // using lazy as we are using function before the item is initialized
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.attributedStatText(label: "posts", value: 5)
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
//        label.attributedStatText(label: "followers", value: 2)

        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.attributedStatText(label: "following", value: 1)

        return label
    }()
    
    
    
    private let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid")
, for: .normal)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list")
, for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon")
, for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
     //MARK: Lifecycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80/2
        
        addSubview(nameLabel)
        nameLabel.centerX(inView: profileImageView)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,paddingTop: 12, paddingLeft: 12)
        
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: nameLabel.bottomAnchor ,
                                       left: leftAnchor,
                                       right: rightAnchor,
                                       paddingTop: 16,
                                       paddingLeft: 24,
                                       paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
        
        // mid bar
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        addSubview(topDivider)
        addSubview(bottomDivider)

        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        topDivider.anchor(top: buttonStack.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
        bottomDivider.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
     //MARK: Actions
    
    @objc private func handleEditProfileFollowTapped(){
        print("[ProfileCell] handleEditProfileFollowTapped")
        guard let viewModel = viewModel else{
            return
        }
        
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
    }
    
     //MARK: Helpers
    
    
    private func configure(){
        print("[ProfileHeader] configure called...")
        guard let viewModel = viewModel else {
            return
        }
        
        nameLabel.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageURL, completed: nil)
        
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColor
        
        followersLabel.attributedStatText(label: "Followers", value: viewModel.numberOfFollowers)
        followingLabel.attributedStatText(label: "Following", value: viewModel.numberOfFollowing)
    }
}
