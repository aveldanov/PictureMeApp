//
//  UserCell.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/10/21.
//

import UIKit

class UserCell: UITableViewCell{
     //MARK: Properties
    static let identifier = "UserCell"
    
//    var user: User? {
//        didSet{
//            print("BOOOOOOOOM",user)
//            usernameLabel.text = user?.username
//            fullnameLabel.text = user?.fullname
//        }
//    }
    
    var viewModel: UserCellViewModel?{
        didSet{
            configure()
        }
    }
    
    
    
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "venom"
        label.textColor = .black
        return label
    }()
    
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "anton"
        label.textColor = .lightGray
        return label
    }()
    
    
     //MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48/2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     //MARK: Helpers
    
    private func configure(){
        guard let viewModel = viewModel else{
            return
        }
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL, completed: nil)
        usernameLabel.text = viewModel.username
        fullnameLabel.text = viewModel.fullname
    }
    
}
